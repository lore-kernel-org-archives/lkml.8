Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 852CFC3F2CD
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 15:57:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66CF320714
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 15:57:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727426AbgCWP5u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 11:57:50 -0400
Received: from foss.arm.com ([217.140.110.172]:51410 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727207AbgCWP5u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 11:57:50 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8902F1FB;
        Mon, 23 Mar 2020 08:57:49 -0700 (PDT)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.195.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D8EF13F7C3;
        Mon, 23 Mar 2020 08:57:48 -0700 (PDT)
Date:   Mon, 23 Mar 2020 15:57:46 +0000
From:   Qais Yousef <qais.yousef@arm.com>
To:     Oliver Neukum <oneukum@suse.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: lockdep warning in urb.c:363 usb_submit_urb
Message-ID: <20200323155746.du2ogtvy6gnjzpb4@e107158-lin.cambridge.arm.com>
References: <20200323143857.db5zphxhq4hz3hmd@e107158-lin.cambridge.arm.com>
 <1584977769.27949.18.camel@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1584977769.27949.18.camel@suse.de>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/23/20 16:36, Oliver Neukum wrote:
> Am Montag, den 23.03.2020, 14:38 +0000 schrieb Qais Yousef:
> > Hi
> > 
> > I've hit the following lockdep warning when I trigger hibernate on arm64
> > platform (Juno-r2)
> > 
> > 
> > 	echo suspend > /sys/power/disk
> > 	echo disk > /sys/power/state
> > 
> > I only had a usb flash drive attached to it. Let me know if you need more info.
> 
> Hi,
> 
> that is not a lockdep issue, but the hub driver is not properly killing
> its URB presumably. Yet, the driver looks correct to me. Please use
> the additional patch and activate dynamic debugging for usbcore.

Yes sorry my bad, it's a WARN_ONCE().

I applied your patch and will reproduce, but meanwhile not sure if you noticed
this line in my previous email

[  327.154849] usb usb2: runtime PM trying to activate child device usb2 but parent (7ffb0000.ohci) is not active

Thanks

--
Qais Yousef
