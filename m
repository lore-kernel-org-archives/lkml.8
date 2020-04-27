Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B86F9C4CECD
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 20:07:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 98080206D6
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 20:07:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pg9HzUQy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726860AbgD0UHD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 16:07:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725919AbgD0UHB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 16:07:01 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 064D3C0610D5
        for <linux-kernel@vger.kernel.org>; Mon, 27 Apr 2020 13:07:01 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id e26so270166wmk.5
        for <linux-kernel@vger.kernel.org>; Mon, 27 Apr 2020 13:07:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=cc:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=24jm4GLg7KcSdmvEBL/9cPElK0syYBQHKVx8N1+MAU4=;
        b=Pg9HzUQyg5RA0+hvrmI73UOkuF/9Cr5LUJQsCEnf1fjcsho050+qghoGdQOYhB8Trz
         8G9xIXaOWP/IaYw0rIxE2xoVVUux9NTBMR14HccUAjwX0fY4PmaErmVku6+d5ovrTodX
         bbyOJ08gnloJs/o8mCbjuq6fWM+QweeRxbCJ+kn6estXnSnR2hOJCB+w3GlM/pDsIHHJ
         58sUZqUXC1f59dKfjAyDmgdH5HGnMuaod+rS3f4FFDcq1Y/zoBocXt9EzQqlzx6SRmJy
         dbx/POmCHPnDiqH8tKfsR7TicGdUCpVEh1F3l9rA31Dlf2gn1XMm9WatXj9l8kK2NdxR
         rUQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:cc:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=24jm4GLg7KcSdmvEBL/9cPElK0syYBQHKVx8N1+MAU4=;
        b=cvxQyzO/viCgBCdZRQiz34iPj+8PdpYDMCHzrElfXvKPM4YAGWMEThJ4BlPK5KQ6Sa
         /RIEv700v6YU6RYpz/RWkXan7QbqzANYLuleyV4m/YqR04ven1Om3O+qmyGtT/JYgNVz
         6USbMSXyYz+xY7oee6rhfD2KjMiNCbZWNPx4A5zH4cHGdOJoDbsjoQ2JobicDSXVaF0U
         PheO70UqUx6+AI9RoFekY4WAkvvqPBaAdUWqD96B13XFFNRL7LkGK7REoRafSTD1Bdw6
         EweJZD/pp4azYA8NzeIhgFcbPk8/cDlILg+XR2cXvjoRq3EUSwjavSt6UHEHzaRP6iQu
         Znug==
X-Gm-Message-State: AGi0PuajbYIOvpkSJkX1s8nY0/e151d3/m6omNQVj/PDf2xgCmUVDolx
        aKPAmth08t0akH5pZu2Q3gU=
X-Google-Smtp-Source: APiQypJh7+yhT8PXtTKgbjFqecr5pL6hNJD3OfafOUzCRDq+pSpviCz70i2wV3o1y5Jh5hk5nu+ahQ==
X-Received: by 2002:a1c:3884:: with SMTP id f126mr395842wma.91.1588018019702;
        Mon, 27 Apr 2020 13:06:59 -0700 (PDT)
Received: from ?IPv6:2001:a61:2482:101:3351:6160:8173:cc31? ([2001:a61:2482:101:3351:6160:8173:cc31])
        by smtp.gmail.com with ESMTPSA id u30sm22553735wru.13.2020.04.27.13.06.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Apr 2020 13:06:59 -0700 (PDT)
Cc:     mtk.manpages@gmail.com, Alexander Viro <viro@zeniv.linux.org.uk>,
        =?UTF-8?Q?St=c3=a9phane_Graber?= <stgraber@ubuntu.com>,
        Linux Containers <containers@lists.linux-foundation.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Serge Hallyn <serge@hallyn.com>,
        Aleksa Sarai <cyphar@cyphar.com>
Subject: Re: [PATCH] nsproxy: attach to namespaces via pidfds
To:     Christian Brauner <christian.brauner@ubuntu.com>,
        linux-kernel@vger.kernel.org
References: <20200427143646.619227-1-christian.brauner@ubuntu.com>
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Message-ID: <f77ae6fe-a02c-1bd3-39d9-6cb829c3ccdd@gmail.com>
Date:   Mon, 27 Apr 2020 22:06:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200427143646.619227-1-christian.brauner@ubuntu.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Christian,

On 4/27/20 4:36 PM, Christian Brauner wrote:
> For quite a while we have been thinking about using pidfds to attach to
> namespaces. 

(Sounds promising.)

> This patchset has existed for about a year already but we've
> wanted to wait to see how the general api would be received and adopted.
> Now that more and more programs in userspace have started using pidfds
> for process management it's time to send this one out.
> 
> This patch makes it possible to use pidfds to attach to the namespaces
> of another process, i.e. they can be passed as the first argument to the
> setns() syscall. When only a single namespace type is specified the
> semantics are equivalent to passing an nsfd. That means
> setns(nsfd, CLONE_NEWNET) equals setns(pidfd, CLONE_NEWNET). However,
> when a pidfd is passed, multiple namespace flags can be specified in the
> second setns() argument and setns() will attach the caller to all the
> specified namespaces all at once or to none of them. 

While I think I understand what the intended semantics are, the
description in the previous paragraph feels off, so that if 
this whole text lands in a commit message (or a manual page),
I think it needs fixing.

Firs, it seems odd to say that 

   "setns(nsfd, CLONE_NEWNET) equals setns(pidfd, CLONE_NEWNET)"

setns(nsfd, CLONE_NEWNET) means: fail if nsfd does not refer to a
network namespace.

setns(pidfd, CLONE_NEWNET) means: move into just the network
namespace of the process referred to by 'pidfd'.

I would not call those two things "equal", in a semantic sense.

And then:

> If 0 is specified
> together with a pidfd then setns() will interpret it the same way 0 is
> interpreted together with a nsfd argument, i.e. attach to any/all
> namespaces.

If I understand right, setns(pidfd, 0) would mean: move into
all of the same namespaces as the process referred to by 'pidfd'.

But setns(nsfd, 0) means: move into whatever kind of namespace
is referred to by 'nsfd'.

I would not say of these two cases that 0 is interpreted
in the same way.

Hopefully I have not misunderstood.



> The obvious example where this is useful is a standard container
> manager interacting with a running container: pushing and pulling files
> or directories, injecting mounts, attaching/execing any kind of process,
> managing network devices all these operations require attaching to all
> or at least multiple namespaces at the same time. Given that nowadays
> most containers are spawned with all namespaces enabled we're currently
> looking at at least 14 syscalls, 7 to open the /proc/<pid>/ns/<ns>
> nsfds, another 7 to actually perform the namespace switch. With time
> namespaces we're looking at about 16 syscalls.
> (We could amortize the first 7 or 8 syscalls for opening the nsfds by
>  stashing them in each container's monitor process but that would mean
>  we need to send around those file descriptors through unix sockets
>  everytime we want to interact with the container or keep on-disk
>  state. Even in scenarios where a caller wants to join a particular
>  namespace in a particular order callers still profit from batching
>  other namespaces. That mostly applies to the user namespace but
>  all container runtimes I found join the user namespace first no matter
>  if it privileges or deprivileges the container.)
> With pidfds this becomes a single syscall no matter how many namespaces
> are supposed to be attached to.

That does seem like a win. Thanks for working on this!

Cheers,

Michael

-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
