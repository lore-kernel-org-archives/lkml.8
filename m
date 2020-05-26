Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E63D0C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 19:52:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C19EB207CB
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 19:52:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bnWhzRKV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728646AbgEZTwH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 15:52:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390418AbgEZTwC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 15:52:02 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D54EC03E96F
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 12:52:01 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id e125so13060585lfd.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 12:52:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=eBEPuPRe4Vv2CIYhMh2f1CuE2rLakV/r952j5euzgs8=;
        b=bnWhzRKVsaWXVi38IqofrgRQO1+O7g9G0wdnz61VvLTxmGpf0Fg8OK7MAptjxxMn3T
         kHaTgIILdbWOUvZ50Uyaodde5Gj5I8XzkPC6W7EQK+hxASYjt5Sh36CvVntc1Ox6e4AM
         6rDBHoaKOeBgjFYeUVH8aJzZGm+JLhmsB+9sI8gsqKrdVDncLLtGJ98HUrkDNkVhKNmf
         qwfCbSXVlKEzR3ziDVHFYZMhK/sFnYDl6XrECA+oMoNnDGkkgT7L0UZcyjdkgz3nnMMq
         gKTv9rkTMxjDqh+JFrLhdYXj6IWJwGLH4WZExZxsbyKo6fpi38b+eoChPqqLK+RQf2k+
         Bhiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=eBEPuPRe4Vv2CIYhMh2f1CuE2rLakV/r952j5euzgs8=;
        b=NpVLJGieVljEme7yzisjz6yEkSWnbmgJrHuxXOsgIxOKUriR0Ptv2SP7zf7NDbfDXl
         TMgW4f3lVRWYXlTrpl4DNztfuKfmbyBo0k9pWqFpSRDwBGQA20p4R3G+FM6NvK2bTF2m
         U/NAHhiK8nqnfRqU2Uu0hYaZpGhCUjUIgSyTM7Xphjt15txGsEkyDUmWNZUdl4IMZt6I
         6Q/7Bh22YHCRxCHgF1L0jpoBHSmswFoHTSSR0bGNZI/A5qh7Y6vzjvXIyFMyGKV/e2LK
         NsZ/TVVeR1wySHKMBe/rm+1iQupMrQD6bg9wTsKvoLBHr/0bRtu3lMdXYHNnsIYMfOiJ
         oF5w==
X-Gm-Message-State: AOAM533Tlw4xFFQDR0XuroW8UaX0jy3s9/Kdl0jQREhARhFcmIHWHlGY
        VBxBhyds3g5IUqk+lU059oQSVW5hUViZMw11f/ZAYg==
X-Google-Smtp-Source: ABdhPJzlR6LQriHCuEiGE/6Qirb1H9ZITawQCPoXz9As27TgLBKfSZTPQcDuOcWf7Fk6FiSnZhxZUdI8yRzAAC8OiFQ=
X-Received: by 2002:a05:6512:6ca:: with SMTP id u10mr1293382lff.184.1590522719828;
 Tue, 26 May 2020 12:51:59 -0700 (PDT)
MIME-Version: 1.0
References: <20200522055350.806609-1-areber@redhat.com> <dc86dffb-c7f8-15bb-db4e-be135da650cc@schaufler-ca.com>
 <20200525080541.GF104922@dcbz.redhat.com> <877dwybxvi.fsf@x220.int.ebiederm.org>
 <CALKUemw0UZ67yaDwAomHh0n8QZfjd52QvgEXTJ4R3JSrQjZX9g@mail.gmail.com>
In-Reply-To: <CALKUemw0UZ67yaDwAomHh0n8QZfjd52QvgEXTJ4R3JSrQjZX9g@mail.gmail.com>
From:   Jann Horn <jannh@google.com>
Date:   Tue, 26 May 2020 21:51:33 +0200
Message-ID: <CAG48ez3PFoy11H11so-xXSJf4HM6Ndkufxk40sLj8JFvO6+BPQ@mail.gmail.com>
Subject: Re: [PATCH] capabilities: Introduce CAP_RESTORE
To:     Christine Flood <chf@redhat.com>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Adrian Reber <areber@redhat.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Pavel Emelyanov <ovzxemul@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Andrei Vagin <avagin@gmail.com>,
        Nicolas Viennot <Nicolas.Viennot@twosigma.com>,
        =?UTF-8?B?TWljaGHFgiBDxYJhcGnFhHNraQ==?= <mclapinski@google.com>,
        Kamil Yurtsever <kyurtsever@google.com>,
        Dirk Petersen <dipeit@gmail.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Radostin Stoyanov <rstoyanov1@gmail.com>,
        Cyrill Gorcunov <gorcunov@openvz.org>,
        Serge Hallyn <serge@hallyn.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Sargun Dhillon <sargun@sargun.me>,
        Arnd Bergmann <arnd@arndb.de>,
        Aaron Goidel <acgoide@tycho.nsa.gov>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        SElinux list <selinux@vger.kernel.org>,
        Eric Paris <eparis@parisplace.org>,
        "Haley, Andrew" <aph@redhat.com>,
        "Bhole, Deepak" <dbhole@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 26, 2020 at 9:01 PM Christine Flood <chf@redhat.com> wrote:
> Java applications suffer from slow startup times due to dynamic class loa=
ding and warming up the Just In Time compilers.  Not all Java users have ro=
ot access on their machines.  Enabling CRIU in user mode solves this proble=
m for us.  We are about to release a user library that will allow check poi=
nting Java from within Java.  Having to run this as root would severely lim=
it its utility.

Have you looked into whether it would be practical to restore the
saved process state with different PIDs, and then fix up all places
that might have stored the old PIDs? As long as all threads are
managed by the JVM, that might be doable, right?

If you did that, you would also solve the problem of not being able to
start two copies of the same image (because their PIDs would collide)
or randomly not being able to start processes (because their PIDs
collide with other existing things).
