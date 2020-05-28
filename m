Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F114C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 14:04:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3BA1520814
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 14:04:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390885AbgE1OEq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 10:04:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390644AbgE1OEn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 10:04:43 -0400
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9720BC05BD1E
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 07:04:43 -0700 (PDT)
Received: by ozlabs.org (Postfix, from userid 1034)
        id 49XqFj0Wktz9sRY; Fri, 29 May 2020 00:04:40 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Rui Salvaterra <rsalvaterra@gmail.com>,
        Paul Mackerras <paulus@samba.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
In-Reply-To: <b34706f8de87f84d135abb5f3ede6b6f16fb1f41.1589969799.git.christophe.leroy@csgroup.eu>
References: <b34706f8de87f84d135abb5f3ede6b6f16fb1f41.1589969799.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH] Revert "powerpc/32s: reorder Linux PTE bits to better match Hash PTE bits."
Message-Id: <159067441582.2990081.4426286987662980016.b4-ty@ellerman.id.au>
Date:   Fri, 29 May 2020 00:04:40 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 May 2020 10:23:45 +0000 (UTC), Christophe Leroy wrote:
> This reverts commit 697ece78f8f749aeea40f2711389901f0974017a.
> 
> The implementation of SWAP on powerpc requires page protection
> bits to not be one of the least significant PTE bits.
> 
> Until the SWAP implementation is changed and this requirement voids,
> we have to keep at least _PAGE_RW outside of the 3 last bits.
> 
> [...]

Applied to powerpc/fixes.

[1/1] Revert "powerpc/32s: reorder Linux PTE bits to better match Hash PTE bits."
      https://git.kernel.org/powerpc/c/40bb0e904212cf7d6f041a98c58c8341b2016670

cheers
