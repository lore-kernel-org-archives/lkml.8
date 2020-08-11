Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 253FEC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 11:59:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 015DB2075D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 11:59:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="SNclY0Yy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728879AbgHKL71 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 07:59:27 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:58042 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728864AbgHKL70 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 07:59:26 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07BBuvOw114704;
        Tue, 11 Aug 2020 11:59:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=Z2ArjTHKNc7GCKD0u7iKG+pvdERcNwoPF+GuSDrsHRE=;
 b=SNclY0Yyq6dtFLnCQ4FT1lXDBKeNvlacEOUiL6vuI08cyuTDXFxDTXMA199ZJIE/u0mW
 /JOUbCFv7XeVvqfOXCkWrQabzGvsRsfa6TujA5gxVXNXx7zTccR1hnQJezl0lBhJjPG2
 RuijZcVd6N1Rwve8ADr3ldOlHpHRjG7TBg1+SiCnTVPy175Jq6+Klr2HCq8N5Camv6Pf
 3iJliD4YhoMh/wH38ePVL241STjQXVMXrwkXbqbra9v5kFVZ5zMUdb1CfkdsXFi9+Oev
 49QSzYOUY9vwUODOExIYJfaSOmMqmJukhoqTlUJBQIXBQ2bhCBSYdJtsFnU41cJYnWge pA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 32smpnc4g3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 11 Aug 2020 11:59:19 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07BBxHHZ067225;
        Tue, 11 Aug 2020 11:59:18 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 32t5y3sxg0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 Aug 2020 11:59:18 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 07BBxF0N005209;
        Tue, 11 Aug 2020 11:59:15 GMT
Received: from localhost (/73.243.10.6)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 11 Aug 2020 11:59:15 +0000
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3652.0.5.2.1\))
Subject: Re: [PATCH] memremap: Convert devmap static branch to {inc,dec}
From:   William Kucharski <william.kucharski@oracle.com>
In-Reply-To: <20200810235319.2796597-1-ira.weiny@intel.com>
Date:   Tue, 11 Aug 2020 05:59:14 -0600
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <4AF6A6E6-A098-448A-9CFD-86231D46032B@oracle.com>
References: <20200810235319.2796597-1-ira.weiny@intel.com>
To:     Ira Weiny <ira.weiny@intel.com>
X-Mailer: Apple Mail (2.3652.0.5.2.1)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9709 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0
 suspectscore=0 mlxscore=0 adultscore=0 bulkscore=0 phishscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008110083
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9709 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 lowpriorityscore=0
 bulkscore=0 impostorscore=0 phishscore=0 clxscore=1011 spamscore=0
 malwarescore=0 adultscore=0 mlxlogscore=999 mlxscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008110083
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks good to me.

Reviewed-by: William Kucharski <william.kucharski@oracle.com>

> On Aug 10, 2020, at 5:53 PM, ira.weiny@intel.com wrote:
>=20
> From: Ira Weiny <ira.weiny@intel.com>
>=20
> While reviewing Protection Key Supervisor support it was pointed out
> that using a counter to track static branch enable was an anti-pattern
> which was better solved using the provided static_branch_{inc,dec}
> functions.[1]
>=20
> Fix up devmap_managed_key to work the same way.  Also this should be
> safer because there is a very small (very unlikely) race when multiple
> callers try to enable at the same time.
>=20
> [1] =
https://lore.kernel.org/lkml/20200714194031.GI5523@worktop.programming.kic=
ks-ass.net/
>=20
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Vishal Verma <vishal.l.verma@intel.com>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> ---
> mm/memremap.c | 7 ++-----
> 1 file changed, 2 insertions(+), 5 deletions(-)
>=20
> diff --git a/mm/memremap.c b/mm/memremap.c
> index 03e38b7a38f1..9fb9ad500e78 100644
> --- a/mm/memremap.c
> +++ b/mm/memremap.c
> @@ -40,12 +40,10 @@ EXPORT_SYMBOL_GPL(memremap_compat_align);
> #ifdef CONFIG_DEV_PAGEMAP_OPS
> DEFINE_STATIC_KEY_FALSE(devmap_managed_key);
> EXPORT_SYMBOL(devmap_managed_key);
> -static atomic_t devmap_managed_enable;
>=20
> static void devmap_managed_enable_put(void)
> {
> -	if (atomic_dec_and_test(&devmap_managed_enable))
> -		static_branch_disable(&devmap_managed_key);
> +	static_branch_dec(&devmap_managed_key);
> }
>=20
> static int devmap_managed_enable_get(struct dev_pagemap *pgmap)
> @@ -56,8 +54,7 @@ static int devmap_managed_enable_get(struct =
dev_pagemap *pgmap)
> 		return -EINVAL;
> 	}
>=20
> -	if (atomic_inc_return(&devmap_managed_enable) =3D=3D 1)
> -		static_branch_enable(&devmap_managed_key);
> +	static_branch_inc(&devmap_managed_key);
> 	return 0;
> }
> #else
> --=20
> 2.28.0.rc0.12.gb6a658bd00c9
>=20
>=20

