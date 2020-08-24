Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3E22C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 01:04:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A3B23206C0
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 01:04:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PjifuIqs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727885AbgHXBEu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Aug 2020 21:04:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726600AbgHXBEt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Aug 2020 21:04:49 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D94BC061573;
        Sun, 23 Aug 2020 18:04:49 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id z22so6840940oid.1;
        Sun, 23 Aug 2020 18:04:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mKKnJmnZ3+RfGwqeM9N9qLBBL6CS47leSje6BwF1paY=;
        b=PjifuIqsEUJwD4cLSnr55oO8o/owcAPWr0mPItui1NH2Yn8A5ZUCzb8VavEn/XskYm
         FtIHZlz1Pc6VfejrRQxVbsO5LvKimiLmDrGz8HJP7Xdk0M84HDM8GZfsKMjv+439W9E2
         qkdCDrjK9p14e/En0+AHgVrHru00Ek/MXsfPBUKSNB5UAZ22/ec2Pw0v7Tsg0toWyOQu
         F+NrPuj6huFTUVjiRRAm7uTxMO2VLOq496CdOkYfLVaoesLu/60pF1axoUWjRtcEZi5A
         3Rb3IjkFT73XgiSpHn7R5FZjCXh0sL3orvgi2ycVCJtTV08DETqz2oUHdY73uWpkMgYu
         uZhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mKKnJmnZ3+RfGwqeM9N9qLBBL6CS47leSje6BwF1paY=;
        b=ZXBPL9MNgNoz6b1vNX4u6dhi0LPB0PLBlYe++tT/7z/CYmI32FnlqIg2kSfWp9E7IZ
         MNORGmL4XPRFh+AFwbhwm4QRpCm1nF9DkHMz6gipre6AgqPdxNmU1usDaGfan8IP7+Yf
         45Gie/H1r7fbQK+5/TLnP9g2NPG7IJROniosfSX2awyoy6FBQ2qv7uqOIO1ObkIMkUrt
         1HZN0EcYbgUsLKIVorPUJ5aQ73okUi436lQD1DeuAYDFx1Av3UD3ZZlSb5x/bKhmrxAR
         oBvg0pMq3WO5Xb+sJzD6IWPzNj11/TRLeuwcjquarvKTAqs1QIo8RptDAi/jwbVJkA1E
         Xe2Q==
X-Gm-Message-State: AOAM531UYZPQQjQ6Q6GTROXCnAgR7qeJtw4CLVwi40kZQMBuZpZy4sCM
        rE+aQU4/h0JyyiREejpUYNLM8gBbZfUDsI81qGuz2ExE
X-Google-Smtp-Source: ABdhPJxTS2egXZnQG45E/UMLmB1PekQ2898Oe9Yij0mWTr5u9tpaxZ01bOUFiStnKGlwMRoAydZdjtGtL3aAPknp7lc=
X-Received: by 2002:a05:6808:b:: with SMTP id u11mr1863885oic.33.1598231088494;
 Sun, 23 Aug 2020 18:04:48 -0700 (PDT)
MIME-Version: 1.0
References: <1597213838-8847-1-git-send-email-wanpengli@tencent.com> <1597213838-8847-2-git-send-email-wanpengli@tencent.com>
In-Reply-To: <1597213838-8847-2-git-send-email-wanpengli@tencent.com>
From:   Wanpeng Li <kernellwp@gmail.com>
Date:   Mon, 24 Aug 2020 09:04:37 +0800
Message-ID: <CANRm+CzzJuffAfcR9KyZ6Yv1sSQJyM+H2V19=OuU=jJON6iVXQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] KVM: LAPIC: Guarantee the timer is in tsc-deadline
 mode when setting
To:     LKML <linux-kernel@vger.kernel.org>, kvm <kvm@vger.kernel.org>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ping :)
On Wed, 12 Aug 2020 at 14:30, Wanpeng Li <kernellwp@gmail.com> wrote:
>
> From: Wanpeng Li <wanpengli@tencent.com>
>
> Check apic_lvtt_tscdeadline() mode directly instead of apic_lvtt_oneshot()
> and apic_lvtt_period() to guarantee the timer is in tsc-deadline mode when
> wrmsr MSR_IA32_TSCDEADLINE.
>
> Signed-off-by: Wanpeng Li <wanpengli@tencent.com>
> ---
> v1 -> v2:
>  * fix indentation
>
>  arch/x86/kvm/lapic.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
> index 79599af..abaf48e 100644
> --- a/arch/x86/kvm/lapic.c
> +++ b/arch/x86/kvm/lapic.c
> @@ -2193,8 +2193,7 @@ void kvm_set_lapic_tscdeadline_msr(struct kvm_vcpu *vcpu, u64 data)
>  {
>         struct kvm_lapic *apic = vcpu->arch.apic;
>
> -       if (!kvm_apic_present(vcpu) || apic_lvtt_oneshot(apic) ||
> -                       apic_lvtt_period(apic))
> +       if (!kvm_apic_present(vcpu) || !apic_lvtt_tscdeadline(apic))
>                 return;
>
>         hrtimer_cancel(&apic->lapic_timer.timer);
> --
> 2.7.4
>
