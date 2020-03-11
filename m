Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FBD2C4CEC0
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 18:20:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCA892072F
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 18:20:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="CDghcC10"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730785AbgCKSUb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 14:20:31 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:46170 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730677AbgCKSUb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 14:20:31 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02BI9egj050614;
        Wed, 11 Mar 2020 18:20:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=oeRFK0NjZTN8yMcVMosmm0YDweQTiOEhQ6PF9jI70lY=;
 b=CDghcC104IgwC1JzA7VSInmsFAgIpOvNudmyTKzJw6Dyvj+Q4RDEeypecawV3W42rTNi
 n+Bs7pAo7rpHaVV+GR5Fx9MFaPraGsELWmAm8X/3ZC5v19RnaIfRZXfS86Z+4F3KmVoX
 3GL0thHPpWvIvqeWGiMq3NREZWeMBAe3PWyDPlHzwfvGcl3ANxMP42LIHCOHCaYgDnIA
 Ezjt+DtFeWTs4AjRe71L5rpK1B53rUw7k2YjQO5XjvAvNaDCOLeuo1wSLA+FFfHMhd+W
 4sx1qPut3g3PIH/9YCUS69ZaZOAG3XL+XH5vFXsEpkp7UWWLAbhtUMgL4bVLA84OB3gr Hw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 2yp7hm9qkm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 Mar 2020 18:20:19 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02BIKBxD017532;
        Wed, 11 Mar 2020 18:20:18 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 2ypv9vx0r0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 Mar 2020 18:20:18 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 02BIKG2M009762;
        Wed, 11 Mar 2020 18:20:16 GMT
Received: from [192.168.1.206] (/71.63.128.209)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 11 Mar 2020 11:20:16 -0700
Subject: Re: [PATCH] mm/hugetlb: remove unnecessary memory fetch in
 PageHeadHuge()
To:     Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        "Kirill A.Shutemov" <kirill.shutemov@linux.intel.com>
References: <20200311172440.6988-1-vbabka@suse.cz>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <23247c25-a637-d1b0-574f-84d1cd0ded1d@oracle.com>
Date:   Wed, 11 Mar 2020 11:20:15 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200311172440.6988-1-vbabka@suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9557 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 spamscore=0 malwarescore=0 mlxscore=0 adultscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2003110104
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9557 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0
 priorityscore=1501 clxscore=1015 mlxscore=0 impostorscore=0
 mlxlogscore=999 suspectscore=0 phishscore=0 malwarescore=0 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2003110104
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/11/20 10:24 AM, Vlastimil Babka wrote:
> Commit f1e61557f023 ("mm: pack compound_dtor and compound_order into one word
> in struct page") changed compound_dtor from a pointer to an array index in
> order to pack it. To check if page has the hugeltbfs compound_dtor, we can
> just compare the index directly without fetching the function pointer.
> Said commit did that with PageHuge() and we can do the same with PageHeadHuge()
> to make the code a bit smaller and faster.
> 
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> Cc: Mike Kravetz <mike.kravetz@oracle.com>
> Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

Thanks!

Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
-- 
Mike Kravetz
