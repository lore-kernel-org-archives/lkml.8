Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA70EC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 13:58:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9BD9D206B5
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 13:58:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726957AbgHRN6a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 09:58:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726880AbgHRN6X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 09:58:23 -0400
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E87AEC061342
        for <linux-kernel@vger.kernel.org>; Tue, 18 Aug 2020 06:58:22 -0700 (PDT)
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4BWCDV0lgsz9sTR; Tue, 18 Aug 2020 23:58:17 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Paul Mackerras <paulus@samba.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
In-Reply-To: <07884ed033c31e074747b7eb8eaa329d15db07ec.1596641219.git.christophe.leroy@csgroup.eu>
References: <07884ed033c31e074747b7eb8eaa329d15db07ec.1596641219.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH] powerpc/32s: Fix is_module_segment() when MODULES_VADDR is defined
Message-Id: <159775907962.1766076.11931243751061238558.b4-ty@ellerman.id.au>
Date:   Tue, 18 Aug 2020 23:58:17 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 Aug 2020 15:27:28 +0000 (UTC), Christophe Leroy wrote:
> When MODULES_VADDR is defined, is_module_segment() shall check the
> address against it instead of checking agains VMALLOC_START.

Applied to powerpc/fixes.

[1/1] powerpc/32s: Fix is_module_segment() when MODULES_VADDR is defined
      https://git.kernel.org/powerpc/c/7bee31ad8e2f6c276f36993346ac70f4d4c80e45

cheers
