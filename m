Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA59BC433E5
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 12:47:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A540C22C9C
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 12:47:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595249235;
	bh=5nlIs4idUYLiORL6o0nohjjWclRfMD7uXYM/ofVovUM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=O+ifG3n2n9ApTMPtXcbeR0UnUhmab0ISscduA2l71mwF6lylEpFTE7LJ2FdgwG0VM
	 vb5TRp+wo1FN+oicO7Zokr0pvAfE2vioKJiuRieV45uN6wksSlhWmGPpn8GNc6ZAzH
	 17Vbua3BCsWWd08PgiCzKCSitcPl208pqfTPU1tU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728760AbgGTMrO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 08:47:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:42900 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728461AbgGTMrO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 08:47:14 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 69A5C2070A;
        Mon, 20 Jul 2020 12:47:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595249233;
        bh=5nlIs4idUYLiORL6o0nohjjWclRfMD7uXYM/ofVovUM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KQb+ogeUF6SAWUatFdzs3NY4sR3B3/wxBkY5i5v97TNfZwXYQS6IilmZH7XFElQ+3
         z2Zs3lHyCqrICMc4CmADg269R58raYY0BpO29mJs5SiOaVQMXPeNuwrl4laXUsMqSm
         Rqoy3fqg/7exlxbSTN4HDKW6PcdrDC+3nevasX+U=
Date:   Mon, 20 Jul 2020 14:47:24 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     Corey Minyard <cminyard@mvista.com>,
        Jing Xiangfeng <jingxiangfeng@huawei.com>,
        openipmi-developer@lists.sourceforge.net,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>, Corey Minyard <minyard@acm.org>
Subject: Re: [PATCH] ipmi: Remove duplicate code in __ipmi_bmc_register()
Message-ID: <20200720124724.GA4085046@kroah.com>
References: <2084072d-e16c-d47c-6eed-f47e8f149c44@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2084072d-e16c-d47c-6eed-f47e8f149c44@web.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 20, 2020 at 02:07:50PM +0200, Markus Elfring wrote:
> > > __ipmi_bmc_register() jumps to the label 'out_free_my_dev_name' in an
> > > error path. So we can remove duplicate code in the if (rv).
> >
> > Looks correct, queued for next release.
> 
> 1. Can an imperative wording be preferred for the change description?
> 
> 2. Will the tag “Fixes” become helpful for the commit message?
> 
> 3. Did you avoid a typo in the patch subject?
> 
> Regards,
> Markus

Hi,

This is the semi-friendly patch-bot of Greg Kroah-Hartman.

Markus, you seem to have sent a nonsensical or otherwise pointless
review comment to a patch submission on a Linux kernel developer mailing
list.  I strongly suggest that you not do this anymore.  Please do not
bother developers who are actively working to produce patches and
features with comments that, in the end, are a waste of time.

Patch submitter, please ignore Markus's suggestion; you do not need to
follow it at all.  The person/bot/AI that sent it is being ignored by
almost all Linux kernel maintainers for having a persistent pattern of
behavior of producing distracting and pointless commentary, and
inability to adapt to feedback.  Please feel free to also ignore emails
from them.

thanks,

greg k-h's patch email bot
