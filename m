Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 761C8C11D0C
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 17:32:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40F5B2467A
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 17:32:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="yw55C4gf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="E/TUP4W+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728415AbgBTRcS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 12:32:18 -0500
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:54133 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726959AbgBTRcR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 12:32:17 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 862EC21AB4;
        Thu, 20 Feb 2020 12:32:16 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Thu, 20 Feb 2020 12:32:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=Ay1v4I3raYISAcTCBgfWLbl1z8B
        K11fKSxA2zB0pXj8=; b=yw55C4gff4dd9drT8w4Q4u7N5Q0zhfB/9hoHZ9XoGyo
        v6CvPSkKBlPsnJUEbiS7GM3aoW/M00z2cOAH3oPEFUQoHnG/0l8iZWC9dDMFIFS3
        05ThvLt6MoRFpnwkuhQid6gbuGRqunZ30CnB4j/iqXQ2xSldiUmYLvGwaR6tOzVR
        VOk+FezMjuKLib5pfMtUBIZhXiASx/XXMlBKzKG4OG5E+u6gUIX4ftDpy1F9UaKD
        Dg+22JbBeEi4cm1L3mS3W57vWwkZTuqCM7NPenF3obLADklU0RVv4nNO++h7bcVN
        fbqxjx17pPzjxJV/jGrbVaX6h+rxE3L3D9xAu6Syxag==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=Ay1v4I
        3raYISAcTCBgfWLbl1z8BK11fKSxA2zB0pXj8=; b=E/TUP4W+gjBqbTrrQTK9Bu
        tDzxiE2dMHFS89Zih1vemTPTbpLx0Tct0H3CeUFVUrJO1yioRS0EFTpaT9ntvJ/n
        Sudrb1k8R5xNu6/8FVA//vBjJ7iDa7E+W5MPN9VJVEnXMGFxZASPSSZ1IxGVBSJ+
        0+qlstr/Fb9xoNc0zuh669UIfncJ0E576HjsYEzMSUwtXi+lxyQWMz0LuDvn4AqB
        e7nLmB+HD0bDzi1X6MIKLAo0kryLjI18+02wh8kfOtdrQGe5cfVy0VcBSfbizK0W
        Vwsrvl2Hw3cV0VjVbNmhR8Rd+muTsGkdl12xcNPfjSPrlKjjUBPwUUDEvS89LEng
        ==
X-ME-Sender: <xms:n8JOXiiM3A93u8SHlXFFgbUXnF_UIDzJwFk21GT0a1-b02RrIs9oPQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrkedvgddutdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecukfhppeeltd
    drkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghi
    lhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:n8JOXutsVth5QITUpKCPwf4NneECws8jZhZV7sZT_zKPzNvUhZD53w>
    <xmx:n8JOXkzbk5FwE4A4CRvAWtmTpMqGV0lWN0158ZgAFwfjrlphgGXjhg>
    <xmx:n8JOXsPuNLMWK3osy2RHvSstRaz8-b_fXGxZDpoK9NJ8WF_CQ3vYxA>
    <xmx:oMJOXiPuIzLV7FPq6YQRW6ykLphRz9PNUiz-4au70YZJ0wAd8FPGUQ>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 450D2328005E;
        Thu, 20 Feb 2020 12:32:15 -0500 (EST)
Date:   Thu, 20 Feb 2020 18:32:13 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     Ondrej Jirman <megous@megous.com>
Cc:     linux-sunxi@googlegroups.com, Chen-Yu Tsai <wens@csie.org>,
        Samuel Holland <samuel@sholland.org>,
        Stephen Boyd <swboyd@chromium.org>,
        "moderated list:ARM/Allwinner sunXi SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] bus: sunxi-rsb: Return correct data when mixing 16-bit
 and 8-bit reads
Message-ID: <20200220173213.s2ytf3zdi6q3bxli@gilmour.lan>
References: <20200219010951.395599-1-megous@megous.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="4qmk5mkxpxvl2c2h"
Content-Disposition: inline
In-Reply-To: <20200219010951.395599-1-megous@megous.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--4qmk5mkxpxvl2c2h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Feb 19, 2020 at 02:09:50AM +0100, Ondrej Jirman wrote:
> When doing a 16-bit read that returns data in the MSB byte, the
> RSB_DATA register will keep the MSB byte unchanged when doing
> the following 8-bit read. sunxi_rsb_read() will then return
> a result that contains high byte from 16-bit read mixed with
> the 8-bit result.
>
> The consequence is that after this happens the PMIC's regmap will
> look like this: (0x33 is the high byte from the 16-bit read)
>
> % cat /sys/kernel/debug/regmap/sunxi-rsb-3a3/registers
> 00: 33
> 01: 33
> 02: 33
> 03: 33
> 04: 33
> 05: 33
> 06: 33
> 07: 33
> 08: 33
> 09: 33
> 0a: 33
> 0b: 33
> 0c: 33
> 0d: 33
> 0e: 33
> [snip]
>
> Fix this by masking the result of the read with the correct mask
> based on the size of the read. There are no 16-bit users in the
> mainline kernel, so this doesn't need to get into the stable tree.
>
> Signed-off-by: Ondrej Jirman <megous@megous.com>
> ---
>  drivers/bus/sunxi-rsb.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/bus/sunxi-rsb.c b/drivers/bus/sunxi-rsb.c
> index b8043b58568ac..8ab6a3865f569 100644
> --- a/drivers/bus/sunxi-rsb.c
> +++ b/drivers/bus/sunxi-rsb.c
> @@ -316,6 +316,7 @@ static int sunxi_rsb_read(struct sunxi_rsb *rsb, u8 rtaddr, u8 addr,
>  {
>  	u32 cmd;
>  	int ret;
> +	u32 mask;
>
>  	if (!buf)
>  		return -EINVAL;
> @@ -323,12 +324,15 @@ static int sunxi_rsb_read(struct sunxi_rsb *rsb, u8 rtaddr, u8 addr,
>  	switch (len) {
>  	case 1:
>  		cmd = RSB_CMD_RD8;
> +		mask = 0xffu;
>  		break;
>  	case 2:
>  		cmd = RSB_CMD_RD16;
> +		mask = 0xffffu;
>  		break;
>  	case 4:
>  		cmd = RSB_CMD_RD32;
> +		mask = 0xffffffffu;
>  		break;
>  	default:
>  		dev_err(rsb->dev, "Invalid access width: %zd\n", len);
> @@ -345,7 +349,7 @@ static int sunxi_rsb_read(struct sunxi_rsb *rsb, u8 rtaddr, u8 addr,
>  	if (ret)
>  		goto unlock;
>
> -	*buf = readl(rsb->regs + RSB_DATA);
> +	*buf = readl(rsb->regs + RSB_DATA) & mask;

Thanks for debugging this and the extensive commit log.

I guess it would be cleaner to just use GENMASK(len * 8, 0) here?

Maxime

--4qmk5mkxpxvl2c2h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXk7CnQAKCRDj7w1vZxhR
xYwdAQDlHMlf/FdIX+Eumbe45KdrYyQhhaHzGmbiyBwtrtgxMgEAnMJqK4ffi3Lb
e+5SIgZ8ZAhD5GxFQ06Ui8UaoF4B+Qc=
=g9qg
-----END PGP SIGNATURE-----

--4qmk5mkxpxvl2c2h--
