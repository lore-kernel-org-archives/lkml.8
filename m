Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8558C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 07:56:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A3FD720787
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 07:56:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="xneF9++a";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="p0cu4g70"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731680AbgEZH4k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 03:56:40 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:35183 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726638AbgEZH4j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 03:56:39 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id E90A95C0058;
        Tue, 26 May 2020 03:56:37 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Tue, 26 May 2020 03:56:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:content-transfer-encoding:in-reply-to; s=fm2; bh=Z
        u9qqU+I+thjV7ih0gjMq+r1LnUk7vFMdi7Yew8UXJA=; b=xneF9++arCV/I77rR
        8tDgoctxQlEU8NQEX4Ez381uoRVlHrFxRnwUQt6j/dmP6Tz8QrKj9xh5oi+qGkf7
        7CLIYDqQ50alvXSblYSOK35/JoV/lycqKEVACaq07FM1XhYkpvld9OKDf/T/nPIX
        oMstbQijFskdWwMkeXr/L2Fnmx/NYkholzSYmB/zk3JRxq7ZopMK+ZAuxGOx9sg8
        mCq6aiv4ZETpLj26t5tOZPj5jQii2pHk7fvadHK1pjYXIK78++k/8Tt+BbMH++3h
        7EErQaTF1K5uUuSQwYOnu2tyg9OvX8rmlI8SaZrEx1Slq9L911h5oOyeS1SglYLp
        fVUzQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; bh=Zu9qqU+I+thjV7ih0gjMq+r1LnUk7vFMdi7Yew8UX
        JA=; b=p0cu4g70VqbywSbgNEoJJGrVh0fks3lfYnbqF9+Dt5jSYkkdic/bllsTh
        O77J/jq4X9lj2+sAWxFz++C7TzM2ywsTdVLknidD6RSBd1EpubjQWs3WLfG+Z3sm
        1uPZ0UDxrl9ndLRGaUxZ9lIRmtBR7jWDaUnO95RPsbBhVgo/3BKz/A9/MJH3imaG
        fmPXLLginST6wZlqGI1y9Ip4j96L2TPbclo22ejhobOsAGAW9xGlzdqn5We3osZ6
        GTOOr4sFK35zy3jbiTbFHO5hwrAbhp/2Ida66TJgNMpP9x4I8iIHiAoelkRHfJVc
        yxlj9AyEOox/5lmzjM4IVsdnB96qA==
X-ME-Sender: <xms:scvMXtW6yirSIt1uH7W78oOy4M0e6wqkOFer8qkJJ2MiaZMPRuFJ2A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedruddvuddguddvvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvuffkfhggtggugfgjsehtqhertddttddvnecuhfhrohhmpeforgig
    ihhmvgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrf
    grthhtvghrnhepgfejtedtjefggfffvdetuedthedtheegheeuteekfeeghfdtteejkeel
    udegvddunecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:scvMXtkGf5broUr6pAbTdzLfNgFpIixxtsz-1ba5es1lu3Sy8OiVXA>
    <xmx:scvMXpY4qalIlkQ9EWDOhnvEhEoTtynFhThong14ufMKt6lp0SZrYA>
    <xmx:scvMXgVID8mORfqJf9rT0xHxW6GJ7TqUIm3trViClXYj0w8pmMOhJQ>
    <xmx:tcvMXsyv-p5n67fNuL0DwsQ7uh4PB8z8SzI0caVkb1jgVU5OHgqEQA>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id E28AD328005E;
        Tue, 26 May 2020 03:56:32 -0400 (EDT)
Date:   Tue, 26 May 2020 09:56:30 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Rikard Falkeborn <rikard.falkeborn@gmail.com>
Cc:     Joerg Roedel <joro@8bytes.org>, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, Chen-Yu Tsai <wens@csie.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 2/2] iommu/sun50i: Constify sun50i_iommu_ops
Message-ID: <20200526075630.wjevamadh5mcnleb@gilmour.lan>
References: <20200525214958.30015-1-rikard.falkeborn@gmail.com>
 <20200525214958.30015-3-rikard.falkeborn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200525214958.30015-3-rikard.falkeborn@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 25, 2020 at 11:49:58PM +0200, Rikard Falkeborn wrote:
> The struct sun50i_iommu_ops is not modified and can be made const to
> allow the compiler to put it in read-only memory.
>=20
> Before:
>    text    data     bss     dec     hex filename
>   14358    2501      64   16923    421b drivers/iommu/sun50i-iommu.o
>=20
> After:
>    text    data     bss     dec     hex filename
>   14726    2117      64   16907    420b drivers/iommu/sun50i-iommu.o
>=20
> Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>

Acked-by: Maxime Ripard <mripard@kernel.org>

Thanks!
Maxime
