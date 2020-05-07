Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8C43C38A24
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 19:01:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE67824954
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 19:01:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728486AbgEGTBi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 15:01:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726320AbgEGTBi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 15:01:38 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6E72C05BD43;
        Thu,  7 May 2020 12:01:37 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jWllz-0039PB-Sr; Thu, 07 May 2020 19:01:32 +0000
Date:   Thu, 7 May 2020 20:01:31 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Max Kellermann <mk@cm4all.com>
Cc:     axboe@kernel.dk, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] fs/io_uring: fix O_PATH fds in openat, openat2, statx
Message-ID: <20200507190131.GF23230@ZenIV.linux.org.uk>
References: <20200507185725.15840-1-mk@cm4all.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200507185725.15840-1-mk@cm4all.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 07, 2020 at 08:57:25PM +0200, Max Kellermann wrote:
> If an operation's flag `needs_file` is set, the function
> io_req_set_file() calls io_file_get() to obtain a `struct file*`.
> 
> This fails for `O_PATH` file descriptors, because those have no
> `struct file*`

O_PATH descriptors most certainly *do* have that.  What the hell
are you talking about?
