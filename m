Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59491CA90AF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 12:43:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D4A8206B7
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 12:43:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731994AbgEMMnn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 08:43:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729041AbgEMMnl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 08:43:41 -0400
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 679FCC061A0C
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 05:43:41 -0700 (PDT)
Received: by ozlabs.org (Postfix, from userid 1034)
        id 49MZ973C9Jz9sRf; Wed, 13 May 2020 22:43:39 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Paul Mackerras <paulus@samba.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
In-Reply-To: <ea599546f2a7771bde551393889e44e6b2632332.1587368807.git.christophe.leroy@c-s.fr>
References: <ea599546f2a7771bde551393889e44e6b2632332.1587368807.git.christophe.leroy@c-s.fr>
Subject: Re: [PATCH] powerpc/32s: Fix build failure with CONFIG_PPC_KUAP_DEBUG
Message-Id: <158937375571.3526905.9278561779310816982.b4-ty@ellerman.id.au>
Date:   Wed, 13 May 2020 22:43:39 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Apr 2020 07:47:05 +0000 (UTC), Christophe Leroy wrote:
> gpr2 is not a parametre of kuap_check(), it doesn't exist.
> 
> Use gpr instead.

Applied to powerpc/fixes.

[1/1] powerpc/32s: Fix build failure with CONFIG_PPC_KUAP_DEBUG
      https://git.kernel.org/powerpc/c/4833ce06e6855d526234618b746ffb71d6612c9a

cheers
