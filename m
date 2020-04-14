Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0203C2BB86
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 13:28:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD1AE206A2
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 13:28:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="hYCUF+Lr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732074AbgDNN2s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 09:28:48 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:58044 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731898AbgDNN0H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 09:26:07 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03EDO5UW043642;
        Tue, 14 Apr 2020 13:26:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=gatGl3cXyXLavzUnNcCzXYbQt7xdiunM/YVOCfb2tV0=;
 b=hYCUF+LrRDOfYKEY32wyv0mlGa/Jg4YKSL4HygoQ2650pcI7mMZ2UAKoZcbyU7zi4ltC
 1nFIdXP7YNr+RcQ+cOPtdsOnpzBQKQjcmWe8Svvz1aNpe15Po3rhSc2WLnQGx/eUk+bJ
 k62dcz8aKQ7TDKz4g+QsGHswgU06ZFQSlVMotzspusEyly1IHKkqeY52pTZ69VbFs+kU
 z/TetCRr6C0M6qWwfZzuinuo1mpOk195dGqkTivLEqt1KdvyJKAXEfpePrrVH+/m2m7x
 ULp9pGwqBEkPrynPFIJWfCbg3gLBPKh/flQ8OwFh+/rHMyMVOBTyT8koVioRA5g1rLB7 8Q== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 30b5um4n05-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Apr 2020 13:26:00 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03EDLlFB177137;
        Tue, 14 Apr 2020 13:26:00 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 30bqchndks-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Apr 2020 13:26:00 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 03EDPwi6019231;
        Tue, 14 Apr 2020 13:25:58 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 14 Apr 2020 06:25:58 -0700
Date:   Tue, 14 Apr 2020 16:25:51 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Ivan Safonov <insafonov@gmail.com>
Cc:     devel@driverdev.osuosl.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Nishka Dasgupta <nishkadg.linux@gmail.com>,
        Larry Finger <Larry.Finger@lwfinger.net>
Subject: Re: [PATCH 5/8] staging: rtl8188eu: Remove function rtw_modular64()
Message-ID: <20200414132551.GJ1163@kadam>
References: <20190712071746.2474-5-nishkadg.linux@gmail.com>
 <66fb1e37-107e-54f4-4986-ca4e4bb99d2d@yandex.ru>
 <20200414115604.GF1163@kadam>
 <20becb6f-7bf6-8618-9525-b64c226088c7@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20becb6f-7bf6-8618-9525-b64c226088c7@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9590 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 mlxlogscore=999
 bulkscore=0 malwarescore=0 phishscore=0 mlxscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004140110
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9590 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1011 bulkscore=0 mlxscore=0
 mlxlogscore=999 lowpriorityscore=0 impostorscore=0 adultscore=0
 phishscore=0 spamscore=0 suspectscore=1 malwarescore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004140110
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 14, 2020 at 03:22:59PM +0300, Ivan Safonov wrote:
> On 4/14/20 2:56 PM, Dan Carpenter wrote:
> > On Sun, Apr 12, 2020 at 04:34:08PM +0300, Ivan Safonov wrote:
> > > > Remove function rtw_modular64 as all it does is call do_div.
> > > 
> > > This is wrong. Macro do_div(x, y) change first argument x, but
> > > rtw_modular64(x, y) preserve it.
> > > 
> > > > +			tsf = pmlmeext->TSFValue - do_div(pmlmeext->TSFValue, (pmlmeinfo->bcn_interval*1024)) - 1024; /* us */
> > > 
> > > rounddown(pmlmeext->TSFValue, pmlmeinfo->bcn_interval * 1024) - 1024
> > > is a better replacement for
> > 
> > You're absolutely correct that the patch is buggy, but I'm not sure that
> > rounddown() is what we want.
> > 
> > rtw_modular64() took the MOD of x.  So it should be something like:
> > 
> > 	tsf = pmlmeext->TSFValue - (pmlmeext->TSFValue % (pmlmeinfo->bcn_interval * 1024)) - 1024; /* us */
> > 
> > But what the heck is that even???  If pmlmeinfo->bcn_interval is zero
> > or one then the subtraction ends up giving us a negative.
> > 
> > regards,
> > dan carpenter
> > 
> 
> 1. pmlmeext->TSFValue can not be negative, because it is uint64_t;
> 2. pmlmeext->TSFValue is cyclic value:
>     https://en.wikipedia.org/wiki/Timing_synchronization_function ;
> 3. (rounddown(a, b)) is equal to (a - a % b) by definition.

Yeah.  You're right.  I got mixed up and I misread what you were
suggesting.

	tsf = rounddown(pmlmeext->TSFValue, pmlmeinfo->bcn_interval * 1024) - 1024;

regards,
dan carpenter

