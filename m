Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A199AC2BB1D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 02:47:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7DBFC2072D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 02:47:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="fotpdRKl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391729AbgDOCrr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 22:47:47 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:42164 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730445AbgDOCrh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 22:47:37 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03F2ggwT162384;
        Wed, 15 Apr 2020 02:47:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=Jdw3YEyH0IYgZZImoNUbg+XauRPAdVLPNWvR9MoiGSA=;
 b=fotpdRKlqogkplrUWEOZo7IPzyYJ+yRlYZE/thnd0xL1AEikQHS/t1wB1h8Z2nJL4BAn
 yQ2bGEie/aRMUeWpWQlRQOtZiDNPv4hnyR0xsexB5kyGfUPXPd8OpzNIO55AjJ5VNG44
 MYud3EVHtHq4N2OfNamqOUA3vGozGHZDLaD+6kWnb2Dl9KGEPGkV/9DClERwTms7cB2G
 jtPACuKenp0CoPQ3PLBxa0eHiTMyRXdVMPDdE3OIBuLP2PYfOA9wlo2uBeKCeYUG1WEW
 8KSP+0bJpJpgbgJ67b7cbZnB6i5Ylr9S3cQvnN4l+YOqgQJulR7tNMzr3/GEciU/fbUB cA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 30dn9cgsf5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Apr 2020 02:47:25 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03F2kxlg194345;
        Wed, 15 Apr 2020 02:47:24 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 30dn8skh63-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Apr 2020 02:47:24 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 03F2lMJl028967;
        Wed, 15 Apr 2020 02:47:23 GMT
Received: from [192.168.0.110] (/73.243.10.6)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 14 Apr 2020 19:47:19 -0700
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [PATCHv3, RESEND 0/8] thp/khugepaged improvements and CoW
 semantics 
From:   William Kucharski <william.kucharski@oracle.com>
In-Reply-To: <20200413100447.20073-6-kirill.shutemov@linux.intel.com>
Date:   Tue, 14 Apr 2020 20:47:18 -0600
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Zi Yan <ziy@nvidia.com>, Yang Shi <yang.shi@linux.alibaba.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>,
        linux-mm <linux-mm@kvack.org>, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <8163D0B7-988F-4713-815E-577A641B5F64@oracle.com>
References: <20200413100447.20073-1-kirill.shutemov@linux.intel.com>
 <20200413100447.20073-6-kirill.shutemov@linux.intel.com>
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9591 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 bulkscore=0 malwarescore=0 phishscore=0 adultscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004150019
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9591 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0
 lowpriorityscore=0 impostorscore=0 malwarescore=0 bulkscore=0
 priorityscore=1501 spamscore=0 suspectscore=0 mlxscore=0 mlxlogscore=999
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004150018
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quick comments, mostly nits:

[PATCH 5/6] khugepaged: Allow to collapse a page shared across fork


> +static bool is_refcount_suitable(struct page *page)
> +{
> +	int expected_refcount, refcount;
> +
> +	refcount = page_count(page);
> +	expected_refcount = total_mapcount(page);
> +	if (PageSwapCache(page))
> +		expected_refcount += compound_nr(page);
> +
> +	if (IS_ENABLED(CONFIG_DEBUG_VM) && expected_refcount > refcount) {
> +		pr_err("expected_refcount: %d, refcount: %d\n",
> +				expected_refcount, refcount);

I'd rather see this message reworded slightly as I prefer to know WHY a value
was unexpected directly from the error message:

		pr_err("expected_refcount (%d) > refcount (%d)\n",

[PATCHv3, RESEND 7/8] thp: Change CoW semantics for anon-THP

I really like the simplifications here.

[PATCHv3, RESEND 8/8] khugepaged: Introduce 'max_ptes_shared' tunable

As above, I'd like to see a tiny extra bit of specificity in the printf()s:

+static void collapse_max_ptes_shared()
+{

[ ... ]

+		if (check_huge(p))
+			success("OK");
+		else
+			fail("Fail");
+
+		printf("Trigger CoW in %d of %d...",

		printf("Trigger CoW on page %d of %d...",

+				hpage_pmd_nr - max_ptes_shared - 1, hpage_pmd_nr);
+		fill_memory(p, 0, (hpage_pmd_nr - max_ptes_shared - 1) * page_size);
+		if (!check_huge(p))
+			success("OK");
+		else
+			fail("Fail");
+
+		if (wait_for_scan("Do not collapse with max_ptes_shared exeeded", p))
+			fail("Timeout");
+		else if (!check_huge(p))
+			success("OK");
+		else
+			fail("Fail");
+
+		printf("Trigger CoW in %d of %d...",

		printf("Trigger CoW on page %d of %d...",

+				hpage_pmd_nr - max_ptes_shared, hpage_pmd_nr);
+		fill_memory(p, 0, (hpage_pmd_nr - max_ptes_shared) * page_size);
+		if (!check_huge(p))
+			success("OK");
+		else
+			fail("Fail");

Otherwise, for the khugepaged/THP series:

Reviewed-by: William Kucharski <william.kucharski@oracle.com>
