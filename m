Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0243C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 17:47:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B1412082F
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 17:47:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="LaY4J5uc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390751AbgDCRrP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 13:47:15 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:60190 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727882AbgDCRrP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 13:47:15 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 033HhbOm129525;
        Fri, 3 Apr 2020 17:44:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=corp-2020-01-29;
 bh=9pBTIFGFje5WBl0mCqsYZom67c7a/tLU9dKn56ZKFv8=;
 b=LaY4J5ucPEW55ViX1m4gZk9CIkGjg7xCWh/8E53ttZ8QRUBfUuu0bWrPkempYvL1ZRMn
 vrl1mtCAvOqnVILZEO3GTrzK8/fUdxRFYAUzFyGq/aKYD39OdF8T5JtF37nr+QX2Y4d1
 aRfaJKB3gmgqDeN/83QzV0KkDu1ChJ0VsSlSg15tgJC1gn2gqPB033Iy/0WTD68khKiH
 vV0lA5l8VFoa0giw+0A6PHLvjTYhbtNmAz51Uu2j90HXz/7Yeak1nkve0BlDjxIMarPW
 aCoFw0r83jrfA3HzaDE8v55dAzgnPcLZU27Kq3ROf7uB3usqLEE4VNrvzVZszRjsCtm7 zg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 303cevjdg3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 03 Apr 2020 17:44:51 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 033Hh4lT003225;
        Fri, 3 Apr 2020 17:44:51 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 302g2nks9j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 03 Apr 2020 17:44:51 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 033HiibL011446;
        Fri, 3 Apr 2020 17:44:44 GMT
Received: from ca-dmjordan1.us.oracle.com (/10.211.9.48)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 03 Apr 2020 10:44:44 -0700
Date:   Fri, 3 Apr 2020 13:45:00 -0400
From:   Daniel Jordan <daniel.m.jordan@oracle.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     kernel test robot <lkp@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, LKP <lkp@lists.01.org>,
        Tejun Heo <tj@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>
Subject: Re: [PATCH v2] workqueue: Remove the warning in wq_worker_sleeping()
Message-ID: <20200403174500.75rwuijdri5ewl5c@ca-dmjordan1.us.oracle.com>
References: <20200327074308.GY11705@shao2-debian>
 <20200327175350.rw5gex6cwum3ohnu@linutronix.de>
 <20200327232959.rpylymw2edhtxuwr@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200327232959.rpylymw2edhtxuwr@linutronix.de>
User-Agent: NeoMutt/20180716
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9580 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=813 spamscore=0 mlxscore=0
 adultscore=0 phishscore=0 bulkscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004030146
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9580 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 adultscore=0
 clxscore=1011 phishscore=0 lowpriorityscore=0 spamscore=0 malwarescore=0
 suspectscore=0 mlxscore=0 impostorscore=0 mlxlogscore=879 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004030146
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sebastian,

On Sat, Mar 28, 2020 at 12:29:59AM +0100, Sebastian Andrzej Siewior wrote:
> v1…v2: - Drop the warning instead of using cmpxchg_local().
> 	 Tglx pointed out that wq_worker_sleeping() is already invoked
> 	 with disabled preemption so the race described can not happen.

I guess you mean this race:

> However, if the interrupt occurs in wq_worker_sleeping() between reading and
> setting `sleeping' i.e.
> 
> |        if (WARN_ON_ONCE(worker->sleeping))
> |                return;
>  *interrupt*
> |        worker->sleeping = 1;
> 
> then pool->nr_running will be decremented twice in wq_worker_sleeping()
> but it will be incremented only once in wq_worker_running().

Why would preemption prevent it?  Interrupts are still enabled.

What am I missing?  :-)
