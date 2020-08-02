Return-Path: <SRS0=HA/2=BM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C9FCC433DF
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Aug 2020 13:35:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0EF4F2065C
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Aug 2020 13:35:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728482AbgHBNfP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Aug 2020 09:35:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728423AbgHBNfP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Aug 2020 09:35:15 -0400
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC10BC06174A
        for <linux-kernel@vger.kernel.org>; Sun,  2 Aug 2020 06:35:14 -0700 (PDT)
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4BKMTC14kXz9sTH; Sun,  2 Aug 2020 23:35:10 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     linuxppc-dev@lists.ozlabs.org, Vladis Dronov <vdronov@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>
In-Reply-To: <20200729133741.62789-1-vdronov@redhat.com>
References: <20200729133741.62789-1-vdronov@redhat.com>
Subject: Re: [PATCH] powerpc: fix function annotations to avoid section mismatch warnings with gcc-10
Message-Id: <159637523829.42190.11957533441290690592.b4-ty@ellerman.id.au>
Date:   Sun,  2 Aug 2020 23:35:10 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Jul 2020 15:37:41 +0200, Vladis Dronov wrote:
> Certain warnings are emitted for powerpc code when building with a gcc-10
> toolset:
> 
>     WARNING: modpost: vmlinux.o(.text.unlikely+0x377c): Section mismatch in
>     reference from the function remove_pmd_table() to the function
>     .meminit.text:split_kernel_mapping()
>     The function remove_pmd_table() references
>     the function __meminit split_kernel_mapping().
>     This is often because remove_pmd_table lacks a __meminit
>     annotation or the annotation of split_kernel_mapping is wrong.
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc: fix function annotations to avoid section mismatch warnings with gcc-10
      https://git.kernel.org/powerpc/c/aff779515a070df7e23da9e86f1096f7d10d647e

cheers
