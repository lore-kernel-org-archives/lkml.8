Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A9FDC433E6
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 22:00:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2448F20848
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 22:00:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="WdgFQy7p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727919AbgH0WAV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 18:00:21 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:40098 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726147AbgH0WAU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 18:00:20 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07RLwhn3090406;
        Thu, 27 Aug 2020 21:59:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=uB9oAF8MGvMJ+QhspQ5Wyh1mOckHt5TxrKbL6zVXoD0=;
 b=WdgFQy7pQ1P/dehQjnH8pVop8IqhOc0c9PFYmFXsS/yyCIJtA48ypsV3/Ng1kqH/VkUs
 VCI91KA4C+tysVLYxl48tAaUOjMT09PkD26AgvfjFP5A8m+Nbe5cEh0bGxA56mo7bKI6
 kJsPFljZRZwETWmx8/FoowsIEvVLkhyLbKlZYFECLvDV9YeK4vgero6JoYZ0E0oam03n
 vKlvOPG6vnyFwoI45FgY2wuiryY6W1qrdXNVWh9kfCTWhemG6Ou5yiCwQYMtWOJwoiLu
 04EK5GSAeStUvppwX0+A0uTSCKuLs7uizZhz7DYfyJqZYrVMB7JQipwWphgxjhQDm8YN sw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 336ht3h0yy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 27 Aug 2020 21:59:54 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07RLsjXA168999;
        Thu, 27 Aug 2020 21:59:53 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 333ru20wqk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Aug 2020 21:59:53 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 07RLxq7H007493;
        Thu, 27 Aug 2020 21:59:52 GMT
Received: from dhcp-10-154-191-150.vpn.oracle.com (/10.154.191.150)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 27 Aug 2020 14:59:52 -0700
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.1\))
Subject: Re: [PATCH] use cpu_to_le{16,32} instead of __constant_cpu_to_
From:   Himanshu Madhani <himanshu.madhani@oracle.com>
In-Reply-To: <20200827.230128.2175364115734830909.rene@exactcode.com>
Date:   Thu, 27 Aug 2020 16:59:51 -0500
Cc:     linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <2C05B6D9-91B3-445A-AB5C-730E1A123C3A@oracle.com>
References: <b7719680-e451-5687-1fb7-c8c059a880d4@acm.org>
 <2C755628-1426-4BA4-B2A3-AD059BB0F605@exactcode.com>
 <c7daea00-410d-2073-bf52-2abda9acdf8e@acm.org>
 <20200827.230128.2175364115734830909.rene@exactcode.com>
To:     Rene Rebe <rene@exactcode.com>
X-Mailer: Apple Mail (2.3608.120.23.2.1)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9726 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3 adultscore=0
 phishscore=0 spamscore=0 bulkscore=0 mlxlogscore=999 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008270163
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9726 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 malwarescore=0
 phishscore=0 priorityscore=1501 clxscore=1011 suspectscore=3 spamscore=0
 impostorscore=0 mlxscore=0 mlxlogscore=999 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008270164
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bart,


> On Aug 27, 2020, at 4:01 PM, Rene Rebe <rene@exactcode.com> wrote:
> 
> So following your recommendation here is a RFC removing all the other
> few remaining __constant_cpu_to_le{16,32} instances.

RFC looks fine.  Please add RB to official patch when you send it out. 


Reviewed-by: Himanshu Madhani <himanshu.madhani@oracle.com> 

--
Himanshu Madhani	 Oracle Linux Engineering

