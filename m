Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E3EBC4332D
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 15:38:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28E5B2080C
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 15:38:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728040AbgCSPiZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 11:38:25 -0400
Received: from eddie.linux-mips.org ([148.251.95.138]:56256 "EHLO
        cvs.linux-mips.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727512AbgCSPiZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 11:38:25 -0400
X-Greylist: delayed 1389 seconds by postgrey-1.27 at vger.kernel.org; Thu, 19 Mar 2020 11:38:24 EDT
Received: (from localhost user: 'macro', uid#1010) by eddie.linux-mips.org
        with ESMTP id S23991640AbgCSPPNBl1o2 (ORCPT
        <rfc822;netdev@vger.kernel.org> + 1 other);
        Thu, 19 Mar 2020 16:15:13 +0100
Date:   Thu, 19 Mar 2020 15:15:13 +0000 (GMT)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Randy Dunlap <rdunlap@infradead.org>
cc:     LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        David Miller <davem@davemloft.net>
Subject: Re: [RFC PATCH] x86: slightly reduce defconfigs
In-Reply-To: <433f203e-4e00-f317-2e6b-81518b72843c@infradead.org>
Message-ID: <alpine.LFD.2.21.2003191514290.1745527@eddie.linux-mips.org>
References: <433f203e-4e00-f317-2e6b-81518b72843c@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Feb 2020, Randy Dunlap wrote:

> Eliminate 2 config symbols from both x86 defconfig files:
> HAMRADIO and FDDI.
> 
> The FDDI Kconfig file even says (for the FDDI config symbol):
>   Most people will say N.

 For CONFIG_FDDI:

Acked-by: Maciej W. Rozycki <macro@linux-mips.org>

  Maciej
