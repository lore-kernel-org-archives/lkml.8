Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E1ACC43331
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 11:22:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53D5720675
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 11:22:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="V4h4DEgr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388093AbgDBLWP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 07:22:15 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:44022 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388012AbgDBLWP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 07:22:15 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 032BDkNn088511;
        Thu, 2 Apr 2020 11:21:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=AJdz6L/Vw6hmin7lipJ5B/HV3aW2/d8FK2eFPWDTde4=;
 b=V4h4DEgrooTwo8Gp+yNfnUO829ofSbMSOpY4QwsaBhwUR/u/3QLq/RSwdCHIFCD09MBC
 r0NMa/PxZhtLQ/hjZfX1DZgqFc6ZclYhtQnNq0T5FB3KRN5pbdJvILOpr/1L1PHuWs15
 q0SV99aD4I8h3ORwO+zk+VkJFZMqykQY027UFvjwB+ByslB51AIXMiymRW5iFDASZ9MD
 2AqHKYknQR+61T5YsUkv1y/41zWr0H/+5v0d2HXN1yDg22n2Kvi63bEN4gWS91cfnDpf
 cBeluIcUn+Io+YuK/QLUCXLp0IJ1rjzEyJ+jqRDoxVchuWQkbT0M5A7SlWGRGpuRsj0/ jw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 303cevaqxp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 02 Apr 2020 11:21:53 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 032BCx8q078899;
        Thu, 2 Apr 2020 11:21:53 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 302g2jcvv1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 02 Apr 2020 11:21:53 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 032BLnCJ008878;
        Thu, 2 Apr 2020 11:21:49 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 02 Apr 2020 04:21:48 -0700
Date:   Thu, 2 Apr 2020 14:21:37 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     ltykernel@gmail.com
Cc:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        x86@kernel.org, michael.h.kelley@microsoft.com, wei.liu@kernel.org,
        devel@linuxdriverproject.org, vkuznets@redhat.com,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [Update PATCH] x86/Hyper-V: Initialize Syn timer clock when it's
Message-ID: <20200402112137.GM2001@kadam>
References: <20200330141708.12822-1-Tianyu.Lan@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200330141708.12822-1-Tianyu.Lan@microsoft.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9578 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0 mlxscore=0
 adultscore=0 phishscore=0 bulkscore=0 suspectscore=1 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004020102
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9578 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 adultscore=0
 clxscore=1011 phishscore=0 lowpriorityscore=0 spamscore=0 malwarescore=0
 suspectscore=1 mlxscore=0 impostorscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004020102
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This doesn't apply to today's linux-next.

regards,
dan carpenter

