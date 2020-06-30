Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3940C433E3
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 23:45:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ABF8920663
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 23:45:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="X75Kmn4N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726997AbgF3Xpn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 19:45:43 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:40718 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726837AbgF3Xpg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 19:45:36 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05UNh9VK030919;
        Tue, 30 Jun 2020 23:45:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=+WucHskJg3QFtvF4MbKQVLD+ZxodWXbuWkDZ04zp8RQ=;
 b=X75Kmn4NnDg221chyxgibM/KpJ8nVUFAQ2AWi20xpxeCT8KoPpBkhiFiZ5alc+i2GNrR
 SjwMkK64vatsryC0ziqyP2NUmDuXsZT05fgsg2tD6nNnF9DS3vZgu5wBBTJMRTunuHc5
 M3Olt51hGSkFaIiEvabxuWACIptxwEBXhBtZrz1BmqTW7giBfNo6Gr+/amiw8gHffCOq
 NGZOZPFcKAlGDNc8r6W0SR5QZMjdHKtXOiehcWVo7kIcK7qkqx4wxpYXI+49IG7dsm7T
 EiRfHRtLal2GviWbSrF5pZ95I4N/IkyCd2DfgR4TvEzxqazeOlwRE/PMbuZt/XbVfbjh tg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 31wxrn7csy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 30 Jun 2020 23:45:19 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05UNcdLK059805;
        Tue, 30 Jun 2020 23:45:18 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 31y52jjbb1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Jun 2020 23:45:18 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 05UNjETr013266;
        Tue, 30 Jun 2020 23:45:15 GMT
Received: from [192.168.2.112] (/50.38.35.18)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 30 Jun 2020 23:45:14 +0000
Subject: Re: [PATCH v3 02/15] mm, hwpoison: remove recalculating hpage
To:     nao.horiguchi@gmail.com, linux-mm@kvack.org
Cc:     mhocko@kernel.org, akpm@linux-foundation.org, osalvador@suse.de,
        tony.luck@intel.com, david@redhat.com,
        aneesh.kumar@linux.vnet.ibm.com, zeil@yandex-team.ru,
        naoya.horiguchi@nec.com, linux-kernel@vger.kernel.org
References: <20200624150137.7052-1-nao.horiguchi@gmail.com>
 <20200624150137.7052-3-nao.horiguchi@gmail.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <abf6b82d-ced9-4457-5145-a46d808e83fc@oracle.com>
Date:   Tue, 30 Jun 2020 16:45:12 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200624150137.7052-3-nao.horiguchi@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9668 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 mlxscore=0
 adultscore=0 suspectscore=0 bulkscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006300164
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9668 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999
 priorityscore=1501 impostorscore=0 bulkscore=0 clxscore=1015
 malwarescore=0 phishscore=0 adultscore=0 cotscore=-2147483648
 lowpriorityscore=0 suspectscore=0 spamscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006300164
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/24/20 8:01 AM, nao.horiguchi@gmail.com wrote:
> From: Naoya Horiguchi <naoya.horiguchi@nec.com>
> 
> hpage is never used after try_to_split_thp_page() in memory_failure(),
> so we don't have to update hpage.  So let's not recalculate/use hpage.
> 
> Suggested-by: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
> Signed-off-by: Naoya Horiguchi <naoya.horiguchi@nec.com>

Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
-- 
Mike Kravetz
