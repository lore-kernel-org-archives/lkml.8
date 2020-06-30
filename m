Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C7CAC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 23:30:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2524F2053B
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 23:30:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="NvDcFFYP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726126AbgF3Xag (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 19:30:36 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:42696 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726066AbgF3Xaf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 19:30:35 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05UNSEDl135265;
        Tue, 30 Jun 2020 23:30:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=8xntrXJkOjHlvgVyL7GBucVnQm+i3rz5IkbLMrITKKw=;
 b=NvDcFFYP8uQFTBdQe7lgBku1prz3/lJAUcfFHm6QTjVNR31s2H7xn+QnxcbjfNECNzZW
 emnHQVhsZadJeTIMdxh2e6xGtIxggcvf9Ug3mH1rt9gNrK+nQUwQheH4ix4TmS8qg7aW
 LUmmMZGnvLI9COXrjduTyBUI5SFERZtqX1r0JhEBfAckX1+JrJ6F9FpNdy6NGc6exIoq
 sIIHcKc2r63UZ7LAuIJrZ1TWyctArEQLKAdsp3eAY7Wjkq2Lc8kd1mE/n+Fb1UhSWZra
 x6CMCIFfx7jYJ0QMaPeEXh7pU0QWrl4PhExUuVyyC5EPNmjq7aAHBtsOKyGyBLRYHk+f hw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 31ywrbnknr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 30 Jun 2020 23:30:17 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05UNMZcH052099;
        Tue, 30 Jun 2020 23:28:17 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 31xfvt5qm0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Jun 2020 23:28:16 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 05UNSCdK004168;
        Tue, 30 Jun 2020 23:28:13 GMT
Received: from [192.168.2.112] (/50.38.35.18)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 30 Jun 2020 23:28:12 +0000
Subject: Re: [PATCH v3 01/15] mm,hwpoison: cleanup unused PageHuge() check
To:     nao.horiguchi@gmail.com, linux-mm@kvack.org
Cc:     mhocko@kernel.org, akpm@linux-foundation.org, osalvador@suse.de,
        tony.luck@intel.com, david@redhat.com,
        aneesh.kumar@linux.vnet.ibm.com, zeil@yandex-team.ru,
        naoya.horiguchi@nec.com, linux-kernel@vger.kernel.org
References: <20200624150137.7052-1-nao.horiguchi@gmail.com>
 <20200624150137.7052-2-nao.horiguchi@gmail.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <890127ee-b6e1-9e96-d1dd-c04bd92f836f@oracle.com>
Date:   Tue, 30 Jun 2020 16:28:09 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200624150137.7052-2-nao.horiguchi@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9668 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0 spamscore=0
 phishscore=0 malwarescore=0 mlxlogscore=999 bulkscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006300162
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9668 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 mlxlogscore=999
 clxscore=1011 cotscore=-2147483648 priorityscore=1501 lowpriorityscore=0
 malwarescore=0 mlxscore=0 adultscore=0 suspectscore=0 impostorscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2006300162
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/24/20 8:01 AM, nao.horiguchi@gmail.com wrote:
> From: Naoya Horiguchi <naoya.horiguchi@nec.com>
> 
> Drop the PageHuge check, which is dead code since memory_failure() forks
> into memory_failure_hugetlb() for hugetlb pages.
> 
> memory_failure() and memory_failure_hugetlb() shares some functions like
> hwpoison_user_mappings() and identify_page_state(), so they should properly
> handle 4kB page, thp, and hugetlb.
> 
> Signed-off-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
> Signed-off-by: Oscar Salvador <osalvador@suse.de>

Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
-- 
Mike Kravetz
