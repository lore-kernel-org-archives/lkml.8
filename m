Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D2E5C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 00:49:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E27AE208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 00:49:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="V03We3Dj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728069AbgGUAtt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 20:49:49 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:49663 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726483AbgGUAts (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 20:49:48 -0400
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20200721004945epoutp0299617ae5aa3feb8ec75f0877b2e4101c~jnieUVixe1011910119epoutp02g
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 00:49:45 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20200721004945epoutp0299617ae5aa3feb8ec75f0877b2e4101c~jnieUVixe1011910119epoutp02g
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1595292585;
        bh=+Uzcvn6oYYLa1MSOyIR9siF0duZ42iVzlTGtd/cFMNM=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=V03We3DjoZG3lUaFROcGcWp1g2VKeZNKynECysL4x/d8taDiu+UKCxMoVsc7KMi5R
         TOTJo3alWwNZK+wjhe8DAaJ9yYeLrFRteR4p4s9jMjAG0JyJe7LYOzuOI5TEVQVqJG
         xKIltAQMqYMu8NVaksSaYlbZotktvJusWKR+zEyw=
Received: from epsmges5p1new.samsung.com (unknown [182.195.42.73]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTP id
        20200721004945epcas5p2da9a283dd9d38859370cbcbf1fa4bf83~jnid7oQHP2155921559epcas5p2N;
        Tue, 21 Jul 2020 00:49:45 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        FA.7E.09467.9AB361F5; Tue, 21 Jul 2020 09:49:45 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
        20200721004944epcas5p1e94545896bc7effa14b6be6c6cd3f4ec~jnidSBFcS2225522255epcas5p1x;
        Tue, 21 Jul 2020 00:49:44 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200721004944epsmtrp203faed8cf617ac16d861e3e1a328ebac~jnidRVBdk1406814068epsmtrp2S;
        Tue, 21 Jul 2020 00:49:44 +0000 (GMT)
X-AuditID: b6c32a49-a3fff700000024fb-6d-5f163ba9d6cb
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        96.FD.08303.8AB361F5; Tue, 21 Jul 2020 09:49:44 +0900 (KST)
Received: from alimakhtar02 (unknown [107.108.234.165]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200721004942epsmtip2cda0fe2f832c40b4aeed1b471d5173c5~jnibGTnkZ0963209632epsmtip2q;
        Tue, 21 Jul 2020 00:49:42 +0000 (GMT)
From:   "Alim Akhtar" <alim.akhtar@samsung.com>
To:     "'Colin King'" <colin.king@canonical.com>,
        "'Kishon Vijay Abraham I'" <kishon@ti.com>,
        "'Vinod Koul'" <vkoul@kernel.org>,
        "'Seungwon Jeon'" <essuuj@gmail.com>,
        "'Kiwoong Kim'" <kwmad.kim@samsung.com>
Cc:     <kernel-janitors@vger.kernel.org>, <linux-kernel@vger.kernel.org>
In-Reply-To: <20200720162952.339697-1-colin.king@canonical.com>
Subject: RE: [PATCH][next] phy: samsung-ufs: fix check on failed
 devm_clk_get call for rx1_symbol_clk
Date:   Tue, 21 Jul 2020 06:19:40 +0530
Message-ID: <042e01d65ef8$d34fefe0$79efcfa0$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQFmw1qQJSzC5eufS7nQRzHnPGSrDgFTUe/4qeXPvDA=
Content-Language: en-in
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrCKsWRmVeSWpSXmKPExsWy7bCmhu5Ka7F4g5mzRS1+r+5ls1h+YQmT
        xdZb0hYXnvawWdzccpTF4vKuOWwWO++cYHZg95jV0MvmsXPWXXaPTas62Tz6tqxi9Dh+YzuT
        x+dNcgFsUVw2Kak5mWWpRfp2CVwZ/dNPsRWc56u4enk2ewPjJp4uRk4OCQETibML5rB3MXJx
        CAnsZpR4e2ULM4TziVFi27ROJgjnM6PEjqdz2WFavi18DNWyi1Fi6syNUFVvGCXeHbjEBFLF
        JqArsWNxGxtIQkTgPKPE0eOHwBLMAq4Sd87cYwWxOQXsJSYtuc8MYgsLpEv8mf8WrIZFQFXi
        yvalbCA2r4ClxPYNk1ggbEGJkzOfsEDM0ZZYtvA1M8RJChI/ny4DmykiYCXx7vUBqBpxiaM/
        e8AekhCYyiFx6eYXRogGF4mDMyGGSggIS7w6vgXqNymJz+/2Ai3mALKzJXp2GUOEaySWzjsG
        VW4vceDKHBaQEmYBTYn1u/QhVvFJ9P5+wgTRySvR0SYEUa0q0fzuKlSntMTE7m5WCNtDYt3F
        bWwTGBVnIXlsFpLHZiF5YBbCsgWMLKsYJVMLinPTU4tNCwzzUsv1ihNzi0vz0vWS83M3MYIT
        kpbnDsa7Dz7oHWJk4mA8xCjBwawkwjuRRzheiDclsbIqtSg/vqg0J7X4EKM0B4uSOK/SjzNx
        QgLpiSWp2ampBalFMFkmDk6pBqZZwd65ZyJkPWcKObw78a/r0rK2G++X6MgZ7LKbkGc888fr
        ss0hudeswwuCV/D7vNhmPnlLsIrAhTNLjK/2X+gpfVazYN5GJtfps09tWnjFXOvpiXQn/XXi
        bv/0P5yT2eKiXF5Un3X4hNSDSfm3dB9+CHvXzLaMd/mKzOUVl+x3TdpWnFO49n6svrzr3pVv
        Jwu/ttXizu3R0XnAN/vKta2aH13fraxVeDZh4iKlC8YNnoqh6YW/OSosjVp2FTyavevZzhbT
        nF3z7wkImT5b23xsQ1zPK+XQaax/bTNuveKbv1xA89G3kKiYxtZqdbkz8zQWOC3iuMVYIaYn
        cuHBT/dJZfdDoi7Pv1LLv/6TiskfJZbijERDLeai4kQABlN5tLcDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupkkeLIzCtJLcpLzFFi42LZdlhJXneFtVi8wf4WTYvfq3vZLJZfWMJk
        sfWWtMWFpz1sFje3HGWxuLxrDpvFzjsnmB3YPWY19LJ57Jx1l91j06pONo++LasYPY7f2M7k
        8XmTXABbFJdNSmpOZllqkb5dAlfGjeNTWAua+CpuvrjK3MD4nLuLkZNDQsBE4tvCx+xdjFwc
        QgI7GCUa915ggkhIS1zfOIEdwhaWWPnvOVTRK0aJa9NOs4Ik2AR0JXYsbmMDSYgIXGaUOLlh
        JwtIglnAXWJa005GiI4JjBIHn88CG8UpYC8xacl9ZhBbWCBVYva8BWCTWARUJa5sX8oGYvMK
        WEps3zCJBcIWlDg58wnUUG2JpzefwtnLFr5mhjhPQeLn02Vgc0QErCTevT4AVSMucfRnD/ME
        RuFZSEbNQjJqFpJRs5C0LGBkWcUomVpQnJueW2xYYJSXWq5XnJhbXJqXrpecn7uJERxbWlo7
        GPes+qB3iJGJg/EQowQHs5II70Qe4Xgh3pTEyqrUovz4otKc1OJDjNIcLErivF9nLYwTEkhP
        LEnNTk0tSC2CyTJxcEo1MOncZfbpTnhZd/FqotGKS51WAXvmilqIq5v+1Il8/W9tyhe/mQo7
        Q+KVf5n03p99ifFT2L7HV7ctO3t8SsWOiVK8zVL/+I7s/L0mqVjCxDxIQ0cmvq281Ffspou/
        KPeLvFVrr2ZWnCg5MjHW7URw8N3tF3xdbBZV+LXvrxSVvmFem5L/bBaTyP71YnLOBh6SYX8u
        MGj3bPMrn59yYsuKtHb7phUbFI9nT+3J5b4ztfKwN/PvRS7ubg42//M3Gs6wucxiJvZUzuXc
        xj7BuR5qCp2M0xc/WNVlfVW1zqlli3b6sxuCSycejrkczMi93PvQ0pcdZx8ZlxxbfalauD9Q
        kuHtsqP/TGNmRFg729zKVWIpzkg01GIuKk4EABpn6ukcAwAA
X-CMS-MailID: 20200721004944epcas5p1e94545896bc7effa14b6be6c6cd3f4ec
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
X-CMS-RootMailID: 20200720162959epcas5p1bf43c0c67ee0c098428b78b2d0ded2db
References: <CGME20200720162959epcas5p1bf43c0c67ee0c098428b78b2d0ded2db@epcas5p1.samsung.com>
        <20200720162952.339697-1-colin.king@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Colin,

> -----Original Message-----
> From: Colin King <colin.king=40canonical.com>
> Sent: 20 July 2020 22:00
> To: Kishon Vijay Abraham I <kishon=40ti.com>; Vinod Koul <vkoul=40kernel.=
org>;
> Seungwon Jeon <essuuj=40gmail.com>; Kiwoong Kim
> <kwmad.kim=40samsung.com>; Alim Akhtar <alim.akhtar=40samsung.com>
> Cc: kernel-janitors=40vger.kernel.org; linux-kernel=40vger.kernel.org
> Subject: =5BPATCH=5D=5Bnext=5D phy: samsung-ufs: fix check on failed devm=
_clk_get call
> for rx1_symbol_clk
>=20
> From: Colin Ian King <colin.king=40canonical.com>
>=20
> The check to see if the call to devm_clk_get on rx1_symbol_clk is checkin=
g the
> wrong variable, this looks like a copy-paste error. Fix this to check
> phy->rx1_symbol instead of phy->rx0_symbol.
>=20
This fix is already posted by Gustavo =5B1=5D
=5B1=5D https://lkml.org/lkml/2020/7/20/617

Thanks=21

> Addresses-Coverity: (=22Copy-paste error=22)
> Fixes: bca21e930451 (=22phy: samsung-ufs: add UFS PHY driver for samsung =
SoC=22)
> Signed-off-by: Colin Ian King <colin.king=40canonical.com>
> ---
>  drivers/phy/samsung/phy-samsung-ufs.c =7C 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/phy/samsung/phy-samsung-ufs.c
> b/drivers/phy/samsung/phy-samsung-ufs.c
> index 43ef77d1d96c..9832599a0283 100644
> --- a/drivers/phy/samsung/phy-samsung-ufs.c
> +++ b/drivers/phy/samsung/phy-samsung-ufs.c
> =40=40 -147,7 +147,7 =40=40 static int samsung_ufs_phy_symbol_clk_init(st=
ruct
> samsung_ufs_phy *phy)
>  	=7D
>=20
>  	phy->rx1_symbol_clk =3D devm_clk_get(phy->dev, =22rx1_symbol_clk=22);
> -	if (IS_ERR(phy->rx0_symbol_clk)) =7B
> +	if (IS_ERR(phy->rx1_symbol_clk)) =7B
>  		dev_err(phy->dev, =22failed to get rx1_symbol_clk clock=5Cn=22);
>  		return PTR_ERR(phy->rx1_symbol_clk);
>  	=7D
> --
> 2.27.0


