Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CD37C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 23:50:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2ECD32074F
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 23:50:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CLdorriL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730265AbgG1XuT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 19:50:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729380AbgG1XuS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 19:50:18 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44B71C061794
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 16:50:18 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id l1so22643430ioh.5
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 16:50:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jRxdAdAcHQnSvpTiqQgDtVDOtHSnq2LhAba7kclXwmw=;
        b=CLdorriLRZlh+3BoQMXxMwaWcWPavdGBwY5QQyfKxAA8388SW7TpF+RcKYp3UH8z8j
         TFA9xrNz6x9GOIfm3+uDe9vLt/3yxdKN3o4f1XkLdRbzEhiT8fY4MivoXSPjS+mKj+XX
         T2YaqUyn3rKQK4mlv4WSeVv/8yza4afEF6UVC7pecWB2puz14dxFfwZ2bUMVihlG568D
         xbKVLrWawCnrsJYAc3FmTbnDCXw3B70TpEC5zyhb+wwhg7U1Fvzwg4r/sJDyeQ7eUhLX
         zx3KtBrYWKgqPYYuf8ZegpOQ6TQIhvIS3pZ1cUUMHL0RCXO1aMP3bFbSnowYHsBuGFoD
         uZqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jRxdAdAcHQnSvpTiqQgDtVDOtHSnq2LhAba7kclXwmw=;
        b=EsaQbEiT+L03J10SCrGvgFv4MRtt4mlaU/BVjJ5sYfgxAGmDrt07lH4lUBdRDyiQfg
         y0fbgex+HEAAKWRIbik64CHTa2n9Hs3DaEVTOUCUq1n+Sv+Zx/5hOrO7q2TN4i3BYe2h
         Gbp82+fyjh7GVb/Q15VcmF2l9GIvE8P4bI90AWYJGZRPicTqlCzfHfFZW8lT55VNBAKC
         aPCsKjbgNQVyoojm6FNZFP1D6qCKTsbiPgVencMLY8WbEinfEDGRg8fYTSoz5wSSiWyK
         X7HkL7eIcn/vdDBiL7Lz6CyopZtyyhm6iizmzrv1a9qQhGaGgbia8ZiGiEgv16OhvwMp
         pSUQ==
X-Gm-Message-State: AOAM532KUnquWW1MjlPm8Zo/2rNMSFNo6PJL0s1RUF6SxY8WKHDX/i6k
        azsuh4370nHz905F5UMYOyDR9JSrVZgsc/SDxuU7NQ==
X-Google-Smtp-Source: ABdhPJytUIlbwggkeNor/HyEXSDWZhleuTFIsDfEol1n9HinAhHXVVF5rBK6e8v65tTRGFaJzdhp3zBOh9A+2sb847c=
X-Received: by 2002:a6b:c3cf:: with SMTP id t198mr30778184iof.164.1595980217386;
 Tue, 28 Jul 2020 16:50:17 -0700 (PDT)
MIME-Version: 1.0
References: <159597929496.12744.14654593948763926416.stgit@bmoger-ubuntu> <159597947370.12744.8741858978174141331.stgit@bmoger-ubuntu>
In-Reply-To: <159597947370.12744.8741858978174141331.stgit@bmoger-ubuntu>
From:   Jim Mattson <jmattson@google.com>
Date:   Tue, 28 Jul 2020 16:50:06 -0700
Message-ID: <CALMp9eTqJHS2fwyRyUS8gRD+HzyEzP0yovok6rfbjb8mfZTejw@mail.gmail.com>
Subject: Re: [PATCH v3 01/11] KVM: SVM: Introduce __set_intercept,
 __clr_intercept and __is_intercept
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
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 28, 2020 at 4:37 PM Babu Moger <babu.moger@amd.com> wrote:
>
> This is in preparation for the future intercept vector additions.
>
> Add new functions __set_intercept, __clr_intercept and __is_intercept
> using kernel APIs __set_bit, __clear_bit and test_bit espectively.
>
> Signed-off-by: Babu Moger <babu.moger@amd.com>
Sean will probably complain about introducing unused functions, but...

Reviewed-by: Jim Mattson <jmattson@google.com>
