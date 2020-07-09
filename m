Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E066C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 18:58:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CBCF420774
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 18:58:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="kDRGkOob"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726345AbgGIS63 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 14:58:29 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:39238 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726228AbgGIS63 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 14:58:29 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 069IuwdK144135;
        Thu, 9 Jul 2020 18:58:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=lAxMFBw8USCvsXQY7vici6b5KYUftXCRohJuxNlvVx0=;
 b=kDRGkOobmtj7/7wczdW3a1ASfm9DA581KShS++JghppkZPqYkP00siEAyfqrizahVFHF
 HWI19oHZM5pHS58kW2e+NuSJnXqRujD3daMWRUiFArmal1DA/duwONtm7vQ0izIXGzjf
 5nLnV4x/SnfsVa/K1BXkCtIvNezetROpCBrAA3pIa0ED9xvl3rG6Mf8ekskajfAs+ZIB
 ktR8nbf33GWhV4mslKDDMbWs/I0zdIpdX4SbsSH56ZRlK18cZl0X0HHUAn0lLM7i4WWV
 up+clViGLeEdi/NK+IxjJhm44R97b3Vmd61wPZpedHJPBBMJUCkrtTadxrbRG2jzs+Nm +A== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 325y0akmc5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 09 Jul 2020 18:58:15 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 069IdNxV184628;
        Thu, 9 Jul 2020 18:58:15 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 325k3hryqe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 09 Jul 2020 18:58:15 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 069IwCel013417;
        Thu, 9 Jul 2020 18:58:12 GMT
Received: from [192.168.2.112] (/50.38.35.18)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 09 Jul 2020 11:58:12 -0700
Subject: Re: [PATCH v3] mm/hugetlb: avoid hardcoding while checking if cma is
 enable
To:     "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>,
        Roman Gushchin <guro@fb.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>,
        Jonathan Cameron <jonathan.cameron@huawei.com>
References: <20200707040204.30132-1-song.bao.hua@hisilicon.com>
 <20200707125641.dbd2ccd63f525aa5870069d8@linux-foundation.org>
 <9066e009-5ed2-1992-d70d-fd27b4bf5871@oracle.com>
 <20200708184615.GA251665@carbon.dhcp.thefacebook.com>
 <B926444035E5E2439431908E3842AFD2560E41@DGGEMI525-MBS.china.huawei.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <b2a98ab7-0a36-ad3d-f40d-1cc9216c7961@oracle.com>
Date:   Thu, 9 Jul 2020 11:58:11 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <B926444035E5E2439431908E3842AFD2560E41@DGGEMI525-MBS.china.huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9677 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 mlxscore=0
 spamscore=0 malwarescore=0 phishscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007090129
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9677 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0
 priorityscore=1501 spamscore=0 phishscore=0 clxscore=1015 mlxlogscore=999
 lowpriorityscore=0 malwarescore=0 bulkscore=0 suspectscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007090130
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks like this produced a warning in linux-next.  I suspect it is due to the
combination CONFIG_HUGETLB_PAGE && !CONFIG_CMA.

Instead of adding the routine hugetlb_cma_enabled() to scan the hugetlb_cma
array, could we just use a boolean as follows?  It can simply be set in
hugetlb_cma_reserve when we reserve CMA.
-- 
Mike Kravetz

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index fab4485b9e52..92cb882cf287 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -46,6 +46,7 @@ unsigned int default_hstate_idx;
 struct hstate hstates[HUGE_MAX_HSTATE];
 
 static struct cma *hugetlb_cma[MAX_NUMNODES];
+static bool hugetlb_cma_enabled = false;
 
 /*
  * Minimum page order among possible hugepage sizes, set to a proper value
@@ -2571,7 +2572,7 @@ static void __init hugetlb_hstate_alloc_pages(struct hstate *h)
 
 	for (i = 0; i < h->max_huge_pages; ++i) {
 		if (hstate_is_gigantic(h)) {
-			if (IS_ENABLED(CONFIG_CMA) && hugetlb_cma[0]) {
+			if (hugetlb_cma_enabled) {
 				pr_warn_once("HugeTLB: hugetlb_cma is enabled, skip boot time allocation\n");
 				break;
 			}
@@ -5708,6 +5709,7 @@ void __init hugetlb_cma_reserve(int order)
 		reserved += size;
 		pr_info("hugetlb_cma: reserved %lu MiB on node %d\n",
 			size / SZ_1M, nid);
+		hugetlb_cma_enabled = true;
 
 		if (reserved >= hugetlb_cma_size)
 			break;
