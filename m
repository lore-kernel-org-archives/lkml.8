Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C00B0C5519A
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 10:36:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E6A520575
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 10:36:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="WqtMusq0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726953AbgD0Kgi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 06:36:38 -0400
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:29322 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726504AbgD0Kgh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 06:36:37 -0400
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03RAaGWH009962;
        Mon, 27 Apr 2020 05:36:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=PODMain02222019;
 bh=OOTbH6J0LXbyL05jmtZltIdW1VwK87T91qGzwTutrOo=;
 b=WqtMusq09J8w4C15t+/5TY9EygUGgKqRf5OkJrIUCGeIvWQe4g25hQLNbyOm27fbSHn1
 fSmN7Y6TOBYe+Al4OxqrkwqHdIICKBrPyLHUZQtxew3xX55hx8vXm3Dv8NTaxfx9qqav
 OEXMveiU1p6rgTg5Pq1Oe8/gp8f4AlxlaZpwWbpPXoc9SCrf0bo3EFAMnNnSgCU2kLSm
 +z4OVaOyNsYubDzTMnHGfwWHmtRTGMRfEbgHMFGu/HfQH8ZlmMSbiEEFDqze5vRAEzdO
 JSgg4sP+xIa2mvs4a7YyB4usOZVR8DdefZH3cx+xTtT5aCa0+07Zfy94yH6mu4eGJNn5 Vg== 
Authentication-Results: ppops.net;
        spf=fail smtp.mailfrom=ckeepax@opensource.cirrus.com
Received: from ediex01.ad.cirrus.com ([87.246.76.36])
        by mx0b-001ae601.pphosted.com with ESMTP id 30mhmqu12w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 27 Apr 2020 05:36:16 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Mon, 27 Apr
 2020 11:36:14 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.1913.5 via Frontend
 Transport; Mon, 27 Apr 2020 11:36:14 +0100
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 692D82C8;
        Mon, 27 Apr 2020 10:36:14 +0000 (UTC)
Date:   Mon, 27 Apr 2020 10:36:14 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     <robh+dt@kernel.org>, <lee.jones@linaro.org>, <broonie@kernel.org>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>, <jdelvare@suse.com>,
        <linux@roeck-us.net>, <linus.walleij@linaro.org>
CC:     <lgirdwood@gmail.com>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <patches@opensource.cirrus.com>
Subject: Re: [PATCH 6/6] mfd: lochnagar: Move binding over to dtschema
Message-ID: <20200427103614.GM44490@ediswmail.ad.cirrus.com>
References: <20200427102812.23251-1-ckeepax@opensource.cirrus.com>
 <20200427102812.23251-6-ckeepax@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200427102812.23251-6-ckeepax@opensource.cirrus.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-SPF-Result: fail
X-Proofpoint-SPF-Record: v=spf1 include:spf-001ae601.pphosted.com include:spf.protection.outlook.com
 ip4:5.172.152.52 -all
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 clxscore=1015 bulkscore=0
 spamscore=0 lowpriorityscore=0 impostorscore=0 malwarescore=0 phishscore=0
 suspectscore=0 priorityscore=1501 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004270096
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 27, 2020 at 11:28:12AM +0100, Charles Keepax wrote:
> Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
> ---
> +            lochnagar-pinctrl {
> +                compatible = "cirrus,lochnagar-pinctrl";
> +
> +                gpio-controller;
> +                #gpio-cells = <2>;
> +                gpio-ranges = <&lochnagar 0 0 LOCHNAGAR2_PIN_NUM_GPIOS>;
> +
> +                pinctrl-names = "default";
> +                pinctrl-0 = <&pinsettings>;

This seems to cause the following error:

Documentation/devicetree/bindings/mfd/cirrus,lochnagar.example.dt.yaml:
lochnagar@22: lochnagar-pinctrl:pin-settings:phandle: [[4]] is not of type 'object'

I think the schema is correct and the problem is one of tooling,
I have been poking at it for a while but can't seem to find a way
to silence this one. Any advice would be greatly appreciated.

Thanks,
Charles

> +
> +                pinsettings: pin-settings {
> +                    ap2aif {
> +                        input-enable;
> +                        groups = "gf-aif1";
> +                        function = "codec-aif3";
> +                    };
> +                    codec2aif {
> +                        output-enable;
> +                        groups = "codec-aif3";
> +                        function = "gf-aif1";
> +                    };
> +                };
> +            };
