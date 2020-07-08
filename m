Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE1C3C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 10:19:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 82A7720739
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 10:19:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="iS4sCjoh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728356AbgGHKTh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 06:19:37 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:35084 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725949AbgGHKTW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 06:19:22 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 068AChKj044749;
        Wed, 8 Jul 2020 10:19:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=/BlpZ6hzTwlUibKA0cSfCKXBgMHk0GrIHKQ8DTOACvA=;
 b=iS4sCjohEWXxeEpkY7s3DGlC9ZnGvgDWKWmVhYuq2ZNgseFO2AGs/aLTvTmYqbGk5LT4
 Kc1xjBfRDDEDd7ogF9IKB4joLrx0iK8dhx4y/LrrjiyjNP2a6SsHKbOe3vNbdrS3SdNu
 XIfdM/Ufa3DMAuZSOViAl1zqvQR4OMLTkb8N45ZY4fn3AT6CA9tss8Rh1PtyDSyNmz5Q
 iG9k4WC55SuFMywImc15EKmQG7ac+DG2zCLmdnpXVx+zoKesu85fSy2aQrHDQ6/zDDl5
 YgoQEbWEBGs/WYku0EfsSRZ8T3kgJcz3X0AAKFDIL1XTEAzsSO1XeKRCecVMVWxC7Yho cg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 322kv6hfxk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 08 Jul 2020 10:19:08 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 068AEHhY124906;
        Wed, 8 Jul 2020 10:19:07 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 3233pypju6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 08 Jul 2020 10:19:07 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 068AJ5uA004732;
        Wed, 8 Jul 2020 10:19:05 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 08 Jul 2020 03:19:05 -0700
Date:   Wed, 8 Jul 2020 13:18:58 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     "Alexander A. Klimov" <grandmaster@al2klimov.de>
Cc:     marvin24@gmx.de, gregkh@linuxfoundation.org,
        ac100@lists.launchpad.net, linux-tegra@vger.kernel.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Replace HTTP links with HTTPS ones: STAGING - NVIDIA
 COMPLIANT EMBEDDED CONTROLLER INTERFACE (nvec)
Message-ID: <20200708101858.GL2549@kadam>
References: <20200708091428.13554-1-grandmaster@al2klimov.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200708091428.13554-1-grandmaster@al2klimov.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9675 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0 spamscore=0
 mlxscore=0 mlxlogscore=900 bulkscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2007080074
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9675 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 bulkscore=0
 malwarescore=0 suspectscore=0 mlxlogscore=901 phishscore=0 spamscore=0
 priorityscore=1501 clxscore=1011 impostorscore=0 mlxscore=0 adultscore=0
 cotscore=-2147483648 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2007080074
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

You need to have a subsystem prefix in the subject.

[PATCH] Staging: nvec: Replace HTTP links with HTTPS

regards,
dan carpenter

