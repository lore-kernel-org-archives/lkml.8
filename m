Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 022AAC41621
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 18:42:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D09BE2076E
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 18:42:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NI5YdHzm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727715AbgCXSmh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 14:42:37 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:36022 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727365AbgCXSmg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 14:42:36 -0400
Received: by mail-wm1-f65.google.com with SMTP id g62so4764501wme.1
        for <linux-kernel@vger.kernel.org>; Tue, 24 Mar 2020 11:42:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pPtwMbJxrA1Es8ak0yumoRvEWX0T2QU5/hT413522OM=;
        b=NI5YdHzmFt8MJznP4pojeq6KTnqd6bmIu2KrxmmLL1Xe2tr97ui/97+nEp55ClKB3A
         873nWHtQXnaK/FX5EzwDrasARNrqwER0pd3f7CRkAouFGcpVFQkMlYif+tTNPzSaz3us
         uS3/+WbLU5Q3bdhR8HkD65f/pkj8xXKg8MaFF5hnUjVgH7VH/j/XV2iBinR/ummxg4sZ
         dtIGVSnPgJCL0JvVKo3PD1Fh1+wrNDfPW00mF9RjB3twX9vbQd3Dhhoxn0NbtIJN1Yr3
         lPpOrd4Nskw3MoXDsIS+nUC8rfZQv2RFfR3ajZ46SDPVl/aJNryZLDoSrG6xfQZKJk18
         Ss4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pPtwMbJxrA1Es8ak0yumoRvEWX0T2QU5/hT413522OM=;
        b=NmhJEajx8KD3bxbpjgRI0+5LrtVeonKJYR4QxkHH2Oqb/dBiqSmUADEklF1sSI40MV
         4nVXLxkmUZhZTQl3ljOfvuUe2oQTPst8OZ3fnOQyH8V3agnJgaV6sqFCQxS5R/NybHA3
         ylN8ivPHpfTWcr2CjjOgLdrdxufS1bruN95h58cWYdZXIBxoT8IEycsCSVc0G+TGlVtu
         a8ArJ2Iv2efs+J7MiVBQcNTALfg6O2gm3Ur/zW5x2c/onseuRPI8Pp9akhQKccCbQqPz
         UnesmpUFl7P9UcoiHrHlrXtXLBKiTSmXUd2tA2pecVsSwCHADXQYhZs2uV+jSxCQqM/p
         D/Xw==
X-Gm-Message-State: ANhLgQ0stq9dNkhiPr9HN6QymWQeQ6qagT2WH8dv2Yd2g3gyvTHlP8eC
        rqiKrlwa3mHbaKps0tgCV0FMfV+gnZfm+bzRHrEO4w==
X-Google-Smtp-Source: ADFU+vs4sQRYA41bjiNHunaQN2sONVEfP7brWVrPfFBwzK5q8MTUlZRXbUkGnnDCfaae5S4dUZwF76luoNfQxU9kSTE=
X-Received: by 2002:a1c:bcd4:: with SMTP id m203mr7106648wmf.35.1585075353851;
 Tue, 24 Mar 2020 11:42:33 -0700 (PDT)
MIME-Version: 1.0
References: <20200324094154.32352-1-joro@8bytes.org> <20200324183007.GA7798@linux.intel.com>
In-Reply-To: <20200324183007.GA7798@linux.intel.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Tue, 24 Mar 2020 11:42:21 -0700
Message-ID: <CALMp9eRYNH+=Ra=1KSJdT5Ej5kTfdV8J7Rf6JcS9NGbPOYPj8A@mail.gmail.com>
Subject: Re: [PATCH 0/4] KVM: SVM: Move and split up svm.c
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Joerg Roedel <joro@8bytes.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Ashish Kalra <Ashish.Kalra@amd.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        kvm list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 24, 2020 at 11:30 AM Sean Christopherson
<sean.j.christopherson@intel.com> wrote:
>
> On Tue, Mar 24, 2020 at 10:41:50AM +0100, Joerg Roedel wrote:
> > Hi,
> >
> > here is a patch-set agains kvm/queue which moves svm.c into its own
> > subdirectory arch/x86/kvm/svm/ and splits moves parts of it into
> > separate source files:
>
> What are people's thoughts on using "arch/x86/kvm/{amd,intel}" instead of
> "arch/x86/kvm/{svm,vmx}"?  Maybe this won't be an issue for AMD/SVM, but on
> the Intel/VMX side, there is stuff in the pipeline that makes using "vmx"
> for the sub-directory quite awkward.  I wasn't planning on proposing the
> rename (from vmx->intel) until I could justify _why_, but perhaps it makes
> sense to bundle all the pain of a reorganizing code into a single kernel
> version?

Doesn't VIA have some CPUs that implement VMX?
