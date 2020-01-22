Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53897C33CB6
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 16:06:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26CEA2071E
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 16:06:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YxvtTado"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728205AbgAVQGe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 11:06:34 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:29226 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725883AbgAVQGd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 11:06:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579709192;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=x8qyk16EQoiKQDWHcoCsrg8S6aLPNFCtfv1vrpksIQM=;
        b=YxvtTadojmsMr4r6k+8pAn4VFANRjfQpHM9p/AnMMBMaUPQ/dj1uZC+mTxCrRgB641D9uV
        d8xkMR//KdJVfoiIhClozmxsfbr7ECiGNckODzRgPaJwYKiPhjsYstVuXp7ORA4NSZqXjn
        WEaKY1GWpN6lxMrgHy42G4B0AJAT3WA=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-12-gSaC6T76OlKouqo9iLABYA-1; Wed, 22 Jan 2020 11:06:31 -0500
X-MC-Unique: gSaC6T76OlKouqo9iLABYA-1
Received: by mail-wr1-f69.google.com with SMTP id j13so3272795wrr.20
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jan 2020 08:06:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=x8qyk16EQoiKQDWHcoCsrg8S6aLPNFCtfv1vrpksIQM=;
        b=prS+hpqce4ImLFQ7JRldg3GQfKGZClIIr7LpU4v1XZSqOPdWONYooQCKJM/u2TjSG/
         8uyP/fVey441jtVNiVdIZK0nV5fLsXqgTbQ9UE1AT8IhVGLjx0sFr6Tu1SEHcpJWPKIE
         MFlkJ/RUiqfPn91/SmAPjgcpEQM+mUV+QO2KxSmxYiGdNPqaeis9rKSblBElUlrePfZa
         uU98cwLQeYpidvjy1qCE79FoI35NLanm89r8sSNGqtNP+5hp9qxkzQbGQLOeZuAkEUq5
         tCcYkh++WzZYXB4SfVSAIH+VCssib6CPfiwOsy9CG/vTO8zMbkAqVc2zWLRtTciApRXr
         iSdg==
X-Gm-Message-State: APjAAAVRw3rIZdRuUciwL36WyHU3m92QSvQUKZc1ch2qSTe+ZuWLLcsB
        NWkUxrqxc6mrw/yrm6ug87B/0HzCdCNly7rR16QPmmTPWnXdxOlBPt1yPNof1j6hKmyZ22NUwA1
        B03VHPuWI23i90+JANeHMfoFq
X-Received: by 2002:a1c:9602:: with SMTP id y2mr3643020wmd.23.1579709188818;
        Wed, 22 Jan 2020 08:06:28 -0800 (PST)
X-Google-Smtp-Source: APXvYqyEpgRbW+shvDD7JCspQO++0KMJsnqySv9bIuY1pzJqxjjS6lrQbEYxP/XEfn+24miwuSmtHQ==
X-Received: by 2002:a1c:9602:: with SMTP id y2mr3642990wmd.23.1579709188357;
        Wed, 22 Jan 2020 08:06:28 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:b8fe:679e:87eb:c059? ([2001:b07:6468:f312:b8fe:679e:87eb:c059])
        by smtp.gmail.com with ESMTPSA id s15sm54142437wrp.4.2020.01.22.08.06.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jan 2020 08:06:27 -0800 (PST)
Subject: Re: [PATCH v5 18/18] svm: Allow AVIC with in-kernel irqchip mode
To:     Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     rkrcmar@redhat.com, joro@8bytes.org, vkuznets@redhat.com,
        rkagan@virtuozzo.com, graf@amazon.com, jschoenh@amazon.de,
        karahmed@amazon.de, rimasluk@amazon.com, jon.grimm@amd.com
References: <1573762520-80328-1-git-send-email-suravee.suthikulpanit@amd.com>
 <1573762520-80328-19-git-send-email-suravee.suthikulpanit@amd.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <72b5dc17-1056-098d-e830-56e19cc769ab@redhat.com>
Date:   Wed, 22 Jan 2020 17:06:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <1573762520-80328-19-git-send-email-suravee.suthikulpanit@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/11/19 21:15, Suravee Suthikulpanit wrote:
> Once run-time AVIC activate/deactivate is supported, and EOI workaround
> for AVIC is implemented, we can remove the kernel irqchip split mode
> requirement for AVIC.
> 
> Hence, remove the check for irqchip split mode when enabling AVIC.
> 
> Cc: Radim Krčmář <rkrcmar@redhat.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> ---
>  arch/x86/kvm/svm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kvm/svm.c b/arch/x86/kvm/svm.c
> index 2dfdd7c..2cba5be 100644
> --- a/arch/x86/kvm/svm.c
> +++ b/arch/x86/kvm/svm.c
> @@ -5149,7 +5149,7 @@ static void svm_set_virtual_apic_mode(struct kvm_vcpu *vcpu)
>  
>  static bool svm_get_enable_apicv(struct kvm *kvm)
>  {
> -	return avic && irqchip_split(kvm);
> +	return avic;
>  }
>  
>  static void svm_hwapic_irr_update(struct kvm_vcpu *vcpu, int max_irr)
> 

Since I'm going to remove get_enable_apicv, this patch will look like
this instead:

diff --git a/arch/x86/kvm/svm.c b/arch/x86/kvm/svm.c
index ceead401a696..1c4a26d34913 100644
--- a/arch/x86/kvm/svm.c
+++ b/arch/x86/kvm/svm.c
@@ -2074,7 +2074,7 @@ static int svm_vm_init(struct kvm *kvm)
 			return ret;
 	}

-	kvm_apicv_init(kvm, avic && irqchip_split(kvm));
+	kvm_apicv_init(kvm, avic);
 	return 0;
 }


Paolo

