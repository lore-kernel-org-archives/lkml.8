Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 979F1C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 23:17:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6CF5820739
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 23:17:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="d1BIlQya"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726960AbgGPXRY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 19:17:24 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:55426 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726189AbgGPXRX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 19:17:23 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06GNDPgK088443;
        Thu, 16 Jul 2020 23:17:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=8jtki/pU95bZMs51t72Fvdic/OjDlvBAeH0vxva+v1M=;
 b=d1BIlQyasWZQ9MBtOcWLb43omvjPgkZWmnYzB71AFO0OcQc+6doqyh8kCIQnKRDmFggS
 xZsMl0rbWhLZRY66Kwjdho6Q7gptc2icRRCVHEaKHyLYaUWCNaX4Vrhs+tkBcLGSf1AJ
 HMJybpVlmy4UNTSTNnq+xjoHHQs98r2OTElwLvyZPGHDliwl/RSX6+SNQzSzBavtNA+Z
 oV98Ev4fcwSrtUr3k+vFBmFL7LzpSATz8Y+J9AVj+Xvco0eUBKZ2RkaSEvGPgfbaJPRg
 8Qv1Q/MFs9S9Tjj3/ynJ7n7YQbfrc7VrJWCTYvSsapQaq/X34KorYouq+TU70KjwLAUu jg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 3275cmm8mr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 16 Jul 2020 23:17:07 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06GNDiTN111977;
        Thu, 16 Jul 2020 23:15:06 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 327qbctyd5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Jul 2020 23:15:06 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 06GNF3TF013005;
        Thu, 16 Jul 2020 23:15:04 GMT
Received: from [192.168.2.112] (/50.38.35.18)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 16 Jul 2020 16:15:03 -0700
Subject: Re: [PATCH v4 03/15] mm,madvise: call soft_offline_page() without
 MF_COUNT_INCREASED
To:     Oscar Salvador <osalvador@suse.de>, akpm@linux-foundation.org
Cc:     mhocko@suse.com, linux-mm@kvack.org, david@redhat.com,
        aneesh.kumar@linux.vnet.ibm.com, naoya.horiguchi@nec.com,
        linux-kernel@vger.kernel.org,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Oscar Salvador <osalvador@suse.com>
References: <20200716123810.25292-1-osalvador@suse.de>
 <20200716123810.25292-4-osalvador@suse.de>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <0467947a-4306-bc36-2c5e-04e578990d36@oracle.com>
Date:   Thu, 16 Jul 2020 16:15:01 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200716123810.25292-4-osalvador@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9684 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 mlxscore=0 spamscore=0 phishscore=0 suspectscore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007160149
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9684 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 priorityscore=1501
 bulkscore=0 adultscore=0 lowpriorityscore=0 phishscore=0 spamscore=0
 impostorscore=0 malwarescore=0 mlxlogscore=999 clxscore=1011 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007160149
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/16/20 5:37 AM, Oscar Salvador wrote:
> From: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
> 
> The call to get_user_pages_fast is only to get the pointer to a struct
> page of a given address, pinning it is memory-poisoning handler's job,
> so drop the refcount grabbed by get_user_pages_fast
> 
> Signed-off-by: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
> Signed-off-by: Oscar Salvador <osalvador@suse.com>

Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>

-- 
Mike Kravetz
