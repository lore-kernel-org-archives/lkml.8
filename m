Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF5E2C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 21:16:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 898AC2072E
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 21:16:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pXBP0dYr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393457AbgFWVP6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 17:15:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390360AbgFWU2K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 16:28:10 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DBE6C061755
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 13:28:11 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id m81so25417066ioa.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 13:28:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=P5UNTUR/q9352l4Mlr6IfyTScpTOUF+qqIDl8m4Q5dI=;
        b=pXBP0dYrp0aWb7reKttRpg7fCJP6uN8YEsLqzatG5AfZRlHt2wzho0utGEdiM74V9Q
         gPei1v8ea5yzziraZW3573GE451dop8lq6t4TNAyjWVZmmH2ktSHjzTk50ivD0+8AJBG
         7YY6MGutzQ7cv+ofQUhtxHi8d0/mILk9ALk6CheDXG9koxRmWYnTK5oswDM7wMKcV55v
         V5XgDf8ektorep4GCw6hyLwBcm1VyAjbjood7QMOMgLPgAAlRD4+HOKZ7tB3pvkEq3zO
         SfYvM/mrGa6UURTxJmBFNQ1GA7vJ8pV1gswC2Lw9gMWMKj0rGpngsPejkNnfpvqmckqo
         TTjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=P5UNTUR/q9352l4Mlr6IfyTScpTOUF+qqIDl8m4Q5dI=;
        b=pBsfUG6jwf8PxLQd+mkaBIZHhJADmjF1/5eOHWhq04be+OYW47NR72nrP6y37U+SBS
         UlYOX+a+TJ5l9yPv2pJSVff7PzDLGu3PcQJ96qEbPyIv7+PjU46TIJ77JyRq6g5WKlmB
         kyLUENw4SNhgs8RCE9HkjW9qCdIahbQ4zzhA30aFMWuvlwfbruOYr7iNo9dytzJx57FR
         vdcLNM9deSgfPZ6K5U2rm/YA9GCxQESEmnRxdqVVhoyl8+xtERxf2CjO2cAxJcG6z1vJ
         wboxoXYGrfqxI9PgNfkhSFLbqLmt6KXDCmTkLudfE54MKAKj9+xzp1Fz6bVD0YvHyH6d
         L0Sg==
X-Gm-Message-State: AOAM531Mp2+xRtODBhWDGFfL0whw8kuFgD/dfn9UKaHdoSYRLWaXv28e
        US+lgKumDV8fLhJIVjtdGNiGCpqSZpZ8MjPU8DbQ6A==
X-Google-Smtp-Source: ABdhPJyUzmhsf+zkopxpmhKwOdEOcFwNtbjiy/Z3KOJz3Pm7R67RaWz/QszzzmeKnQ+WNMpxUHJ8y9OLysGUfzdwX/M=
X-Received: by 2002:a02:cced:: with SMTP id l13mr24583703jaq.68.1592944090180;
 Tue, 23 Jun 2020 13:28:10 -0700 (PDT)
MIME-Version: 1.0
References: <20200623194027.23135-1-sean.j.christopherson@intel.com> <20200623194027.23135-2-sean.j.christopherson@intel.com>
In-Reply-To: <20200623194027.23135-2-sean.j.christopherson@intel.com>
From:   Jon Cargille <jcargill@google.com>
Date:   Tue, 23 Jun 2020 13:27:58 -0700
Message-ID: <CANxmayj_08OsLst_oSczhYphQ3t4m+inf5-4k0_qfKUbzWU3fQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] KVM: x86/mmu: Avoid multiple hash lookups in kvm_get_mmu_page()
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Peter Feiner <pfeiner@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

LGTM.

Reviewed-By: Jon Cargille <jcargill@google.com>


On Tue, Jun 23, 2020 at 12:40 PM Sean Christopherson
<sean.j.christopherson@intel.com> wrote:
>
> Refactor for_each_valid_sp() to take the list of shadow pages instead of
> retrieving it from a gfn to avoid doing the gfn->list hash and lookup
> multiple times during kvm_get_mmu_page().
>
> Cc: Peter Feiner <pfeiner@google.com>
> Cc: Jon Cargille <jcargill@google.com>
> Cc: Jim Mattson <jmattson@google.com>
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
> ---
>  arch/x86/kvm/mmu/mmu.c | 17 +++++++++--------
>  1 file changed, 9 insertions(+), 8 deletions(-)
>
> diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> index 3dd0af7e7515..67f8f82e9783 100644
> --- a/arch/x86/kvm/mmu/mmu.c
> +++ b/arch/x86/kvm/mmu/mmu.c
> @@ -2258,15 +2258,14 @@ static bool kvm_mmu_prepare_zap_page(struct kvm *kvm, struct kvm_mmu_page *sp,
>  static void kvm_mmu_commit_zap_page(struct kvm *kvm,
>                                     struct list_head *invalid_list);
>
> -
> -#define for_each_valid_sp(_kvm, _sp, _gfn)                             \
> -       hlist_for_each_entry(_sp,                                       \
> -         &(_kvm)->arch.mmu_page_hash[kvm_page_table_hashfn(_gfn)], hash_link) \
> +#define for_each_valid_sp(_kvm, _sp, _list)                            \
> +       hlist_for_each_entry(_sp, _list, hash_link)                     \
>                 if (is_obsolete_sp((_kvm), (_sp))) {                    \
>                 } else
>
>  #define for_each_gfn_indirect_valid_sp(_kvm, _sp, _gfn)                        \
> -       for_each_valid_sp(_kvm, _sp, _gfn)                              \
> +       for_each_valid_sp(_kvm, _sp,                                    \
> +         &(_kvm)->arch.mmu_page_hash[kvm_page_table_hashfn(_gfn)])     \
>                 if ((_sp)->gfn != (_gfn) || (_sp)->role.direct) {} else
>
>  static inline bool is_ept_sp(struct kvm_mmu_page *sp)
> @@ -2477,6 +2476,7 @@ static struct kvm_mmu_page *kvm_mmu_get_page(struct kvm_vcpu *vcpu,
>                                              unsigned int access)
>  {
>         union kvm_mmu_page_role role;
> +       struct hlist_head *sp_list;
>         unsigned quadrant;
>         struct kvm_mmu_page *sp;
>         bool need_sync = false;
> @@ -2496,7 +2496,9 @@ static struct kvm_mmu_page *kvm_mmu_get_page(struct kvm_vcpu *vcpu,
>                 quadrant &= (1 << ((PT32_PT_BITS - PT64_PT_BITS) * level)) - 1;
>                 role.quadrant = quadrant;
>         }
> -       for_each_valid_sp(vcpu->kvm, sp, gfn) {
> +
> +       sp_list = &vcpu->kvm->arch.mmu_page_hash[kvm_page_table_hashfn(gfn)];
> +       for_each_valid_sp(vcpu->kvm, sp, sp_list) {
>                 if (sp->gfn != gfn) {
>                         collisions++;
>                         continue;
> @@ -2533,8 +2535,7 @@ static struct kvm_mmu_page *kvm_mmu_get_page(struct kvm_vcpu *vcpu,
>
>         sp->gfn = gfn;
>         sp->role = role;
> -       hlist_add_head(&sp->hash_link,
> -               &vcpu->kvm->arch.mmu_page_hash[kvm_page_table_hashfn(gfn)]);
> +       hlist_add_head(&sp->hash_link, sp_list);
>         if (!direct) {
>                 /*
>                  * we should do write protection before syncing pages
> --
> 2.26.0
>
