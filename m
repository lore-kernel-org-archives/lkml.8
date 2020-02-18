Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CD8DC34044
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 16:35:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 758D122B48
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 16:35:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="jtIPsg8T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726774AbgBRQfK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 11:35:10 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:35464 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726403AbgBRQfH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 11:35:07 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01IGVM8B004765;
        Tue, 18 Feb 2020 16:34:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=9uIbz+6IZmhj+I6Ic8HpGMJUYSme2yHvjIUhlDjxNmM=;
 b=jtIPsg8TtK+AILGdKY3iw3MXqwd1YZljuFfBFRFF8O2BEklHbn/34z1C3+dOVpTim1nC
 AVnwk+Ai7/yXUDdypDiEmIuTRmcvdkLlGim74/L7Y0fbBNLHnMpVHgjpeMn4beh2KfrA
 mNMlJZLODJM570UZ7fCXhe8C5MPIVtkptQ8fhS0FwzyWbrzo8f8R0B/OXRY9ieck7FSd
 2yjUzpEnPO67hqN2nH5kDIUq+Q0tK0z5z1YY09dLVdqj58HJT7+XkoU3yfy2tQDTF1Oi
 nUN8pP42lh34BL8GG7W+wx7sfqueSxaTnFE4FiyoESdGtYu/C2NORDfsjh12wNNXlxm6 mA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 2y8e1hjruy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 Feb 2020 16:34:50 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01IGRrFR019262;
        Tue, 18 Feb 2020 16:34:50 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 2y6ternbnp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 Feb 2020 16:34:50 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 01IGYmmg023227;
        Tue, 18 Feb 2020 16:34:48 GMT
Received: from ca-dmjordan1.us.oracle.com (/10.211.9.48)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 18 Feb 2020 08:34:48 -0800
Date:   Tue, 18 Feb 2020 11:35:04 -0500
From:   Daniel Jordan <daniel.m.jordan@oracle.com>
To:     Corentin Labbe <clabbe.montjoie@gmail.com>
Cc:     tj@kernel.org, jiangshanlai@gmail.com, will@kernel.org,
        mark.rutland@arm.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: WARNING: at kernel/workqueue.c:1473 __queue_work+0x3b8/0x3d0
Message-ID: <20200218163504.y5ofvaejleuf5tbh@ca-dmjordan1.us.oracle.com>
References: <20200217204803.GA13479@Red>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200217204803.GA13479@Red>
User-Agent: NeoMutt/20180716
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9535 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0 bulkscore=0
 suspectscore=2 mlxscore=0 mlxlogscore=987 adultscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002180121
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9535 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 phishscore=0
 mlxlogscore=999 mlxscore=0 malwarescore=0 clxscore=1011 adultscore=0
 lowpriorityscore=0 spamscore=0 bulkscore=0 priorityscore=1501
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002180121
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Corentin,

On Mon, Feb 17, 2020 at 09:48:03PM +0100, Corentin Labbe wrote:
> When running some CI test jobs (targeting crypto tests), I always get the following WARNING:

Can you be more specific about which test triggers this?  I used the config
option you mention and failed to reproduce after doing the boot-time crypto
tests and running various tcrypt incantations.

> [    7.886361] ------------[ cut here ]------------
> [    7.886388] WARNING: CPU: 2 PID: 147 at kernel/workqueue.c:1473 __queue_work+0x3b8/0x3d0
> [    7.886394] Modules linked in: ghash_generic
> [    7.886409] CPU: 2 PID: 147 Comm: modprobe Not tainted 5.6.0-rc1-next-20200214-00068-g166c9264f0b1-dirty #545

I was using just plain next-20200214.  Can't find 166c9264f0b1, what tag/branch
were you using exactly?

> So it seems that it is a "events" workqueue that hit this problem.

Looks like "schedule_work(&init_free_wq)" in do_init_module(), can't be sure
though.

thanks,
Daniel
