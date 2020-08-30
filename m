Return-Path: <SRS0=gmpU=CI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33B73C433E6
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Aug 2020 11:39:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 173DB207DA
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Aug 2020 11:39:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728801AbgH3Ljw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Aug 2020 07:39:52 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:48625 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726030AbgH3Lju (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Aug 2020 07:39:50 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4BfWb84lKlz9sTF; Sun, 30 Aug 2020 21:39:48 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>, giuseppe@sguazz.it,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
In-Reply-To: <ec96c15bfa1a7415ab604ee1c98cd45779c08be0.1598553015.git.christophe.leroy@csgroup.eu>
References: <ec96c15bfa1a7415ab604ee1c98cd45779c08be0.1598553015.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH v2] powerpc/32s: Disable VMAP stack which CONFIG_ADB_PMU
Message-Id: <159878757051.255624.17808533477852714140.b4-ty@ellerman.id.au>
Date:   Sun, 30 Aug 2020 21:39:48 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Aug 2020 18:30:27 +0000 (UTC), Christophe Leroy wrote:
> low_sleep_handler() can't restore the context from virtual
> stack because the stack can hardly be accessed with MMU OFF.
> 
> For now, disable VMAP stack when CONFIG_ADB_PMU is selected.

Applied to powerpc/fixes.

[1/1] powerpc/32s: Disable VMAP stack which CONFIG_ADB_PMU
      https://git.kernel.org/powerpc/c/4a133eb351ccc275683ad49305d0b04dde903733

cheers
