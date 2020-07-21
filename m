Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3506BC433E3
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 00:46:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 09C5A208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 00:46:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="DuMGx+kL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728308AbgGUAq6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 20:46:58 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:62084 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726390AbgGUAq5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 20:46:57 -0400
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20200721004653epoutp0177dd042b7e78e67520ca137b1618acde~jnf_BOdpj1766917669epoutp01E
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 00:46:53 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20200721004653epoutp0177dd042b7e78e67520ca137b1618acde~jnf_BOdpj1766917669epoutp01E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1595292413;
        bh=oLlrWB5JYm22Tmu2fEdzaAxhdJKYq6e1vefJZVTEOLw=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=DuMGx+kLszEydYe85zMHHAId+FWtlu3JKnnrvo9o8dGd1EW0rE0/0rbvCpuo8YQN7
         lGOwZ5Q60HDWtpCTzpMm3kXIDZjQ717hGcQqPT+1Mx8+73Tqy9kZzJcEuu55kHFdrh
         h3vqcLeb6jkOnGAIf2d6Lm52+yc6P5PsOVyfxrUk=
Received: from epsmges5p3new.samsung.com (unknown [182.195.42.75]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTP id
        20200721004653epcas5p49d869db34ac55848b3ce7bc7d3f6b57a~jnf9uTXRV2360823608epcas5p4z;
        Tue, 21 Jul 2020 00:46:53 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        74.C6.09475.DFA361F5; Tue, 21 Jul 2020 09:46:53 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
        20200721004652epcas5p4d41ae387539d2fb0a160191bb819e22f~jnf8p4CgG2360823608epcas5p4y;
        Tue, 21 Jul 2020 00:46:52 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200721004652epsmtrp24f88b71df0314de833a0632d6087d17f~jnf8pIzHK1274712747epsmtrp2P;
        Tue, 21 Jul 2020 00:46:52 +0000 (GMT)
X-AuditID: b6c32a4b-39fff70000002503-05-5f163afdcbff
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        ED.AD.08303.CFA361F5; Tue, 21 Jul 2020 09:46:52 +0900 (KST)
Received: from alimakhtar02 (unknown [107.108.234.165]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200721004649epsmtip15bf2629c2208ba3a3f05f208363521a7~jnf6LSetb0087300873epsmtip1J;
        Tue, 21 Jul 2020 00:46:49 +0000 (GMT)
From:   "Alim Akhtar" <alim.akhtar@samsung.com>
To:     "'Gustavo A. R. Silva'" <gustavoars@kernel.org>,
        "'Kishon Vijay Abraham I'" <kishon@ti.com>,
        "'Vinod Koul'" <vkoul@kernel.org>,
        "'Seungwon Jeon'" <essuuj@gmail.com>,
        "'Kiwoong Kim'" <kwmad.kim@samsung.com>
Cc:     <linux-kernel@vger.kernel.org>
In-Reply-To: <20200720132718.GA13413@embeddedor>
Subject: RE: [PATCH v2][next] phy: samsung-ufs: Fix IS_ERR argument
Date:   Tue, 21 Jul 2020 06:16:47 +0530
Message-ID: <042d01d65ef8$6c683f80$4538be80$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQKZ8YLttU7Tp6j0fXRMUQzsBrUhewDDhm+cp4PwvVA=
Content-Language: en-in
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprKKsWRmVeSWpSXmKPExsWy7bCmuu5fK7F4g3l3RS2WX1jCZPHr4jRW
        iwtPe9gsbm45ymJxedccNoudd04wO7B57Jx1l91j06pONo++LasYPY7f2M7k8XmTXABrFJdN
        SmpOZllqkb5dAlfGpveH2ApaeSveb9rC1MD4lauLkZNDQsBE4umDp2xdjFwcQgK7GSV61nQw
        QTifGCXOt7RBZT4zSjQemcoI03Khbw0riC0ksItR4mujMkTRG0aJmzdOsoMk2AR0JXYsBunm
        5BARuMoo8eB/ShcjBwezgJLE1VNyIGFOAQOJV1NOMoHYwgLOEqvvvGQDKWERUJVYvd4cxOQV
        sJRoX2QGUsErIChxcuYTFhCbWUBeYvvbOcwQ1yhI/Hy6jBVikZXEztd/mCBqxCWO/uxhBrlM
        QmAqh8T3zU2sEA0uErd23oJ6RVji1fEt7BC2lMTnd3vBTpAQyJbo2WUMEa6RWDrvGAuEbS9x
        4MocFohHNCXW79KHWMUn0fv7CRNEJ69ER5sQRLWqRPO7q1Cd0hITu7tZIUo8JJ7NNZjAqDgL
        yV+zkPw1C8n9sxB2LWBkWcUomVpQnJueWmxaYJyXWq5XnJhbXJqXrpecn7uJEZxytLx3MD56
        8EHvECMTB+MhRgkOZiUR3ok8wvFCvCmJlVWpRfnxRaU5qcWHGKU5WJTEeZV+nIkTEkhPLEnN
        Tk0tSC2CyTJxcEo1MGn/cD3PuzXJa+NyiUlKETMK2ri2/9xz80zA1P4k5wChtNbbB+c47dm7
        dt/KEPGVKb5cjd7HmB8HfOR5Ge2xe0XiwqhWhg7RS73+YZwHNuzqDeiUabf9YLt02cQuOxum
        JaGVTyLS7vzfPEN53ZZ6wTPeip9eib2WeG/rpJj9r8Ozu0fu3Io3Saouy1tCWjcKTv9315Xn
        rfWHk723BHlWWNv6neu7rHJQ5bJ9Sf/XD+mWuj0eMc+iRIVDvf6uutWoZ1bBybFfb7vblSbu
        qXe+eX1NYFhdevJ+s9ivH1PrOs4aHm13eJ6y/uuyk6mnLEJSyj61Sk5klchdU+ymb31ji3ii
        5MktLRps37R2+S7cpMRSnJFoqMVcVJwIAB7PGfioAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrDLMWRmVeSWpSXmKPExsWy7bCSnO4fK7F4g9VH2C2WX1jCZPHr4jRW
        iwtPe9gsbm45ymJxedccNoudd04wO7B57Jx1l91j06pONo++LasYPY7f2M7k8XmTXABrFJdN
        SmpOZllqkb5dAlfGpveH2ApaeSveb9rC1MD4lauLkZNDQsBE4kLfGlYQW0hgB6PEx091EHFp
        iesbJ7BD2MISK/89B7K5gGpeMUoc3jWdDSTBJqArsWNxGxtIQkTgJqPElBN3gCZxcDALKElc
        PSUH0dDIKHHhfz8TSAOngIHEqyknwWxhAWeJ1XdesoHUswioSqxebw5i8gpYSrQvMgOp4BUQ
        lDg58wkLiM0soCexfv0cRghbXmL72znMELcpSPx8ugzsfhEBK4mdr/8wQdSISxz92cM8gVF4
        FpJRs5CMmoVk1CwkLQsYWVYxSqYWFOem5xYbFhjlpZbrFSfmFpfmpesl5+duYgRHkJbWDsY9
        qz7oHWJk4mA8xCjBwawkwjuRRzheiDclsbIqtSg/vqg0J7X4EKM0B4uSOO/XWQvjhATSE0tS
        s1NTC1KLYLJMHJxSDUyuZg7zvyXrJwhMf8S+2Hv9H4fSs39OpNdfYHEsrbZXeNqZ2bjnl63n
        K76YyIz5C9oY/W/4sO9c/HTPmS9r75zPn+i1/wr3ztvxS95WTHt04ayzkalrqJGy3Y9Er/WB
        jgdMI55dDVmYsuHZ6Ulh33R2uTEr64Qeb5+1hD9JtUaJecO0qNLjPMc3ee9TEd+93yn6eg9b
        2K2ov2YXRU4dsp55MW3z52v76w1czt7hTjU9fzbE7PYyS96mCy8XzJ+reS8g5bLj9t9aUy50
        1nVHxBQfFlKf/dhUfm+Q0Lmla7p7dW43Wwmy/D6++tD8RXdelYnNu7xm/jWmnukmNxw2Xbzo
        aBkj4qn1Ol/87zb1a22nlFiKMxINtZiLihMBDKNp2w8DAAA=
X-CMS-MailID: 20200721004652epcas5p4d41ae387539d2fb0a160191bb819e22f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
X-CMS-RootMailID: 20200720132147epcas5p14aba715032bcda00fad2147cac8b354b
References: <CGME20200720132147epcas5p14aba715032bcda00fad2147cac8b354b@epcas5p1.samsung.com>
        <20200720132718.GA13413@embeddedor>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Gustavo,

> -----Original Message-----
> From: Gustavo A. R. Silva <gustavoars@kernel.org>
> Sent: 20 July 2020 18:57
> To: Kishon Vijay Abraham I <kishon@ti.com>; Vinod Koul <vkoul@kernel.org>;
> Seungwon Jeon <essuuj@gmail.com>; Alim Akhtar
> <alim.akhtar@samsung.com>; Kiwoong Kim <kwmad.kim@samsung.com>
> Cc: linux-kernel@vger.kernel.org; Gustavo A. R. Silva
<gustavoars@kernel.org>
> Subject: [PATCH v2][next] phy: samsung-ufs: Fix IS_ERR argument
> 
> Fix IS_ERR argument in samsung_ufs_phy_symbol_clk_init(). The proper
> argument to be passed to IS_ERR() is phy->rx1_symbol_clk.
> 
> This bug was detected with the help of Coccinelle.
> 
> Fixes: bca21e930451 ("phy: samsung-ufs: add UFS PHY driver for samsung
SoC")
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---
Reviewed-by: Alim Akhtar <alim.akhtar@samsung.com>

> Changes in v2:
>  - Update subject line and changelog text.
> 
>  drivers/phy/samsung/phy-samsung-ufs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/phy/samsung/phy-samsung-ufs.c
> b/drivers/phy/samsung/phy-samsung-ufs.c
> index 43ef77d1d96c..9832599a0283 100644
> --- a/drivers/phy/samsung/phy-samsung-ufs.c
> +++ b/drivers/phy/samsung/phy-samsung-ufs.c
> @@ -147,7 +147,7 @@ static int samsung_ufs_phy_symbol_clk_init(struct
> samsung_ufs_phy *phy)
>  	}
> 
>  	phy->rx1_symbol_clk = devm_clk_get(phy->dev, "rx1_symbol_clk");
> -	if (IS_ERR(phy->rx0_symbol_clk)) {
> +	if (IS_ERR(phy->rx1_symbol_clk)) {
>  		dev_err(phy->dev, "failed to get rx1_symbol_clk clock\n");
>  		return PTR_ERR(phy->rx1_symbol_clk);
>  	}
> --
> 2.27.0


