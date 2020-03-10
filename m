Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B46F7C10F27
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 09:50:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 882872467D
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 09:50:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583833817;
	bh=Zu/l5fryMW6NbrP4kqlO7eEbl7l/EtuRNKW9VU2dTOo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=FPrl/EgKgiierRS/nQVrlXy6XQrqn0iVaCyYIjNUJKq5TPrJVAkSRFtoAknKi+G4m
	 uHKl02hr1exbh78slvC93udDEcKHKaaH3IJ/2+CeHv0W0Ml+uu0McnD340pik3HWh6
	 4K765W+fZgIkEtt4i5nNHe55E2wuqW/CMSTCAb2U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726477AbgCJJuQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 05:50:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:33542 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726211AbgCJJuQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 05:50:16 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9C6692467D;
        Tue, 10 Mar 2020 09:50:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583833814;
        bh=Zu/l5fryMW6NbrP4kqlO7eEbl7l/EtuRNKW9VU2dTOo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cZWYPiukgKFacUoodHREbVxDOxigTZzXF4VAOl5wFscRpq7DlS/TVQ+3rNtlWREUO
         k9voy+NeQzCD8D7fAS8va/5qrZZx51k4Ql7uH6EKgkhgbEVgg7BpbxykGGLjxlJ1sQ
         VJMVJ5RXrlc76ZTnuWPjJlVWNSm5bCJXnsdFV5Og=
Date:   Tue, 10 Mar 2020 10:50:11 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Malcolm Priestley <tvboxspy@gmail.com>
Cc:     Oscar Carter <oscar.carter@gmx.com>, devel@driverdev.osuosl.org,
        Colin Ian King <colin.king@canonical.com>,
        Forest Bond <forest@alittletooquiet.net>,
        Gabriela Bittencourt <gabrielabittencourt00@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: vt6656: Use BIT_ULL() macro instead of bit
 shift operation
Message-ID: <20200310095011.GC2516963@kroah.com>
References: <20200307104929.7710-1-oscar.carter@gmx.com>
 <20200308065538.GF3983392@kroah.com>
 <20200308161047.GA3285@ubuntu>
 <561bc968-f88c-40e3-f53c-5c03f74f75ea@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <561bc968-f88c-40e3-f53c-5c03f74f75ea@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 08, 2020 at 07:22:07PM +0000, Malcolm Priestley wrote:
> >>>   */
> >>>  #undef __NO_VERSION__
> >>>
> >>> +#include <linux/bits.h>
> >>>  #include <linux/etherdevice.h>
> >>>  #include <linux/file.h>
> >>>  #include "device.h"
> >>> @@ -802,8 +803,7 @@ static u64 vnt_prepare_multicast(struct ieee80211_hw *hw,
> >>>
> >>>  	netdev_hw_addr_list_for_each(ha, mc_list) {
> >>>  		bit_nr = ether_crc(ETH_ALEN, ha->addr) >> 26;
> >>> -
> >>> -		mc_filter |= 1ULL << (bit_nr & 0x3f);
> >>> +		mc_filter |= BIT_ULL(bit_nr);
> >>
> >> Are you sure this does the same thing?  You are not masking off bit_nr
> >> anymore, why not?
> > 
> > My reasons are exposed below:
> > 
> > The ether_crc function returns an u32 type (unsigned of 32 bits). Then the right
> > shift operand discards the 26 lsb bits (the bits shifted off the right side are
> > discarded). The 6 msb bits of the u32 returned by the ether_crc function are
> > positioned in bit 5 to bit 0 of the variable bit_nr. Due to the right shift
> > happens over an unsigned type, the 26 new bits added on the left side will be 0.
> > 
> > In summary, after the right bit shift operation we obtain in the variable bit_nr
> > (unsigned of 32 bits) the value represented by the 6 msb bits of the value
> > returned by the ether_crc function. So, only the 6 lsb bits of the variable
> > bit_nr are important. The 26 msb bits of this variable are 0.
> > 
> > In this situation, the "and" operation with the mask 0x3f (mask of 6 lsb bits)
> > is unnecessary due to its purpose is to reset (set to 0 value) the 26 msb bits
> > that are yet 0.
> 
> The mask is only there out of legacy originally it was 31(0x1f) and the
> bit_nr spread across two mc_filter u32 arrays.
> 
> The mask is not needed now it is u64.
> 
> The patch is fine.

Ok, then the changelog needs to be fixed up to explain all of this and
resent.

thanks,

greg k-h
