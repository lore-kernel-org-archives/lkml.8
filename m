Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3497DC10DAA
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 16:29:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED620206B8
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 16:29:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731131AbgIIQ3w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 12:29:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731129AbgIIQ1k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 12:27:40 -0400
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A11DC061796
        for <linux-kernel@vger.kernel.org>; Wed,  9 Sep 2020 06:27:41 -0700 (PDT)
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4BmjVt10gLz9sTN; Wed,  9 Sep 2020 23:27:33 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
In-Reply-To: <e0bcdabac45fcd26c02d7df273bd4a5827c6033d.1596716375.git.christophe.leroy@csgroup.eu>
References: <e0bcdabac45fcd26c02d7df273bd4a5827c6033d.1596716375.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH] powerpc/irq: Drop forward declaration of struct irqaction
Message-Id: <159965716629.808686.18358177011917781182.b4-ty@ellerman.id.au>
Date:   Wed,  9 Sep 2020 23:27:33 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Aug 2020 12:19:46 +0000 (UTC), Christophe Leroy wrote:
> Since the commit identified below, the forward declaration of
> struct irqaction is useless. Drop it.

Applied to powerpc/next.

[1/1] powerpc/irq: Drop forward declaration of struct irqaction
      https://git.kernel.org/powerpc/c/b134cfc3e3276ccd5d29e39de5c848a45b08e410

cheers
