Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F3ACC35679
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 07:32:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F37820637
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 07:32:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="h5bFUu77"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727206AbgBXHcn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 02:32:43 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:57500 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725792AbgBXHcm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 02:32:42 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01O7VL7i053525;
        Mon, 24 Feb 2020 07:32:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=ctgNwyDsGErJORzON8g3jp9u7VQvJRVglKKheMnzkkU=;
 b=h5bFUu77Tdpq7K6YcUFW/6O4hLpE73MsWFyh9w4MrdE0V4+wivoFHCxCP8oTouXgs3qA
 oOlexsdjkR9v5E/7QDKns/Ma8KiqUA8jnAtfbpwJmfjLWOIFdYT1+KL9qH8uD8J+1GpX
 PsNboxUAIqwRoBjNifdVjVhhQlsFsO07gYgWywQ5MOt9B3WHsIit5Ok4rdXba8gGCVLb
 1YjHM4VscAqNv2BnyyPq60MTgaujJVZKMyKAIXOXAj1qMmKyqsC9FL43rSAO5M8GoWvc
 N2tQWhWrmDoXh66/Ih8FuPrYpB/k7y5lCRBCX5zPD1I4vEUNv0OXXEvPDMBBI5rk/D8s 2Q== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 2yauqu5f6b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Feb 2020 07:32:13 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01O7SLXe162686;
        Mon, 24 Feb 2020 07:32:12 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 2yby5anfs9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Feb 2020 07:32:12 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 01O7W9o4007023;
        Mon, 24 Feb 2020 07:32:10 GMT
Received: from kadam (/129.205.23.165)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sun, 23 Feb 2020 23:32:09 -0800
Date:   Mon, 24 Feb 2020 10:31:57 +0300
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
Message-ID: <20200224073157.GB3286@kadam>
References: <20200222001513.43099-1-colin.king@canonical.com>
 <20200222121801.cu4dfnk4z5xd5uc2@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200222121801.cu4dfnk4z5xd5uc2@wittgenstein>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9540 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 bulkscore=0
 suspectscore=0 mlxlogscore=999 phishscore=0 adultscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002240065
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9540 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 bulkscore=0
 clxscore=1011 malwarescore=0 impostorscore=0 adultscore=0 phishscore=0
 priorityscore=1501 mlxlogscore=999 spamscore=0 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002240065
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 22, 2020 at 01:18:01PM +0100, Christian Brauner wrote:
> On Sat, Feb 22, 2020 at 12:15:13AM +0000, Colin King wrote:
> > From: Colin Ian King <colin.king@canonical.com>
> > 
> > The less than zero comparison of args.cgroup is aways false because
> > args.cgroup is a u64 and can never be less than zero.  I believe the
> > correct check is to cast args.cgroup to a s64 first to ensure an
> > invalid value is not copied to kargs->cgroup.
> > 
> > Addresses-Coverity: ("Unsigned compared against 0")
> > Fixes: ef2c41cf38a7 ("clone3: allow spawning processes into cgroups")
> > Signed-off-by: Colin Ian King <colin.king@canonical.com>
> 
> Thanks, Colin.
> Dan has reported this issue a few days prior on the janitors list so he
> likely should get a 
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> too.

Colin found it independently so no need for a Reported-by.

> diff --git a/kernel/fork.c b/kernel/fork.c
> index 2diff --git a/kernel/fork.c b/kernel/fork.c
> index 2853e258fe1f..dca4dde3b5b2 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -2618,7 +2618,8 @@ noinline static int copy_clone_args_from_user(struct kernel_clone_args *kargs,
>                      !valid_signal(args.exit_signal)))
>                 return -EINVAL;
> 
> -       if ((args.flags & CLONE_INTO_CGROUP) && args.cgroup < 0)
> +       if ((args.flags & CLONE_INTO_CGROUP) &&
> +           (args.cgroup > INT_MAX || (s64)args.cgroup < 0))

If we're capping it at INT_MAX then the check for negative isn't
required and static analysis tools know it's not so they might complain.

regards,
dan carpenter

