Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8581BC33CA9
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 17:02:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 505862075B
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 17:02:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="OXla0e/R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728778AbgAMRCX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 12:02:23 -0500
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:8716 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727222AbgAMRCX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 12:02:23 -0500
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00DGuhCT018688;
        Mon, 13 Jan 2020 11:02:21 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=PODMain02222019;
 bh=Rf7Moq35PRy3GmEU3be1yw7v/10kRBnXASngE8sGhtg=;
 b=OXla0e/RL80yH2H9AupYjZMyBRzdwxZoUAftrPp+6JtQ/6FayJkE4U36iNZHP2RYkN8v
 g95YSnleagnWOGWN3yN2mWNIuZaVAwRRW2cJUG3qDnvhTaDjMtP0/GNuyywUK86ucSs4
 NlgSZGNolWUbYXWQBAbPmhhUOy0RKzCkRUloMK5qlrATGepFOsbeaQbREDyaApBsMcx6
 jkxZN9b3j8K1OJ/925fbCyCOuivpcsP7xw5l3uQpQCFUHsxmohDNGp7shnBMUA440K/j
 JZ+N/G8Wa+eX67wuWNSsWd3bZAYt3H4ZryEzPOJKUPGOxjElR3u3SJtrf//nVEQE1iS+ 8A== 
Authentication-Results: ppops.net;
        spf=fail smtp.mailfrom=ckeepax@opensource.cirrus.com
Received: from ediex01.ad.cirrus.com ([5.172.152.52])
        by mx0b-001ae601.pphosted.com with ESMTP id 2xfbntu8c8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 13 Jan 2020 11:02:21 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1591.10; Mon, 13 Jan
 2020 17:02:19 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.1591.10 via Frontend
 Transport; Mon, 13 Jan 2020 17:02:19 +0000
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 045092B1;
        Mon, 13 Jan 2020 17:02:20 +0000 (UTC)
Date:   Mon, 13 Jan 2020 17:02:20 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Lee Jones <lee.jones@linaro.org>
CC:     <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>
Subject: Re: [PATCH 2/2] mfd: madera: Wait for boot done before accessing any
 other registers
Message-ID: <20200113170220.GA4098@ediswmail.ad.cirrus.com>
References: <20200106102834.31301-1-ckeepax@opensource.cirrus.com>
 <20200106102834.31301-2-ckeepax@opensource.cirrus.com>
 <20200107142942.GO14821@dell>
 <20200108084220.GH10451@ediswmail.ad.cirrus.com>
 <20200113104425.GD5414@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200113104425.GD5414@dell>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-SPF-Result: fail
X-Proofpoint-SPF-Record: v=spf1 include:spf-001ae601.pphosted.com include:spf.protection.outlook.com
 -all
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 malwarescore=0
 suspectscore=0 priorityscore=1501 impostorscore=0 mlxlogscore=851
 phishscore=0 spamscore=0 clxscore=1015 adultscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-1910280000
 definitions=main-2001130141
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 13, 2020 at 10:44:25AM +0000, Lee Jones wrote:
> On Wed, 08 Jan 2020, Charles Keepax wrote:
> 
> > On Tue, Jan 07, 2020 at 02:29:42PM +0000, Lee Jones wrote:
> > > On Mon, 06 Jan 2020, Charles Keepax wrote:
> > > 
> > > > It is advised to wait for the boot done bit to be set before reading
> > > > any other register, update the driver to respect this.
> > > > 
> > > > Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
> > > > ---
> > > >  drivers/mfd/madera-core.c | 17 +++++++++++++++--
> > > >  1 file changed, 15 insertions(+), 2 deletions(-)
> > > 
> > > I'm assuming this patch is orthogonal to the last?
> > > 
> > > Can I take it on its own?
> > > 
> > 
> > Yeah these can be taken separately to the other series we are
> > waiting on Mark to review.
> 
> I mean the patch.  Can I take 2/2 without 1/2?
> 

Sorry, yes that should work too. Just tested it on my system
seems fine.

Thanks,
Charles
