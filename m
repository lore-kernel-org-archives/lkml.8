Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6070AC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 10:05:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3942E2068F
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 10:05:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="lFsjxZgp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729722AbgHYKFR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 06:05:17 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:39910 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729680AbgHYKFQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 06:05:16 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07PA5DA2066723;
        Tue, 25 Aug 2020 10:05:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=corp-2020-01-29;
 bh=BZIUEtXtKF8QpcVIa/9DQc2vAr4Q696mxXfxPphi1F0=;
 b=lFsjxZgp/BR2EReGU1069zZfbMPHSUHoUdIdCQUo31oJBbK2XFFOavjD3DJ9Pk+/4b5l
 geMOOgf6CYqNVlaB2rNRUjp0sCKR4HbVp8+QtDC5Uh8F5mF6QmGMNTOgnVMhtOnrDelf
 mkdTg1eDjgZeKlVDthIZ07w3HwGRtpvIcOdAGKtjUdT+2HiVe2pffOpizrK7MlUF3NYo
 P0V0GwCjb64A6rlMDVU0EjBQXWswAtGZMT485Bh7dgQswmBnk0sNqTUG4gwGd91AJTnX
 n8iF/7lBJyi9ksy/+QjqPyOlvfG5mwhw02Mer7xTMI1vgzdYLHHynlUQvcNAbFFkphHE yA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 333w6tr3ws-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 25 Aug 2020 10:05:13 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07P9kAvu168653;
        Tue, 25 Aug 2020 10:05:07 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 333ru74u2h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Aug 2020 10:05:06 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 07PA55Q9018090;
        Tue, 25 Aug 2020 10:05:05 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 25 Aug 2020 03:05:05 -0700
Date:   Tue, 25 Aug 2020 13:04:58 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     qianli zhao <zhaoqianligood@gmail.com>
Cc:     Markus Elfring <Markus.Elfring@web.de>,
        Qianli Zhao <zhaoqianli@xiaomi.com>, Tejun Heo <tj@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH v2] workqueue: Warn when work flush own workqueue
Message-ID: <20200825100458.GV1793@kadam>
References: <74f570e0aab48b86f7a157d87c16715289d457f4.1598323824.git.zhaoqianli@xiaomi.com>
 <8aef74ea-5b28-07e1-d66b-91ed9e0920e9@web.de>
 <CAPx_LQEaVq_LFXdhTAkyc_EczurqkLzKcVhb6YKFw6V_0jQbvg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPx_LQEaVq_LFXdhTAkyc_EczurqkLzKcVhb6YKFw6V_0jQbvg@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9723 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 bulkscore=0 suspectscore=0 spamscore=0 mlxscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008250074
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9723 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 impostorscore=0
 mlxlogscore=999 suspectscore=0 phishscore=0 malwarescore=0 spamscore=0
 priorityscore=1501 clxscore=1011 mlxscore=0 lowpriorityscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008250075
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We have asked Markus to stop harrassing people about commit messages but
he refuses so I think he was banned from vger at the start of the month.

On Tue, Aug 25, 2020 at 04:55:52PM +0800, qianli zhao wrote:
> Markus
> 
> Thanks for your suggestion,and sorry for my poor wording.
> 
> On Tue, Aug 25, 2020 at 4:00 PM Markus Elfring <Markus.Elfring@web.de> wrote:
> >
> > > Flushing own workqueue or work self in work context will lead to
> > > a deadlock.
> >
> > I imagine that the wording “or work self” can become clearer another bit.
> >
> >
> > > Catch this incorrect usage and issue a warning when issue happened
> >
> > * Would you like to mark the end of such a sentence with a dot?
> >
> > * How do you think about to adjust the repetition of the word “issue”?
> 
> How about below changelog?
> 
> workqueue: Warn when work flush own workqueue
> 
> Flushing itself or own workqueue in work context will
> lead to a deadlock.
> Catch this incorrect usage and warning when issue happened.

"If a workqueue flushes itself then that will lead to a deadlock.  Print
a warning and a stack trace when this happens."

> 
> >
> >
> > …
> > > - update comment
> > > ---
> > >  kernel/workqueue.c | 10 +++++++---
> >
> > I suggest to replace these triple dashes by a blank line.
> Ok

This does not matter at all.  Keep the dashes or remove them.  It
doesn't matter at all.

> >
> >
> > …
> > > @@ -2585,6 +2585,7 @@ static int rescuer_thread(void *__rescuer)
> > >   * @target_work: work item being flushed (NULL for workqueue flushes)
> > >   *
> > >   * %current is trying to flush the whole @target_wq or @target_work on it.
> > > + * If a work flushing own workqueue or itself will lead to a deadlock.
> >
> > I stumble on understanding challenges for the wording “work flushing”.
> > Can an adjustment help in comparison to the term “work item”?
> 
> How about below comment?
> 
> * If a work item flushing own workqueue or itself will lead to a deadlock.

Write this:

	* If a work queue flushes itself, that will lead to a deadlock

regards,
dan carpenter
