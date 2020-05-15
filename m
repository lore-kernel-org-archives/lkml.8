Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27BFDC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 17:52:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1255C20727
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 17:52:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726263AbgEORwU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 13:52:20 -0400
Received: from ms.lwn.net ([45.79.88.28]:53540 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726183AbgEORwU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 13:52:20 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id CD95A72D;
        Fri, 15 May 2020 17:52:19 +0000 (UTC)
Date:   Fri, 15 May 2020 11:52:18 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-kernel@vger.kernel.org,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Simon Horman <horms+renesas@verge.net.au>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>
Subject: Re: [PATCH 01/14] docs: move DMA kAPI to Documentation/core-api
Message-ID: <20200515115218.4d805685@lwn.net>
In-Reply-To: <a1517185418cb9d987f566ef85a5dd5c7c99f34e.1588345503.git.mchehab+huawei@kernel.org>
References: <cover.1588345503.git.mchehab+huawei@kernel.org>
        <a1517185418cb9d987f566ef85a5dd5c7c99f34e.1588345503.git.mchehab+huawei@kernel.org>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  1 May 2020 17:37:45 +0200
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> Move those files to the core-api, where they belong, renaming
> them to ReST and adding to the core API index file.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  .../{DMA-API-HOWTO.txt => core-api/dma-api-howto.rst}         | 0
>  Documentation/{DMA-API.txt => core-api/dma-api.rst}           | 0
>  .../{DMA-attributes.txt => core-api/dma-attributes.rst}       | 0
>  Documentation/{DMA-ISA-LPC.txt => core-api/dma-isa-lpc.rst}   | 0
>  Documentation/core-api/index.rst                              | 4 ++++
>  5 files changed, 4 insertions(+)
>  rename Documentation/{DMA-API-HOWTO.txt => core-api/dma-api-howto.rst} (100%)
>  rename Documentation/{DMA-API.txt => core-api/dma-api.rst} (100%)
>  rename Documentation/{DMA-attributes.txt => core-api/dma-attributes.rst} (100%)
>  rename Documentation/{DMA-ISA-LPC.txt => core-api/dma-isa-lpc.rst} (100%)

This one seems obvious, applied.

jon
