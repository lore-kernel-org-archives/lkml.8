Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25EECC433E2
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 02:32:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E5F2C2070B
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 02:32:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594607542;
	bh=dNg0UZZ/8+CcNFqVQfTmfbOA5NESFUJcg9zEIihcTn0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=BKrmyQ1q0ZkslBsSZ/x+ug+0ftH+oTxXO03oIivDAeXl2613aptbDdclbg2TzE9/z
	 dqvPGIr+RIeHxqSSdtk9ULwD98QABowZU4fCUEzdtCTj1WFZUZF+1xcHfjF+QlUbZ7
	 A/xcAWjeTTjFvWkAxxdm7r6QxaHn/yOd+GqXyk3Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728408AbgGMCcV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Jul 2020 22:32:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:53252 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726534AbgGMCcU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jul 2020 22:32:20 -0400
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3497B2068F;
        Mon, 13 Jul 2020 02:32:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594607540;
        bh=dNg0UZZ/8+CcNFqVQfTmfbOA5NESFUJcg9zEIihcTn0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NSSuH5LOuslQU1pKMaZ4HKvnkQDcR7mFP+6r2sFZQ/vfd3s5Mo0axkw4VraXzqNks
         1qX2FWR1N9Dbx9R7E/TM2Wf57ReZdo7njkmmngyG+2cm++mwduKLgAJtAKsJD/K2eK
         b29DER03KctwDqS2e/XCBv/G8actedChFCY6O/6g=
Date:   Mon, 13 Jul 2020 10:32:15 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Bruno Thomsen <bruno.thomsen@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>, bth@kamstrup.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Subject: Re: [PATCH 1/3] dt-bindings: ARM: imx: add kamstrup flex
 concentrator to schema
Message-ID: <20200713023214.GX21277@dragon>
References: <20200629114927.17379-1-bruno.thomsen@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200629114927.17379-1-bruno.thomsen@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 29, 2020 at 01:49:25PM +0200, Bruno Thomsen wrote:
> Add Kamstrup flex concentrator compatibles to the schema so we can
> make use of them for the validation.
> 
> Signed-off-by: Bruno Thomsen <bruno.thomsen@gmail.com>

'dt-bindings: fsl: ...' should be just fine as subject prefix.

Shawn

> ---
>  Documentation/devicetree/bindings/arm/fsl.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
> index 05906e291e38..66627b272e40 100644
> --- a/Documentation/devicetree/bindings/arm/fsl.yaml
> +++ b/Documentation/devicetree/bindings/arm/fsl.yaml
> @@ -299,6 +299,8 @@ properties:
>            - enum:
>                - fsl,imx7d-sdb             # i.MX7 SabreSD Board
>                - fsl,imx7d-sdb-reva        # i.MX7 SabreSD Rev-A Board
> +              - kam,imx7d-flex-concentrator       # Kamstrup OMNIA Flex Concentrator
> +              - kam,imx7d-flex-concentrator-mfg   # Kamstrup OMNIA Flex Concentrator in manufacturing mode
>                - novtech,imx7d-meerkat96   # i.MX7 Meerkat96 Board
>                - technexion,imx7d-pico-dwarf   # TechNexion i.MX7D Pico-Dwarf
>                - technexion,imx7d-pico-hobbit  # TechNexion i.MX7D Pico-Hobbit
> 
> base-commit: 9ebcfadb0610322ac537dd7aa5d9cbc2b2894c68
> -- 
> 2.26.2
> 
