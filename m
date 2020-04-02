Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A70EBC43331
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 08:16:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 772762078E
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 08:16:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ApHM7iN4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387713AbgDBIQT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 04:16:19 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:50548 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387574AbgDBIQS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 04:16:18 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0328DQwQ143813;
        Thu, 2 Apr 2020 08:16:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=mime-version :
 message-id : date : from : to : cc : subject : references : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=O6BIiuKyZpO6P/IQ7LqOJjcZsm3+4lrzYTFGZULwaZg=;
 b=ApHM7iN40FK5+SS6+xuNNpsMZf22crsmUKtWfIySGUSce5912uZPuHlBsEpr+M/GG+OM
 gcOUdCfYMbvJK0FAv7KsPq5+ntPeyPWHkRnEl5FqbexJBz+VmgI+0/8/xO8oTaOC/4dw
 KlhEBg9abY1TolO3X1sYzBNT4OgP+hAHonRAK6YR7SWqZmL2Mu1uxn1oUR9Ifm+i8J3U
 2xDuwyBmtvxi65vb8zqB1bIFofoiLQUoCTTwdGlXm4elqVi71pIZq06YQsIQ3wG6RN6e
 gqT8KYg+xuCBy/m2Ju7EMeWtBiBd0GtnZfoLiAtLlQaLTZwLYpqK6KKK/DdmgLUDjpJf AA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 303aqhta04-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 02 Apr 2020 08:16:09 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0328CQ1r076164;
        Thu, 2 Apr 2020 08:14:08 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 302g4v4hyu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 02 Apr 2020 08:14:08 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0328E6Dw020581;
        Thu, 2 Apr 2020 08:14:06 GMT
Received: from kadam (/41.57.98.10) by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Thu, 02 Apr 2020 01:12:19 -0700
USER-AGENT: Mutt/1.9.4 (2018-02-28)
MIME-Version: 1.0
Message-ID: <20200402081211.GC2001@kadam>
Date:   Thu, 2 Apr 2020 01:12:12 -0700 (PDT)
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Aiman Najjar <aiman.najjar@hurranet.com>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Florian Schilhabel <florian.c.schilhabel@googlemail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8712: fix checkpatch warnings
References: <20200326055616.GA3718@kernel-dev>
In-Reply-To: <20200326055616.GA3718@kernel-dev>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9578 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 suspectscore=0
 mlxscore=0 spamscore=0 malwarescore=0 mlxlogscore=851 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004020074
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9578 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 clxscore=1011
 malwarescore=0 impostorscore=0 mlxlogscore=905 spamscore=0 mlxscore=0
 priorityscore=1501 lowpriorityscore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004020074
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 26, 2020 at 01:56:16AM -0400, Aiman Najjar wrote:
> @@ -350,7 +351,7 @@ static int xmitframe_addmic(struct _adapter *padapter,
>  	struct	sta_info *stainfo;
>  	struct	qos_priv *pqospriv = &(padapter->mlmepriv.qospriv);
>  	struct	pkt_attrib  *pattrib = &pxmitframe->attrib;
> -	struct	security_priv *psecuritypriv = &padapter->securitypriv;
> +	struct	security_priv *psecpriv = &padapter->securitypriv;

This patch is doing too many things of course, but the other problem is
that when you're renaming variables we don't what them to start with "p"
to mean that they are a pointer.  "psecpriv" should just be "secpriv".
That name is still kind of rubbish, but it's not against the rules like
starting with a p for pointer.

regards,
dan carpenter

