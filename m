Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0E4EC433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 14:04:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B139A20771
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 14:04:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594130694;
	bh=aI7fADWXYx23GnKpPWN2X5XgChmWqQZyJqYKmMDSAQo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=HsMllWHveQv70Fmg199sEmGwpuWETXxoMFS9/fGGBd5d310SRlHKEXljsE/vCyHFy
	 a++D74weF/21WrfYkGz8TSBt2R+BubOLGspkWLDFyO1S/Y3mHzw/FjaFbST8wQctWm
	 AFWGKgSF8nSoVUoLXm0zudvpThZzcMi5wN1JDqw4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727962AbgGGOEx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 10:04:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:43252 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726805AbgGGOEx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 10:04:53 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 398AE20738;
        Tue,  7 Jul 2020 14:04:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594130692;
        bh=aI7fADWXYx23GnKpPWN2X5XgChmWqQZyJqYKmMDSAQo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SoeLmtx77p+kv58rEoMdD32iQGKtENB4JdzIcrm0MMUfuY/CTUKXKrVkpIz3Owf1R
         HadstbQ2cSVV898JPYqRGaA55VuzX9tBpxvSTtkb8iFpJgxF7GgpWo+p9HpTGwVR5o
         2YAAJijAXWscKIGdY/F4xTheKIY36IL1I5K1nsPo=
Date:   Tue, 7 Jul 2020 16:04:50 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Babu Moger <babu.moger@amd.com>
Cc:     fenghua.yu@intel.com, stable@vger.kernel.org, mingo@redhat.com,
        bp@alien8.de, hpa@zytor.com, tglx@linutronix.de,
        reinette.chatre@intel.com, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/resctrl: Fix memory bandwidth counter width for AMD
Message-ID: <20200707140450.GB4064836@kroah.com>
References: <159364160826.31030.7457664122034606608.stgit@bmoger-ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <159364160826.31030.7457664122034606608.stgit@bmoger-ubuntu>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 01, 2020 at 05:13:45PM -0500, Babu Moger wrote:
> [ Upstream commit 2c18bd525c47f882f033b0a813ecd09c93e1ecdf ]
> 
> Memory bandwidth is calculated reading the monitoring counter
> at two intervals and calculating the delta. It is the software’s
> responsibility to read the count often enough to avoid having
> the count roll over _twice_ between reads.
> 
> The current code hardcodes the bandwidth monitoring counter's width
> to 24 bits for AMD. This is due to default base counter width which
> is 24. Currently, AMD does not implement the CPUID 0xF.[ECX=1]:EAX
> to adjust the counter width. But, the AMD hardware supports much
> wider bandwidth counter with the default width of 44 bits.
> 
> Kernel reads these monitoring counters every 1 second and adjusts the
> counter value for overflow. With 24 bits and scale value of 64 for AMD,
> it can only measure up to 1GB/s without overflowing. For the rates
> above 1GB/s this will fail to measure the bandwidth.
> 
> Fix the issue setting the default width to 44 bits by adjusting the
> offset.
> 
> AMD future products will implement CPUID 0xF.[ECX=1]:EAX.
> 
>  [ bp: Let the line stick out and drop {}-brackets around a single
>    statement. ]
> 
> Fixes: 4d05bf71f157 ("x86/resctrl: Introduce AMD QOS feature")
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> Signed-off-by: Borislav Petkov <bp@suse.de>
> Link: https://lkml.kernel.org/r/159129975546.62538.5656031125604254041.stgit@naples-babu.amd.com
> ---
> 
> Note:
>  This commit is already queued for 5.7 stable kernel.
>  Backporting it t 5.6 stable and older kernels now.

Now queued up to 5.4.y, thanks.

greg k-h
