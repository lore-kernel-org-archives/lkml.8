Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4E51C34047
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 12:21:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8983021D56
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 12:21:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727135AbgBSMV6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 07:21:58 -0500
Received: from smtprelay0213.hostedemail.com ([216.40.44.213]:51037 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726530AbgBSMV6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 07:21:58 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id CD4B71801D023;
        Wed, 19 Feb 2020 12:21:56 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: bean98_8543dd22e971c
X-Filterd-Recvd-Size: 1765
Received: from XPS-9350.home (unknown [47.151.143.254])
        (Authenticated sender: joe@perches.com)
        by omf12.hostedemail.com (Postfix) with ESMTPA;
        Wed, 19 Feb 2020 12:21:55 +0000 (UTC)
Message-ID: <f3bac52dffc9e5402eb6c6106256dffaf550ee90.camel@perches.com>
Subject: Re: [PATCH 03/24] n_hdlc: convert debuglevel use to pr_debug
From:   Joe Perches <joe@perches.com>
To:     Jiri Slaby <jslaby@suse.cz>, gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Wed, 19 Feb 2020 04:20:33 -0800
In-Reply-To: <20200219084118.26491-3-jslaby@suse.cz>
References: <20200219084118.26491-1-jslaby@suse.cz>
         <20200219084118.26491-3-jslaby@suse.cz>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2020-02-19 at 09:40 +0100, Jiri Slaby wrote:
> With pr_debug we have a fine-grained control about debugging prints. So
> convert the use of global debuglevel variable and tests to a commonly
> used pr_debug. And drop debuglevel completely.
> 
> This also implicitly adds a loglevel to the messages (KERN_DEBUG) as it
> was missing on most of them.
[]
> diff --git a/drivers/tty/n_hdlc.c b/drivers/tty/n_hdlc.c
[]
> @@ -310,11 +306,9 @@ static int n_hdlc_tty_open (struct tty_struct *tty)
>  {
>  	struct n_hdlc *n_hdlc = tty2n_hdlc (tty);
>  
> -	if (debuglevel >= DEBUG_LEVEL_INFO)	
> -		printk("%s(%d)n_hdlc_tty_open() called (device=%s)\n",
> -		__FILE__,__LINE__,
> -		tty->name);
> -		
> +	pr_debug("%s(%d)%s() called (device=%s)\n",
> +			__FILE__, __LINE__, __func__, tty->name);

Perhaps remove all the __FILE__ and __LINE__ arguments as
dynamic debug could emit module and __LINE__ when necessary.



