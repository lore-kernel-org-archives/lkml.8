Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FFDFC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 10:43:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 21D27206B7
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 10:43:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="WKXqV58o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728041AbgFZKm6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 06:42:58 -0400
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:4336 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726197AbgFZKm6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 06:42:58 -0400
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05QAgYo7026581;
        Fri, 26 Jun 2020 05:42:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=PODMain02222019;
 bh=HIdZGRZV343sE1uUrGswag+c34TD4R/gDRthwL74GiM=;
 b=WKXqV58oPwAAMoft7eE5qG5JWBc+28sFKh893C3era7iHH10fbtzFT8OVOKCmqatKsor
 Ql+03xTnHtQfLe7GZBVF7MEIrHAmdYc4eAJasdNyveTxbIQ9BCm4nRAKnmB8laQ6RWA4
 ctxO9Ccx+xyHMV0CNevC8nsHMAcKcDF4H3WXvb7tpULB9rlgJJ9dIGNPL4i+5shCw80m
 oC2BpkTteUTfqm/xqJ6/x3FNf3pXx9gaRW/NFkMe4qvMFSZcfzrtXDKLkqzrD3qYmnWp
 twHtbig+49dGHpiOlPtupCaoxinL9wUIa8DsJBRG54qSG7iBd9v4OTrU7+RuFWL4FB4v fQ== 
Authentication-Results: ppops.net;
        spf=fail smtp.mailfrom=ckeepax@opensource.cirrus.com
Received: from ediex02.ad.cirrus.com ([87.246.76.36])
        by mx0b-001ae601.pphosted.com with ESMTP id 31uuqsc53k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 26 Jun 2020 05:42:38 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Fri, 26 Jun
 2020 11:42:36 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.1913.5 via Frontend
 Transport; Fri, 26 Jun 2020 11:42:36 +0100
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id CC18D2AB;
        Fri, 26 Jun 2020 10:42:36 +0000 (UTC)
Date:   Fri, 26 Jun 2020 10:42:36 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Lee Jones <lee.jones@linaro.org>
CC:     <lgirdwood@gmail.com>, <broonie@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>
Subject: Re: [RESEND 06/10] regulator: wm8350-regulator: Repair odd
 formatting in documentation
Message-ID: <20200626104236.GC71940@ediswmail.ad.cirrus.com>
References: <20200625191708.4014533-1-lee.jones@linaro.org>
 <20200625191708.4014533-7-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200625191708.4014533-7-lee.jones@linaro.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-SPF-Result: fail
X-Proofpoint-SPF-Record: v=spf1 include:spf-001ae601.pphosted.com include:spf.protection.outlook.com
 ip4:5.172.152.52 -all
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 malwarescore=0
 mlxlogscore=724 suspectscore=0 bulkscore=0 priorityscore=1501
 cotscore=-2147483648 clxscore=1015 mlxscore=0 adultscore=0 impostorscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2006260077
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 25, 2020 at 08:17:04PM +0100, Lee Jones wrote:
> Kerneldoc expects function arguments to be in the format '@.*:'.  If
> this format is not followed the kerneldoc tooling/parsers/validators
> get confused.
> 
> Fixes the following W=1 warning(s):
> 
>  drivers/regulator/wm8350-regulator.c:1234: warning: Function parameter or member 'wm8350' not described in 'wm8350_register_led'
>  drivers/regulator/wm8350-regulator.c:1234: warning: Function parameter or member 'lednum' not described in 'wm8350_register_led'
>  drivers/regulator/wm8350-regulator.c:1234: warning: Function parameter or member 'dcdc' not described in 'wm8350_register_led'
>  drivers/regulator/wm8350-regulator.c:1234: warning: Function parameter or member 'isink' not described in 'wm8350_register_led'
>  drivers/regulator/wm8350-regulator.c:1234: warning: Function parameter or member 'pdata' not described in 'wm8350_register_led'
> 
> Cc: patches@opensource.cirrus.com
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---

Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles
