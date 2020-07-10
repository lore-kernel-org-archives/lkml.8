Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6A86C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 00:24:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 82BC920720
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 00:24:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="i3NWQcCD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726757AbgGJAYg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 20:24:36 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:50310 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726268AbgGJAYf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 20:24:35 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06A07Hx0102872;
        Fri, 10 Jul 2020 00:24:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=zJ71shxFuZz9AsflxxmVD772uEc/naqgyywzJ2rhY8Y=;
 b=i3NWQcCD7FVFTUCxEnPW5BJhh4Z0gMQNizCDIwI/AuoiTVY1YrzjNY9BCtUa0DVEbpLA
 LCXlwkA78abHW3rpFPtiLdVzDx9xk9FD6WiW+nVPITvPLB8Pxf6CmMLUbrfkEPTDjLHG
 aeRmaBU6sptGpB3cOJM/ydyPbExNkTqCPsUdrpaoFDAXPIYzZpvsvhw1b9IDoj4M0LAd
 7P8CcR6izOu6uKzv5lKbALPcm+giHyqYuo5Vqk97y2SaWPUPnkBXytABYUbDppPBk7hG
 OpZj5GRRLGPFTjD99UHePu+eEcwFJnSrBjcErdEjIw0Q3WS3ZmR+e/WDrVX02wKRv9Zp 7w== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 325y0ampp6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 10 Jul 2020 00:24:19 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06A09cGn188665;
        Fri, 10 Jul 2020 00:24:19 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 325k3hv3r8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Jul 2020 00:24:18 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 06A0OG3P007144;
        Fri, 10 Jul 2020 00:24:16 GMT
Received: from [192.168.2.112] (/50.38.35.18)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 09 Jul 2020 17:24:16 -0700
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
 <b2a98ab7-0a36-ad3d-f40d-1cc9216c7961@oracle.com>
 <B926444035E5E2439431908E3842AFD256460F@DGGEMI525-MBS.china.huawei.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <99dd3c24-a864-c0e2-4f02-33a7fbc97bc7@oracle.com>
Date:   Thu, 9 Jul 2020 17:24:14 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <B926444035E5E2439431908E3842AFD256460F@DGGEMI525-MBS.china.huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9677 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0
 mlxlogscore=999 bulkscore=0 spamscore=0 mlxscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007090156
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9677 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 malwarescore=0
 clxscore=1015 impostorscore=0 phishscore=0 suspectscore=0
 priorityscore=1501 bulkscore=0 lowpriorityscore=0 mlxlogscore=999
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007090156
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/9/20 4:45 PM, Song Bao Hua (Barry Song) wrote:
> 
> 
>> -----Original Message-----
>> From: Mike Kravetz [mailto:mike.kravetz@oracle.com]
>> Sent: Friday, July 10, 2020 6:58 AM
>> To: Song Bao Hua (Barry Song) <song.bao.hua@hisilicon.com>; Roman
>> Gushchin <guro@fb.com>
>> Cc: Andrew Morton <akpm@linux-foundation.org>; linux-mm@kvack.org;
>> linux-kernel@vger.kernel.org; Linuxarm <linuxarm@huawei.com>; Jonathan
>> Cameron <jonathan.cameron@huawei.com>
>> Subject: Re: [PATCH v3] mm/hugetlb: avoid hardcoding while checking if cma
>> is enable
>>
>> Looks like this produced a warning in linux-next.  I suspect it is due to the
>> combination CONFIG_HUGETLB_PAGE && !CONFIG_CMA.
>>
>> Instead of adding the routine hugetlb_cma_enabled() to scan the hugetlb_cma
>> array, could we just use a boolean as follows?  It can simply be set in
>> hugetlb_cma_reserve when we reserve CMA.
> 
> Maybe just use hugetlb_cma_size? If hugetlb_cma_size is not 0, someone is trying to use
> cma, then bootmem for gigantic pages will be totally ignored according to discussion here:
> https://lkml.org/lkml/2020/7/8/1288
> 
> if somebody sets a wrong hugetlb_cma_size which causes that cma is not reserved. 
> It is the fault of users? We just need to document hugetlb_cma will overwrite bootmem
> reservations?
> 

Yes, I think using hugetlb_cma_size would be sufficient.  If someone
specifies hugetlb_cma=<N> and hugepagesz=<gigantic_page_size> hugepages=<X>
that is wrong.  I don't think we need to worry about 'falling back' to
preallocating X gigantic pages if N is a bad value.  Or, even if the arch
does not support cma allocation.

I am working on a patch to check this earlier in command processing.  That
will make this check unnecessary.  However, that patch is based on new
command line processing code only in 5.8.  So, I think we still need to do
this so that it can be backported to stable.
-- 
Mike Kravetz
