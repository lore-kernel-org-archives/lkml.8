Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7648CC433E6
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 16:27:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 43B542080C
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 16:27:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="o5yZBPEo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727929AbgH1Q1X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 12:27:23 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:56774 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726033AbgH1Q1U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 12:27:20 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07SGK81F010032;
        Fri, 28 Aug 2020 16:27:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=szWeicb44docMrTDzmD1U0oIaG1KQo02urCu6Wi/Ql0=;
 b=o5yZBPEoaTvrO64o1Et9oN3WV+uGD90DcyqsAWzsf34u93Qd3HuWKrQYIFyhAtF/ryIn
 BuNQfnnxMA2LdJR0cGZqt98UAiW9meXMi3aCro+F8/EbzoaA6nVNZmQ36OYcip9ej07V
 PTRa1zqIQH8QeYfsEqfaMsNAogB805P03FJr0yf16n4wZPMxZkluSDKDFOx7bHaOme2n
 UhS0CXaQWxsQMkps/FBL7Tl7FZmyyzzb/xICYo6QIMGdSXcVrQzy1GdNkXz9QwS1N4/O
 9JiXnKGKpu4JNdV+gGjpi7hYuTk+drJ+BmSBjHPWEDxGa5c6EgvxLgAZkj7Dxk3/9xBr vg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 333dbscvje-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 28 Aug 2020 16:27:13 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07SGL4vE028921;
        Fri, 28 Aug 2020 16:25:12 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 333ru2yy1r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Aug 2020 16:25:12 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 07SGPBXg028595;
        Fri, 28 Aug 2020 16:25:11 GMT
Received: from [192.168.2.112] (/50.38.35.18)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 28 Aug 2020 09:25:11 -0700
Subject: Re: [Patch v2 6/7] mm/hugetlb: return non-isolated page in the loop
 instead of break and check
To:     Wei Yang <richard.weiyang@linux.alibaba.com>,
        akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org, bhe@redhat.com
References: <20200828033242.8787-1-richard.weiyang@linux.alibaba.com>
 <20200828033242.8787-7-richard.weiyang@linux.alibaba.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <80ca8de0-45cd-0c53-9f95-90957960c19d@oracle.com>
Date:   Fri, 28 Aug 2020 09:25:10 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200828033242.8787-7-richard.weiyang@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9727 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0
 phishscore=0 spamscore=0 bulkscore=0 mlxlogscore=999 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008280121
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9727 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 phishscore=0 malwarescore=0
 mlxlogscore=999 spamscore=0 mlxscore=0 lowpriorityscore=0 suspectscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008280121
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/27/20 8:32 PM, Wei Yang wrote:
> Function dequeue_huge_page_node_exact() iterates the free list and
> return the first non-isolated one.
> 
> Instead of break and check the loop variant, we could return in the loop
> directly. This could reduce some redundant check.
> 
> Signed-off-by: Wei Yang <richard.weiyang@linux.alibaba.com>
> Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>

Commit bbe88753bd42 (mm/hugetlb: make hugetlb migration callback CMA aware)
in v5.9-rc2 modified dequeue_huge_page_node_exact.  This patch will need
to be updated to take those changes into account.

-- 
Mike Kravetz
