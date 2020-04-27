Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA9E3C54FD0
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 10:32:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 96C99206B6
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 10:32:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="Qn2mPZs3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727787AbgD0KcS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 06:32:18 -0400
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:53946 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726786AbgD0KcR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 06:32:17 -0400
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03RAT1DG001890;
        Mon, 27 Apr 2020 05:32:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=PODMain02222019;
 bh=LiJ2Fq3Jj+17nXSz7NwWSDtYILEvzTXxE2sPvciKCKA=;
 b=Qn2mPZs37tJ4JozsoGPJNk3cTpZKeLARKuByRZq20HeAutZkPBT/lroX9hj7eQD4iziY
 ebwNZrgu8POUODgJPLdCQu5E0Fzmj0jhZNlnp3Mdh3VRsHjHDCbMRjvMe6fCxogD8pc6
 RC3eITuHvQirWRPrTv5mgAsKzQlRVQKt6FINM6Seg+WLZit9sL7hYI+yKKl6SRisCapE
 hjI91AwhmxGfVgC+cwc4ddyjsm1MAxHWh72r9Da8Zyrlq2O8+F7JYLYV/tZCmjSEE9fc
 X5NFoh01HP+0gc32+zoB/3NGVrCYyctWKwEED+J7xyUz9eiIyux/KyWiXSKdQGX+lmo4 /Q== 
Authentication-Results: ppops.net;
        spf=fail smtp.mailfrom=ckeepax@opensource.cirrus.com
Received: from ediex01.ad.cirrus.com ([87.246.76.36])
        by mx0a-001ae601.pphosted.com with ESMTP id 30mjm4ayq7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 27 Apr 2020 05:32:08 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Mon, 27 Apr
 2020 11:32:06 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.1913.5 via Frontend
 Transport; Mon, 27 Apr 2020 11:32:06 +0100
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 47A852C6;
        Mon, 27 Apr 2020 10:32:06 +0000 (UTC)
Date:   Mon, 27 Apr 2020 10:32:06 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Marek Szyprowski <m.szyprowski@samsung.com>
CC:     <patches@opensource.cirrus.com>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>, Mark Brown <broonie@kernel.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Lee Jones <lee.jones@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Subject: Re: [PATCH 4/4] ASoC: wm8994: Silence warnings during deferred probe
Message-ID: <20200427103206.GL44490@ediswmail.ad.cirrus.com>
References: <20200427074832.22134-1-m.szyprowski@samsung.com>
 <CGME20200427074843eucas1p1a3a265df0c7f14b0aaec25eb65daf606@eucas1p1.samsung.com>
 <20200427074832.22134-5-m.szyprowski@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200427074832.22134-5-m.szyprowski@samsung.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-SPF-Result: fail
X-Proofpoint-SPF-Record: v=spf1 include:spf-001ae601.pphosted.com include:spf.protection.outlook.com
 ip4:5.172.152.52 -all
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=975
 suspectscore=0 lowpriorityscore=0 priorityscore=1501 phishscore=0
 malwarescore=0 bulkscore=0 adultscore=0 clxscore=1015 impostorscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004270094
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 27, 2020 at 09:48:32AM +0200, Marek Szyprowski wrote:
> Don't confuse user with meaningless warning about the failure in getting
> clocks in case of deferred probe.
> 
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---

Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles
