Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 672BEC18E5A
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 18:10:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E7882146E
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 18:10:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="vX+vq8Qt";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="0LGbYfQ1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726712AbgCJSKJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 14:10:09 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:54605 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726269AbgCJSKI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 14:10:08 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 328B021B6A;
        Tue, 10 Mar 2020 14:10:07 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Tue, 10 Mar 2020 14:10:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=SRt+6h/WZcgD+dTltRfTPOTYiLo
        w8DtLgwozFTB/+oc=; b=vX+vq8QtTgWR3mMawoHQd6j2nLo7dUfFVqhyUVUG+rX
        M/1LbMAR7c/l1V2e4EXXH/JOeQ9XG+vZh1rTpakd07ChzI60sbXGzqHb8jJFT0Qa
        eI8WqWApgYjISQJ2EqfqELSa4SBhMQaMR0exYMNYk8E1s5Jm5mgjYzGmTqgUiI6M
        l5v5Pzw7jHa3NNMJ/TgkzGJeIk+Pm/5Q2DGSwwlvnU/o+6MY242jgI3eMiGgk5Um
        8JCidPckRX+I3fMBDor54sWUivAlMqDBMjeVr5FnLP7IQ/Luj+p+xTDTk9Re4tbh
        IlWVFToLBGdSaVXtC5c8cu2y6PNyjN1gpatNoyrdunQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=SRt+6h
        /WZcgD+dTltRfTPOTYiLow8DtLgwozFTB/+oc=; b=0LGbYfQ14FzuF/Rv8VEMhm
        iGvLR+5HQ7402JxSGmQVDpLHd9ObHUQZyd5XI4niHMeP8IdnCZ5YOsDEJkXbNe98
        h8l1+axoA4OCe2Ngy9XqpVjUbBA7YpBmwIqryGRw0SZ79fJJwLvsgunrLjSAXGG0
        QsKOq8JvZRX1KNtaiQToUU+Z/MV2naiCRgQCR26dyeYc0yr4qmPGS4xpgH7C29yz
        znxJQv2lJzvaA3Fuho89JB85PwNp+aNovL2z/QnKDLcARdFu7NJ8IWhRbmI3tJsk
        3+MkUCR2qeiDf/wLDYNydqoAnTbjriBP9ILl+Giks9CEk1Fpd5uac5Ar1YonUF8w
        ==
X-ME-Sender: <xms:_tdnXsOsQ2mA9hmgDFPqCuYs25fk-JMG8pBjm8paz4oTGA5yw-5qeA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedruddvtddguddtvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfhfgggtuggjsehttd
    ertddttddvnecuhfhrohhmpeforgigihhmvgcutfhiphgrrhguuceomhgrgihimhgvsegt
    vghrnhhordhtvggthheqnecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhho
    rdhtvggthh
X-ME-Proxy: <xmx:_tdnXvo7v2kSvu7oGDiu8kaCvbytm33atHG-UxrEmKyeMxWhM329lw>
    <xmx:_tdnXjuYIexMDgz57AjlVoFjPRhSgBjqAh2Fc9iksBckbx5bQIWwCA>
    <xmx:_tdnXrTusp0U3H24pWAZfbWvkLlnN1fOFcvUySRDB7QG0K4NJR6H0w>
    <xmx:_9dnXms0pgFeSe9rLJJnPv8rnkshn5jct2UsywzduMVS5MBN8pYYeA>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 504353280065;
        Tue, 10 Mar 2020 14:10:06 -0400 (EDT)
Date:   Tue, 10 Mar 2020 19:10:03 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     Chen-Yu Tsai <wens@kernel.org>
Cc:     Chen-Yu Tsai <wens@csie.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] ARM: dts: sun8i: r40: fix SPI address and reorder
 nodes
Message-ID: <20200310181003.wgryf373em5zwlvb@gilmour.lan>
References: <20200310174709.24174-1-wens@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200310174709.24174-1-wens@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 11, 2020 at 01:47:06AM +0800, Chen-Yu Tsai wrote:
> From: Chen-Yu Tsai <wens@csie.org>
>
> Hi,
>
> Here are some fixes for the R40 device tree for v5.6. The base addresses
> for SPI2 and SPI3 were incorrect and are fixed. I also found some nodes
> were not added in the proper order, possibly because git matched the
> incorrect place when applying the patch. These are fixed as well.
>
> ChenYu

Acked-by: Maxime Ripard <mripard@kernel.org>

Thanks!
Maxime
