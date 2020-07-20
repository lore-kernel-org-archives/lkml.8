Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D24AC433E8
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 16:01:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7327820672
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 16:01:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732501AbgGTQBO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 12:01:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731851AbgGTQBL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 12:01:11 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EC3BC061794;
        Mon, 20 Jul 2020 09:01:11 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jxYDr-00Ge6L-Kq; Mon, 20 Jul 2020 16:00:59 +0000
Date:   Mon, 20 Jul 2020 17:00:59 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Hillf Danton <hdanton@sina.com>
Cc:     syzbot <syzbot+75867c44841cb6373570@syzkaller.appspotmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com,
        Markus Elfring <Markus.Elfring@web.de>
Subject: Re: KASAN: use-after-free Read in userfaultfd_release (2)
Message-ID: <20200720160059.GO2786714@ZenIV.linux.org.uk>
References: <0000000000001bbb6705aa49635a@google.com>
 <20200713084512.10416-1-hdanton@sina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200713084512.10416-1-hdanton@sina.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 13, 2020 at 04:45:12PM +0800, Hillf Danton wrote:

> Bridge the gap between slab free and the fput in task work wrt
> file's private data.

No.  This

> @@ -2048,6 +2055,7 @@ SYSCALL_DEFINE1(userfaultfd, int, flags)
>  
>  	fd = get_unused_fd_flags(O_RDONLY | O_CLOEXEC);
>  	if (fd < 0) {
> +		file->private_data = NULL;
>  		fput(file);
>  		goto out;
>  	}
> 

is fundamentally wrong; you really shouldn't take over the cleanups
if you ever do fput().
