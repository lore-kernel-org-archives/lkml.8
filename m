Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1C8CC34050
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 12:40:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83EF524654
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 12:40:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727827AbgBSMkB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 07:40:01 -0500
Received: from ozlabs.org ([203.11.71.1]:40389 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727780AbgBSMj7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 07:39:59 -0500
Received: by ozlabs.org (Postfix, from userid 1034)
        id 48My3d1z1Vz9sST; Wed, 19 Feb 2020 23:39:55 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: a4031afb9d10d97f4d0285844abbc0ab04245304
In-Reply-To: <4f70c2778163affce8508a210f65d140e84524b4.1581272050.git.christophe.leroy@c-s.fr>
To:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc/8xx: Fix clearing of bits 20-23 in ITLB miss
Message-Id: <48My3d1z1Vz9sST@ozlabs.org>
Date:   Wed, 19 Feb 2020 23:39:55 +1100 (AEDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2020-02-09 at 18:14:42 UTC, Christophe Leroy wrote:
> In ITLB miss handled the line supposed to clear bits 20-23 on the
> L2 ITLB entry is buggy and does indeed nothing, leading to undefined
> value which could allow execution when it shouldn't.
> 
> Properly do the clearing with the relevant instruction.
> 
> Fixes: 74fabcadfd43 ("powerpc/8xx: don't use r12/SPRN_SPRG_SCRATCH2 in TLB Miss handlers")
> Cc: stable@vger.kernel.org
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/a4031afb9d10d97f4d0285844abbc0ab04245304

cheers
