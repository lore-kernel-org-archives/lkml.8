Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8EC4C2BA2B
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 14:20:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F9C52078A
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 14:20:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=firstfloor.org header.i=@firstfloor.org header.b="reAgR5jj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729058AbgDGOUG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 10:20:06 -0400
Received: from one.firstfloor.org ([193.170.194.197]:40912 "EHLO
        one.firstfloor.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728737AbgDGOUG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 10:20:06 -0400
Received: by one.firstfloor.org (Postfix, from userid 503)
        id A6FD78733C; Tue,  7 Apr 2020 16:20:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=firstfloor.org;
        s=mail; t=1586269203;
        bh=lRzrQwhMU5K1R+FJHTlsmI5L3Ae0ffZFkwYoksiVqAg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=reAgR5jjyJWwcXa6izYSZ7QW82J41bt4hnpQ9Fr3T6bRdmGKs3HnL4XvvYKvycXVb
         femjynZgUxgi2MBsoha0TLacKsKqpIB3rcNbd4w6qZRoukub6fI375GwmK857nMhFz
         +cXTpLXOQ6j7+B/C9TgdB6fJssIIHTDuuFq2UTAY=
Date:   Tue, 7 Apr 2020 07:20:03 -0700
From:   Andi Kleen <andi@firstfloor.org>
To:     Keno Fischer <keno@juliacomputing.com>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andi Kleen <andi@firstfloor.org>,
        Kyle Huey <khuey@kylehuey.com>,
        Robert O'Callahan <robert@ocallahan.org>
Subject: Re: [RFC PATCH v2] x86/arch_prctl: Add ARCH_SET_XCR0 to set XCR0
 per-thread
Message-ID: <20200407142002.jxzc3xcuyoznjgkh@two.firstfloor.org>
References: <20200407011259.GA72735@juliacomputing.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200407011259.GA72735@juliacomputing.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Thank you in advance for any review comments - I thought the comments
> on v1 were quite helpful. I understand this is a tall ask for mainline
> inclusion, but the feature is just too useful for me to give up ;).

> [1] https://lkml.org/lkml/2018/6/16/134

The rationale from that post should have been in this description.

You can already do what you want using the clearcpuid= boot flags using the
infrastructure in [1], which is in newer kernels.

So to disable AVX512 you would use clearcpuid=304 and the AVX feature
set should be the same as Haswell. To disable AVX2 you would use
clearcpuid=293 and you get the same feature set as Sandy Bridge.

A boot option is not as convenient as a run time setting, but has a lot
less weird corner cases.

-Andi

[1]
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/arch/x86/kernel/cpu/cpuid-deps.c?id=0b00de857a648dafe7020878c7a27cf776f5edf4

-Andi
