Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A554AC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 06:08:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8361A207D8
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 06:08:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=sargun.me header.i=@sargun.me header.b="fWV/9lzt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726887AbgEZGI6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 02:08:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726207AbgEZGI5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 02:08:57 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10EA2C061A0E
        for <linux-kernel@vger.kernel.org>; Mon, 25 May 2020 23:08:57 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id bs4so16634843edb.6
        for <linux-kernel@vger.kernel.org>; Mon, 25 May 2020 23:08:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sargun.me; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=V5YTh51mOSkEuxU21BvSuS/w+t0LyTN4bdZGeF4brQo=;
        b=fWV/9lztW7nmFrKNP0PJ4RtoJAO6nrDX3GUlHhH4zIRcu804CcMll+BcR/TH+zTrIi
         VbimfFrLLAZRbnIDe4AovAH/2WLLd6lnUM9Mmhm0hZjDtq/EUCKd36hg6LZq+np9n/oj
         PIaajG/lFoLSUHfjAO5tASEwXekSEHmOnEB94=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=V5YTh51mOSkEuxU21BvSuS/w+t0LyTN4bdZGeF4brQo=;
        b=UwiDd00w4nwt1OtWOlwiRqmR8g+n2+bGEji4+I9fjkEr5isJ/jJoPdUOz59GNgWwNJ
         tVMVfWAZO70ZbFqLrHe4MZ1hQuzh87e/yZ7fEtxDuMBOiT0W/7b4T3mrfP8ywogzSFZZ
         nXkirvQ0qhIC1pQihKfKUJV3cac2bmmUzcVh86QOJ6fWV224BNZ/4TqwdMMsLJssCNEv
         gtYK9JL5vEo430pbJbtoP8ifikfch0mnr906Z2pId/zXPd75xikf93tlW2xd4YgdzUG+
         09smnPcs+ECdQGF3DzeMZEPKVd9Hs6Dv7RDXUDVpBAbAd0o2OVjA/hZoOgaTCuSyGarF
         VMtQ==
X-Gm-Message-State: AOAM532oxC2T6mJ8GCZySbcoT1Ab9NaGYQElW/0SQfix9JHnPzdk47Y0
        z5qKA1+q6eQD1mcTXgRcrbpaArM1eEmLIy/2FVqDLg==
X-Google-Smtp-Source: ABdhPJzib02G90pJOtMeOUHnKCP2wPTxzVpDsQuhN4DT9I2bM+InsgjG5fVPNFXE6LDET7T6rqwFER52/c6lbAlIXeA=
X-Received: by 2002:a05:6402:b38:: with SMTP id bo24mr18800566edb.24.1590473335434;
 Mon, 25 May 2020 23:08:55 -0700 (PDT)
MIME-Version: 1.0
References: <20200524233942.8702-1-sargun@sargun.me> <20200524233942.8702-5-sargun@sargun.me>
 <20200525142043.jkdsfabntqusizxz@wittgenstein>
In-Reply-To: <20200525142043.jkdsfabntqusizxz@wittgenstein>
From:   Sargun Dhillon <sargun@sargun.me>
Date:   Mon, 25 May 2020 23:08:19 -0700
Message-ID: <CAMp4zn_JFEVQd3PpOod=R11fSFOQYVWpS3bVQensOQyhc=BQag@mail.gmail.com>
Subject: Re: [PATCH 4/5] seccomp: Add SECCOMP_ADDFD_FLAG_MOVE flag to add fd ioctl
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Containers <containers@lists.linux-foundation.org>,
        Linux API <linux-api@vger.kernel.org>,
        Tycho Andersen <tycho@tycho.ws>,
        Kees Cook <keescook@chromium.org>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Jeffrey Vander Stoep <jeffv@google.com>,
        Jann Horn <jannh@google.com>, Robert Sesek <rsesek@google.com>,
        Chris Palmer <palmer@google.com>,
        Matt Denton <mpdenton@google.com>,
        Kees Cook <keescook@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > + * they are created in. Specifcally, sockets, and their interactions with the
> > + * net_cls and net_prio cgroup v1 controllers. This "moves" the file descriptor
> > + * so that it takes on the cgroup controller's configuration in the process
> > + * that the file descriptor is being added to.
> > + */
> > +#define SECCOMP_ADDFD_FLAG_MOVE              (1UL << 1)
>
> I'm not happy about the name because "moving" has much more to do with
> transferring ownership than what we are doing here. After a "move" the
> fd shouldn't be valid anymore. But that might just be my thinking.
>
> But why make this opt-in and not do it exactly like when you send around
> fds and make this mandatory?

Based upon Tycho's comments in an offline thread, I'm going to make
this the default
(setting the cgroup metadata) to mirror what SCM_RIGHTS does, and then
if we come
up with a good use case where we need to preserve *cgroup v1*
metadata, then we can
add an opt-out flag in the future.
