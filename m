Return-Path: <SRS0=eufF=BE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4A0DC433E1
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jul 2020 06:20:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B351220714
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jul 2020 06:20:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595658037;
	bh=aB9zslYB9/2Zug7XW92hg+SH4Gw3jq74h7xUfY0Khjc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=sng9AFp2b8QiEHVYk1cx8i1TOKJqvDgkqpQdpqrrZCV0LBNnWDbcSWMBlaU/WGXLb
	 x2AkwMlV8Fmv+L+Pp3HYXbGzz4WLtY9O8ZrYbgg54qz6Y7EN6QzggsEU5cy8jSDD03
	 SZTFI+q1jxgd0h4kAfOqHdyUkxtZPwlWFWwYQ338=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726892AbgGYGUg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Jul 2020 02:20:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:38622 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725941AbgGYGUg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jul 2020 02:20:36 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 48B96206F6;
        Sat, 25 Jul 2020 06:20:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595658035;
        bh=aB9zslYB9/2Zug7XW92hg+SH4Gw3jq74h7xUfY0Khjc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oGxWhl6pX1redUPCtEPHGjscZjpVsQwwCNnS58+JVpKSRMPNC36Y5kelBLcG0GMrs
         +cH1yc2sVyTw7+s/ZgvAJ61jZxCaQ9MpzI3I7tOh8qguahi3TxJA3vCdBZTWYqgITv
         70Bgc9E2903GqWzVCzc3dvE0ob0y7By9zNVbQvI4=
Date:   Sat, 25 Jul 2020 08:20:35 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     =?utf-8?B?5b2t5rWp?= <penghao@uniontech.com>
Cc:     perex <perex@perex.cz>, tiwai <tiwai@suse.com>,
        alsa-devel <alsa-devel@alsa-project.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        phz0008 <phz0008@163.com>,
        "penghao@deepin.com " <penghao@deepin.com>
Subject: Re: Re: [PATCH 14216/14216] ALSA: usb-audio: This patch for prevent
 autowakeup from s3 trig by usb disconnect signal from Lenovo
 ThinkcentreTI024Gen3  USB-audio.
Message-ID: <20200725062035.GB1051290@kroah.com>
References: <20200725040155.27648-1-penghao@uniontech.com>
 <20200725054844.GA1045868@kroah.com>
 <2108119032.587807.1595657354769.JavaMail.xmail@bj-wm-cp-2>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2108119032.587807.1595657354769.JavaMail.xmail@bj-wm-cp-2>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 25, 2020 at 02:09:14PM +0800, 彭浩 wrote:
> This email message is intended only for the use of the individual or entity who
> /which is the intended recipient and may contain information that is privileged
> or confidential. If you are not the intended recipient, you are hereby notified
> that any use, dissemination, distribution or copying of, or taking any action
> in reliance on, this e-mail is strictly prohibited. If you have received this
> email in error, please notify UnionTech Software Technology  immediately by
> replying to this e-mail and immediately delete and discard all copies of the
> e-mail and the attachment thereto (if any). Thank you.

Please note that this email footer is not compatible with kernel
development, so I have now removed it from my system.

greg k-h
