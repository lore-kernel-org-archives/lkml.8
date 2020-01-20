Return-Path: <SRS0=vnT4=3J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 925B1C2D0DB
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 14:46:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70C18217F4
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 14:46:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728778AbgATOqf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jan 2020 09:46:35 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:37500 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726626AbgATOqf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 09:46:35 -0500
Received: from [154.119.55.242] (helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1itYK0-0005Hw-E4; Mon, 20 Jan 2020 14:46:33 +0000
Date:   Mon, 20 Jan 2020 15:46:28 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tejun Heo <tj@kernel.org>, Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org
Subject: Re: [PATCH v4 1/6] cgroup: unify attach permission checking
Message-ID: <20200120144627.2ttqolx3md6vyfew@wittgenstein>
References: <20200117181219.14542-1-christian.brauner@ubuntu.com>
 <20200117181219.14542-2-christian.brauner@ubuntu.com>
 <20200120144244.GD30403@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200120144244.GD30403@redhat.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 20, 2020 at 03:42:45PM +0100, Oleg Nesterov wrote:
> I guess I am totally confused, but...
> 
> On 01/17, Christian Brauner wrote:
> >
> > +static inline bool cgroup_same_domain(const struct cgroup *src_cgrp,
> > +				      const struct cgroup *dst_cgrp)
> > +{
> > +	return src_cgrp->dom_cgrp == dst_cgrp->dom_cgrp;
> > +}
> > +
> > +static int cgroup_attach_permissions(struct cgroup *src_cgrp,
> > +				     struct cgroup *dst_cgrp,
> > +				     struct super_block *sb, bool thread)
> > +{
> > +	int ret = 0;
> > +
> > +	ret = cgroup_procs_write_permission(src_cgrp, dst_cgrp, sb);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret = cgroup_migrate_vet_dst(dst_cgrp);
> > +	if (ret)
> > +		return ret;
> > +
> > +	if (thread &&
> > +	    !cgroup_same_domain(src_cgrp->dom_cgrp, dst_cgrp->dom_cgrp))
>                                         ^^^^^^^^^^          ^^^^^^^^^^
> 
>              cgroup_same_domain(src_cgrp, dst_cgrp)
> 
> no?
> 
> And given that cgroup_same_domain() has no other users, perhaps it can
> simply check
> 
> 	     src_cgrp->dom_cgrp != dst_cgrp->dom_cgrp

Yeah, I just added it because the helper is very descriptive given its
name. Maybe too descriptive given my braino.
I'll just remove it in favor of this check and give it a small comment.

Thanks!
Christian
