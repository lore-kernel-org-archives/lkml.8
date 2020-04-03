Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0AE1C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 19:05:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8998420719
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 19:05:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="fcP66OMr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728329AbgDCTFw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 15:05:52 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:35516 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726087AbgDCTFv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 15:05:51 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 033J3efK010886;
        Fri, 3 Apr 2020 19:05:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=OA5jJPClOx29aTOMe3lvmGw9pgRUlGByEeSa9X2kEVU=;
 b=fcP66OMrliNgEd8OP1mK3ULC4u1v/DrkpC+N76uTZriLgYlRWl67mn3tnPD+FGNeSZhM
 KX+OyZ+fMMFrymn1ee8FyuIwGN3cU0YJFxEDq4BZdM0J59XznisrQ1TAk81Xrzt9tbuX
 vorpl0qj2NqEXN5KJdyzfDWAEDdLhhcmDDgOz3KDUEqWw8Lg3djNOhYQOasVobskBf4U
 3iGJT5Ytz2IFjDZxlFADaRdYdm+TLyK00zuxmFank5UGY6WUu/AzfPKKaipXqD2waDrz
 eV+6s3qX3AZR9st8EX1x6NzE3DpdOSk0I7OdekXk8jqayhTknwq18aY5XxMNTCyGapjY 2A== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 303yunnbrg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 03 Apr 2020 19:05:33 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 033J2RNV171765;
        Fri, 3 Apr 2020 19:05:33 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 302g4y0ydd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 03 Apr 2020 19:05:33 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 033J5VaR014026;
        Fri, 3 Apr 2020 19:05:31 GMT
Received: from ca-dmjordan1.us.oracle.com (/10.211.9.48)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 03 Apr 2020 12:05:31 -0700
Date:   Fri, 3 Apr 2020 15:05:51 -0400
From:   Daniel Jordan <daniel.m.jordan@oracle.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Daniel Jordan <daniel.m.jordan@oracle.com>,
        kernel test robot <lkp@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, LKP <lkp@lists.01.org>,
        Tejun Heo <tj@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>
Subject: Re: [PATCH v2] workqueue: Remove the warning in wq_worker_sleeping()
Message-ID: <20200403190551.mntw6ydtqysaoipu@ca-dmjordan1.us.oracle.com>
References: <20200327074308.GY11705@shao2-debian>
 <20200327175350.rw5gex6cwum3ohnu@linutronix.de>
 <20200327232959.rpylymw2edhtxuwr@linutronix.de>
 <20200403174500.75rwuijdri5ewl5c@ca-dmjordan1.us.oracle.com>
 <20200403182502.woqrxpydt3n6l6ie@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200403182502.woqrxpydt3n6l6ie@linutronix.de>
User-Agent: NeoMutt/20180716
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9580 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 suspectscore=0
 mlxscore=0 spamscore=0 malwarescore=0 mlxlogscore=912 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004030154
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9580 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 lowpriorityscore=0
 malwarescore=0 adultscore=0 priorityscore=1501 mlxlogscore=967 bulkscore=0
 suspectscore=0 mlxscore=0 spamscore=0 impostorscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004030154
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 03, 2020 at 08:25:02PM +0200, Sebastian Andrzej Siewior wrote:
> On 2020-04-03 13:45:00 [-0400], Daniel Jordan wrote:
> > Why would preemption prevent it?  Interrupts are still enabled.
> > 
> > What am I missing?  :-)
> 
> Preemption is disabled which means no other task is allowed to be
> scheduled.

Aha, "preempt_count() > 1" in kvm_async_pf_task_wait().

Thanks.
