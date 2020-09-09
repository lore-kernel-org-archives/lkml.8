Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0003C433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 16:34:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 771982166E
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 16:34:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731177AbgIIQeu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 12:34:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731116AbgIIQ12 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 12:27:28 -0400
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A23BC06179B
        for <linux-kernel@vger.kernel.org>; Wed,  9 Sep 2020 06:27:48 -0700 (PDT)
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4BmjVy5cDVz9sVb; Wed,  9 Sep 2020 23:27:38 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     hch@infradead.org, Michael Ellerman <mpe@ellerman.id.au>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Paul Mackerras <paulus@samba.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
In-Reply-To: <245cabd8f291facac8c8c5fd370e361a69e02860.1597384145.git.christophe.leroy@csgroup.eu>
References: <245cabd8f291facac8c8c5fd370e361a69e02860.1597384145.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH v2] powerpc: Remove flush_instruction_cache() on 8xx
Message-Id: <159965717033.808686.4691063730479167234.b4-ty@ellerman.id.au>
Date:   Wed,  9 Sep 2020 23:27:37 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 Aug 2020 05:49:29 +0000 (UTC), Christophe Leroy wrote:
> flush_instruction_cache() is never used on 8xx, remove it.

Applied to powerpc/next.

[1/1] powerpc: Remove flush_instruction_cache() on 8xx
      https://git.kernel.org/powerpc/c/76d46a1e2fe2c35f24c07b7cc8a41afbf98b349e

cheers
