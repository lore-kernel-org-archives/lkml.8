Return-Path: <SRS0=EowN=3M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B75A5C33CB6
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 02:22:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8901F24676
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 02:22:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="aPuL0AcV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726135AbgAWCW7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 21:22:59 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:38628 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725911AbgAWCW6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 21:22:58 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00N2IOOr146772;
        Thu, 23 Jan 2020 02:22:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2019-08-05;
 bh=SA1PoIEexyns62QHbPmD0wC6nKmliREB7fno0Go5kog=;
 b=aPuL0AcVY+GnWTa2cN8gSP8LypRv/dhK5gb+K6ZYnUKlrzydz0yDF1ngMnY5PzZCxpls
 sKdlHWxv56c3IL3oR9b3+w4J92pkLX/cgbZWh1qLmNMbQbdJhimtghzvh/Vx1ojCB7CM
 m7fhIkvvNu4iX7SICFJQDVhEa5XR4NCoP08+fc0YCqOzMCd/9VfqzdlEj20AKeHUrvZ+
 ys2PBx1qCqX9do3hKRUhcEYmW3BhAZDE7Wny3rl9GnISiiP/Iabf7jI1wycAwX04XKPz
 yX+Y4vZ/tpn6f8WuIq3UjwrrI9uLFcaea5VAPYKaHGUofzK7A3Aw7bMaQU17UTPdeLKp iA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 2xkseuqmpv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 Jan 2020 02:22:44 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00N2I6PQ024883;
        Thu, 23 Jan 2020 02:22:43 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 2xpt6n6kvp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 Jan 2020 02:22:43 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 00N2MeFt032566;
        Thu, 23 Jan 2020 02:22:40 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 22 Jan 2020 18:22:40 -0800
To:     John Garry <john.garry@huawei.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>
Subject: Re: linux-next: build failure after merge of the scsi-mkp tree
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20200122151056.7d09abf0@canb.auug.org.au>
        <52ff5728-8530-2be8-6dfa-739db5897a61@huawei.com>
Date:   Wed, 22 Jan 2020 21:22:36 -0500
In-Reply-To: <52ff5728-8530-2be8-6dfa-739db5897a61@huawei.com> (John Garry's
        message of "Wed, 22 Jan 2020 09:51:18 +0000")
Message-ID: <yq18slygbdf.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.92 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9508 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=634
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2001230018
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9508 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=713 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2001230018
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


John,

> Could you please drop this patch from your branch/revert it? Sorry for
> the hassle.

Done!

-- 
Martin K. Petersen	Oracle Linux Engineering
