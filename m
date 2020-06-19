Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11C1EC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 12:49:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA058207E8
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 12:49:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DJzpqNQL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732513AbgFSMt4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 08:49:56 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:51916 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732278AbgFSMtq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 08:49:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592570984;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/g/+YnCzud6gIE/myiatywuh+bgiNOQQZfOvz+r2RZM=;
        b=DJzpqNQL3Ct78b71K3She8S6lrhS3usL8RrHve8/Fe6OvbZlg6mL0+tQcu46JUkXre2a7j
        wCJeM5i67zqeqXPsz5Xb5HA/z0ezPbvt16HNIJ2y+2qfvWOaQ++M8/Hn63ImspXHOc9tbP
        HV9MlLeH/yVCwJNU1bYE/DUE4N0GBAs=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-204-oZMYJzKHPZWIBTOOOU2agQ-1; Fri, 19 Jun 2020 08:49:42 -0400
X-MC-Unique: oZMYJzKHPZWIBTOOOU2agQ-1
Received: by mail-lf1-f71.google.com with SMTP id r10so3400791lfc.6
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jun 2020 05:49:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/g/+YnCzud6gIE/myiatywuh+bgiNOQQZfOvz+r2RZM=;
        b=T+KnlY9rBH5IDnIRMd2fUf3+h8g9njtB3ykPZjzOimaMleirDF66cPgV0RNoIDfw8c
         +ZqAy9paUyqU6+Ck6j+aFd2Be96iJlpHVyBFBR18H/cCc1jnddY0NZLBsYmG+YWS/JjV
         uoenfM0vL9i9CBqP3FI/zxC6mE978sJsznaz2zZv8NcAGRrj7ArfK3E1pYQRq91f53Ay
         1FCkmVNTk8zODabuzHKgwZ9pKtYps3wEhz9WrOmrK/7lWM/M+1pWKbMij58aafnP9trg
         10BSoHYzY/gs+AnUi9zFM6KMw9t2/wVlqz/1UN9CTTV/GV1kObrzolKF6wzE/BelJfE1
         BgCQ==
X-Gm-Message-State: AOAM530eQzQYUu1mNIgS3NYp+3WA/MduBF06eJQQCDQYQgCpRRphNyK2
        y9j41dD+rgw6EeLLam68g/Vl/CJv+l+FKs/0+NN57T6E1XocRFG+DoxWfYyQxoZDMl6ZDPpQqEP
        oXDlXBi0K4lf5u333mKs8JvwhN6Vdn9nCqo8zzlb0
X-Received: by 2002:ac2:5604:: with SMTP id v4mr1946248lfd.124.1592570981118;
        Fri, 19 Jun 2020 05:49:41 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwXiPt6NoxSwMoZyeQFCP8RfJAk3JTg7gTtWYjd2TAO4zxGdEHaGSVd0jZZyRVkg26M9VYhdLJvCgnHGSnzbYY=
X-Received: by 2002:ac2:5604:: with SMTP id v4mr1946227lfd.124.1592570980848;
 Fri, 19 Jun 2020 05:49:40 -0700 (PDT)
MIME-Version: 1.0
References: <20200520125616.193765-1-kpsingh@chromium.org>
In-Reply-To: <20200520125616.193765-1-kpsingh@chromium.org>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Fri, 19 Jun 2020 14:49:29 +0200
Message-ID: <CAFqZXNsu8Vs86SKpdnej_=xnQqg=Hh132JqNe1Ybt-bHJB4NeQ@mail.gmail.com>
Subject: Re: [PATCH bpf] security: Fix hook iteration for secid_to_secctx
To:     KP Singh <kpsingh@chromium.org>
Cc:     Linux kernel mailing list <linux-kernel@vger.kernel.org>,
        bpf@vger.kernel.org,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        James Morris <jmorris@namei.org>,
        Anders Roxell <anders.roxell@linaro.org>,
        Casey Schaufler <casey@schaufler-ca.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 20, 2020 at 2:56 PM KP Singh <kpsingh@chromium.org> wrote:
> From: KP Singh <kpsingh@google.com>
>
> secid_to_secctx is not stackable, and since the BPF LSM registers this
> hook by default, the call_int_hook logic is not suitable which
> "bails-on-fail" and casues issues when other LSMs register this hook and
> eventually breaks Audit.
>
> In order to fix this, directly iterate over the security hooks instead
> of using call_int_hook as suggested in:
>
> https: //lore.kernel.org/bpf/9d0eb6c6-803a-ff3a-5603-9ad6d9edfc00@schaufler-ca.com/#t
>
> Fixes: 98e828a0650f ("security: Refactor declaration of LSM hooks")
> Fixes: 625236ba3832 ("security: Fix the default value of secid_to_secctx hook"
> Reported-by: Alexei Starovoitov <ast@kernel.org>
> Signed-off-by: KP Singh <kpsingh@google.com>
[...]

Sorry for being late to the party, but doesn't this (and the
associated default return value patch) just paper over a bigger
problem? What if I have only the BPF LSM enabled and I attach a BPF
program to this hook that just returns 0? Doesn't that allow anything
privileged enough to do this to force the kernel to try and send
memory from uninitialized pointers to userspace and/or copy such
memory around and/or free uninitialized pointers?

Why on earth does the BPF LSM directly expose *all* of the hooks, even
those that are not being used for any security decisions (and are
"useful" in this context only for borking the kernel...)? Feel free to
prove me wrong, but this lazy approach of "let's just take all the
hooks as they are and stick BPF programs to them" doesn't seem like a
good choice... IMHO you should either limit the set of hooks that can
be attached to only those that aren't used to return back values via
pointers, or (if you really really need to do some state
updates/logging in those hooks) use wrapper functions that will call
the BPF progs via a simplified interface so that they cannot cause
unsafe behavior.

--
Ondrej Mosnacek
Software Engineer, Platform Security - SELinux kernel
Red Hat, Inc.

