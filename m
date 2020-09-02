Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDEBFC433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 14:12:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA0A420829
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 14:12:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="qBFNyh5F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727797AbgIBOLv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 10:11:51 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:38718 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727044AbgIBN6u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 09:58:50 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 082DtFBq098614;
        Wed, 2 Sep 2020 13:58:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=sISFKp6fY3CZNRYrsljYaLRFlBpsjvuEEeZbVQnf6C8=;
 b=qBFNyh5FamTaAKmaLTj1t/9vNrjXSicagwiameh1CvuZNb61kgn0OxoLoUBEun7kAWbL
 bGILnf+Le3fR6TlAH15WsTi1DAUd0s61NZZ2idY/BWnlGBcmBiDyjKSshvCKpLzJKZU5
 7iqhmRbZV4QjxGZwGHBwde8NhFMBIqIgEC2G2OJBKI6hf6PmxczCia+MgjtSUcCxJa5I
 +wQQBJZVug/J2HQX0DRr/nYnOrbwlomBSxk6m3X9xo4RodwWjjbhra0hzJLFc3dSejKZ
 MKLLeJga/IFqfjME3aC7z6FUkihb2SPUCHIOzW7YSbJonaHt35B11lOiWiGukpatSO90 Kg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 337eer2qxv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 02 Sep 2020 13:58:40 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 082Dt4ft154100;
        Wed, 2 Sep 2020 13:58:39 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 3380su04k1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Sep 2020 13:58:39 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 082DwcpO011001;
        Wed, 2 Sep 2020 13:58:38 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 02 Sep 2020 06:58:38 -0700
Date:   Wed, 2 Sep 2020 16:58:32 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Antoni Przybylik <antoni.przybylik@wp.pl>
Cc:     gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: gdm724x: gdm_tty: replaced macro with a
 function v2
Message-ID: <20200902135832.GZ8299@kadam>
References: <20200902132559.61310-1-antoni.przybylik@wp.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200902132559.61310-1-antoni.przybylik@wp.pl>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9731 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 phishscore=0 malwarescore=0 mlxscore=0 spamscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009020133
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9731 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 adultscore=0 spamscore=0 mlxscore=0
 phishscore=0 impostorscore=0 mlxlogscore=999 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009020132
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 02, 2020 at 03:25:59PM +0200, Antoni Przybylik wrote:
> This approach is more elegant and prevents some problems related to
> macros such as operator precedence in expanded expression.
> -------------------------------------------------------------------
> Changed return type to bool and removed inline sepcifier.
> 
> Signed-off-by: Antoni Przybylik <antoni.przybylik@wp.pl>
> ---
  ^^^
See this line.

No that doesn't work at all.  Try applying your patch and reviewing the
git log.  Look the the email archive to see how to send a v2 patch.

1) subject says [PATCH v2]
2) comments under the --- line

>  drivers/staging/gdm724x/gdm_tty.c | 15 +++++++++------
>  1 file changed, 9 insertions(+), 6 deletions(-)
> 

regards,
dan carpenter

