Return-Path: <SRS0=8lgJ=7H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53779C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 09:34:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F30A2071A
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 09:34:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389500AbgEYJes (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 May 2020 05:34:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388437AbgEYJer (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 05:34:47 -0400
Received: from laurent.telenet-ops.be (laurent.telenet-ops.be [IPv6:2a02:1800:110:4::f00:19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50858C061A0E
        for <linux-kernel@vger.kernel.org>; Mon, 25 May 2020 02:34:47 -0700 (PDT)
Received: from ramsan ([IPv6:2a02:1810:ac12:ed60:44fd:9440:53b:cc34])
        by laurent.telenet-ops.be with bizsmtp
        id ixaV2200V5QlbNy01xaVwV; Mon, 25 May 2020 11:34:45 +0200
Received: from geert (helo=localhost)
        by ramsan with local-esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1jd9V7-0002XJ-Km; Mon, 25 May 2020 11:34:29 +0200
Date:   Mon, 25 May 2020 11:34:29 +0200 (CEST)
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     linux-kernel@vger.kernel.org
cc:     linux-um@lists.infradead.org
Subject: Re: Build regressions/improvements in v5.7-rc7
In-Reply-To: <20200525075924.23960-1-geert@linux-m68k.org>
Message-ID: <alpine.DEB.2.21.2005251132020.9189@ramsan.of.borg>
References: <20200525075924.23960-1-geert@linux-m68k.org>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 May 2020, Geert Uytterhoeven wrote:
> Below is the list of build error/warning regressions/improvements in
> JFYI, when comparing v5.7-rc7[1] to v5.7-rc6[3], the summaries are:
>  - build errors: +4/-0
>  - build warnings: +0/-0

   + error: modpost: "devm_ioremap" [drivers/net/ethernet/xilinx/ll_temac.ko] undefined!:  => N/A
   + error: modpost: "devm_ioremap_resource" [drivers/net/ethernet/xilinx/xilinx_emac.ko] undefined!:  => N/A
   + error: modpost: "devm_ioremap_resource" [drivers/ptp/ptp_ines.ko] undefined!:  => N/A
   + error: modpost: "devm_of_iomap" [drivers/net/ethernet/xilinx/ll_temac.ko] undefined!:  => N/A

um-x86_64/um-all*config

Most of these are not new, but were somehow hidden in the previous
builds.

> [1] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/9cb1fd0efd195590b828b9b865421ad345a4a145/ (194 out of 239 configs)
> [3] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/b9bbe6ed63b2b9f2c9ee5cbd0f2c946a2723f4ce/ (194 out of 239 configs)

Gr{oetje,eeting}s,

 						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
 							    -- Linus Torvalds
