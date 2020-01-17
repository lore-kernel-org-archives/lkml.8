Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C762C33CB1
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 17:12:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5849F2072B
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 17:12:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728900AbgAQRMd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jan 2020 12:12:33 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:50460 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726603AbgAQRMd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 12:12:33 -0500
Received: from ip5f5bd679.dynamic.kabel-deutschland.de ([95.91.214.121] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1isVAb-0007V1-EI; Fri, 17 Jan 2020 17:12:29 +0000
Date:   Fri, 17 Jan 2020 18:12:28 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Li Zefan <lizefan@huawei.com>,
        Peter Zijlstra <peterz@infradead.org>, cgroups@vger.kernel.org
Subject: Re: [PATCH v2 2/3] clone3: allow spawning processes into cgroups
Message-ID: <20200117171228.evtvrny3v7zjcocd@wittgenstein>
References: <20191223061504.28716-1-christian.brauner@ubuntu.com>
 <20191223061504.28716-3-christian.brauner@ubuntu.com>
 <20200107163204.GB2677547@devbig004.ftw2.facebook.com>
 <20200108180906.l4mvtdmh7nm2z7sc@wittgenstein>
 <20200116122944.nj3e66eusxu6sb44@wittgenstein>
 <20200117165311.GH2677547@devbig004.ftw2.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200117165311.GH2677547@devbig004.ftw2.facebook.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 17, 2020 at 08:53:11AM -0800, Tejun Heo wrote:
> Hello, Christian.
> 
> Sorry about late reply.
> 
> On Thu, Jan 16, 2020 at 01:29:44PM +0100, Christian Brauner wrote:
> > Could it be that you misread cgroup_attach_permissions()? Because it
> > does check for write permissions on the destination cgroup.procs file.
> > That's why I've added the cgroup_get_from_file() helper. :) See:
> > 
> > static int cgroup_attach_permissions(struct cgroup *src_cgrp,
> > 				     struct cgroup *dst_cgrp,
> > 				     struct super_block *sb, bool thread)
> > {
> > 	int ret = 0;
> > 
> > 	ret = cgroup_procs_write_permission(src_cgrp, dst_cgrp, sb);
> > 	if (ret)
> > 		return ret;
> 
> So, if you look at cgroup_procs_write_permission(), it's only checking
> the write perm of the common ancestor, not the destination because it
> assumes that the destination is already checked by the vfs layer, and
> we need to check both.

Ok, gimme 20 min.

Thanks!
Christian
