Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2FE4C2BA19
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 09:45:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B39C520776
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 09:45:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UNwRCuC7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726939AbgDWJpK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 05:45:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726343AbgDWJpK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 05:45:10 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F8ABC03C1AF;
        Thu, 23 Apr 2020 02:45:10 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id e26so5001817otr.2;
        Thu, 23 Apr 2020 02:45:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=n6ZqebWlg204l/WYlcxSJMS+2DS6scyfdiu+AZLw5jQ=;
        b=UNwRCuC7UVwmFvehs/bjmUtY6RKoA6Z9LE4DFeTTFborUYqlZqOp97DzZu09ZhtcRx
         wJo0fmw1xJH8xyBN6GeJv/P0HvMX50qUSBYIw4x9VP13ToL69EyNWiCJ4n5pCCLHlbPh
         koBaWNFSpjPddtzXrsy1tQ20Xls3kEQnRYhUgtsTy3h5HDZMF3Ebq1k8RLSXoGPhFyqb
         4nKq2mMcQqZMWP387L93ddqJwTnNBoiIyIVgC+UR+fHoH2sxPEVTEnM28I07J64R2h2/
         hhi7u0wPZBnRFcBYbtMMq+VD89W+wEAdCH1IUjGk+uYrdUPVgIKhfPlobqT5VzKxN2oy
         jF7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=n6ZqebWlg204l/WYlcxSJMS+2DS6scyfdiu+AZLw5jQ=;
        b=UNHwrvEvl1bfcoDJIHGTMlMrjhmpDxMkSMBQqS+TfFzY/vuOXpIbpJazKl3so8bM0n
         ou4lsNUOwqcMRfxNYZocxjEMwHRFB7JOd4RXSulqpVp+qk+cSszDrSgcwPqIj+8RxrEc
         IByMeXcJ2EoLAZh80MUp970Op3K+eHRSrvoyV6IZVt/6+xodMth49MzhRQLRVRt5VQMM
         nnZYyhgwwiQdLLEzMqBzSeS+eYe1oUczAkxWKhpi9KldAmcNnpmRnmKBD7FJ0fSHPnaq
         yXcduTinLK3YoidE8vkuGBHO7kZDwY/Cn+gyOmz2uSvRPWQXQPiZbOmD6V9dEN6CICRI
         rqPA==
X-Gm-Message-State: AGi0PuYPVunb+hRpUT8jUAQLs9W9jCehRZvsOsWNl8xMNNVS5AKiE4//
        OMrBPuN/xn0b19OUDZoUklqIF7t/+rBVY7zpP+BuwzYy
X-Google-Smtp-Source: APiQypKJniww7CaQVDAQOV36GE447YPzgsjP4zY2TylCeykgsfNXhfFGYf5RTg39rnXtlL30Zmjr+t2bgoyRLJgxG8E=
X-Received: by 2002:a9d:7f04:: with SMTP id j4mr2815237otq.185.1587635108563;
 Thu, 23 Apr 2020 02:45:08 -0700 (PDT)
MIME-Version: 1.0
References: <1587632507-18997-1-git-send-email-wanpengli@tencent.com>
 <1587632507-18997-2-git-send-email-wanpengli@tencent.com> <09cba36c-61d8-e660-295d-af54ceb36036@redhat.com>
 <CANRm+Cybksev1jJK7Fuog43G9zBCqmtLTYGvqAdCwpw3f6z0yA@mail.gmail.com> <8a29181c-c6bb-fe36-51ac-49d764819393@redhat.com>
In-Reply-To: <8a29181c-c6bb-fe36-51ac-49d764819393@redhat.com>
From:   Wanpeng Li <kernellwp@gmail.com>
Date:   Thu, 23 Apr 2020 17:44:58 +0800
Message-ID: <CANRm+CzFgbuYY6t8E0OihXMzRV8ePjnoZPUPXxGcexbL8gKfEA@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] KVM: LAPIC: Introduce interrupt delivery fastpath
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, kvm <kvm@vger.kernel.org>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Haiwei Li <lihaiwei@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Apr 2020 at 17:41, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> On 23/04/20 11:35, Wanpeng Li wrote:
> >> Ok, got it now.  The problem is that deliver_posted_interrupt goes through
> >>
> >>         if (!kvm_vcpu_trigger_posted_interrupt(vcpu, false))
> >>                 kvm_vcpu_kick(vcpu);
> >>
> >> Would it help to make the above
> >>
> >>         if (vcpu != kvm_get_running_vcpu() &&
> >>             !kvm_vcpu_trigger_posted_interrupt(vcpu, false))
> >>                 kvm_vcpu_kick(vcpu);
> >>
> >> ?  If that is enough for the APICv case, it's good enough.
> > We will not exit from vmx_vcpu_run to vcpu_enter_guest, so it will not
> > help, right?
>
> Oh indeed---the call to sync_pir_to_irr is in vcpu_enter_guest.  You can
> add it to patch 3 right before "goto cont_run", since AMD does not need it.

Just move kvm_x86_ops.sync_pir_to_irr(vcpu)? How about the set pir/on
part for APICv and non-APICv part in fast_deliver_interrupt()?

    Wanpeng
