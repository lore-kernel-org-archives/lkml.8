Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1A4EC34031
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 07:44:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87ECC21D7D
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 07:44:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="fO3nknBQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726266AbgBRHoN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 02:44:13 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:36644 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726127AbgBRHoM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 02:44:12 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01I7hshl148884;
        Tue, 18 Feb 2020 07:43:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=2cFkJJ+HWXz8rBSLgVbh02TUoTvyZyGJ1ksnlPP9NrM=;
 b=fO3nknBQ/q/w2ukA1ZS7Kp/Uu7Qp2snL+wn0aw8BHScGey6QHUFCJnSRZ084h/Wla1d7
 l9CyxuzQl6LtfOVENSmjGIzkhzkSxmzAFvqHZUJaI7l65ArrkGvaWjNOYgaektzYq+2a
 YvJH10HZV8SABWf1DTOzfu8ZpLO7Jj8WMSegXfTCxR595PqnwMIF2dQprr2NFmD1GltD
 svQlVKSq6zwFNybGSZ7XaIoDI2MrL+tDnWl2M/0s/IvznB3A204L3vZVrbQv5tgfu97L
 8TLcZQmq5Y548Ruo+bs7H0QJc3E1i6Ra4mufnqhPudLo22ZzMKc0Kw07bdB0Pn3lhzTX rQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 2y699rkppn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 Feb 2020 07:43:59 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01I7fgEu116169;
        Tue, 18 Feb 2020 07:43:59 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 2y6tepdnuk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 Feb 2020 07:43:58 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 01I7hhNs027756;
        Tue, 18 Feb 2020 07:43:43 GMT
Received: from kadam (/129.205.23.165)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 17 Feb 2020 23:43:42 -0800
Date:   Tue, 18 Feb 2020 10:43:36 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Kaaira Gupta <kgupta@es.iitr.ac.in>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: staging: board: disabled driver
Message-ID: <20200218074335.GC19641@kadam>
References: <20200213185205.GA26906@kaaira-HP-Pavilion-Notebook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200213185205.GA26906@kaaira-HP-Pavilion-Notebook>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9534 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0 bulkscore=0
 suspectscore=0 mlxscore=0 mlxlogscore=999 adultscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002180062
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9534 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0
 malwarescore=0 priorityscore=1501 adultscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 lowpriorityscore=0 spamscore=0 clxscore=1015 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002180062
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 14, 2020 at 12:22:05AM +0530, Kaaira Gupta wrote:
> I made some changes in board.h and other files under board to remove the MACRO using conditions. I did git log --oneline "file path" to get the logs, but turned out the driver was disabled. Hence on seeing it's KConfig file I found STAGING_BOARd and searched it in device drivers in menuconfig. I found that OF_ADDRESS-> OF-> X86_INTEL_CE were disabled as well. But I couldn't find X86_INTEL_CE under the device drivers.What should I do about it? Is there a way around or should I look at other drivers than board?
> Thanks for your time!

Use "make nconfig" and then press F8 and search for X86_INTEL_CE.

regards,
dan carpenter

