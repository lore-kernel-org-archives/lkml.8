Return-Path: <SRS0=flzY=3U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D19EDC2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 15:08:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A3E9215A4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 15:08:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580483320;
	bh=ZkdW85X6BcWzNT1iz4ptdsfG0j76MIA8CDAdsvmLkzA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=RHNG1IaH1USI0gfmSBZfsa1LBRm0Io6CDVtjaBywZBq+vs36Pj2phagICGWA0XBuO
	 lnpxb6v69OYnYXZFskMKsrgHDZRlSLAsL47M8AtNRNv9qSJz70irqJcCVgtmV/acQb
	 djU9Z6Qw4yvgk/BuGqhS24SiVJ0ZeOqIm1kuTV/A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729214AbgAaPIk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jan 2020 10:08:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:60126 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729074AbgAaPIj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jan 2020 10:08:39 -0500
Received: from cakuba.hsd1.ca.comcast.net (unknown [199.201.64.133])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9AF8A20661;
        Fri, 31 Jan 2020 15:08:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580483319;
        bh=ZkdW85X6BcWzNT1iz4ptdsfG0j76MIA8CDAdsvmLkzA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=BJGyawYVyxoZlC+x0fG3Jauyae4GzlZNsHkGyzwVCnaC188CKuWjoyHLItzYxXUKt
         jx2FtGHt64QV/UskNi8X8wsuq97+q3FrO0QlSZXxEHlpdEwi55pp2Mkru7pklBLjOK
         cC9hOsbyWrrNTOallZtJA28zhARKajRRtDb4vnFs=
Date:   Fri, 31 Jan 2020 07:08:37 -0800
From:   Jakub Kicinski <kuba@kernel.org>
To:     christopher.s.hall@intel.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, hpa@zytor.com, mingo@redhat.com,
        x86@kernel.org, jacob.e.keller@intel.com, richardcochran@gmail.com,
        davem@davemloft.net, sean.v.kelley@intel.com
Subject: Re: [Intel PMC TGPIO Driver 0/5] Add support for Intel PMC Time
 GPIO Driver with PHC interface changes to support additional H/W Features
Message-ID: <20200131070837.52a6c513@cakuba.hsd1.ca.comcast.net>
In-Reply-To: <20191211214852.26317-1-christopher.s.hall@intel.com>
References: <20191211214852.26317-1-christopher.s.hall@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some process notes here:

On Wed, 11 Dec 2019 13:48:47 -0800, christopher.s.hall@intel.com wrote:

Please fix the date on your system / patches.

> Acknowledgment: Portions of the driver code were authored by Felipe
> Balbi <balbi@kernel.org>

Strangely none of the patches carry his sign-off tho, neither have you
CCed him?

Presumably this is going via the networking tree, so please tag the
patches with [PATCH net-next] rather than the name of the driver.
Subject should sufficiently serve as an indication of what the patches
do.

The net-next networking tree is now closed and will reopen shortly
after the merge window is over:

http://vger.kernel.org/~davem/net-next.html

If you post a next version before it's open to get reviews - please
post it as [RFC net-next].

(also don't use "static inline" in C files, compiler will know)
