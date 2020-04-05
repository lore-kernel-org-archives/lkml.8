Return-Path: <SRS0=MDzn=5V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E61A2C2BA17
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Apr 2020 23:42:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B77C920659
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Apr 2020 23:42:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="hmSsRli8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727857AbgDEXmY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Apr 2020 19:42:24 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:52290 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727509AbgDEXmY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Apr 2020 19:42:24 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 035Ncw6r106619;
        Sun, 5 Apr 2020 23:42:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=FGYYv8/AFAz28NJ61TBupGrpo92vVodx2L/ZNMwhDE4=;
 b=hmSsRli8iHqssrFV6fKc5NoQDQt/2uqtQifiKS5nbAvBpZ0XN6fIOjvWHJxFJVwXLKFr
 qxm6np61bioOgmNlSiYYauONmMVu7YD5YAsRzKZcf3dIrl4YiXNRxcmSy4JX3YuPZOHS
 gyNdmZTMdTuOhaeeJGEp49MEz+0j5QyvvNPy3f8uXWe+VZpc9fkp2PL5oGNOMTO5BRBZ
 Es2fo/zOub3YF7q7hFJmyiZnTwsSKfEQTW4lQ/vSof+3qiFTYiRylLkHnGRp8QC9KMHw
 y/yJp/vEgCvpbWhyTTvyPgw7d4jswXZFuixXAtkKCfK3TuNMTEh2R9y88gxU0ugiCB3Z zQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 306jvmuy2r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 05 Apr 2020 23:42:12 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 035NbmeL188037;
        Sun, 5 Apr 2020 23:40:11 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 307418h9c7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 05 Apr 2020 23:40:11 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 035Ne8bf010666;
        Sun, 5 Apr 2020 23:40:08 GMT
Received: from [192.168.0.110] (/73.243.10.6)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sun, 05 Apr 2020 16:40:08 -0700
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [PATCHv2 0/8] thp/khugepaged improvements and CoW semantics
From:   William Kucharski <william.kucharski@oracle.com>
In-Reply-To: <20200403112928.19742-1-kirill.shutemov@linux.intel.com>
Date:   Sun, 5 Apr 2020 17:40:06 -0600
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Zi Yan <ziy@nvidia.com>, Yang Shi <yang.shi@linux.alibaba.com>,
        linux-mm <linux-mm@kvack.org>, linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Content-Transfer-Encoding: 7bit
Message-Id: <88C0B655-C216-4C1E-970D-204DCCAFE513@oracle.com>
References: <20200403112928.19742-1-kirill.shutemov@linux.intel.com>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9582 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0
 malwarescore=0 bulkscore=0 spamscore=0 adultscore=0 mlxlogscore=608
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004050212
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9582 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0
 mlxlogscore=685 mlxscore=0 bulkscore=0 adultscore=0 priorityscore=1501
 lowpriorityscore=0 clxscore=1011 malwarescore=0 impostorscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004050212
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


For the PATCHv2 series:

Reviewed-by: William Kucharski <william.kucharski@oracle.com>
