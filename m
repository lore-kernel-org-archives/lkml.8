Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FB9FC35671
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 12:38:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 349AE20828
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 12:38:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="sgptO4V3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727438AbgBXMiI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 07:38:08 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:36918 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727281AbgBXMiH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 07:38:07 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01OCVJEA070995;
        Mon, 24 Feb 2020 12:37:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=JWjEVGlBtHCHL7wbXZnNZbCFVHqD6Ma/Z5LZAI5EdvM=;
 b=sgptO4V3yccmzCZMjETC6Q1XEopEzi0ahsTKI2uNE14yzEh7oI+sd3UmToZ99Vcac0mN
 njdmGX+sjON2+8JvYbkMds2Vf6g4vmFU7Kf42yGTGuBB/c7sz27l6843JJVC8hc+718C
 hrCccEwd8w7lmKwpD4rG8L8Rh+oIXkM23Q6q6/higmQ4dmhuZUeZ7TTS7bvIMfMa0BDM
 WYmldOaEFqLrNoO7vRFt4Th/OO5YWQWHg0RmvLgg8cxiNCfV5ciIP1hRcB5b/29Z9AB1
 R+Zbpx0NlcFk8rc0i3ReZNO0N2lIst6BMLcK/7tnSsgtP9Tl1GcsegERvuzrXBCcJAaL 4A== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 2yauqu71s8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Feb 2020 12:37:47 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01OCS7J4039875;
        Mon, 24 Feb 2020 12:37:47 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 2ybe1151an-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Feb 2020 12:37:46 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 01OCbful003249;
        Mon, 24 Feb 2020 12:37:41 GMT
Received: from kadam (/129.205.23.165)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 24 Feb 2020 04:37:40 -0800
Date:   Mon, 24 Feb 2020 15:37:30 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Colin King <colin.king@canonical.com>,
        Christian Brauner <christian@brauner.io>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH][next] clone3: fix an unsigned args.cgroup comparison to
 less than zero
Message-ID: <20200224123730.GB3308@kadam>
References: <20200222001513.43099-1-colin.king@canonical.com>
 <20200222121801.cu4dfnk4z5xd5uc2@wittgenstein>
 <20200224073157.GB3286@kadam>
 <20200224122503.2m4oc5wgg2oqpjsi@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200224122503.2m4oc5wgg2oqpjsi@wittgenstein>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9540 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0
 suspectscore=0 malwarescore=0 phishscore=0 bulkscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002240102
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9540 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 bulkscore=0
 clxscore=1015 malwarescore=0 impostorscore=0 adultscore=0 phishscore=0
 priorityscore=1501 mlxlogscore=999 spamscore=0 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002240102
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 24, 2020 at 01:25:03PM +0100, Christian Brauner wrote:
> On Mon, Feb 24, 2020 at 10:31:57AM +0300, Dan Carpenter wrote:
> > On Sat, Feb 22, 2020 at 01:18:01PM +0100, Christian Brauner wrote:
> > > On Sat, Feb 22, 2020 at 12:15:13AM +0000, Colin King wrote:
> > > > From: Colin Ian King <colin.king@canonical.com>
> > > diff --git a/kernel/fork.c b/kernel/fork.c
> > > index 2diff --git a/kernel/fork.c b/kernel/fork.c
> > > index 2853e258fe1f..dca4dde3b5b2 100644
> > > --- a/kernel/fork.c
> > > +++ b/kernel/fork.c
> > > @@ -2618,7 +2618,8 @@ noinline static int copy_clone_args_from_user(struct kernel_clone_args *kargs,
> > >                      !valid_signal(args.exit_signal)))
> > >                 return -EINVAL;
> > > 
> > > -       if ((args.flags & CLONE_INTO_CGROUP) && args.cgroup < 0)
> > > +       if ((args.flags & CLONE_INTO_CGROUP) &&
> > > +           (args.cgroup > INT_MAX || (s64)args.cgroup < 0))
> > 
> > If we're capping it at INT_MAX then the check for negative isn't
> > required and static analysis tools know it's not so they might complain.
> 
> It isn't, but it's easier to understand for the reader. But I don't care
> that much and if it's trouble for tools than fine.

It's not trouble for tools, (the tools parse it correctly), it's trouble
for me looking at the static checker warnings...

regards,
dan carpenter
