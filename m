Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1265EC2BA19
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 11:15:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA0BE206F5
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 11:15:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="EMJfk10G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727199AbgDFLPl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 07:15:41 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:40970 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726873AbgDFLPl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 07:15:41 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 036BCt5u171444;
        Mon, 6 Apr 2020 11:15:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=QVjxrJ8QSz+DelTGjFdQ/F/1RkfZlL9u7ceZFM/P5eE=;
 b=EMJfk10GM9MpU7Co0nc1cEz9LCFsf3eR9nuSc8gdbobAj97/byE2iB0ItD7qxR/mSzCB
 dwLYc2xB5yguezCQzpBJEFU3tu8quCpKGQcwrVmoW+gYPz7T8oh8tdzXipcNhR92nQf2
 2ZfrPoGQ72jz0SPY6nwoyVAFJaE85E3ssdbU5d5ZvAxCoo/X6fC4/jWJNaa/S4TdCHZe
 TDp2zbp0KMevFd8Wk1OcV960UjUOe7JHF7nCCaSklX+3EE0j91WNT97VP/PKyPKB8YQm
 XNO1Ag6QAoxzq5gQsCmZwR3Xm1e2SqcIogaKiwDs3YD2bjgqPhr4bvf7e58BEyKKwEEL CA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 306jvmx3uk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 06 Apr 2020 11:15:32 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 036BCaZl176512;
        Mon, 6 Apr 2020 11:13:32 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 3073spqqer-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 06 Apr 2020 11:13:32 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 036BDUxr015538;
        Mon, 6 Apr 2020 11:13:31 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 06 Apr 2020 04:13:30 -0700
Date:   Mon, 6 Apr 2020 14:13:23 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Oscar Carter <oscar.carter@gmx.com>
Cc:     Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, Malcolm Priestley <tvboxspy@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] staging: vt6656: Use ARRAY_SIZE instead of define
 RATE_54M
Message-ID: <20200406111323.GD2001@kadam>
References: <20200404141400.3772-1-oscar.carter@gmx.com>
 <20200404141400.3772-2-oscar.carter@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200404141400.3772-2-oscar.carter@gmx.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9582 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 spamscore=0
 malwarescore=0 suspectscore=0 adultscore=0 bulkscore=0 mlxlogscore=792
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004060098
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9582 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0
 mlxlogscore=853 mlxscore=0 bulkscore=0 adultscore=0 priorityscore=1501
 lowpriorityscore=0 clxscore=1015 malwarescore=0 impostorscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004060098
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 04, 2020 at 04:13:58PM +0200, Oscar Carter wrote:
> Use ARRAY_SIZE to replace the define RATE_54M so we will never have a
> mismatch. In this way, avoid the possibility of a buffer overflow if
> this define is changed in the future to a greater value.
> 

Future proofing is not really a valid reason to change this.  We have to
assume that future programmers are not idiots.

The only valid reason to do this is readability, but I'm not convinced
the new version is more readable.

regards,
dan carpenter

