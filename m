Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A794BC43461
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 16:28:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 67A6121D7D
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 16:28:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730261AbgIIQ2u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 12:28:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731132AbgIIQ1k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 12:27:40 -0400
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5383BC0617A3
        for <linux-kernel@vger.kernel.org>; Wed,  9 Sep 2020 06:28:56 -0700 (PDT)
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4BmjWF5Pj0z9sVR; Wed,  9 Sep 2020 23:27:53 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Leonardo Bras <leobras.c@gmail.com>,
        Murilo Fossa Vicentini <muvic@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        David Dai <zdai@linux.vnet.ibm.com>,
        Ram Pai <linuxram@us.ibm.com>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        Paul Mackerras <paulus@samba.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Brian King <brking@linux.vnet.ibm.com>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
In-Reply-To: <20200805030455.123024-1-leobras.c@gmail.com>
References: <20200805030455.123024-1-leobras.c@gmail.com>
Subject: Re: [PATCH v5 0/4] Allow bigger 64bit window by removing default DMA window
Message-Id: <159965717483.808686.14535897310310541742.b4-ty@ellerman.id.au>
Date:   Wed,  9 Sep 2020 23:27:53 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 Aug 2020 00:04:51 -0300, Leonardo Bras wrote:
> There are some devices in which a hypervisor may only allow 1 DMA window
> to exist at a time, and in those cases, a DDW is never created to them,
> since the default DMA window keeps using this resource.
> 
> LoPAR recommends this procedure:
> 1. Remove the default DMA window,
> 2. Query for which configs the DDW can be created,
> 3. Create a DDW.
> 
> [...]

Applied to powerpc/next.

[1/4] powerpc/pseries/iommu: Create defines for operations in ibm, ddw-applicable
      https://git.kernel.org/powerpc/c/cac3e629086f1b2e31c87a6c9b0130d29843ae86
[2/4] powerpc/pseries/iommu: Update call to ibm, query-pe-dma-windows
      https://git.kernel.org/powerpc/c/80f0251231131d164eddab78d2b6c1b8e37d0093
[3/4] powerpc/pseries/iommu: Move window-removing part of remove_ddw into remove_dma_window
      https://git.kernel.org/powerpc/c/74d0b3994e147a2b503170b5e02f1d07dc086586
[4/4] powerpc/pseries/iommu: Allow bigger 64bit window by removing default DMA window
      https://git.kernel.org/powerpc/c/8c0d51592f6f0123953633d1ecf21e843fce0bfd

cheers
