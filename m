Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4E90C433EA
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 01:29:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 862A120791
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 01:29:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="sDJkD157"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728051AbgGPB30 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 21:29:26 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:49022 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728033AbgGPB3Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 21:29:25 -0400
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20200716012921epoutp01a6c2f65424fdaf3b13eb9df5dd30de3d~iF2nUBlut0890408904epoutp01Q
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 01:29:21 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20200716012921epoutp01a6c2f65424fdaf3b13eb9df5dd30de3d~iF2nUBlut0890408904epoutp01Q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1594862961;
        bh=hOa/A7YiqiUgUKfubXBHWOxCskvKIPDJb68BD6K6Sdw=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=sDJkD157ZwKeUhy3Akdkhhi095mTtIZFjR0nR2RYYcGSmYkKkNVmoEpTzQCnUoQ54
         R7EFZORZO2AvdnDAZrjhQV7vPQ7CCyZ5Y05AiANfQpLAqRcYW96KHe9LZovcvBU0gL
         Yfy2rjcukJhR6DshEOSLjlHlT5M+k8mZycd86jSU=
Received: from epsmges5p1new.samsung.com (unknown [182.195.42.73]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTP id
        20200716012920epcas5p2ff4a5f48f3e6b052117db3476bd22e35~iF2m1jJaB0342103421epcas5p2K;
        Thu, 16 Jul 2020 01:29:20 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        4D.1A.09467.07DAF0F5; Thu, 16 Jul 2020 10:29:20 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
        20200716011732epcas5p4e81ce853962d66b1a48ce24e9f63d7ed~iFsTYGCbK1630116301epcas5p4Z;
        Thu, 16 Jul 2020 01:17:32 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200716011732epsmtrp219362f3104ebe5bcc0433d9f84bf0c9a~iFsTXS0GR2678726787epsmtrp2V;
        Thu, 16 Jul 2020 01:17:32 +0000 (GMT)
X-AuditID: b6c32a49-a29ff700000024fb-ba-5f0fad709991
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        5D.EB.08303.CAAAF0F5; Thu, 16 Jul 2020 10:17:32 +0900 (KST)
Received: from alimakhtar02 (unknown [107.108.234.165]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200716011730epsmtip1bda720948ff454b86cbda2a5c209b952~iFsRNj4yc3113931139epsmtip19;
        Thu, 16 Jul 2020 01:17:30 +0000 (GMT)
From:   "Alim Akhtar" <alim.akhtar@samsung.com>
To:     "'Vinod Koul'" <vkoul@kernel.org>
Cc:     <robh+dt@kernel.org>, <krzk@kernel.org>, <kwmad.kim@samsung.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-samsung-soc@vger.kernel.org>, <kishon@ti.com>
In-Reply-To: <20200713061737.GD34333@vkoul-mobl>
Subject: RE: [PATCH v12 2/2] phy: samsung-ufs: add UFS PHY driver for
 samsung SoC
Date:   Thu, 16 Jul 2020 06:47:28 +0530
Message-ID: <077501d65b0e$e1630100$a4290300$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQIAZudAEAONCLYZ7ErPEYM0UJKVzwJEgx3VAd4V62cCg/PmQ6h9FfEw
Content-Language: en-in
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrCKsWRmVeSWpSXmKPExsWy7bCmpm7BWv54gzM39C3mHznHanHhaQ+b
        xfnzG9gtbm45ymKx6fE1VovLu+awWcw4v4/JonXvEXaLnXdOMDtwemxa1cnmsXlJvUffllWM
        HsdvbGfy+LxJLoA1issmJTUnsyy1SN8ugStj+l2rgjXyFfeexDUwfpHoYuTkkBAwkZh7fwcb
        iC0ksJtR4u4PCQj7E6PE8/aiLkYuIPszo8Sby7tYYBom3rjDDpHYxSjRd+w+E4TzhlHi9Mpp
        rCBVbAK6EjsWt4GNFRFQldjy5AEbSBGzwDNGiTWbOhhBEpwCBhKn/l0CGyssECzxYd8CZhCb
        Bajh1pfXYDavgKXEuaWXGSFsQYmTM5+A1TMLyEtsfzuHGeIkBYmfT5cBLeYAWuYm8fleEUSJ
        uMTRnz3MIHslBBZySKz9f4MZpEZCwEXiz1R1iFZhiVfHt7BD2FISn9/tZYMoyZbo2WUMEa6R
        WDrvGNTz9hIHrsxhASlhFtCUWL9LHyIsKzH11DomiK18Er2/nzBBxHkldsyDsVUlmt9dhRoj
        LTGxu5t1AqPSLCR/zULy1ywkD8xC2LaAkWUVo2RqQXFuemqxaYFhXmq5XnFibnFpXrpecn7u
        JkZwQtLy3MF498EHvUOMTByMhxglOJiVRHh5uHjjhXhTEiurUovy44tKc1KLDzFKc7AoifMq
        /TgTJySQnliSmp2aWpBaBJNl4uCUamDa0F96qNXs/+fZF/ZuF5syl+kjT4Jb1eMpR64Hm0rW
        z9aXFo5s1umXNRc/erk+XIVX+nHsM+ZllxXuiS62vrFD2j98XsSjINOkkxbbeRP8Lyy1bAvj
        2OTP88oo8P4T0RcVYmW/xVX/v8+UL5snv3TRlLeTvaceC+Cv5Ir5Vbxs3UXPrB9hBf/8frpf
        85+3aMf8FV5Rf0N7D78yM6w8O6Guu+jphplnV6xgl1/7W1D+oOOpWdaHfGU5Ev9HTCxKmKMf
        1LY0yPX4Ko/FG1YXBHM6rmm402nmmHFjWsvMnh9zX2w/sCEu8oKc4Cmb68Lq+fGrJ7F08nvn
        ee6xVJtQmWUapZ9UrKvozBi0gatzwRElluKMREMt5qLiRABgTY+wtwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupgkeLIzCtJLcpLzFFi42LZdlhJTnfNKv54gxdbNSzmHznHanHhaQ+b
        xfnzG9gtbm45ymKx6fE1VovLu+awWcw4v4/JonXvEXaLnXdOMDtwemxa1cnmsXlJvUffllWM
        HsdvbGfy+LxJLoA1issmJTUnsyy1SN8ugStj+l2rgjXyFfeexDUwfpHoYuTkkBAwkZh44w47
        iC0ksINRYs5HZ4i4tMT1jRPYIWxhiZX/ngPZXEA1rxgl7t/sYQVJsAnoSuxY3MYGYosIqEps
        efKADaSIWeAdo8TufSfZIDoeM0pcOHIXrIpTwEDi1L9LLCC2sECgxKLZ75hAbBag7ltfXjOD
        2LwClhLnll5mhLAFJU7OfAJUzwE0VU+ibSNYmFlAXmL72znMENcpSPx8uowVpEREwE3i870i
        iBJxiaM/e5gnMArPQjJoFsKgWUgGzULSsYCRZRWjZGpBcW56brFhgVFearlecWJucWleul5y
        fu4mRnBkaWntYNyz6oPeIUYmDsZDjBIczEoivDxcvPFCvCmJlVWpRfnxRaU5qcWHGKU5WJTE
        eb/OWhgnJJCeWJKanZpakFoEk2Xi4JRqYOJ7c/On3BxlV0eej5Pnp+/7kn385FSmmQqK/Fu2
        Kf+3l4qSN/pyb+JFwfNvdTvkecrrj/QdORWbt6R78nuF1n9xCfel8/aq8iZtCX7MfKza4R1r
        9b+dIvzXq3/tSzvf6trWl+j6tyDWzdtmUop0obRatssdhayti8/tOXd/vlc7+58ra/eaxPKG
        r5a3vj4/Mu366qkne1I8xMR8I29L/nz0v/swi3dlo6X7OZu/alIlPOXf5q0ql41t2CegH8T9
        jEn45sOqVtVN35x25Oc8/LepbB1bwrOpX2uKTy5wvOi7onuzReS/U76CV4VnLasvn7to5XGZ
        hxUN11lYd7LqrEpimaP6SdT553ZrPeO3rkosxRmJhlrMRcWJAGADDc8bAwAA
X-CMS-MailID: 20200716011732epcas5p4e81ce853962d66b1a48ce24e9f63d7ed
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
X-CMS-RootMailID: 20200703173144epcas5p1daa9f5c594e7f299638cc75b7425b7c8
References: <20200703171135.77389-1-alim.akhtar@samsung.com>
        <CGME20200703173144epcas5p1daa9f5c594e7f299638cc75b7425b7c8@epcas5p1.samsung.com>
        <20200703171135.77389-2-alim.akhtar@samsung.com>
        <20200713061737.GD34333@vkoul-mobl>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vinod,

> -----Original Message-----
> From: Vinod Koul <vkoul@kernel.org>
> Sent: 13 July 2020 11:48
> To: Alim Akhtar <alim.akhtar@samsung.com>
> Cc: robh+dt@kernel.org; krzk@kernel.org; kwmad.kim@samsung.com;
> devicetree@vger.kernel.org; linux-arm-kernel@lists.infradead.org; linux-
> kernel@vger.kernel.org; linux-samsung-soc@vger.kernel.org; kishon@ti.com
> Subject: Re: [PATCH v12 2/2] phy: samsung-ufs: add UFS PHY driver for
samsung
> SoC
> 
> On 03-07-20, 22:41, Alim Akhtar wrote:
> 
> > +static const struct samsung_ufs_phy_cfg exynos7_post_init_cfg[] = {
> > +	END_UFS_PHY_CFG
> > +};
> 
> This is dummy, why not add a check to make config optional?
> 
Currently this is dummy, however this might be used for the similar platform
which do some phy tunning post init.
Will just remove this for now for this platform, will add this check in
driver.

> > +static int samsung_ufs_phy_symbol_clk_init(struct samsung_ufs_phy
> > +*phy) {
> > +	int ret = 0;
> 
> superfluous init, am sure I flagged it before as well
> 
Yes, you did, but 0-DAY CI kernel test gave warning [1], so I kept this as
it is.
[1] https://lkml.org/lkml/2020/7/3/81

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
> __func__, ret);
> > +		goto out;
> > +	}
> > +
> > +	ret = clk_prepare_enable(phy->rx0_symbol_clk);
> > +	if (ret) {
> > +		dev_err(phy->dev, "%s: rx0_symbol_clk enable failed %d\n",
> __func__, ret);
> > +		clk_disable_unprepare(phy->tx0_symbol_clk);
> > +		goto out;
> > +	}
> > +
> > +	ret = clk_prepare_enable(phy->rx1_symbol_clk);
> > +	if (ret) {
> > +		dev_err(phy->dev, "%s: rx1_symbol_clk enable failed %d\n",
> __func__, ret);
> > +		clk_disable_unprepare(phy->tx0_symbol_clk);
> > +		clk_disable_unprepare(phy->rx0_symbol_clk);
> 
> maybe it will look better if we add common rollback and jump to proper
labels
> 
Sure, will change in next version.

> > +static int samsung_ufs_phy_clks_init(struct samsung_ufs_phy *phy) {
> > +	int ret;
> > +
> > +	phy->ref_clk = devm_clk_get(phy->dev, "ref_clk");
> > +	if (IS_ERR(phy->ref_clk))
> > +		dev_err(phy->dev, "failed to get ref_clk clock\n");
> > +
> > +	ret = clk_prepare_enable(phy->ref_clk);
> > +	if (ret) {
> > +		dev_err(phy->dev, "%s: ref_clk enable failed %d\n",
__func__,
> ret);
> > +		return ret;
> > +	}
> > +
> > +	dev_info(phy->dev, "UFS MPHY ref_clk_rate = %ld\n",
> > +clk_get_rate(phy->ref_clk));
> 
> debug pls
> 
Sure, will change

> > +static int samsung_ufs_phy_init(struct phy *phy) {
> > +	struct samsung_ufs_phy *_phy = get_samsung_ufs_phy(phy);
> 
> ss_phy perhaps?
> 
Sure, will change 

> > +	int ret;
> > +
> > +	_phy->lane_cnt = phy->attrs.bus_width;
> > +	_phy->ufs_phy_state = CFG_PRE_INIT;
> > +
> > +	if (_phy->drvdata->has_symbol_clk) {
> > +		ret = samsung_ufs_phy_symbol_clk_init(_phy);
> > +		if (ret)
> > +			dev_err(_phy->dev, "failed to set ufs phy symbol
> clocks\n");
> > +	}
> > +
> > +	ret = samsung_ufs_phy_clks_init(_phy);
> > +	if (ret)
> > +		dev_err(_phy->dev, "failed to set ufs phy  clocks\n");
> > +
> > +	samsung_ufs_phy_calibrate(phy);
> > +
> > +	return 0;
> 
> not return samsung_ufs_phy_calibrate() ?
> --
Will add an error path.

> ~Vinod

