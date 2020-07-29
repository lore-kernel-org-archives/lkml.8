Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5865CC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 18:27:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 33C342075F
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 18:27:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pEqPizQO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727001AbgG2S1a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 14:27:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726535AbgG2S13 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 14:27:29 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 607EDC0619D2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jul 2020 11:27:29 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id q75so17419513iod.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jul 2020 11:27:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9e3mG+v7myF4LEXwRfh3GRKcoZXstqdGx+UgF30PeTk=;
        b=pEqPizQOCPoXxgVFJAMQlVBXQR/mU9S7abwBOtX/TTUmKj6GIAh7zjxsCGZoI78c2B
         abztUw38VUU6dlMbXR/H13fUIzfOnofDdyzyIPbE09ScBOtSGgCRaaSTmMYsyIag5kBn
         djcCRSiL/S2nPi8rIEESm9gRFwWH8vgdlA4TtQEIjeFYph5WbfvKkOJG/WiyZ8J4KKfp
         O+rLE+BIGCT0TcyohT+d7pfpMJJeYAbhXgpuJdO/eJDoaVcX8JrFmXxIdAp6q77ZYYyK
         ODM9GXhnmubLbbydE5pQyFlqsimvbLTI0o0ulRFsGtrTfEeItGHfI6mUaZDMs5RYn/1d
         DfXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9e3mG+v7myF4LEXwRfh3GRKcoZXstqdGx+UgF30PeTk=;
        b=blzKwovVNpnqnX/zUGE9MBvmHHLzlXrpTUm/Bdvmc/zROLKxvUWTwgmZQ9tAC6lf7A
         p20IVIVyoN6HsgIoiwT3JbCM/OJdc79cIyJTc3HAYpyj1pPbM5PslJ1ZtS/AL40SF+yi
         dRJ0YUqyd20XJuvwWrPZe2Fw8iCT3NYKRA4nS8xdi7klnfUMAdX3rhpnlcKjFDovLW3y
         31PEf0MFK7OYbXrN/fLagTuLWnR3kJB6tisNfY1Guz48K0K1z+fCM+CyEADU/2ye94Kg
         6eKeB3zvoQ21DQDqj+x9VoW8FZM3NIdchWDvaHchOuUQlyNTExOlQ6EvgEERsp6A1gXD
         Yudg==
X-Gm-Message-State: AOAM532gEqHUNdq/qBxKJgrjnE17b0Wf5lxO+5LCwNqTBm9aoLb8wZT3
        llYRfMqaq2bHfN2ozDBoWzLyGw4PjrhuKFDmmzRKpQ==
X-Google-Smtp-Source: ABdhPJy8Rk93wQKYTA78KmP19sPmrYvz6fCMGk9nxajFL0I+dSD9ntQRJ6q7G1dSmLx0JPVcxZef+wUD8X+WAEE22bE=
X-Received: by 2002:a6b:b4d1:: with SMTP id d200mr33069247iof.70.1596047248155;
 Wed, 29 Jul 2020 11:27:28 -0700 (PDT)
MIME-Version: 1.0
References: <20200728004446.932-1-graf@amazon.com> <87d04gm4ws.fsf@vitty.brq.redhat.com>
 <a1f30fc8-09f5-fe2f-39e2-136b881ed15a@amazon.com> <CALMp9eQ3OxhQZYiHPiebX=KyvjWQgxQEO-owjSoxgPKsOMRvjw@mail.gmail.com>
 <14035057-ea80-603b-0466-bb50767f9f7e@amazon.com>
In-Reply-To: <14035057-ea80-603b-0466-bb50767f9f7e@amazon.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Wed, 29 Jul 2020 11:27:16 -0700
Message-ID: <CALMp9eSxWDPcu2=K4NHbx_ZcYjA_jmnoD7gXbUp=cnEbiU0jLA@mail.gmail.com>
Subject: Re: [PATCH] KVM: x86: Deflect unknown MSR accesses to user space
To:     Alexander Graf <graf@amazon.com>
Cc:     Aaron Lewis <aaronlewis@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Joerg Roedel <joro@8bytes.org>, kvm list <kvm@vger.kernel.org>,
        linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 29, 2020 at 2:06 AM Alexander Graf <graf@amazon.com> wrote:
>
>
>
> On 28.07.20 19:13, Jim Mattson wrote:

> > This sounds similar to Peter Hornyack's RFC from 5 years ago:
> > https://www.mail-archive.com/kvm@vger.kernel.org/msg124448.html.
>
> Yeah, looks very similar. Do you know the history why it never got
> merged? I couldn't spot a non-RFC version of this on the ML.

I believe Peter got frustrated with all of the pushback he was
getting, and he moved on to other things. While Google still uses that
code, Aaron's new approach should give us equivalent functionality
without having to comment out the MSRs that kvm previously didn't know
about, and which we still want redirected to userspace.

> > It seems unlikely that userspace is going to know what to do with a
> > large number of MSRs. I suspect that a small enumerated list will
> > suffice. In fact, +Aaron Lewis is working on upstreaming a local
> > Google patch set that does just that.
>
> I tend to disagree on that sentiment. One of the motivations behind this
> patch is to populate invalid MSR accesses into user space, to move logic
> like "ignore_msrs"[1] into user space. This is not very useful for the
> cloud use case, but it does come in handy when you want to have VMs that
> can handle unimplemented MSRs in parallel to ones that do not.
>
> So whatever we implement, I would ideally want a mechanism at the end of
> the day that allows me to "trap the rest" into user space.

I do think "the rest" should be explicitly specified, so that
userspace doesn't get surprises when kvm evolves. Maybe this can be
done using the allow-list you refer to later, along with a specified
action for disallowed MSRs: (1) raise #GP, (2) ignore, or (3) exit to
userspace. This actually seems orthogonal to what Aaron is working on,
which is to request that specific MSR accesses exit to userspace. But,
at least the plumbing for {RD,WR}MSR completion when coming back from
userspace can be leveraged by both.
