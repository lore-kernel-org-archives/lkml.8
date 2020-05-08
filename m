Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C42DC38A2A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 06:41:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 870AF21655
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 06:41:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728005AbgEHGlC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 02:41:02 -0400
Received: from nibbler.cm4all.net ([82.165.145.151]:43085 "EHLO
        nibbler.cm4all.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727867AbgEHGk7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 02:40:59 -0400
Received: from localhost (localhost [127.0.0.1])
        by nibbler.cm4all.net (Postfix) with ESMTP id EB97CC0271
        for <linux-kernel@vger.kernel.org>; Fri,  8 May 2020 08:40:56 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at nibbler.cm4all.net
Received: from nibbler.cm4all.net ([127.0.0.1])
        by localhost (nibbler.cm4all.net [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id 219PGDMDguyP for <linux-kernel@vger.kernel.org>;
        Fri,  8 May 2020 08:40:56 +0200 (CEST)
Received: from zero.intern.cm-ag (zero.intern.cm-ag [172.30.16.10])
        by nibbler.cm4all.net (Postfix) with SMTP id CBDD0C0263
        for <linux-kernel@vger.kernel.org>; Fri,  8 May 2020 08:40:56 +0200 (CEST)
Received: (qmail 4015 invoked from network); 8 May 2020 09:57:16 +0200
Received: from unknown (HELO rabbit.intern.cm-ag) (172.30.3.1)
  by zero.intern.cm-ag with SMTP; 8 May 2020 09:57:16 +0200
Received: by rabbit.intern.cm-ag (Postfix, from userid 1023)
        id A73C3461450; Fri,  8 May 2020 08:40:56 +0200 (CEST)
Date:   Fri, 8 May 2020 08:40:56 +0200
From:   Max Kellermann <mk@cm4all.com>
To:     axboe@kernel.dk
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] fs/io_uring: fix O_PATH fds in openat, openat2,
 statx
Message-ID: <20200508064056.GA21129@rabbit.intern.cm-ag>
References: <20200508063846.21067-1-mk@cm4all.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200508063846.21067-1-mk@cm4all.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/05/08 08:38, Max Kellermann <mk@cm4all.com> wrote:
> This fails for `O_PATH` file descriptors, because io_file_get() calls
> fget(), which rejects `O_PATH` file descriptors.  To support `O_PATH`,
> fdget_raw() must be used (like path_init() in `fs/namei.c` does).
> This rejection causes io_req_set_file() to throw `-EBADF`.  This
> breaks the operations `openat`, `openat2` and `statx`, where `O_PATH`
> file descriptors are commonly used.

Code is the same as in v1, but I investigated the root cause of the
problem and updated the patch description.

Jens, I believe this should be a separate trivial commit just removing
those flags, to allow Greg to backport this to stable easily.

Max
