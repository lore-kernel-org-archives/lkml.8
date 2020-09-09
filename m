Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A21A4C10DAA
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 16:29:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5CC46206B8
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 16:29:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731112AbgIIQ3a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 12:29:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731130AbgIIQ1k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 12:27:40 -0400
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A05AC061755
        for <linux-kernel@vger.kernel.org>; Wed,  9 Sep 2020 06:27:41 -0700 (PDT)
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4BmjVs2XLBz9sVR; Wed,  9 Sep 2020 23:27:33 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
In-Reply-To: <fbe58d27cf128d5fe581e4510ded8701858f268e.1596716328.git.christophe.leroy@csgroup.eu>
References: <fbe58d27cf128d5fe581e4510ded8701858f268e.1596716328.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH] powerpc/hwirq: Remove stale forward irq_chip declaration
Message-Id: <159965716610.808686.6255095510129044770.b4-ty@ellerman.id.au>
Date:   Wed,  9 Sep 2020 23:27:33 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Aug 2020 12:19:06 +0000 (UTC), Christophe Leroy wrote:
> Since commit identified below, the forward declaration of
> struct irq_chip is useless (was struct hw_interrupt_type at that time)
> 
> Remove it, together with the associated comment.

Applied to powerpc/next.

[1/1] powerpc/hwirq: Remove stale forward irq_chip declaration
      https://git.kernel.org/powerpc/c/169b9afee572853522901b7cbf34842c0494a887

cheers
