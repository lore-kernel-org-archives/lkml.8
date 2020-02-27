Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F13F5C35677
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 17:58:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C961D246F6
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 17:58:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="d7e7wn2s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730428AbgB0R6j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 12:58:39 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:36489 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730289AbgB0R6i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 12:58:38 -0500
Received: by mail-io1-f67.google.com with SMTP id d15so449005iog.3
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2020 09:58:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=B6rcGpYawUM9m0yQ03WTjODUvPD3hJBe9AVyTeKl4kE=;
        b=d7e7wn2sW4fGC0sWWBJzzxX6uQVEv7ov2BhIMQGfHey0s8ln3v55U/sJ80lR4nGtJU
         /K+xiyMbPRZyofaPHoPRKExmGn5dsXUOpeJ420oh/J9N+3qNMndlB9/h1onyVpoUCszg
         oGo1CDtBAFVpNjaCYPIWjMSCWzOgPHRkpDtPfjoSFhiFNxKt3K7/SpiZs7V5ZEMoeoI3
         0MPofhHFBLnyb9uNvUwHfbtamziwNA04RbYlVHKCToNDkV5kQFirkxaIe562qujMyBbi
         ie5ZCkdqdfK0fKuZJx62tSj0qgWXCY7Q7j3T92CdJrdPFtkAHhev2dV3QOYkkiPgzQC3
         bi0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=B6rcGpYawUM9m0yQ03WTjODUvPD3hJBe9AVyTeKl4kE=;
        b=p9mQO/lfp1gadTfpIoKHyk3KXIjH+My7dipfQxKy3v/haS5xdnhrBdqGHs881UGN7V
         yIQpl3Se9MRzccrjuYhrrsU8OYr+t8/vn8XCjvDxPk+EfgWEEiCvFvyf6KW/o7JRZ/P7
         4HXEfw+kGkHlegNQ5uPG9EnC0SkpSTdAgVTg7/h1e1K5Y0Ga9mmIstgFxrdH/p1XImOJ
         +EYAUfYtbae2EdkPxxPDDB14E6Qpq7xwt6TQkLjDgLr6qzddUT7gjRa7iT1JVCpuiDpv
         Ewu0S0wga7WxgKfrwSTzbAwiuJkWVqMFv+3iGwaJ4/KZxCCfUOIiWa+7xlaU4TFK9XHp
         pF8Q==
X-Gm-Message-State: APjAAAWI6cxiTnNz2+sQzm1QIQugCxcPKaSY9Bi2ENM+ZGhDC6YppXrl
        BoQ8kocvF9Rmd0rcHekwObkj044MMgnw8OBUOdRGlg==
X-Google-Smtp-Source: APXvYqyhzy6uk8Ophi2J6HBvyjfvSvIOFDQ7BS2sQE4GvT6DxIQKE46TgCUwsJZdOmdqvF0M2DO8Yp6Zew1drla42GY=
X-Received: by 2002:a6b:740c:: with SMTP id s12mr452251iog.108.1582826317684;
 Thu, 27 Feb 2020 09:58:37 -0800 (PST)
MIME-Version: 1.0
References: <20200227172306.21426-1-mgamal@redhat.com>
In-Reply-To: <20200227172306.21426-1-mgamal@redhat.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Thu, 27 Feb 2020 09:58:26 -0800
Message-ID: <CALMp9eRPxc6OuFZhrbyDJWhkrhtOeBWD5qSwkgg5RuVx8F_RqQ@mail.gmail.com>
Subject: Re: [PATCH 0/5] KVM: Support guest MAXPHYADDR < host MAXPHYADDR
To:     Mohammed Gamal <mgamal@redhat.com>
Cc:     kvm list <kvm@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Joerg Roedel <joro@8bytes.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 27, 2020 at 9:23 AM Mohammed Gamal <mgamal@redhat.com> wrote:
>
> When EPT/NPT is enabled, KVM does not really look at guest physical
> address size. Address bits above maximum physical memory size are reserved.
> Because KVM does not look at these guest physical addresses, it currently
> effectively supports guest physical address sizes equal to the host.
>
> This can be problem when having a mixed setup of machines with 5-level page
> tables and machines with 4-level page tables, as live migration can change
> MAXPHYADDR while the guest runs, which can theoretically introduce bugs.
>
> In this patch series we add checks on guest physical addresses in EPT
> violation/misconfig and NPF vmexits and if needed inject the proper
> page faults in the guest.
>
> A more subtle issue is when the host MAXPHYADDR is larger than that of the
> guest. Page faults caused by reserved bits on the guest won't cause an EPT
> violation/NPF and hence we also check guest MAXPHYADDR and add PFERR_RSVD_MASK
> error code to the page fault if needed.

What about the #GP that should be delivered if any reserved bits are
set in any of the 4 PDPTRs when the guest loads CR3 in PAE mode?
