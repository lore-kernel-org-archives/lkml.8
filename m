Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BC69C38A24
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 19:01:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 831E52083B
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 19:01:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728540AbgEGTBl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 15:01:41 -0400
Received: from nibbler.cm4all.net ([82.165.145.151]:59005 "EHLO
        nibbler.cm4all.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728493AbgEGTBk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 15:01:40 -0400
Received: from localhost (localhost [127.0.0.1])
        by nibbler.cm4all.net (Postfix) with ESMTP id 5C116C022B
        for <linux-kernel@vger.kernel.org>; Thu,  7 May 2020 21:01:36 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at nibbler.cm4all.net
Received: from nibbler.cm4all.net ([127.0.0.1])
        by localhost (nibbler.cm4all.net [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id eSVU-Ao62Jj0 for <linux-kernel@vger.kernel.org>;
        Thu,  7 May 2020 21:01:36 +0200 (CEST)
Received: from zero.intern.cm-ag (zero.intern.cm-ag [172.30.16.10])
        by nibbler.cm4all.net (Postfix) with SMTP id 34E1DC0215
        for <linux-kernel@vger.kernel.org>; Thu,  7 May 2020 21:01:36 +0200 (CEST)
Received: (qmail 2452 invoked from network); 7 May 2020 22:17:53 +0200
Received: from unknown (HELO rabbit.intern.cm-ag) (172.30.3.1)
  by zero.intern.cm-ag with SMTP; 7 May 2020 22:17:53 +0200
Received: by rabbit.intern.cm-ag (Postfix, from userid 1023)
        id 08C93461450; Thu,  7 May 2020 21:01:36 +0200 (CEST)
Date:   Thu, 7 May 2020 21:01:36 +0200
From:   Max Kellermann <mk@cm4all.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Max Kellermann <mk@cm4all.com>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] fs/io_uring: fix O_PATH fds in openat, openat2, statx
Message-ID: <20200507190135.GA15950@rabbit.intern.cm-ag>
References: <20200507185725.15840-1-mk@cm4all.com>
 <a048108e-67e0-b261-ab56-312a98045255@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a048108e-67e0-b261-ab56-312a98045255@kernel.dk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/05/07 20:58, Jens Axboe <axboe@kernel.dk> wrote:
> Do you happen to have a liburing test addition for this as well?

No, I'll write one tomorrow.  GitHub PR or email preferred?

Max
