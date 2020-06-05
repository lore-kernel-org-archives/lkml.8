Return-Path: <SRS0=RcPI=7S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BD90C433E1
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 09:05:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 732792067B
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 09:05:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="XNa+wh6N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726205AbgFEJFQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jun 2020 05:05:16 -0400
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:50828 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726096AbgFEJFP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jun 2020 05:05:15 -0400
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05592GkR028461;
        Fri, 5 Jun 2020 04:05:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=PODMain02222019;
 bh=b0UbT5qs2lstj4mFlCph8aT/gEmaELJnQY0qAmGoqDc=;
 b=XNa+wh6NVmGxHYp9kURkrD5R3miW51heCqRjwuWx+c084jS5vGGYQYIVL7tlLzaXt5qc
 1QYyMslpaketxrhc4k40kh7UZEPK90u3gB2M+JV+X/J6KzcFv8QUMTnvyUZOAfRZUmNO
 l4w7wzO1N4S2Zk2GvDm7W/ByoY57topK/5el1gMl4g8V83YTh8PMoBopTwwKWaFWsxDE
 zho6xvI/cT/6QlZlM4jCEegWKB7UtFyxwA7EUV8gPWKoFdXfjCoH6DQ6rL13PAf9F9xq
 cnixHAwgHhKuOaStuEAxI1NzuyRHl6Waa1/efMfNhXTxFac9x5E3HLCOdCfP32XfoVVv zg== 
Authentication-Results: ppops.net;
        spf=fail smtp.mailfrom=ckeepax@opensource.cirrus.com
Received: from ediex01.ad.cirrus.com ([87.246.76.36])
        by mx0b-001ae601.pphosted.com with ESMTP id 31f918rwx2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 05 Jun 2020 04:05:09 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Fri, 5 Jun 2020
 10:05:07 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.1913.5 via Frontend
 Transport; Fri, 5 Jun 2020 10:05:07 +0100
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 938E42AB;
        Fri,  5 Jun 2020 09:05:07 +0000 (UTC)
Date:   Fri, 5 Jun 2020 09:05:07 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Rob Herring <robh@kernel.org>
CC:     <cw00.choi@samsung.com>, <lee.jones@linaro.org>,
        <linus.walleij@linaro.org>, <broonie@kernel.org>,
        <myungjoo.ham@samsung.com>, <lgirdwood@gmail.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <patches@opensource.cirrus.com>
Subject: Re: [PATCH v3 4/7] mfd: arizona: Move binding over to dtschema
Message-ID: <20200605090507.GK71940@ediswmail.ad.cirrus.com>
References: <20200513095720.8867-1-ckeepax@opensource.cirrus.com>
 <20200513095720.8867-4-ckeepax@opensource.cirrus.com>
 <20200527194329.GA2608641@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200527194329.GA2608641@bogus>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-SPF-Result: fail
X-Proofpoint-SPF-Record: v=spf1 include:spf-001ae601.pphosted.com include:spf.protection.outlook.com
 ip4:5.172.152.52 -all
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0
 cotscore=-2147483648 lowpriorityscore=0 priorityscore=1501 adultscore=0
 mlxlogscore=999 suspectscore=0 spamscore=0 malwarescore=0 clxscore=1015
 bulkscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006050071
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 27, 2020 at 01:43:29PM -0600, Rob Herring wrote:
> On Wed, May 13, 2020 at 10:57:17AM +0100, Charles Keepax wrote:
> > Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
> > ---
> > +        LDOVDD-supply:
> > +          description:
> > +            Digital power supply, used internally to generate DCVDD when
> > +            internally supplied.
> > +          $ref: /schemas/types.yaml#/definitions/phandle
> 
> Don't need a type. *-supply has one already.
> 
> I'll fix up when applying.

Just noticing as my kernel updated with the patches that for some
reason the type on -supply doesn't seem to get applied. I can set
the supplies to strings or integers and it still passes the
schema, without those extra $ref's I had in.

Thanks,
Charles
