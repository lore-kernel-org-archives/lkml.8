Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 945F2C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 05:29:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 73341207ED
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 05:29:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727984AbgFIF3c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 01:29:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727792AbgFIF2r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 01:28:47 -0400
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BEFAC03E969
        for <linux-kernel@vger.kernel.org>; Mon,  8 Jun 2020 22:28:47 -0700 (PDT)
Received: by ozlabs.org (Postfix, from userid 1034)
        id 49gzDs2zx8z9sTH; Tue,  9 Jun 2020 15:28:44 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Paul Mackerras <paulus@samba.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
In-Reply-To: <7195fcde7314ccbf7a081b356084a69d421b10d4.1590660977.git.christophe.leroy@csgroup.eu>
References: <7195fcde7314ccbf7a081b356084a69d421b10d4.1590660977.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH] powerpc/32: disable KASAN with pages bigger than 16k
Message-Id: <159168035113.1381411.9694012621969820760.b4-ty@ellerman.id.au>
Date:   Tue,  9 Jun 2020 15:28:44 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 May 2020 10:17:04 +0000 (UTC), Christophe Leroy wrote:
> Mapping of early shadow area is implemented by using a single static
> page table having all entries pointing to the same early shadow page.
> The shadow area must therefore occupy full PGD entries.
> 
> The shadow area has a size of 128Mbytes starting at 0xf8000000.
> With 4k pages, a PGD entry is 4Mbytes
> With 16k pages, a PGD entry is 64Mbytes
> With 64k pages, a PGD entry is 256Mbytes which is too big.
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc/32: Disable KASAN with pages bigger than 16k
      https://git.kernel.org/powerpc/c/888468ce725a4cd56d72dc7e5096078f7a9251a0

cheers
