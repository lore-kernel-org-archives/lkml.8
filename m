Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A923DC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 21:23:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A37C2068F
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 21:23:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="q4oE1uym"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727055AbgG2VXt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 17:23:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726476AbgG2VXs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 17:23:48 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EAE0C0619D2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jul 2020 14:23:48 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id c16so8914710ils.8
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jul 2020 14:23:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=1yAh0Nb8RBXx/Dg8quoaFiNeVsKdfNd0tJqGuua5O5Q=;
        b=q4oE1uymGAyjZSxT2oNr7c/h/meq3PX77eRHDZz46aFCENlLQB49giKAGSwFCD7BDd
         HJExMuO9RqoIZ6SqNyIHc0zZwWGTNNixjxOZSikbXEp3Yd/pa6hEabFkY5Lcq5hSvS03
         /L4bYgNsyU+5j5X59xHMTUiYx1/Anx1IzzIAsbtxs4lRaT/ZgAqEsF+qDLo+n1N7pUYb
         Ur6hXaXRcwnbJLwxEShvY771sNpRvaalZ9yPWHXYBxKcE+FFvtIEm8KYbUsQpTYhEyfY
         wAbDUsz8NUFJkxgzafPoVQ7pMSmfbx2ZFAlf1I7bAIVWQzv8j06N7j2Z3zeHadGvDs8H
         VLoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=1yAh0Nb8RBXx/Dg8quoaFiNeVsKdfNd0tJqGuua5O5Q=;
        b=PRnBXYmaTFiEWNZWrN4JLCDVQZdQFDOdWlHe8pB9C0NW1TaF3sBLqJ/TutlGM3fbz8
         avX28NzEwdFYDeRleNJ9vIRfNQUnvRGdrp3saFvUAhcab1mZPje5uFIZ4ON8Ap6vWofI
         QuRWhwF8VfQ8p30gWUwS9gz1uON+Yw3HpiCNk43/lX1gXr1+9tzBk8ggT7N1+Ll+8r56
         3M5gfCxfapNlBuFvf3Z3Xkh6CJ2Lbpavw+T2noLkoRbHb9+jWXUBiaa6JKq4E3qi8t9r
         FOKPHoEFBelSosKmZtTjVtSh6s+hedpLeCLwoKyzaBQQK1gMDLFJIlsqIgmECz/pNSFL
         nAPg==
X-Gm-Message-State: AOAM5320j8otbEyVb8n8gVvweZRh9bfGyvprmYWPBWrR3aXUG4vP/Oj1
        h7lx97RTYJiayrxSzFZBRvr0MWGv5QkJuwCuzwrAqA==
X-Google-Smtp-Source: ABdhPJzZwSom2NJHrADvd8thg40ia/i5aSoq1/32F72dab/LwaryY8svwIOWPJkOdFVDdXogcBYPlTnd9iOJZKPgqFI=
X-Received: by 2002:a92:790d:: with SMTP id u13mr30534775ilc.26.1596057827729;
 Wed, 29 Jul 2020 14:23:47 -0700 (PDT)
MIME-Version: 1.0
References: <159597929496.12744.14654593948763926416.stgit@bmoger-ubuntu> <159597950612.12744.7213388116029286561.stgit@bmoger-ubuntu>
In-Reply-To: <159597950612.12744.7213388116029286561.stgit@bmoger-ubuntu>
From:   Jim Mattson <jmattson@google.com>
Date:   Wed, 29 Jul 2020 14:23:35 -0700
Message-ID: <CALMp9eQUNLXgveya3TpyCH7L8EbEUEdPy+_ee_wSXwxqsKPDwQ@mail.gmail.com>
Subject: Re: [PATCH v3 06/11] KVM: SVM: Add new intercept vector in vmcb_control_area
To:     Babu Moger <babu.moger@amd.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        kvm list <kvm@vger.kernel.org>, Joerg Roedel <joro@8bytes.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 28, 2020 at 4:38 PM Babu Moger <babu.moger@amd.com> wrote:
>
> The new intercept bits have been added in vmcb control area to support
> few more interceptions. Here are the some of them.
>  - INTERCEPT_INVLPGB,
>  - INTERCEPT_INVLPGB_ILLEGAL,
>  - INTERCEPT_INVPCID,
>  - INTERCEPT_MCOMMIT,
>  - INTERCEPT_TLBSYNC,
>
> Add new intercept vector in vmcb_control_area to support these instructio=
ns.
> Also update kvm_nested_vmrun trace function to support the new addition.
>
> AMD documentation for these instructions is available at "AMD64
> Architecture Programmer=E2=80=99s Manual Volume 2: System Programming, Pu=
b. 24593
> Rev. 3.34(or later)"
>
> The documentation can be obtained at the links below:
> Link: https://www.amd.com/system/files/TechDocs/24593.pdf
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D206537
>
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---

> @@ -16,6 +16,7 @@ enum vector_offset {
>         EXCEPTION_VECTOR,
>         INTERCEPT_VECTOR_3,
>         INTERCEPT_VECTOR_4,
> +       INTERCEPT_VECTOR_5,
>         MAX_VECTORS,
>  };

Is this enumeration actually adding any value?
vmcb->control.intercepts[INTERCEPT_VECTOR_5] doesn't seem in any way
"better" than just vmcb->control.intercepts[5].

Reviewed-by: Jim Mattson <jmattson@google.com>
