Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8BB6C2BA1E
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 11:27:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9765206F5
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 11:27:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="SiNBix7z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727359AbgDFL1d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 07:27:33 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:56754 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726858AbgDFL1d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 07:27:33 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 036BNuWP058699;
        Mon, 6 Apr 2020 11:27:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=jdymwg49u9z6nptWp8aWE8NhMrcTghUd7TN0UKmJrqQ=;
 b=SiNBix7zKxvhm2nQwnn4ctQVK1Fo71/bh8e1Z/OKpN64YAr2q1E977K4YxY6dTwLcPP5
 PXcNCEdUZyWvkEAMlGiLjE1dD6wUtQ4xY7E/P0JagBMBG1jVSzjIBV3iNAqkCXsahVPj
 1OlDr2CbVeR8nCS+aCtSYWUWfUs527GVQNGIyJftbMyuf6PBFRT8xkcn7O1sEcwnQVfN
 ajOmVIgl5fQ20eU4yvsJyc4y+kiPXH6Coqi12YkT940mbij4SByvU3PNGJ/yRSXqD+OF
 lwr5BezhfyBF/m+8PQcsOw5uHetlTp1WWaES4FfOPIh4+yeW5/2Q8gmSAbwT5gA+c1NC 4g== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 306hnqx87c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 06 Apr 2020 11:27:28 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 036BNC7Y184986;
        Mon, 6 Apr 2020 11:25:28 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 3073qcur47-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 06 Apr 2020 11:25:28 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 036BPQaf013856;
        Mon, 6 Apr 2020 11:25:26 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 06 Apr 2020 04:25:26 -0700
Date:   Mon, 6 Apr 2020 14:25:20 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Michael Straube <straube.linux@gmail.com>
Cc:     gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, Larry.Finger@lwfinger.net
Subject: Re: [PATCH 1/2] staging: rtl8188eu: remove unnecessary asignment
Message-ID: <20200406112519.GH2001@kadam>
References: <20200405112230.31975-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200405112230.31975-1-straube.linux@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9582 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 mlxlogscore=999
 spamscore=0 bulkscore=0 adultscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004060100
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9582 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 adultscore=0
 priorityscore=1501 mlxscore=0 malwarescore=0 mlxlogscore=999
 lowpriorityscore=0 spamscore=0 impostorscore=0 suspectscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004060100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 05, 2020 at 01:22:29PM +0200, Michael Straube wrote:
> Remove unnecessary asignment in SwLedBlink1(). The code path with the
> asignment 'pLed->BlinkTimes = 0' is only executed when
> 'pLed->BlinkTimes' is already zero and the value is not changed between
> the test 'if (pLed->BlinkTimes == 0)' and the asignment.
> 

Better to get rid of the bStopBlinking variable and this becomes more
obvious.

regards,
dan carpenter

