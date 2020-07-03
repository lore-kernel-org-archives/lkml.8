Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB590C433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 01:27:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8BE97207E8
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 01:27:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="WCc9IJiW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726317AbgGCB1g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 21:27:36 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:48792 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726017AbgGCB1g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 21:27:36 -0400
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20200703012733epoutp016d2bfa24fc6658beb4e2abbaa0b2181f~eGcU_mTdE3108831088epoutp01E
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jul 2020 01:27:33 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20200703012733epoutp016d2bfa24fc6658beb4e2abbaa0b2181f~eGcU_mTdE3108831088epoutp01E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1593739653;
        bh=486TETuF0TtY1Ijml+wVzO2TgvTJbcOwVIykt/LKFDM=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=WCc9IJiWhKxIp6C1hYPOVxrqn7x0zVd+yiAmOCYxTDAUmcjVZTTexgNag9B3g3sOX
         CiMkO4N4id1E3qPsBjAdJ64r6qtiIFJjdTTP+3waspLvi1oDXrIuSXMSoGu52WZHJ8
         LNkaCVqx1AZ0762KI5dNoAiqoaeLgV1j4DDxOWpo=
Received: from epsmges5p1new.samsung.com (unknown [182.195.42.73]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20200703012732epcas5p33664d44a9a4ac14ebda77b20ba141f3f~eGcUgxWe71327413274epcas5p3F;
        Fri,  3 Jul 2020 01:27:32 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        5B.D5.09467.4898EFE5; Fri,  3 Jul 2020 10:27:32 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
        20200703012731epcas5p487ad0c350f0bee1b424cf87ad70ba606~eGcT4AHLI0405204052epcas5p43;
        Fri,  3 Jul 2020 01:27:31 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200703012731epsmtrp1881a8e8fef880fe95b0358e98e3a661b~eGcT3Dyxi0067500675epsmtrp1l;
        Fri,  3 Jul 2020 01:27:31 +0000 (GMT)
X-AuditID: b6c32a49-a29ff700000024fb-74-5efe8984bd1e
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        5F.22.08382.3898EFE5; Fri,  3 Jul 2020 10:27:31 +0900 (KST)
Received: from alimakhtar02 (unknown [107.108.234.165]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200703012729epsmtip1ba9e44dc8c112f27b84de2e0a387f4fa~eGcRxBuF21996719967epsmtip1L;
        Fri,  3 Jul 2020 01:27:29 +0000 (GMT)
From:   "Alim Akhtar" <alim.akhtar@samsung.com>
To:     "'Vinod Koul'" <vkoul@kernel.org>
Cc:     <robh+dt@kernel.org>, <krzk@kernel.org>, <kwmad.kim@samsung.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-samsung-soc@vger.kernel.org>, <kishon@ti.com>
In-Reply-To: <20200701065310.GX2599@vkoul-mobl>
Subject: RE: [RESEND PATCH v10 2/2] phy: samsung-ufs: add UFS PHY driver for
 samsung SoC
Date:   Fri, 3 Jul 2020 06:57:27 +0530
Message-ID: <002701d650d9$1ee4ba40$5cae2ec0$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-in
Thread-Index: AQJuMKyjv+9hLEX/NMXwBi+iiP5M1wIz1HEhAUr1ZGUBeyaBPqebjoTw
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrOKsWRmVeSWpSXmKPExsWy7bCmlm5L5784g/n9Chbzj5xjtbjwtIfN
        4vz5DewWN7ccZbHY9Pgaq8XlXXPYLGac38dk0br3CLvFzjsnmB04PTat6mTz2Lyk3qNvyypG
        j+M3tjN5fN4kF8AaxWWTkpqTWZZapG+XwJXx88Z91oK7WhV7zuxia2BcqNjFyMkhIWAi8aun
        ga2LkYtDSGA3o8THOa9YIJxPjBJtvXugnG+MErMadzDDtBz/tJERIrGXUeJlxy4mCOcNo8Sp
        46cZQarYBHQldixuYwOxRQRUJbY8eQC2hFngGaPEmk0dYEWcAvoSS08uYQKxhQWiJG6t3QBm
        swioSPQ3HwZax8HBK2ApcXWZK0iYV0BQ4uTMJywgNrOAvMT2t3OgLlKQ+Pl0GStEXFzi6M8e
        Zoi9bhJTN1wFu1RCYCWHxInZy5hAZkoIuEicOSAK0Sss8er4FnYIW0riZX8bO0RJtkTPLmOI
        cI3E0nnHWCBse4kDV+awgJQwC2hKrN+lD7GVT6L39xOo4bwSHW1CENWqEs3vrkJ1SktM7O5m
        hbA9JM7cPcU6gVFxFpK/ZiH5axaSX2YhLFvAyLKKUTK1oDg3PbXYtMAwL7Vcrzgxt7g0L10v
        OT93EyM4LWl57mC8++CD3iFGJg7GQ4wSHMxKIrwJqv/ihHhTEiurUovy44tKc1KLDzFKc7Ao
        ifMq/TgTJySQnliSmp2aWpBaBJNl4uCUamAykNO+27r71/XAkua/35c/X/r4dVTr7j2iNp3h
        24XthE71cbTPso7MvSrn4HdNfFfFjAurXQz/mctLN22warpUtsNJt0Bp+ak0zTCD1unqBrbr
        +K8yLZP/++8D48mjxzdZKi22ql+cU3o2JaHOVvrq18nRE82P3PdYvM5z+ZQJhu1eLhqbj7kc
        /mV+cdnS49e/Xbxqm28d6c+8fnVFU9qt367dHT/SDu9j2xBo/ii6TqNqh1xngd+B9qnLDnq+
        7g8wvBN3zFG32ToijK/LuPtUc7DSZY6Zn3dK6lVtW3dSN/T3PPaYyN6Up3PmaerN/F3UkT1t
        oqvfykcNe1Z2vmp5ptC3+jbX5AY2lSydA2xKLMUZiYZazEXFiQBBUVR5ugMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupmkeLIzCtJLcpLzFFi42LZdlhJTre581+cwewtRhbzj5xjtbjwtIfN
        4vz5DewWN7ccZbHY9Pgaq8XlXXPYLGac38dk0br3CLvFzjsnmB04PTat6mTz2Lyk3qNvyypG
        j+M3tjN5fN4kF8AaxWWTkpqTWZZapG+XwJXx88Z91oK7WhV7zuxia2BcqNjFyMkhIWAicfzT
        RsYuRi4OIYHdjBIze06xQiSkJa5vnMAOYQtLrPz3nB2i6BWjxP/L95lBEmwCuhI7Frexgdgi
        AqoSW548YAMpYhZ4xyixe99JNoiOR4wS7RfPMIJUcQroSyw9uYQJxBYWiJD4ce0SWJxFQEWi
        v/kw0FQODl4BS4mry1xBwrwCghInZz5hAQkzC+hJtG0Eq2YWkJfY/nYOM8RxChI/ny5jhYiL
        Sxz92cMMcY+bxNQNVxknMArPQjJpFsKkWUgmzULSvYCRZRWjZGpBcW56brFhgWFearlecWJu
        cWleul5yfu4mRnB8aWnuYNy+6oPeIUYmDsZDjBIczEoivAmq/+KEeFMSK6tSi/Lji0pzUosP
        MUpzsCiJ894oXBgnJJCeWJKanZpakFoEk2Xi4JRqYDLZcYj7vciDoEfnFv12/cv+Sv79uovb
        EzcYO5y94TdDv76My8U/LbB5W4KJ+lY/gfJHxp4lz+fmr3gp1CL92Vvs+vN2Pf3X/y6dk2e+
        FPUvwVbm0uOXer3H4x9PZ2o5vDizwfKcbbb6CdY5IXa8Af6eVidt7bstlBbuOx+727b0u78B
        Z2XOwX5H+z9/35b/TZ3Ga/tyXdsWY7P0/0viGtqOWjJY15RvWVWzIemhdUTls52/VP3blwd3
        l3LZHpeKmp+35pTDY2/z9VubJ/XNfhbwpPKE2cwji1xcJa3i84+8t9s0wehoB7PPCoczx6cK
        yPFkzSlxCedrfqzHvqRsQqKX8Z9b/pFPuneqnfJrUGIpzkg01GIuKk4EALF4zGgeAwAA
X-CMS-MailID: 20200703012731epcas5p487ad0c350f0bee1b424cf87ad70ba606
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
X-CMS-RootMailID: 20200625001545epcas5p2127fb1fac70397d9c23a1246cc86f753
References: <20200624235631.11232-1-alim.akhtar@samsung.com>
        <CGME20200625001545epcas5p2127fb1fac70397d9c23a1246cc86f753@epcas5p2.samsung.com>
        <20200624235631.11232-2-alim.akhtar@samsung.com>
        <20200701065310.GX2599@vkoul-mobl>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vinod

> -----Original Message-----
> From: Vinod Koul <vkoul@kernel.org>
> Sent: 01 July 2020 12:23
> To: Alim Akhtar <alim.akhtar@samsung.com>
> Cc: robh+dt@kernel.org; krzk@kernel.org; kwmad.kim@samsung.com;
> devicetree@vger.kernel.org; linux-arm-kernel@lists.infradead.org; linux-
> kernel@vger.kernel.org; linux-samsung-soc@vger.kernel.org; kishon@ti.com
> Subject: Re: [RESEND PATCH v10 2/2] phy: samsung-ufs: add UFS PHY driver
for
> samsung SoC
> 
> Hi Alim,
> 
> On 25-06-20, 05:26, Alim Akhtar wrote:
> 
> > +int samsung_ufs_phy_wait_for_lock_acq(struct phy *phy)
> 
> static ?
> 
Sure, already got warning email from Kobot. Will fix this.
> > +{
> > +	struct samsung_ufs_phy *ufs_phy = get_samsung_ufs_phy(phy);
> > +	const unsigned int timeout_us = 100000;
> > +	const unsigned int sleep_us = 10;
> > +	u32 val;
> > +	int err;
> > +
> > +	err = readl_poll_timeout(
> > +			ufs_phy->reg_pma +
> PHY_APB_ADDR(PHY_PLL_LOCK_STATUS),
> > +			val, (val & PHY_PLL_LOCK_BIT), sleep_us,
timeout_us);
> > +	if (err) {
> > +		dev_err(ufs_phy->dev,
> > +			"failed to get phy pll lock acquisition %d\n", err);
> > +		goto out;
> > +	}
> > +
> > +	err = readl_poll_timeout(
> > +			ufs_phy->reg_pma +
> PHY_APB_ADDR(PHY_CDR_LOCK_STATUS),
> > +			val, (val & PHY_CDR_LOCK_BIT), sleep_us,
timeout_us);
> > +	if (err) {
> > +		dev_err(ufs_phy->dev,
> > +			"failed to get phy cdr lock acquisition %d\n", err);
> > +		goto out;
> 
> this one can be dropped
> 
Sure, will update.
> > +	}
> > +
> > +out:
> > +	return err;
> > +}
> > +
> > +int samsung_ufs_phy_calibrate(struct phy *phy)
> 
> static?
> 
Will fix
> > +{
> > +	struct samsung_ufs_phy *ufs_phy = get_samsung_ufs_phy(phy);
> > +	struct samsung_ufs_phy_cfg **cfgs = ufs_phy->cfg;
> > +	const struct samsung_ufs_phy_cfg *cfg;
> > +	int i;
> > +	int err = 0;
> 
> err before i would make it look better
> 
sure
> > +
> > +	if (unlikely(ufs_phy->ufs_phy_state < CFG_PRE_INIT ||
> > +		     ufs_phy->ufs_phy_state >= CFG_TAG_MAX)) {
> > +		dev_err(ufs_phy->dev, "invalid phy config index %d\n",
> > +							ufs_phy-
> >ufs_phy_state);
> 
> single line now?
> 
Yes, 
> > +		return -EINVAL;
> > +	}
> > +
> > +	if (ufs_phy->is_pre_init)
> > +		ufs_phy->is_pre_init = false;
> 
> that sounds bit strange, you clear it if set? Can you explain what is
going on
> here, and add comments
> 
Hmm, yes right, this is not needed, let me change this and will add a
comment.
The idea here is, before exiting phy calibration in one state, change the
state to next state,
So that when next time calibrate() is called, it will do the phy settings
for the next stage.

> > +static int samsung_ufs_phy_symbol_clk_init(struct samsung_ufs_phy
> > +*phy) {
> > +	int ret = 0;
> 
> superfluous init
> 
ok
> > +
> > +	phy->tx0_symbol_clk = devm_clk_get(phy->dev, "tx0_symbol_clk");
> > +	if (IS_ERR(phy->tx0_symbol_clk)) {
> > +		dev_err(phy->dev, "failed to get tx0_symbol_clk clock\n");
> > +		goto out;
> > +	}
> > +
> > +	phy->rx0_symbol_clk = devm_clk_get(phy->dev, "rx0_symbol_clk");
> > +	if (IS_ERR(phy->rx0_symbol_clk)) {
> > +		dev_err(phy->dev, "failed to get rx0_symbol_clk clock\n");
> > +		goto out;
> > +	}
> > +
> > +	phy->rx1_symbol_clk = devm_clk_get(phy->dev, "rx1_symbol_clk");
> > +	if (IS_ERR(phy->rx0_symbol_clk)) {
> > +		dev_err(phy->dev, "failed to get rx1_symbol_clk clock\n");
> > +		goto out;
> > +	}
> > +
> > +	ret = clk_prepare_enable(phy->tx0_symbol_clk);
> > +	if (ret) {
> > +		dev_err(phy->dev, "%s: tx0_symbol_clk enable failed %d\n",
> > +				__func__, ret);
> > +		goto out;
> > +	}
> > +	ret = clk_prepare_enable(phy->rx0_symbol_clk);
> > +	if (ret) {
> > +		dev_err(phy->dev, "%s: rx0_symbol_clk enable failed %d\n",
> > +				__func__, ret);
> 
> so we keep tx0_symbol_clk enabled when bailing out?
> 
Will add a clk_disable_unprepare()
> > +		goto out;
> > +	}
> > +	ret = clk_prepare_enable(phy->rx1_symbol_clk);
> > +	if (ret) {
> > +		dev_err(phy->dev, "%s: rx1_symbol_clk enable failed %d\n",
> > +				__func__, ret);
> 
> here as well
> 
Will add a clk_disable_unprepare()
> > +static int samsung_ufs_phy_init(struct phy *phy) {
> > +	struct samsung_ufs_phy *_phy = get_samsung_ufs_phy(phy);
> > +	int ret;
> > +
> > +	_phy->lane_cnt = phy->attrs.bus_width;
> > +	_phy->ufs_phy_state = CFG_PRE_INIT;
> > +
> > +	/**
> > +	 * In ufs, PHY need to be calibrated at different stages / state
> > +	 * mainly before Linkstartup, after Linkstartup, before power
> > +	 * mode change and after power mode change.
> > +	 * Below state machine initialize the initial state to handle
> > +	 * PHY calibration at various stages of UFS initialization and power
> > +	 * mode changes
> > +	 */
> > +	_phy->is_pre_init = true;
> > +	_phy->is_post_init = false;
> > +	_phy->is_pre_pmc = false;
> > +	_phy->is_post_pmc = false;
> 
> hmm why not have phy_state and assign that
> pre_init/post_init/pre_pmc/post_pmc states?
> 
These are not needed, ufs_phy_state is enough to handle various stages.
Thanks, will remove and simplify this logic.

> > +static int samsung_ufs_phy_set_mode(struct phy *generic_phy,
> > +					enum phy_mode mode, int submode)
> 
> pls align this to preceding line opening brace (tip: checkpatch with
--strict can
> tell you about these)
Sure, will fix this, thanks for the tip.
> --
> ~Vinod

