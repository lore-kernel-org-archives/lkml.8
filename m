Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 286F3C2BB1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 17:35:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2C5A20716
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 17:35:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="JnS7ekvW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726554AbgCLRfM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 13:35:12 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:36122 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726385AbgCLRfL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 13:35:11 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02CHU5oA184657;
        Thu, 12 Mar 2020 17:30:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=mime-version :
 message-id : date : from : to : cc : subject : references : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=zjwbtzl7AvB+7NnGdPtL8gmsQR0LWewnNP66H9bM+Sg=;
 b=JnS7ekvW8v1tgjppgCuoMOkj5C5t3S6TG7V2Y51M3OVidNaD97W2yg1lt3jwp8NSb/Ll
 9Daf7YOHFv6oiO0GOb8+nffCldlVZUU6ctnjntvTSELW9ezcXo3U7i8s3EbqpcBtCg/L
 d7db3dI7J1Q0muVWCDQ6tf6c5P1TQnl7Ak/RcOH5MYZw+Bt3sahGge9Lv39KZP+QQ1Rs
 VRZ5wwD/CyimBLJRidZwOZMPhDrLdGdMppPf7Eboecke7xwRS9plS2Z1Kzgh0miDGDty
 wMS+3Gbg6UgLg5cOUvDJM6eKmENqZ2SSuq14xISvEvnTlH2GQ+ntQLLllaFigtoHoDYk Gw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 2yp9v6e395-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Mar 2020 17:30:15 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02CHSFDd109698;
        Thu, 12 Mar 2020 17:30:15 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 2yqkvn265d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Mar 2020 17:30:15 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 02CHUCMl000536;
        Thu, 12 Mar 2020 17:30:12 GMT
Received: from [192.168.1.206] (/71.63.128.209) by default (Oracle Beehive
 Gateway v4.0) with ESMTP ; Thu, 12 Mar 2020 09:34:34 -0700
USER-AGENT: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
Content-Language: en-US
MIME-Version: 1.0
Message-ID: <e821d691-67f5-1f29-3c70-0bad13c8ad91@oracle.com>
Date:   Thu, 12 Mar 2020 09:34:32 -0700 (PDT)
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Qian Cai <cai@lca.pw>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     Michal Hocko <mhocko@kernel.org>, Hugh Dickins <hughd@google.com>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Kirill A.Shutemov" <kirill.shutemov@linux.intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Prakash Sangappa <prakash.sangappa@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 0/2] hugetlbfs: use i_mmap_rwsem for more synchronization
References: <20200305002650.160855-1-mike.kravetz@oracle.com>
 <1584028670.7365.182.camel@lca.pw>
In-Reply-To: <1584028670.7365.182.camel@lca.pw>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9558 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=60
 mlxlogscore=999 malwarescore=0 adultscore=0 bulkscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2003120089
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9558 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=60 spamscore=0 mlxscore=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 mlxlogscore=999
 phishscore=0 adultscore=0 clxscore=1015 impostorscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2003120089
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/12/20 8:57 AM, Qian Cai wrote:
> On Wed, 2020-03-04 at 16:26 -0800, Mike Kravetz wrote:
>> While discussing the issue with huge_pte_offset [1], I remembered that
>> there were more outstanding hugetlb races.  These issues are:
> 
> Reverted this series on the top of today's linux-next fixed the hang with LTP
> move_pages12 on both powerpc and arm64,
> 
> # /opt/ltp/testcases/bin/move_pages12
> tst_test.c:1217: INFO: Timeout per run is 0h 05m 00s
> move_pages12.c:263: INFO: Free RAM 260577280 kB
> move_pages12.c:281: INFO: Increasing 2048kB hugepages pool on node 0 to 4
> move_pages12.c:291: INFO: Increasing 2048kB hugepages pool on node 8 to 4
> move_pages12.c:207: INFO: Allocating and freeing 4 hugepages on node 0
> move_pages12.c:207: INFO: Allocating and freeing 4 hugepages on node 8
> <hang>

Thank you for finding this.
I'll dig into it.  It is timing related as it takes a few test runs for
me to reproduce.

Sorry for the issues.  Feel free to revert upstream and mm tree until
there is a resolution.
-- 
Mike Kravetz
