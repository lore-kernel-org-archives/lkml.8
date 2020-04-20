Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A89ABC3815B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 13:24:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 83EE920722
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 13:24:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="QTe+K0BO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727985AbgDTNYN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 09:24:13 -0400
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:28730 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726009AbgDTNYN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 09:24:13 -0400
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03KDL6Rd019755;
        Mon, 20 Apr 2020 08:23:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=PODMain02222019;
 bh=FBwOQTtBXaayFGPmxPZe67lJZ71RjO3Y1bpke6Vbe6o=;
 b=QTe+K0BOFgLB0knqTrCLFt2e6EWywViPdie95h4HRK98cmwrAi+dWkwtRkADyis9qNiy
 xkojtQJ/wgqv4gflMwkCI6Iav8c8Zqk5ARoHz8XJtLMjZLXlo9gARSGKIz6hIyUH+hJv
 DOtd+VYpbObRUb0Ty5/Qt7R+Mj9/8Abu6LggFuLh7sMMra4uPrEfbfIeUIokSMK7O0zO
 1LKnPkXzp7FDeXYaQcUTvfWcY5fIYdKL5cw5CU2ywkGX/ePAe+zuh2rkYM5CIergVV0E
 dT5v5sX7a1x7yfjIcr9Rr1FyAP0BF9rJ6L/ooQI/pvmBqjAU4sSWx2lwA60097RQvhCE TA== 
Authentication-Results: ppops.net;
        spf=fail smtp.mailfrom=ckeepax@opensource.cirrus.com
Received: from ediex01.ad.cirrus.com ([87.246.76.36])
        by mx0b-001ae601.pphosted.com with ESMTP id 30fwyqk3s4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 20 Apr 2020 08:23:22 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1591.10; Mon, 20 Apr
 2020 14:23:20 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.1591.10 via Frontend
 Transport; Mon, 20 Apr 2020 14:23:20 +0100
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 7FFF42AB;
        Mon, 20 Apr 2020 13:23:20 +0000 (UTC)
Date:   Mon, 20 Apr 2020 13:23:20 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     YueHaibing <yuehaibing@huawei.com>
CC:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>, <geert@linux-m68k.org>,
        <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ASoC: wm89xx: Add missing dependency
Message-ID: <20200420132320.GC44490@ediswmail.ad.cirrus.com>
References: <20200418090853.30340-1-yuehaibing@huawei.com>
 <20200420125343.20920-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200420125343.20920-1-yuehaibing@huawei.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-SPF-Result: fail
X-Proofpoint-SPF-Record: v=spf1 include:spf-001ae601.pphosted.com include:spf.protection.outlook.com
 ip4:5.172.152.52 -all
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 spamscore=0 mlxscore=0 adultscore=0 priorityscore=1501 mlxlogscore=788
 clxscore=1015 phishscore=0 impostorscore=0 bulkscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004200115
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 20, 2020 at 08:53:43PM +0800, YueHaibing wrote:
> sound/soc/codecs/wm8900.o: In function `wm8900_i2c_probe':
> wm8900.c:(.text+0xa36): undefined reference to `__devm_regmap_init_i2c'
> sound/soc/codecs/wm8900.o: In function `wm8900_modinit':
> wm8900.c:(.init.text+0xb): undefined reference to `i2c_register_driver'
> sound/soc/codecs/wm8900.o: In function `wm8900_exit':
> wm8900.c:(.exit.text+0x8): undefined reference to `i2c_del_driver'
> sound/soc/codecs/wm8988.o: In function `wm8988_i2c_probe':
> wm8988.c:(.text+0x857): undefined reference to `__devm_regmap_init_i2c'
> sound/soc/codecs/wm8988.o: In function `wm8988_modinit':
> wm8988.c:(.init.text+0xb): undefined reference to `i2c_register_driver'
> sound/soc/codecs/wm8988.o: In function `wm8988_exit':
> wm8988.c:(.exit.text+0x8): undefined reference to `i2c_del_driver'
> sound/soc/codecs/wm8995.o: In function `wm8995_i2c_probe':
> wm8995.c:(.text+0x1c4f): undefined reference to `__devm_regmap_init_i2c'
> sound/soc/codecs/wm8995.o: In function `wm8995_modinit':
> wm8995.c:(.init.text+0xb): undefined reference to `i2c_register_driver'
> sound/soc/codecs/wm8995.o: In function `wm8995_exit':
> wm8995.c:(.exit.text+0x8): undefined reference to `i2c_del_driver'
> 
> Add SND_SOC_I2C_AND_SPI dependency to fix this.
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Fixes: ea00d95200d02ece ("ASoC: Use imply for SND_SOC_ALL_CODECS")
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---

Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles
