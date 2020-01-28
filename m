Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS,URIBL_DBL_ABUSE_MALW autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EDD3C33CB3
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 11:50:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55DCB24687
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 11:50:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="bWCQD9Vq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726182AbgA1Lu2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 06:50:28 -0500
Received: from ozlabs.org ([203.11.71.1]:59483 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725903AbgA1Lu2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 06:50:28 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 486Q0c3KnHz9sP6;
        Tue, 28 Jan 2020 22:50:24 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1580212225;
        bh=c5DNuCqxh54Hk0ufEiRkHS36c/7jzrd+sF8bgHCvQeU=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=bWCQD9VqND/0LIAyeQoi7QbDUbEjZVmPv5DOscLMdnPaB0sHImlK8hI9jpcRk2xtO
         e4y/KYr++Iqj+7eUazD04bDFuhcR5p7moyYc9h/6A/lg+aMUxe2WussGhB9fEBWhsB
         n8UJY1ZzKMnmBsjun8MdIrew4iERCJDh0eDZEGGeXJTVMw9ZgEjrmqtkWhpMSH3U54
         XplqhK4ZpMplOMbpphQGk7DNoc+f1IZ36103ePsFtvoGTN1G4b7MdlvMzGc5woRizD
         ml/aSd0/fJt37f/e+H5mtsbWPJs1OtTCHXOslhfSuKmJacBYTeEHEmbfIW+jy6qG3m
         ANYhsu3fiGTjg==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Vinod Koul <vkoul@kernel.org>, peter.ujfalusi@ti.com
Cc:     dma <dmaengine@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, corbet@lwn.net,
        linux-doc@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Docs build broken by driver-api/dmaengine/client.rst ? (was Re: [GIT PULL]: dmaengine updates for v5.6-rc1)
In-Reply-To: <20200127145835.GI2841@vkoul-mobl>
References: <20200127145835.GI2841@vkoul-mobl>
Date:   Tue, 28 Jan 2020 22:50:21 +1100
Message-ID: <87imkvhkaq.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vinod,

Vinod Koul <vkoul@kernel.org> writes:
> Hello Linus,
>
> Please pull to receive the dmaengine updates for v5.6-rc1. This time we
> have a bunch of core changes to support dynamic channels, hotplug of
> controllers, new apis for metadata ops etc along with new drivers for
> Intel data accelerators, TI K3 UDMA, PLX DMA engine and hisilicon
> Kunpeng DMA engine. Also usual assorted updates to drivers.
>
> The following changes since commit e42617b825f8073569da76dc4510bfa019b1c35a:
>
>   Linux 5.5-rc1 (2019-12-08 14:57:55 -0800)
>
> are available in the Git repository at:
>
>   git://git.infradead.org/users/vkoul/slave-dma.git tags/dmaengine-5.6-rc1
>
> for you to fetch changes up to 71723a96b8b1367fefc18f60025dae792477d602:
>
>   dmaengine: Create symlinks between DMA channels and slaves (2020-01-24 11:41:32 +0530)
>
> ----------------------------------------------------------------
> dmaengine updates for v5.6-rc1
...
>
> Peter Ujfalusi (9):
>       dmaengine: doc: Add sections for per descriptor metadata support

This broke the docs build for me with:

  Sphinx parallel build error:
  docutils.utils.SystemMessage: /linux/Documentation/driver-api/dmaengine/client.rst:155: (SEVERE/4) Unexpected section title.
  
  Optional: per descriptor metadata
  ---------------------------------


The patch below fixes the build. It may not produce the output you
intended, it just makes it bold rather than a heading, but it doesn't
really make sense to have a heading inside a numbered list.

diff --git a/Documentation/driver-api/dmaengine/client.rst b/Documentation/driver-api/dmaengine/client.rst
index a9a7a3c84c63..343df26e73e8 100644
--- a/Documentation/driver-api/dmaengine/client.rst
+++ b/Documentation/driver-api/dmaengine/client.rst
@@ -151,8 +151,8 @@ DMA usage
      Note that callbacks will always be invoked from the DMA
      engines tasklet, never from interrupt context.
 
-  Optional: per descriptor metadata
-  ---------------------------------
+  **Optional: per descriptor metadata**
+
   DMAengine provides two ways for metadata support.
 
   DESC_METADATA_CLIENT



cheers
