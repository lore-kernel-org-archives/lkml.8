Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60F21C3F2CD
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 16:20:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CB0F2051A
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 16:20:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727439AbgCWQUQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 12:20:16 -0400
Received: from mx2.suse.de ([195.135.220.15]:60826 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727312AbgCWQUP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 12:20:15 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 3DBF0AEA4;
        Mon, 23 Mar 2020 16:20:14 +0000 (UTC)
Message-ID: <1584980402.27949.21.camel@suse.de>
Subject: Re: lockdep warning in urb.c:363 usb_submit_urb
From:   Oliver Neukum <oneukum@suse.de>
To:     Qais Yousef <qais.yousef@arm.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 23 Mar 2020 17:20:02 +0100
In-Reply-To: <20200323155746.du2ogtvy6gnjzpb4@e107158-lin.cambridge.arm.com>
References: <20200323143857.db5zphxhq4hz3hmd@e107158-lin.cambridge.arm.com>
         <1584977769.27949.18.camel@suse.de>
         <20200323155746.du2ogtvy6gnjzpb4@e107158-lin.cambridge.arm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Montag, den 23.03.2020, 15:57 +0000 schrieb Qais Yousef:
> On 03/23/20 16:36, Oliver Neukum wrote:
> > Am Montag, den 23.03.2020, 14:38 +0000 schrieb Qais Yousef:
> > > Hi
> > > 
> > > I've hit the following lockdep warning when I trigger hibernate on arm64
> > > platform (Juno-r2)
> > > 
> > > 
> > > 	echo suspend > /sys/power/disk
> > > 	echo disk > /sys/power/state
> > > 
> > > I only had a usb flash drive attached to it. Let me know if you need more info.
> > 
> > Hi,
> > 
> > that is not a lockdep issue, but the hub driver is not properly killing
> > its URB presumably. Yet, the driver looks correct to me. Please use
> > the additional patch and activate dynamic debugging for usbcore.
> 
> Yes sorry my bad, it's a WARN_ONCE().
> 
> I applied your patch and will reproduce, but meanwhile not sure if you noticed
> this line in my previous email
> 
> [  327.154849] usb usb2: runtime PM trying to activate child device usb2 but parent (7ffb0000.ohci) is not active

Hi,

yes I noticed, but that did not trigger the WARN(). One thing at a time
please.

	Regards
		Oliver

