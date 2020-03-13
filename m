Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B63AC10DCE
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 10:56:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7586D20724
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 10:56:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ZyDQ2BgP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726533AbgCMK40 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 06:56:26 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:46256 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726364AbgCMK40 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 06:56:26 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02DAqUSl037864;
        Fri, 13 Mar 2020 10:56:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=D1c/QCAsr3vu+wjm35cURmeCWnmdtLIQ7tyr7FWslxs=;
 b=ZyDQ2BgPBJgcHYVbc8S22FSFGXSI/fr7dKHRloYnBINQSchaLZLX2RAad+4ooqYvQ1AW
 p478gKt8ymGqmWIFEstVKaTGbSU3Jvywtrz5MjsLR4MimLEzqmQ1jHbXdchIfVzBYpP8
 O45/cGfS9b68tewBq28XRdcxAiqiw5LrvqtNffzGp3tp2oxRf6ZRL1/gMl8eIz9LYBGN
 T4VyxIDTAN09EYgue8jxow2kcnZ7AbzPOEXf4GMIjYQ4tKZL1n7HeMBIRE1TQhgd8zWY
 uqwZXr+pqRUywiVlpMnsTfR4DZ/9ira76mEU6ER0l61mrXDtvCdaAB/iOTCuiKr4JCDD zA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 2yqtaeu8hb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 13 Mar 2020 10:56:18 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02DAqBZc067312;
        Fri, 13 Mar 2020 10:56:17 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 2yqtaavx15-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 13 Mar 2020 10:56:17 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 02DAuGKn005674;
        Fri, 13 Mar 2020 10:56:16 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 13 Mar 2020 03:56:15 -0700
Date:   Fri, 13 Mar 2020 13:56:10 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Shreeya Patel <shreeya.patel23498@gmail.com>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        outreachy-kernel@googlegroups.com, sbrivio@redhat.com,
        daniel.baluta@gmail.com, nramas@linux.microsoft.com,
        hverkuil@xs4all.nl, Larry.Finger@lwfinger.net
Subject: Re: [Outreachy kernel] [PATCH v2] Staging: rtl8723bs: sdio_halinit:
 Remove unnecessary conditions
Message-ID: <20200313105610.GV11561@kadam>
References: <20200313104640.19787-1-shreeya.patel23498@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200313104640.19787-1-shreeya.patel23498@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9558 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 suspectscore=0 adultscore=0
 mlxlogscore=996 bulkscore=0 phishscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2003130059
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9558 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 impostorscore=0
 lowpriorityscore=0 bulkscore=0 priorityscore=1501 suspectscore=0
 mlxlogscore=999 mlxscore=0 adultscore=0 malwarescore=0 spamscore=0
 clxscore=1031 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003130059
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ignore this one.  There was a typo in Greg's email address.

regards,
dan carpenter

