Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1649FC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 17:53:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 02B7020758
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 17:53:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726290AbgEORxX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 13:53:23 -0400
Received: from ms.lwn.net ([45.79.88.28]:53558 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726144AbgEORxX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 13:53:23 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 0071E736;
        Fri, 15 May 2020 17:53:22 +0000 (UTC)
Date:   Fri, 15 May 2020 11:53:21 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-kernel@vger.kernel.org,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Mike Rapoport <rppt@linux.ibm.com>
Subject: Re: [PATCH 02/14] docs: add bus-virt-phys-mapping.txt to core-api
Message-ID: <20200515115321.6e00ba57@lwn.net>
In-Reply-To: <ccd32aa5231b0e235a555fdecc4c0d274e5a6161.1588345503.git.mchehab+huawei@kernel.org>
References: <cover.1588345503.git.mchehab+huawei@kernel.org>
        <ccd32aa5231b0e235a555fdecc4c0d274e5a6161.1588345503.git.mchehab+huawei@kernel.org>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  1 May 2020 17:37:46 +0200
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> This describes an old interface used prior the new DMA-API
> interfaces. Add it to the core-api guide, just after the
> DMA stuff.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  .../bus-virt-phys-mapping.rst}                                   | 0
>  Documentation/core-api/index.rst                                 | 1 +
>  2 files changed, 1 insertion(+)
>  rename Documentation/{bus-virt-phys-mapping.txt => core-api/bus-virt-phys-mapping.rst} (100%)

For this one, I think we should maybe just delete the file.  It contains a
warning from *20 years ago* saying not to use it, and talks about
functions like isa_readl() that haven't existed i the kernel for some
time.  Is there any reason to keep dragging it around?

jon
