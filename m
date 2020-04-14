Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F14C0C2BA19
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 10:34:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CBD0120644
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 10:34:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XAUMCg1P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438423AbgDNKet (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 06:34:49 -0400
Received: from merlin.infradead.org ([205.233.59.134]:40888 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438346AbgDNKb6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 06:31:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=+wYwEgzump+qpt5j5BFe+BA8kgNlXr5m7+TftlYnh/4=; b=XAUMCg1POmlq72FZc2Muxszh5S
        K8W7/CdgLCHNS7c1/bRiqDswfmSQxwJJa5SaHY1WLUuzKPHEHi7Peib5/R8PKWSVBHMna8Nxl1WDT
        Yu/MQBUZAuVuEBQRnDshVTsJUFZ6qmwE9cCkjqT1c6eVe6TUSA2TWBijihzfmqjr51uie5hElGdT9
        8WFzeWBKPB+1SGrsUtxaif+eh2yimPWX7QWMzNLhxO3ZB9B7bwI/O2AFCsTi/qMtZvOuS3P0SxdKK
        JGMrCeADxqLpQPqNbaU3fitrWzEZIQxXhx7qeHf5K3QO17hBHcWxCO/MiBHd3h/p8ib8nvKNDuGcm
        ucTbPSfg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jOIqT-0003Hx-UO; Tue, 14 Apr 2020 10:31:10 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 6A2A0305EEC;
        Tue, 14 Apr 2020 12:31:06 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 30F4B20B15B8A; Tue, 14 Apr 2020 12:31:06 +0200 (CEST)
Date:   Tue, 14 Apr 2020 12:31:06 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Kyung Min Park <kyung.min.park@intel.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de,
        mingo@redhat.com, hpa@zytor.com, gregkh@linuxfoundation.org,
        ak@linux.intel.com, tony.luck@intel.com, ashok.raj@intel.com,
        ravi.v.shankar@intel.com, fenghua.yu@intel.com
Subject: Re: [PATCH v3 3/3] x86/delay: Introduce TPAUSE delay
Message-ID: <20200414103106.GK20713@hirez.programming.kicks-ass.net>
References: <1586561395-50914-1-git-send-email-kyung.min.park@intel.com>
 <1586561395-50914-4-git-send-email-kyung.min.park@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1586561395-50914-4-git-send-email-kyung.min.park@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 10, 2020 at 04:29:55PM -0700, Kyung Min Park wrote:
> +static inline void __tpause(u32 ecx, u32 edx, u32 eax)
> +{
> +	/* "tpause %ecx, %edx, %eax;" */
> +	asm volatile(".byte 0x66, 0x0f, 0xae, 0xf1\t\n"
> +		     :
> +		     : "c"(ecx), "d"(edx), "a"(eax));
> +}

Can we please get a comment stating from what binutils version this
opcode has a mnemonic? That way, when we raise the minimum binutils
version we can easily grep and find such things.
