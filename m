Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C3BCC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 21:06:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 43CD6206D4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 21:06:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="B0M2Rleh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726631AbgG2VGe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 17:06:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726476AbgG2VGe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 17:06:34 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16AF1C061794
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jul 2020 14:06:34 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id e64so26020383iof.12
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jul 2020 14:06:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PYXSUMqBNAfekuMZ1II61jWQ+xQzFVAYx97TvpVd0jI=;
        b=B0M2Rleh5A8unRB3YwRgb+tjnGZ4gDCtk6RwC2OUBr1YrPpnKGAVgjv3iD2coO3zEG
         wJywzxnfdtSHlMZbt1el03j75eCIgiy0t3niS4XdBYt+IPVxgeryIV26sAnbBb2ie8ed
         UC4NWxmjIYy4lLysz0TpsFVD6MAdDepPg9DkPizx4N0df4RVfWMk70I17ysRhbPFGyYB
         RZtAY3fSm9ZbaspEEUqJxpDhm8toh0lJx5FtomdhnR4jNmOQgG9l2q1BOBET0sHJrzf/
         wYV+26Xl/ohLIL9dW88838MKGzA/j4SEQN5Qm/kpHXzXionu7yWS34UkzLPnsG8HMIr1
         R3sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PYXSUMqBNAfekuMZ1II61jWQ+xQzFVAYx97TvpVd0jI=;
        b=Y3PHWgI0Jbo0xawb0009vxf/6jbQphE2VCcTac4HBiRrh12jNwEdBT2W92vml3u7UU
         o/cxOcR0tmQZndHNxBmltBGzY3LlUgB/0LYIBMnpQittB0GR0pCfE5/aOVQX8Wi+sR3M
         KwTmF+KIOWlJm4qr/t6A+sLLNZ0+ys7kNGvfmJ84u2oTMcdH/nBEL2fhqSii9SFafeeT
         d4fbeZ+fz3Xu9s7z2CNCGvATuscTIboMK2KvBlZAmYmNTICpwSBaIf5/GTrC9QMLBsDB
         MtGQIv1T2so7YioCAPe2sep9jc1bp92Le9UFXg9eqJsH0PUxYCyRJGkjcJzMh6M3Mlyo
         hlgA==
X-Gm-Message-State: AOAM531I05Qj+u70tIzIB6zPPfP0g1eXzIdU6jjer9obQkRiLESIpt+Z
        WnY9KAVh3Z3uj6rQ4uo6FtJvDfi68Obud5esh9Ee6Q==
X-Google-Smtp-Source: ABdhPJz89qZcoF741PgVTVzeNOR8THiBkq7r/07KbMhPhKErgfdp89Y987XC9GEz5UtVzCaiwYbkBjxQ0irN/VWCLl8=
X-Received: by 2002:a02:bb82:: with SMTP id g2mr49494jan.54.1596056793308;
 Wed, 29 Jul 2020 14:06:33 -0700 (PDT)
MIME-Version: 1.0
References: <159597929496.12744.14654593948763926416.stgit@bmoger-ubuntu> <159597949971.12744.1782012822260431973.stgit@bmoger-ubuntu>
In-Reply-To: <159597949971.12744.1782012822260431973.stgit@bmoger-ubuntu>
From:   Jim Mattson <jmattson@google.com>
Date:   Wed, 29 Jul 2020 14:06:21 -0700
Message-ID: <CALMp9eSY4YshSLEThV1KDRmrXG_pcs68OwrgC4cDe4smaVe8Cg@mail.gmail.com>
Subject: Re: [PATCH v3 05/11] KVM: SVM: Modify 64 bit intercept field to two
 32 bit vectors
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

On Tue, Jul 28, 2020 at 4:38 PM Babu Moger <babu.moger@amd.com> wrote:
>
> Convert all the intercepts to one array of 32 bit vectors in
> vmcb_control_area. This makes it easy for future intercept vector
> additions.  Also update trace functions.
>
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---

> @@ -128,8 +129,7 @@ enum {
>
>  struct __attribute__ ((__packed__)) vmcb_control_area {
>         u32 intercepts[MAX_VECTORS];
> -       u64 intercept;
> -       u8 reserved_1[40];
> +       u8 reserved_1[60 - (MAX_VECTORS * 4)];

Perhaps this could be simplified to 'u32 reserved_1[15 - MAX_VECTORS];'

>         u16 pause_filter_thresh;
>         u16 pause_filter_count;
>         u64 iopm_base_pa;

Reviewed-by: Jim Mattson <jmattson@google.com>
