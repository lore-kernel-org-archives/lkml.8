Return-Path: <SRS0=vnT4=3J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADA35C2D0DB
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 14:22:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F3AA20678
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 14:22:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DhyAIzlX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729021AbgATOWK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jan 2020 09:22:10 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:32208 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726942AbgATOWK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 09:22:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579530129;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PWUAb8tz3AF3amrWTTvwK6sWsIt1KM7KTKlRn37IBoI=;
        b=DhyAIzlXBQJX48Nrtt9eyRBpojky86u6rI3fU1wFLsYUxMb3F2Ig1pZVMsXNrQWJr7D+W7
        kFxNWl6qo89TvoYDrB0UIUNyjU5FZJ6DQpvYRKR7vtcmiU4IsDo2PmMs3IDqz/pO+X80JX
        DiwnbLZrHFlVC/SKz2rfQ083rS6+o2I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-204-Xfydzjv0MEyD7aQHqD5dgg-1; Mon, 20 Jan 2020 09:22:07 -0500
X-MC-Unique: Xfydzjv0MEyD7aQHqD5dgg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E312C800D5C;
        Mon, 20 Jan 2020 14:22:05 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.70])
        by smtp.corp.redhat.com (Postfix) with SMTP id E54B460C05;
        Mon, 20 Jan 2020 14:22:03 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Mon, 20 Jan 2020 15:22:05 +0100 (CET)
Date:   Mon, 20 Jan 2020 15:22:03 +0100
From:   Oleg Nesterov <oleg@redhat.com>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tejun Heo <tj@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Li Zefan <lizefan@huawei.com>, cgroups@vger.kernel.org
Subject: Re: [PATCH v4 3/6] cgroup: refactor fork helpers
Message-ID: <20200120142202.GC30403@redhat.com>
References: <20200117181219.14542-1-christian.brauner@ubuntu.com>
 <20200117181219.14542-4-christian.brauner@ubuntu.com>
 <20200120140029.GB30403@redhat.com>
 <20200120140452.qyjogmmhyqc3gxon@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200120140452.qyjogmmhyqc3gxon@wittgenstein>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/20, Christian Brauner wrote:
>
> On Mon, Jan 20, 2020 at 03:00:30PM +0100, Oleg Nesterov wrote:
> > This is probably the only patch in series I can understand ;)
> >
> > To me it looks like a good cleanup regardless, but
> >
> > On 01/17, Christian Brauner wrote:
> > >
> > > The patch just passes in the parent task_struct
> >
> > For what? "parent" is always "current", no?
>
> Yes. What exactly are you hinting at? :) Would you prefer that the
> commit message speaks of "current" instead of "parent"?

I meant, I don't understand why did you add the new "parent" arg,
cgroup_xxx_fork() can simply use "current" ?

Oleg.

