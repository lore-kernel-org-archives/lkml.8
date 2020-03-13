Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25441C10DCE
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 07:48:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB03F206FA
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 07:48:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="dJTaazcE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726455AbgCMHs3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 03:48:29 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:46596 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726364AbgCMHs2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 03:48:28 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02D7dWup151272;
        Fri, 13 Mar 2020 07:48:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=2SK3WWBLInNfBxx+nDShdd6/aLXO/zK5eUAghcZpK6w=;
 b=dJTaazcEGYB5t2VvQ8V2QqJYkzxxJTFOcV6K/kLD5gFsJ8XeOzb0XrFF77RBQTJ8o6QV
 Co2WUAvK7LX+DRMdKSJjjiPVMbWArabCpeK/heebrdRjrckzKyAqMPmsKcmrqELk+P6b
 JL6uA/R1pcbuuUXFVHKX2TTGDOq/aqrx0BHlQGir1b3nWS9/Glr/Zrp9rgXu71Z1rHK6
 mnKVV8VNc1ufsBY2N3olqcxoBTFJA0W8aFdENf5TT5sl6ZTukmpZ/UN92qAtTT5Fo9L+
 jVJaSISWFkBwsbQM8yriTDAsAnye9PkssYn/8r6xyKEyfNygUpBhcpdjJN8bE7rSP+q8 ag== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 2yqtavjbg2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 13 Mar 2020 07:48:19 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02D7ljuR109285;
        Fri, 13 Mar 2020 07:48:19 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 2yqtav271y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 13 Mar 2020 07:48:19 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 02D7mIYD004387;
        Fri, 13 Mar 2020 07:48:18 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 13 Mar 2020 00:48:17 -0700
Date:   Fri, 13 Mar 2020 10:48:11 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Cc:     Shreeya Patel <shreeya.patel23498@gmail.com>,
        gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, outreachy-kernel@googlegroups.com,
        sbrivio@redhat.com, daniel.baluta@gmail.com, hverkuil@xs4all.nl,
        Larry.Finger@lwfinger.net
Subject: Re: [Outreachy kernel] [PATCH] Staging: rtl8723bs: rtw_mlme: Remove
 unnecessary conditions
Message-ID: <20200313074811.GS11561@kadam>
References: <20200311135859.5626-1-shreeya.patel23498@gmail.com>
 <61a6c3d7-6592-b57b-6466-995309302cc2@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <61a6c3d7-6592-b57b-6466-995309302cc2@linux.microsoft.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9558 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 phishscore=0
 suspectscore=0 mlxscore=0 spamscore=0 mlxlogscore=806 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2003130043
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9558 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 phishscore=0 priorityscore=1501 clxscore=1031 mlxscore=0 adultscore=0
 spamscore=0 bulkscore=0 mlxlogscore=883 lowpriorityscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2003130042
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The original patch description was basically fine.  Outreachy reviews
tend to be more pedantic about this sort of stuff than most maintainers.
There are a couple who have very strict rules, but try to avoid those
maintainers and your life will be happier.

regards,
dan carpenter

