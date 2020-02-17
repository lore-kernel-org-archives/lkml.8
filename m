Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 700E9C3B185
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 10:40:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4194A206F4
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 10:40:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PieRkGbU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729268AbgBQKkc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 05:40:32 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:41325 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725972AbgBQKkb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 05:40:31 -0500
Received: by mail-ot1-f65.google.com with SMTP id r27so15590136otc.8;
        Mon, 17 Feb 2020 02:40:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aLCSyvqx9dWHy5GEPaxx29DRb8rkFCZA7J7ME/KDLu0=;
        b=PieRkGbUt/Wz4EfWwgt8K4tWyVEowiDBImfFcjY5FUasEFi5vSfPpBAxy45M3QMNfU
         JDCR1e2RGPwKt4LvANHVDgWhmhe2s1xn4zSCOAyqVW3WViRYNkvP8mrpxDW9Z9PNQTHQ
         BhKxe/AZW3S111ACGT7FE13PJwuerLzPjZJ7UkksDkv12LxpvBwSPFEpFA8nNzlpq186
         6U4OjECgKV+IZ/aEVgOZjDP3ER1eSJO9W7WaKrRH5TzIEkTVTQllgTcsFymHfJ3npOR6
         JIaJuw4cLnIno0EtyzksaVyZwpfy+IbaSyBcblIWZH81xayIt/GHHAMxcHcoMIv++O0U
         xvrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aLCSyvqx9dWHy5GEPaxx29DRb8rkFCZA7J7ME/KDLu0=;
        b=J1Erw8G5YK43ovGMElFvurMw/+Wv1x4J7J/Iuxb2V+xSds6IOpPey7Q9CXV2km1KOI
         ceyZ/AEB+/gNaTLuJwsLoLNmzkfrxVOPDMkBnZR8SZOGAY4Ewwf4hLPd/Q18XM9L1/7b
         j4TufpNbIm+pIe4NydUPNH2mksXJ+zBRejseW8ec1bcZFrHoi3i7BQqnOmErw4t1LRfP
         yvbYiVtYXODJuFvzryLbRGxFDhniKEM7fuzdNUzz3ewY2Bt4L2Kc0hCheUlSbJ2Lq7f4
         gGUfcbQPuFsaqi4MIfBgkpkOcwMPiZByN9uCg7WQi1XNTzMzq+Fd6ImxZihgJwi3KDAc
         ZLog==
X-Gm-Message-State: APjAAAV6dE6iu7bFSt5A89i3GOf0eX+FDeGxuVZ4m7m57GqL+sDlXyYG
        UFMK+2m2rsfY1GcGvh2JHWyt5OSHeljRXkzk4CEgOyJ1LhI=
X-Google-Smtp-Source: APXvYqzQx6BFLfD+A6DxAo9HQy4ir9xWeRlnUntL7X6kVB/QZdVHZcETH9qZ13FfwD6aq1WmYIzuS00tqpq3O6clOGQ=
X-Received: by 2002:a9d:7ccd:: with SMTP id r13mr11248022otn.56.1581936030747;
 Mon, 17 Feb 2020 02:40:30 -0800 (PST)
MIME-Version: 1.0
References: <CANRm+Cz6Es1TLFdGxz_65i-4osE6=67J=noqWC6n09TeXSJ5SA@mail.gmail.com>
In-Reply-To: <CANRm+Cz6Es1TLFdGxz_65i-4osE6=67J=noqWC6n09TeXSJ5SA@mail.gmail.com>
From:   Wanpeng Li <kernellwp@gmail.com>
Date:   Mon, 17 Feb 2020 18:40:19 +0800
Message-ID: <CANRm+CwQ2pCpdts_wao9Qy1EBqhOnO0PQQWX6ZU3brt2oeUTzw@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] KVM: X86: Less kvmclock sync induced vmexits after
 VM boots
To:     LKML <linux-kernel@vger.kernel.org>, kvm <kvm@vger.kernel.org>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Feb 2020 at 18:36, Wanpeng Li <kernellwp@gmail.com> wrote:
>
> From: Wanpeng Li <wanpengli@tencent.com>
>
> In the progress of vCPUs creation, it queues a kvmclock sync worker to
> the global
> workqueue before each vCPU creation completes. Each worker will be scheduled
> after 300 * HZ delay and request a kvmclock update for all vCPUs and kick them
> out. This is especially worse when scaling to large VMs due to a lot of vmexits.
> Just one worker as a leader to trigger the kvmclock sync request for
> all vCPUs is
> enough.

Sorry for the alignment.

>
> Signed-off-by: Wanpeng Li <wanpengli@tencent.com>
> ---
>  arch/x86/kvm/x86.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index fb5d64e..d0ba2d4 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -9390,8 +9390,9 @@ void kvm_arch_vcpu_postcreate(struct kvm_vcpu *vcpu)
>      if (!kvmclock_periodic_sync)
>          return;
>
> -    schedule_delayed_work(&kvm->arch.kvmclock_sync_work,
> -                    KVMCLOCK_SYNC_PERIOD);
> +    if (kvm->created_vcpus == 1)
> +        schedule_delayed_work(&kvm->arch.kvmclock_sync_work,
> +                        KVMCLOCK_SYNC_PERIOD);
>  }
>
>  void kvm_arch_vcpu_destroy(struct kvm_vcpu *vcpu)
> --
> 2.7.4
