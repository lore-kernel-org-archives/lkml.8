Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5CEEC433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 04:16:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 79D1322CAF
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 04:16:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596773768;
	bh=ku0mtRLPmN6NVNq3U53FKsGpwTHeRKVHnmHxSE42guc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=CwvHhK3gmE4LVcEclAN2RiR/xaf+C9RQCQSBiM9oKSYnmA9Jz7sS/FLIAmkJcs5Qi
	 UYDablLeYbZE1g38ZYjTPcWR5UQmmMG1E0FnCHnaYhbYFMKuLLVrsSK7+gV8DrOevx
	 ZsVNP3WZH0UpsryZPmyYJdj/YmY8XUJzxpPPSYT0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725934AbgHGEQH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 00:16:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:40918 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725379AbgHGEQG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 00:16:06 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 526CF2086A;
        Fri,  7 Aug 2020 04:16:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596773764;
        bh=ku0mtRLPmN6NVNq3U53FKsGpwTHeRKVHnmHxSE42guc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=S7+UxFypRpe8o0zzl2NftpnwsYRS9AdI6vRChUDLAvWxMutLfNSNBIt7cTvBwn+8h
         xysgk+VIjLuAMPR1J6wpNZimmNWIZucpAcbGs5nqWK8oHkug4npsj+enYYU/4zDgrU
         rGPkX+Z7EbO57uBaZquCYaFvcJOeVxnjSrPYLWes=
Date:   Thu, 6 Aug 2020 21:16:03 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Michal =?ISO-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
Cc:     Roman Gushchin <guro@fb.com>, Dennis Zhou <dennis@kernel.org>,
        Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>, linux-mm@kvack.org,
        kernel-team@fb.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/5] mm: memcg: charge memcg percpu memory to the
 parent cgroup
Message-Id: <20200806211603.195727c03995c3a25ffc6d76@linux-foundation.org>
In-Reply-To: <20200729171039.GA22229@blackbody.suse.cz>
References: <20200623184515.4132564-1-guro@fb.com>
        <20200623184515.4132564-5-guro@fb.com>
        <20200729171039.GA22229@blackbody.suse.cz>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Jul 2020 19:10:39 +0200 Michal Koutn=FD <mkoutny@suse.com> wrote:

> Hello.
>=20
> On Tue, Jun 23, 2020 at 11:45:14AM -0700, Roman Gushchin <guro@fb.com> wr=
ote:
> > Because the size of memory cgroup internal structures can dramatically
> > exceed the size of object or page which is pinning it in the memory, it=
's
> > not a good idea to simple ignore it.  It actually breaks the isolation
> > between cgroups.
> No doubt about accounting the memory if it's significant amount.
>=20
> > Let's account the consumed percpu memory to the parent cgroup.
> Why did you choose charging to the parent of the created cgroup?
>=20
> Should the charge go the cgroup _that is creating_ the new memcg?
>=20
> One reason is that there are the throttling mechanisms for memory limits
> and those are better exercised when the actor and its memory artefact
> are the same cgroup, aren't they?
>=20
> The second reason is based on the example Dlegation Containment
> (Documentation/admin-guide/cgroup-v2.rst)
>=20
> > For an example, let's assume cgroups C0 and C1 have been delegated to
> > user U0 who created C00, C01 under C0 and C10 under C1 as follows and
> > all processes under C0 and C1 belong to U0::
> >=20
> >   ~~~~~~~~~~~~~ - C0 - C00
> >   ~ cgroup    ~      \ C01
> >   ~ hierarchy ~
> >   ~~~~~~~~~~~~~ - C1 - C10
>=20
> Thanks to permissions a task running in C0 creating a cgroup in C1 would
> deplete C1's supply victimizing tasks inside C1.

These week-old issues appear to be significant.  Roman?  Or someone
else?
