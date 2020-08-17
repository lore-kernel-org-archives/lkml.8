Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EC16C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 09:23:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 50B8B2072D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 09:23:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="kVBF4LkT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728090AbgHQJXZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 05:23:25 -0400
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:49786 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726538AbgHQJXY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 05:23:24 -0400
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07H9Eei0010088;
        Mon, 17 Aug 2020 04:22:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=PODMain02222019;
 bh=TIgmhQPJma7LMTwk9a2r2DrIV+fSdBsZPGpZsfznD4U=;
 b=kVBF4LkTLx+vxHzdlXI1tA7RDqD1CjQfpE84Hhq/pf2ALXeTa8QDni7zy382rlhUn1ls
 xPiR1Vo8Jpnsa2/INR2kWExSzu5ENhrUH+2xECCel8ELvmTXiKy9ATK+zyMuCt1ZDRHH
 5AXYi2s8hgkVEt7MjOx+sY2DlByUWWI8pctYa0OsCet7v1n2qqdezmKeL0XvgnXCY7bm
 SPVxvzgliAALRuMLzSFUPg4SHjBSKywMfcS6ImkMBMLZo1XKu9F6F9LiwxPmJqu7krsQ
 QmE6oDxyJG/cC/lG0xPaqv+yt0XMttcHMU9OIsQkidCstX7sDrE1DujKkDAcJDtZBILG vw== 
Authentication-Results: ppops.net;
        spf=fail smtp.mailfrom=ckeepax@opensource.cirrus.com
Received: from ediex02.ad.cirrus.com ([87.246.76.36])
        by mx0a-001ae601.pphosted.com with ESMTP id 32xd42t8c0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 17 Aug 2020 04:22:23 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Mon, 17 Aug
 2020 10:22:21 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.1913.5 via Frontend
 Transport; Mon, 17 Aug 2020 10:22:21 +0100
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id AB8B42C3;
        Mon, 17 Aug 2020 09:22:21 +0000 (UTC)
Date:   Mon, 17 Aug 2020 09:22:21 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>
CC:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>,
        Shengjiu Wang <shengjiu.wang@nxp.com>,
        <patches@opensource.cirrus.com>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>, "kernel@puri.sm" <kernel@puri.sm>
Subject: Re: [PATCH] ASoC: wm8962: Export DAC/ADC monomix switches
Message-ID: <20200817092221.GE10899@ediswmail.ad.cirrus.com>
References: <3662154.EqNIRYjrc8@pliszka>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <3662154.EqNIRYjrc8@pliszka>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-SPF-Result: fail
X-Proofpoint-SPF-Record: v=spf1 include:spf-001ae601.pphosted.com include:spf.protection.outlook.com
 ip4:5.172.152.52 -all
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0
 lowpriorityscore=0 adultscore=0 priorityscore=1501 mlxlogscore=756
 mlxscore=0 spamscore=0 suspectscore=0 phishscore=0 impostorscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008170070
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 16, 2020 at 03:23:34AM +0200, Sebastian Krzyszkowiak wrote:
> This allows solutions like ALSA UCM to utilize hardware mono downmix
> for cases where mono output to a single speaker is desired only in
> specific situations (like on a mobile phone).
> 
> Signed-off-by: Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>
> ---

Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles
