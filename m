Return-Path: <SRS0=QqoS=AI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 982FAC433E1
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jun 2020 17:21:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 757E220760
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jun 2020 17:21:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="E0r9Pedd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726554AbgF0RVq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Jun 2020 13:21:46 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:55774 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725900AbgF0RVq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Jun 2020 13:21:46 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05RHIY2d000973;
        Sat, 27 Jun 2020 17:21:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=LUgv2ai4XEX3a2xqOW2NrWKmstTZTlq2pfjO0fUqyck=;
 b=E0r9PeddBLS9PhOBIj1dpbDd19j1A/9pL4r4I/EsN6Z5VXOK3j2PegkLsL33gs4ZlepL
 lTGgbfiwYnmAoTy22aOIDoYFkRg3GysGA/U9SQ+AwJHj2m66hbC3qIOoU5p4f6efApAN
 ObJvEoKe1kD+uqz9pPnkEheMCp6DAks16H8Czp2/l9A4tY/Y8F8IEscwrERS/V+zfJwI
 7WQdJvKEBA3D4HOMM0T2MK1VExaFw+xFI3OodPcI7GW1F0SQztFtB4lktn7JrFJYd+2d
 LEW+0yXD2t67Im3C/NyIvOCtvsgDpZCNjHoBiVlzBtRgTvYYbHfWd+8iDhNbcjPaU5eq GA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 31wxrms9rs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sat, 27 Jun 2020 17:21:39 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05RHEWAJ157563;
        Sat, 27 Jun 2020 17:21:39 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 31wwx1879j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 27 Jun 2020 17:21:39 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 05RHLagF007667;
        Sat, 27 Jun 2020 17:21:37 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sat, 27 Jun 2020 10:21:36 -0700
Date:   Sat, 27 Jun 2020 20:21:30 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Michael Straube <straube.linux@gmail.com>
Cc:     gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, Larry.Finger@lwfinger.net
Subject: Re: [PATCH] staging: rtl8188eu: remove unnecessary comments in
 hal8188e_phy_cfg.h
Message-ID: <20200627172130.GK2549@kadam>
References: <20200627151544.11251-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200627151544.11251-1-straube.linux@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9665 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 adultscore=0 mlxscore=0 spamscore=0 bulkscore=0 malwarescore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2006270125
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9665 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999
 priorityscore=1501 impostorscore=0 bulkscore=0 clxscore=1015
 malwarescore=0 phishscore=0 adultscore=0 cotscore=-2147483648
 lowpriorityscore=0 suspectscore=0 spamscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006270125
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 27, 2020 at 05:15:44PM +0200, Michael Straube wrote:
> @@ -145,21 +138,7 @@ struct bb_reg_def {
>  				 */
>  };
>  
> -/*------------------------------Define structure----------------------------*/
> -
> -
> -/*------------------------Export global variable----------------------------*/
> -/*------------------------Export global variable----------------------------*/
> -
> -
> -/*------------------------Export Marco Definition---------------------------*/
> -/*------------------------Export Marco Definition---------------------------*/
> -
> -
> -/*--------------------------Exported Function prototype---------------------*/
> -/*  */
>  /*  BB and RF register read/write */

You can probably delete this line as well.  ;)

> -/*  */
>  
>  /* Read initi reg value for tx power setting. */
>  void rtl8192c_PHY_GetHWRegOriginalValue(struct adapter *adapter);

regards,
dan carpenter

