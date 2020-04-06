Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B7BDC2BA19
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 11:27:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22CC8206F5
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 11:27:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="tTdiZ//E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727302AbgDFL1E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 07:27:04 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:49936 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726858AbgDFL1D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 07:27:03 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 036BMsJZ190826;
        Mon, 6 Apr 2020 11:26:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=l6U4uiwcoMNuAN7weaFKznTLP8mqOIF7+J81t474szc=;
 b=tTdiZ//ENQ4+HyxiYLF7e0TuwV0FFQslnx8RS/WgQwkOssca2fDNmPLuqa4FGr2xNVli
 EoKJSSrNEUqN2kmW7C5qqEX+kA0y8Ojt8UgvScFQfep3ma18M6G6r7uioL5LrOK/Viey
 j7PO+PIaBZZGinVJLQHsfmuvUU8VaoHZ5Gw654twENIIGUGgSkXe1AtV51VWWai5xkQK
 p2uY2EObk8u0P54fodKK47Tti85Ir8Vis69HOpAEiH2iHTkIaY7/aERVNPu331HLXi5e
 CNUKge8tct4TcoXuClJvG3uF47kzGXGhDMlXjSkWU49tO7fxuEo1nEndw0bzCnrWPj6s zA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 306jvmx593-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 06 Apr 2020 11:26:58 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 036BNO14161458;
        Mon, 6 Apr 2020 11:26:57 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 30741a7640-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 06 Apr 2020 11:26:57 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 036BQshn022602;
        Mon, 6 Apr 2020 11:26:54 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 06 Apr 2020 04:26:54 -0700
Date:   Mon, 6 Apr 2020 14:26:47 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Michael Straube <straube.linux@gmail.com>
Cc:     gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, Larry.Finger@lwfinger.net
Subject: Re: [PATCH 1/2] staging: rtl8188eu: remove unnecessary asignment
Message-ID: <20200406112647.GJ2066@kadam>
References: <20200405112230.31975-1-straube.linux@gmail.com>
 <20200406112519.GH2001@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200406112519.GH2001@kadam>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9582 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0
 malwarescore=0 bulkscore=0 spamscore=0 adultscore=0 mlxlogscore=999
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004060100
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9582 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0
 mlxlogscore=999 mlxscore=0 bulkscore=0 adultscore=0 priorityscore=1501
 lowpriorityscore=0 clxscore=1015 malwarescore=0 impostorscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004060100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 06, 2020 at 02:25:20PM +0300, Dan Carpenter wrote:
> On Sun, Apr 05, 2020 at 01:22:29PM +0200, Michael Straube wrote:
> > Remove unnecessary asignment in SwLedBlink1(). The code path with the
> > asignment 'pLed->BlinkTimes = 0' is only executed when
> > 'pLed->BlinkTimes' is already zero and the value is not changed between
> > the test 'if (pLed->BlinkTimes == 0)' and the asignment.
> > 
> 
> Better to get rid of the bStopBlinking variable and this becomes more
> obvious.

Oh, never mind.  You did that in patch 2.  This is fine then.

Reviewed-by: Dan Carpenter <dan.carpenter@oracle.com>

regards,
dan carpenter

