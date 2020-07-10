Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86C72C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 12:19:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C67B20720
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 12:19:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727818AbgGJMTZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 08:19:25 -0400
Received: from mx2.suse.de ([195.135.220.15]:38280 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726774AbgGJMTZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 08:19:25 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id EB156AC46;
        Fri, 10 Jul 2020 12:19:23 +0000 (UTC)
Date:   Fri, 10 Jul 2020 14:19:23 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Bruno Meneguele <bmeneg@redhat.com>
Cc:     linux-kernel@vger.kernel.org, sergey.senozhatsky@gmail.com,
        torvalds@linux-foundation.org, Jason@zx2c4.com
Subject: Re: [PATCH] doc:kmsg: explictly state the return value in case of
 SEEK_CUR
Message-ID: <20200710121923.GO4751@alley>
References: <20200709155415.41207-1-bmeneg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200709155415.41207-1-bmeneg@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2020-07-09 12:54:15, Bruno Meneguele wrote:
> The commit 625d3449788f ("Revert "kernel/printk: add kmsg SEEK_CUR
> handling"") reverted a change done to the return value in case a SEEK_CUR
> operation was performed for kmsg buffer based on the fact that different
> userspace apps were handling the new return value (-ESPIPE) in different
> ways, breaking them.
> 
> At the same time -ESPIPE was the wrong decision because kmsg /does support/
> seek() but doesn't follow the "normal" behavior userspace is used to.
> Because of that and also considering the time -EINVAL has been used, it was
> decided to keep this way to avoid more userspace breakage.
> 
> This patch adds an official statement to the kmsg documentation pointing to
> the current return value for SEEK_CUR, -EINVAL, thus userspace libraries and
> apps can refer to it for a definitive guide on what to expected.
> 
> --- a/Documentation/ABI/testing/dev-kmsg
> +++ b/Documentation/ABI/testing/dev-kmsg
> @@ -56,6 +56,11 @@ Description:	The /dev/kmsg character device node provides userspace access
>  		  seek after the last record available at the time
>  		  the last SYSLOG_ACTION_CLEAR was issued.
>  
> +		Considering that the seek operation is supported but has 
> +		special meaning to the device, any attempt to seek specific
> +		positions on the buffer (i.e.  using SEEK_CUR) results in an
> +		-EINVAL error returned to userspace.

Sigh, I see that devkmsg_llseek() returns -ESPIPE when offset is not
zero. This is a real mess.

I wonder if we could afford to switch this one to -EINVAL and reduce
the mess.

Anyway, for a random reader, it might be pretty unclear what is
exactly special about /dev/kmsg. I wonder if the following might
be more explanatory and strightforward:

		Other seek operations or offsets are not supported because of
		the special behavior. The device allows to read or write
		only whole variable lenght messages that are stored in
		a ring buffer.

		Because of the non-standard behavior also the error values
		are non-standardand. -ESPIPE is returned for non-zero offset.
		-EINVAL is returned for other operations, e.g. SEEK_CUR.
		This behavior is historical and could not be modified
		wihtout the risk of breaking userspace.


Finally, only few people read documentation. We should add some
warning also to the code. I think about a something like:

/*
 * Be careful when modifying this function!!!
 *
 * Only few operations are supported because the device works only with
 * the entire variable length messages. Non-standard error values are
 * returned in the other cases. User space applications might depend
 * on this behavior.
 */

Best Regards,
Petr
