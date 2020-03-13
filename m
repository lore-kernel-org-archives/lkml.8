Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94A40C2BB1D
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 13:25:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E126206BE
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 13:25:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AHON1tRE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726681AbgCMNZ6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 09:25:58 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:50998 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726479AbgCMNZ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 09:25:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584105956;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Zsg2hmxrQyD4xVASw0wlu0Vs2nauojeVgAGZZ0zLUOQ=;
        b=AHON1tREv5GLNBHaY2+cXp9CLr1ohknZ7I2Q/RSgDpIdGx95Y3uxtfHfrj6ivljd+Ic+Di
        Ap4GLsZbw4ufNyHT+3oiZ121A08sb2vSvFbRe+LBPv6HP9lBTVKJcPoIBnNOtdVuvKWrvT
        wZrLFtJ3Nuj/dDKFO3kpXO0MVAeWExo=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-97-pMPPenlJNBuu8w-k9bxXHQ-1; Fri, 13 Mar 2020 09:25:54 -0400
X-MC-Unique: pMPPenlJNBuu8w-k9bxXHQ-1
Received: by mail-wm1-f72.google.com with SMTP id n188so3450120wmf.0
        for <linux-kernel@vger.kernel.org>; Fri, 13 Mar 2020 06:25:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=Zsg2hmxrQyD4xVASw0wlu0Vs2nauojeVgAGZZ0zLUOQ=;
        b=AgX9sql54PzYHxHwqog1YAr7x0b8Gv6l39s2Lj6etswe5ICcZLGFZIo8LynbwIgwqg
         EDLgh+pbnj8bKf++gYU0RmfaR6+r7f/B2jyB4X3D7jQm7I1gyZsMACJgpz/rM8L8odPo
         l4MWMs79t8oywdKfwSCQ9kmy2ESXu/uoHZKpREcKoNsRf92H4QqBli5V67jyKjLL1yMe
         1pPuAYtXwloTEhBktG4NFD5YzhsBCEhm4HoCRPCFRvEFpenCajD7UfrLxC7NU3wdPQEo
         kYz+FKJbUX2BQnyHgMlvWn4Zz6jxhr8/TdDpn8GF4iqCiXJ2s/uzw9lxSz7eipCJKQml
         fKSA==
X-Gm-Message-State: ANhLgQ1Mw+pAeJcRzyudZgeoVYTe8Wyf8wLIQroCriH3nijV7vW8j5OF
        ktSEnQo2RHTmdUMFN89k3Bc+tAxSggKLpmJ4KYrie+/phXiEc5AcOU1AtbM7eI9VCdHuJbBljEl
        YivypPGMISBejr65Ku404X5s+
X-Received: by 2002:adf:ec4f:: with SMTP id w15mr12354281wrn.106.1584105953549;
        Fri, 13 Mar 2020 06:25:53 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vtNNOSsAUJeY4L6aedmncWQYrdwJODwZaTfEPbLD9g0Egg8iJWDxx35ffXEP6v/Wqy7JF7pIA==
X-Received: by 2002:adf:ec4f:: with SMTP id w15mr12354264wrn.106.1584105953338;
        Fri, 13 Mar 2020 06:25:53 -0700 (PDT)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id w22sm17104519wmk.34.2020.03.13.06.25.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2020 06:25:52 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Nitesh Narayan Lal <nitesh@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        mtosatti@redhat.com, sean.j.christopherson@intel.com,
        wanpengli@tencent.com, jmattson@google.com, joro@8bytes.org,
        pbonzini@redhat.com, peterx@redhat.com
Subject: Re: [Patch v2] KVM: x86: Initializing all kvm_lapic_irq fields in ioapic_write_indirect
In-Reply-To: <1584105384-4864-1-git-send-email-nitesh@redhat.com>
References: <1584105384-4864-1-git-send-email-nitesh@redhat.com>
Date:   Fri, 13 Mar 2020 14:25:51 +0100
Message-ID: <871rpwpesg.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Nitesh Narayan Lal <nitesh@redhat.com> writes:

> Previously all fields of structure kvm_lapic_irq were not initialized
> before it was passed to kvm_bitmap_or_dest_vcpus(). Which will cause
> an issue when any of those fields are used for processing a request.
> For example not initializing the msi_redir_hint field before passing
> to the kvm_bitmap_or_dest_vcpus(), may lead to a misbehavior of
> kvm_apic_map_get_dest_lapic(). This will specifically happen when the
> kvm_lowest_prio_delivery() returns TRUE due to a non-zero garbage
> value of msi_redir_hint, which should not happen as the request belongs
> to APIC fixed delivery mode and we do not want to deliver the
> interrupt only to the lowest priority candidate.
>
> This patch initializes all the fields of kvm_lapic_irq based on the
> values of ioapic redirect_entry object before passing it on to
> kvm_bitmap_or_dest_vcpus().
>
> Fixes: 7ee30bc132c6("KVM: x86: deliver KVM IOAPIC scan request to target vCPUs")
> Signed-off-by: Nitesh Narayan Lal <nitesh@redhat.com>
> ---
>  arch/x86/kvm/ioapic.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/arch/x86/kvm/ioapic.c b/arch/x86/kvm/ioapic.c
> index 7668fed..3a8467d 100644
> --- a/arch/x86/kvm/ioapic.c
> +++ b/arch/x86/kvm/ioapic.c
> @@ -378,12 +378,15 @@ static void ioapic_write_indirect(struct kvm_ioapic *ioapic, u32 val)
>  		if (e->fields.delivery_mode == APIC_DM_FIXED) {
>  			struct kvm_lapic_irq irq;
>  
> -			irq.shorthand = APIC_DEST_NOSHORT;
>  			irq.vector = e->fields.vector;
>  			irq.delivery_mode = e->fields.delivery_mode << 8;
> -			irq.dest_id = e->fields.dest_id;
>  			irq.dest_mode =
>  			    kvm_lapic_irq_dest_mode(!!e->fields.dest_mode);
> +			irq.level = 1;

'level' is bool in struct kvm_lapic_irq but other than that, is there a
reason we set it to 'true' here? I understand that any particular
setting is likely better than random and it should actually not be used
without setting it first but still?

> +			irq.trig_mode = e->fields.trig_mode;
> +			irq.shorthand = APIC_DEST_NOSHORT;
> +			irq.dest_id = e->fields.dest_id;
> +			irq.msi_redir_hint = false;
>  			bitmap_zero(&vcpu_bitmap, 16);
>  			kvm_bitmap_or_dest_vcpus(ioapic->kvm, &irq,
>  						 &vcpu_bitmap);

-- 
Vitaly

