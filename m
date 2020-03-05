Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4766EC3F2D1
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 10:00:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D62D21556
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 10:00:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FOyvF56p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727474AbgCEKA2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 05:00:28 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:51619 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727053AbgCEKA0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 05:00:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583402425;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=h9c3Oo/RuEHs22bhUV7ITfbICrFSfIEa7L4Ikjb6rqs=;
        b=FOyvF56peCZPKLIZurAoxd1oXeyGhIjxp6O5LD9D5BpBd/b3Kym/S0qaokQEWpazfHpAT+
        aQWRVsMuKCkadBfcnnH0ai96w4kzsbq7pk0QuMHHhMNQ0AxCSOjrCj+BANmJEQKA7AB4qX
        DBcpTt3TAbBxpQtN6xtqUJBHb2v1BtU=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-136-OHPMzgzGNYmIFmAg971lRg-1; Thu, 05 Mar 2020 05:00:24 -0500
X-MC-Unique: OHPMzgzGNYmIFmAg971lRg-1
Received: by mail-wr1-f72.google.com with SMTP id w6so2080468wrm.16
        for <linux-kernel@vger.kernel.org>; Thu, 05 Mar 2020 02:00:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=h9c3Oo/RuEHs22bhUV7ITfbICrFSfIEa7L4Ikjb6rqs=;
        b=XjbecWNgCvNyPbqJFZWf29mF2z/m0eXLLlxMpntdro3+eC28aDF/zhrvRzlqRiJlTc
         T6EGKfNuAoKqxT0Dy3awDX0sJbdINyUF/x/sCUxWO03Sz2gKAk4l3Rge6NyGhgNwIv+j
         FKnCMYFzFgDxfXJbfst22PdSKvwLG4n60G8/fG6Xb+uDdn+bqBA/vFaIYb2uekvVJBGe
         /5RepZoebECye1yUeL1IQoTN3SU0Jq85WD1HkcdJzKNQmBh/iucORvn7qBsaHD16SYsd
         KnvFfaXeFwzU4VC8GwRd2OuEUtlBheJDTAH+mkDtD62UEHNGcvYUBcaOYE85sHOoBMnn
         jZiQ==
X-Gm-Message-State: ANhLgQ03t1M1S0T/JSkU3xvioH9lQwLAxzTp+TKEzWIWynCoEeysMaSE
        3HNhEfgbj/WRtF6hKRy/rcLympA+iyVX2aCXny0JYVInMLEL5iO3UO3Ie/+NA/ao3O/bAJ1Mn+i
        1XKsO4AyO6HegkvJgpdHfvolb
X-Received: by 2002:adf:ed4c:: with SMTP id u12mr10026077wro.204.1583402422991;
        Thu, 05 Mar 2020 02:00:22 -0800 (PST)
X-Google-Smtp-Source: ADFU+vs1BoO4KZ5s7zmZKx1MVnI40qzqSNNmxzRndp8CmpnaWitVLFzRckZCZjjtUM9MSCoyPkYzyQ==
X-Received: by 2002:adf:ed4c:: with SMTP id u12mr10026049wro.204.1583402422768;
        Thu, 05 Mar 2020 02:00:22 -0800 (PST)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id e11sm42114205wrm.80.2020.03.05.02.00.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2020 02:00:21 -0800 (PST)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] KVM: x86: Fix warning due to implicit truncation on 32-bit KVM
In-Reply-To: <20200305002422.20968-1-sean.j.christopherson@intel.com>
References: <20200305002422.20968-1-sean.j.christopherson@intel.com>
Date:   Thu, 05 Mar 2020 11:00:20 +0100
Message-ID: <87wo7zcea3.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sean Christopherson <sean.j.christopherson@intel.com> writes:

> Explicitly cast the integer literal to an unsigned long when stuffing a
> non-canonical value into the host virtual address during private memslot
> deletion.  The explicit cast fixes a warning that gets promoted to an
> error when running with KVM's newfangled -Werror setting.
>
>   arch/x86/kvm/x86.c:9739:9: error: large integer implicitly truncated
>   to unsigned type [-Werror=overflow]
>
> Fixes: a3e967c0b87d3 ("KVM: Terminate memslot walks via used_slots"

Missing ')'

> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
> ---
>  arch/x86/kvm/x86.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index ba4d476b79ad..fa03f31ab33c 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -9735,8 +9735,12 @@ int __x86_set_memory_region(struct kvm *kvm, int id, gpa_t gpa, u32 size)
>  		if (!slot || !slot->npages)
>  			return 0;
>  
> -		/* Stuff a non-canonical value to catch use-after-delete. */
> -		hva = 0xdeadull << 48;
> +		/*
> +		 * Stuff a non-canonical value to catch use-after-delete.  This
> +		 * ends up being 0 on 32-bit KVM, but there's no better
> +		 * alternative.
> +		 */
> +		hva = (unsigned long)(0xdeadull << 48);
>  		old_npages = slot->npages;
>  	}

Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>

-- 
Vitaly

