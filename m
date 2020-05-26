Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60CA1C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 18:21:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 31AFE20823
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 18:21:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="iJUi8XvU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729203AbgEZSVZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 14:21:25 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:37314 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727112AbgEZSVZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 14:21:25 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04QIHqUn084835;
        Tue, 26 May 2020 18:21:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=w5YSxrWisiQhUtrrv6OkREhFo/E7+LzoqjnDGHNDDLg=;
 b=iJUi8XvUCqPEQ75J2/9X0aUHPKk8W95D7etKmeJtY7vFK/e3PBMpt6qodpsefBKmp9CK
 8/MmA65GN8QvmMsnVtvtxp13LP0HWHocK9SHZkE1fNo4gJqFbFkyC+9IddiXBCgKKBej
 +6cwXIJqvUT3ET65pHCU813qfThFX8kNbL03UbvUo5bEPoF5+mSoDl1cfxeNgSEYipwp
 VpEwj/8kUO4v89zG32suBgJiJIWDomuJt0CC1bDkWy4pR5KeFGcjAYKzo1swoSFubGxf
 fp5GgwUIQJUPavzMGsit5szBKYY3ripx768kg8Ab95I6WCyX1lzwbFs6d8IcRfgVyBG6 dA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 318xbjufk7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 26 May 2020 18:21:18 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04QIIxUh100695;
        Tue, 26 May 2020 18:21:18 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 317ddpbhuy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 May 2020 18:21:18 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 04QILFbE008571;
        Tue, 26 May 2020 18:21:16 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 26 May 2020 11:21:14 -0700
Date:   Tue, 26 May 2020 21:21:06 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     gaurav <gauravpathak129@gmail.com>
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, abbotti@mev.co.uk
Subject: Re: [PATCH v2] Staging: comedi: dt2814: remove unused assignments
Message-ID: <20200526174813.GB30374@kadam>
References: <20200526150954.GA30374@kadam>
 <20200526155016.9146-1-gauravpathak129@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200526155016.9146-1-gauravpathak129@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9633 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0 mlxscore=0
 phishscore=0 adultscore=0 suspectscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005260142
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9633 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0 mlxscore=0
 lowpriorityscore=0 priorityscore=1501 phishscore=0 cotscore=-2147483648
 suspectscore=0 bulkscore=0 clxscore=1015 impostorscore=0 malwarescore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2005260142
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 26, 2020 at 09:20:16PM +0530, gaurav wrote:
                                          ^^^^^^
So very close except your from header isn't right.  Just fix that and
send a v3.

regards,
dan carpenter

