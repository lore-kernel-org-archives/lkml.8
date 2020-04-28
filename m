Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2517C83007
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 20:08:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AE66820B80
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 20:08:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KjUGDWC9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726470AbgD1UHe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 16:07:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726410AbgD1UH2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 16:07:28 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26316C03C1AB
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 13:07:28 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id r17so17969836lff.2
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 13:07:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=M1YtACLEe9IuTvLnjysZBZz/m54iNfZsObywrWlf7oE=;
        b=KjUGDWC9klYlMPXx4Q6IAmywWSeQcbXkwwzOYikFtW+g+kq2qFglZTMOdtK+hTolHm
         +95eYRT4IQPC9wQ25xEQ/SCOUpJdsiTcw+861799DwWHDH8vvPUt5+I8zdP/ZwSSeH/5
         0XK2fGAcqUzAOkqu5KGDML5Img3Muwp0A++uH/Ag53yiJmrlnrdZXJ6hy+swQVY/hK5b
         lX5Z2b32uNS/Kl8jNnNsH0ruVgDtGu05DBwQSZP/ZRdkBy79mMNYWR9dcS7CIocvNPLE
         70LzUAEHuv/zYF4Ta6uOT4gMGcsGp+FSRfsflhMFCSq0p3nPi0xpZkkNMdM23coeEnCB
         OXjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=M1YtACLEe9IuTvLnjysZBZz/m54iNfZsObywrWlf7oE=;
        b=jK1VedAeWy4huQ0+D21U1GiyxBf0IU0qc0xlY9VJan+Se3nsu46BAqzUoldsywlp1h
         1AKJ1yz3PFjnEMGveRG/6o9GtXE0OP0NhBOL39Cc0Gm2dcctmXSz2AI0fFY3jgzKb0fr
         FkI1OaT0Jt8tAkJqKzMqdsfbgz2SEZ8O6P6y03sKthZykCCbwewJ8QsvpHWkfLkUMaBo
         5XhpZmKf7sPfkzVR/myTVA4OJM7hIzMhEqzu51VAhzzwJQg0xXf0pqu6t1pV/+uucUGM
         YV7igf2RZ1Mhk7xKeGhjww3WbL1YMpV+XNmum4Xd/0oqPcp8v3Zk5PBYm2qIE64YH+sA
         +U3A==
X-Gm-Message-State: AGi0PuY+ZeIn48odzAIkGVnLZa7f5Pbkk8ax6yYM6lNfAHU+kdGMMkqA
        6OgTZ+439wW3zWHVuPmYGMITOF4c5n7EDEnn07bDmQ==
X-Google-Smtp-Source: APiQypI3iiSpP+vuFbfcMhuWh/HEF2kch9czpa3KxmqEEmwzMCc2dSPgMvj85MvOgPehFcfih9BZiBMwVu+AeS8e8lc=
X-Received: by 2002:ac2:4832:: with SMTP id 18mr20437133lft.162.1588104446347;
 Tue, 28 Apr 2020 13:07:26 -0700 (PDT)
MIME-Version: 1.0
References: <20200423022550.15113-1-sean.j.christopherson@intel.com>
 <20200423022550.15113-2-sean.j.christopherson@intel.com> <CALMp9eRD9py=N9hDSon5GPzuiZw1Z+3xHv9umu1_qKzWczz0PA@mail.gmail.com>
In-Reply-To: <CALMp9eRD9py=N9hDSon5GPzuiZw1Z+3xHv9umu1_qKzWczz0PA@mail.gmail.com>
From:   Oliver Upton <oupton@google.com>
Date:   Tue, 28 Apr 2020 13:07:15 -0700
Message-ID: <CAOQ_Qsi62EL3WZWEnKVNT=9YFsZ3Gmsu3V-JeehGmxbvotiShg@mail.gmail.com>
Subject: Re: [PATCH 01/13] KVM: nVMX: Preserve exception priority irrespective
 of exiting behavior
To:     Jim Mattson <jmattson@google.com>
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Joerg Roedel <joro@8bytes.org>, kvm list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Shier <pshier@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 28, 2020 at 11:54 AM Jim Mattson <jmattson@google.com> wrote:
>
> On Wed, Apr 22, 2020 at 7:26 PM Sean Christopherson
> <sean.j.christopherson@intel.com> wrote:
> >
> > Short circuit vmx_check_nested_events() if an exception is pending and
> > needs to be injected into L2, priority between coincident events is not
> > dependent on exiting behavior.  This fixes a bug where a single-step #DB
> > that is not intercepted by L1 is incorrectly dropped due to servicing a
> > VMX Preemption Timer VM-Exit.
> >
> > Injected exceptions also need to be blocked if nested VM-Enter is
> > pending or an exception was already injected, otherwise injecting the
> > exception could overwrite an existing event injection from L1.
> > Technically, this scenario should be impossible, i.e. KVM shouldn't
> > inject its own exception during nested VM-Enter.  This will be addressed
> > in a future patch.
> >
> > Note, event priority between SMI, NMI and INTR is incorrect for L2, e.g.
> > SMI should take priority over VM-Exit on NMI/INTR, and NMI that is
> > injected into L2 should take priority over VM-Exit INTR.  This will also
> > be addressed in a future patch.
> >
> > Fixes: b6b8a1451fc4 ("KVM: nVMX: Rework interception of IRQs and NMIs")
> > Reported-by: Jim Mattson <jmattson@google.com>
> > Cc: Oliver Upton <oupton@google.com>
> > Cc: Peter Shier <pshier@google.com>
> > Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
> Reviewed-by: Jim Mattson <jmattson@google.com>
Reviewed-by: Oliver Upton <oupton@google.com>
