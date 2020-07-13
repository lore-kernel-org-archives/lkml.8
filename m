Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA918C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 06:57:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C58AB20791
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 06:57:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594623422;
	bh=yqdbFyvH04q+9XbGl3VoyxvVtRWjNuHkrGK32q5ZFg8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=jQ1NQAYvQ2FyVNOmZxvysIHVPuRYU/JgLeembSZRd59DzT4MtYXvYwX7xB2p0a5kK
	 oAiO7KxgDaoz6cETNkayipeTzA48q2APJo21gfPGt/X8ci7FpRptYPHieUjcRWXRzX
	 DWgapm3UXLg1EWFytrawShtsz3chXoRm5THtx48I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728725AbgGMG5B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 02:57:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:38020 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725804AbgGMG5B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 02:57:01 -0400
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2DDFA20663;
        Mon, 13 Jul 2020 06:56:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594623420;
        bh=yqdbFyvH04q+9XbGl3VoyxvVtRWjNuHkrGK32q5ZFg8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fE93goWMWHUROumruAYzbgfqPyWPM2NPrLXUBgtUU8YAtIqRT3oGe3q34xF6Fox9k
         3qYLSywlPYg8txAj4K1E7mdCpNqsnpLNN/0I4A/+gDv8NQYlO80Yh6TAY31xtYIZvo
         pQd+A1mH49s61PmTSmbfM9NgXTtHiHe5r0mc4Kv8=
Date:   Mon, 13 Jul 2020 14:56:55 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Fabio Estevam <festevam@gmail.com>
Cc:     Chris Healy <cphealy@gmail.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Stefan Agner <stefan@agner.ch>,
        Rob Herring <robh+dt@kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Andrey Smirnov <andrew.smirnov@gmail.com>
Subject: Re: [PATCH v2] ARM: dts: vfxxx: Add node for CAAM
Message-ID: <20200713065654.GI12113@dragon>
References: <20200707211359.29906-1-cphealy@gmail.com>
 <CAOMZO5CWv7S4iWLWMxQwRs_8qfVRGVgMX3YTkr8H01=6L_V25g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOMZO5CWv7S4iWLWMxQwRs_8qfVRGVgMX3YTkr8H01=6L_V25g@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 07, 2020 at 06:51:00PM -0300, Fabio Estevam wrote:
> Hi Chris,
> 
> On Tue, Jul 7, 2020 at 6:15 PM Chris Healy <cphealy@gmail.com> wrote:
> >
> > From: Andrey Smirnov <andrew.smirnov@gmail.com>
> >
> > Add node for CAAM device in NXP Vybrid SoC.
> >
> > Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> > Signed-off-by: Chris Healy <cphealy@gmail.com>
> >
> > v2:
> > - fixup commit to show that this patch is from Andrey Smirnov.
> 
> We usually put this information below the --- line.
> 
> Maybe Shawn could fix it while applying it.

Fixed and applied.
