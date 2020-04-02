Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D672C43331
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 10:44:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59FDF206F5
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 10:44:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UujYwGGr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388030AbgDBKox (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 06:44:53 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:32919 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728612AbgDBKow (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 06:44:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585824291;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EziteWbH1lD47MmLWhfo2eogYuPlqT+pPp28I6LSJEc=;
        b=UujYwGGrO8SB0Ev0uFxfkGJdFrzzsT9crvRyWiORyVkxL1vt/UKdEV9b4gsTANnO5/AE7k
        t4jGfaLeYWgKOHrz7UByilusbQgnDvrw/rh3HkdxLbP69snTdHqYSfCOTTKq8z6R2DA9XU
        0sjPiByVIHJuHgWSKbGU0jchjBMK1/M=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-54-yC6uAPWzMJCdUC80Xg6RQA-1; Thu, 02 Apr 2020 06:44:47 -0400
X-MC-Unique: yC6uAPWzMJCdUC80Xg6RQA-1
Received: by mail-wm1-f70.google.com with SMTP id b199so467994wmb.4
        for <linux-kernel@vger.kernel.org>; Thu, 02 Apr 2020 03:44:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to;
        bh=EziteWbH1lD47MmLWhfo2eogYuPlqT+pPp28I6LSJEc=;
        b=H9Sl5V6x3qA/9fPeRK019c+bjhqI7SvXkDSMNmUyIZdT6W2KQkI+V+Erhzc13xgt2Z
         JhO9QcMzxe9vD+oY2f1xuNk0qyzqzBZSbj0Ms8p/Xz40QwMjzA77u38kxnSWBTmZdiiI
         v2Kklmu6X+SYBOf5lZ87MnePdX0oZF7bs2nlgJYKJafG+sL7zhLQ8dv0njFEvt+kd5AJ
         uEjRI7d+3DZiyhEaTEUu6tZGL9M6dVIQBRrgI8QFQY7IxyTU2YvPKBgpTcAPZ82lLQjY
         0yQ9yr7HVqhdFm2FORB7fh7t9GKgcNx7wWOMPwadqfQ8maLuNc/t/lXrawEP+cL3Rndr
         Zp8A==
X-Gm-Message-State: AGi0Puaz4u7TCF7cDtlwb5z8CMrnDxwtZgUymy/PZCH/CSezyLFLmjue
        Lr7/1Y/b6ZtVQ1VgCm5TTBvk0m/loNUEbuVEoLaK9fRy+s8ddLf2OD1a6ofWNb6j73xFEaYRhn0
        sNHYl0iRyjGSaUCZdWkipV2e1
X-Received: by 2002:a1c:2b43:: with SMTP id r64mr2939544wmr.77.1585824285814;
        Thu, 02 Apr 2020 03:44:45 -0700 (PDT)
X-Google-Smtp-Source: APiQypJ9ws7eVPM/42ryIkhOgIBcaE4xRcNVfISXRXL+Z0OVXAiOitgqXJ/x0SrofX/9qdOtEgM8cg==
X-Received: by 2002:a1c:2b43:: with SMTP id r64mr2939522wmr.77.1585824285488;
        Thu, 02 Apr 2020 03:44:45 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:1868:42dd:216c:2c09? ([2001:b07:6468:f312:1868:42dd:216c:2c09])
        by smtp.gmail.com with ESMTPSA id u13sm7151479wru.88.2020.04.02.03.44.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Apr 2020 03:44:44 -0700 (PDT)
Subject: Re: linux-next: manual merge of the kvm tree with Linus' tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>, KVM <kvm@vger.kernel.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Haiwei Li <lihaiwei.kernel@gmail.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Joerg Roedel <jroedel@suse.de>
References: <20200402133637.296e70a9@canb.auug.org.au>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <649ebb8f-d8c4-b893-eddb-9c0a00bf30e0@redhat.com>
Date:   Thu, 2 Apr 2020 12:44:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200402133637.296e70a9@canb.auug.org.au>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="Y2MKUGxe9yiNE6fExtMIK6kFebhy1L5tT"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Y2MKUGxe9yiNE6fExtMIK6kFebhy1L5tT
Content-Type: multipart/mixed; boundary="4tmLlM9A6UvIfiuvICLZvZtBPoFLHPGx7"

--4tmLlM9A6UvIfiuvICLZvZtBPoFLHPGx7
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 02/04/20 04:36, Stephen Rothwell wrote:
> Hi all,
>=20
> Today's linux-next merge of the kvm tree got a conflict in:
>=20
>   arch/x86/kvm/svm/svm.c
>=20
> between commits:
>=20
>   aaca21007ba1 ("KVM: SVM: Fix the svm vmexit code for WRMSR")
>   2da1ed62d55c ("KVM: SVM: document KVM_MEM_ENCRYPT_OP, let userspace d=
etect if SEV is available")
>   2e2409afe5f0 ("KVM: SVM: Issue WBINVD after deactivating an SEV guest=
")
>=20
> from Linus' tree and commits:
>=20
>   83a2c705f002 ("kVM SVM: Move SVM related files to own sub-directory")=

>   41f08f0506c0 ("KVM: SVM: Move SEV code to separate file")
>=20
> (at least)
>=20
> from the kvm tree.
>=20
> Its a bit of a pain this code movement appearing during the merge
> window.  Is it really intended for v5.7?

I'll send two separate pull requests to Linus so that he doesn't see the
issues introduced by the code movement.

Paolo

> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tre=
e
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularl=
y
> complex conflicts.
>=20
> diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
> index 621a36702636..2be5bbae3a40 100644
> --- a/arch/x86/kvm/svm/svm.c
> +++ b/arch/x86/kvm/svm/svm.c
> @@ -34,6 +34,7 @@
>  #include <asm/kvm_para.h>
>  #include <asm/irq_remapping.h>
>  #include <asm/spec-ctrl.h>
> +#include <asm/cpu_device_id.h>
> =20
>  #include <asm/virtext.h>
>  #include "trace.h"
> @@ -47,7 +48,7 @@ MODULE_LICENSE("GPL");
> =20
>  #ifdef MODULE
>  static const struct x86_cpu_id svm_cpu_id[] =3D {
> -	X86_FEATURE_MATCH(X86_FEATURE_SVM),
> +	X86_MATCH_FEATURE(X86_FEATURE_SVM, NULL),
>  	{}
>  };
>  MODULE_DEVICE_TABLE(x86cpu, svm_cpu_id);
> @@ -3715,7 +3716,8 @@ static void svm_handle_exit_irqoff(struct kvm_vcp=
u *vcpu,
>  	enum exit_fastpath_completion *exit_fastpath)
>  {
>  	if (!is_guest_mode(vcpu) &&
> -		to_svm(vcpu)->vmcb->control.exit_code =3D=3D EXIT_REASON_MSR_WRITE)
> +	    to_svm(vcpu)->vmcb->control.exit_code =3D=3D SVM_EXIT_MSR &&
> +	    to_svm(vcpu)->vmcb->control.exit_info_1)
>  		*exit_fastpath =3D handle_fastpath_set_msr_irqoff(vcpu);
>  }
>=20
> diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
> index 3ef57dee48cc..0e3fc311d7da 100644
> --- a/arch/x86/kvm/svm/sev.c
> +++ b/arch/x86/kvm/svm/sev.c
> @@ -920,6 +920,9 @@ int svm_mem_enc_op(struct kvm *kvm, void __user *ar=
gp)
>  	if (!svm_sev_enabled())
>  		return -ENOTTY;
> =20
> +	if (!argp)
> +		return 0;
> +
>  	if (copy_from_user(&sev_cmd, argp, sizeof(struct kvm_sev_cmd)))
>  		return -EFAULT;
> =20
> @@ -1030,14 +1033,6 @@ find_enc_region(struct kvm *kvm, struct kvm_enc_=
region *range)
>  static void __unregister_enc_region_locked(struct kvm *kvm,
>  					   struct enc_region *region)
>  {
> -	/*
> -	 * The guest may change the memory encryption attribute from C=3D0 ->=
 C=3D1
> -	 * or vice versa for this memory range. Lets make sure caches are
> -	 * flushed to ensure that guest data gets written into memory with
> -	 * correct C-bit.
> -	 */
> -	sev_clflush_pages(region->pages, region->npages);
> -
>  	sev_unpin_memory(kvm, region->pages, region->npages);
>  	list_del(&region->list);
>  	kfree(region);
> @@ -1062,6 +1057,13 @@ int svm_unregister_enc_region(struct kvm *kvm,
>  		goto failed;
>  	}
> =20
> +	/*
> +	 * Ensure that all guest tagged cache entries are flushed before
> +	 * releasing the pages back to the system for use. CLFLUSH will
> +	 * not do this, so issue a WBINVD.
> +	 */
> +	wbinvd_on_all_cpus();
> +
>  	__unregister_enc_region_locked(kvm, region);
> =20
>  	mutex_unlock(&kvm->lock);
> @@ -1083,6 +1085,13 @@ void sev_vm_destroy(struct kvm *kvm)
> =20
>  	mutex_lock(&kvm->lock);
> =20
> +	/*
> +	 * Ensure that all guest tagged cache entries are flushed before
> +	 * releasing the pages back to the system for use. CLFLUSH will
> +	 * not do this, so issue a WBINVD.
> +	 */
> +	wbinvd_on_all_cpus();
> +
>  	/*
>  	 * if userspace was terminated before unregistering the memory region=
s
>  	 * then lets unpin all the registered memory.
>=20



--4tmLlM9A6UvIfiuvICLZvZtBPoFLHPGx7--

--Y2MKUGxe9yiNE6fExtMIK6kFebhy1L5tT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEE8TM4V0tmI4mGbHaCv/vSX3jHroMFAl6FwhsACgkQv/vSX3jH
roPzhAf9HwI9/dqrFuR/k0dEdYmbqQwkD5sztWEDtP7BgQSQrW+r8gkfMgxcUHtG
GTWFo6ByUXs17vkhsWE22aidSN/NHIZLl/xU+9vKtI+52qLrJxHHQHKLahkP+ENS
VnvjQa8JN3U9OIGpMUwzLFKZsVpyrHkVsRflKOFECvhFncugUDW6BSvuPWmZgD37
/OGvTxjuD1Kkw+yGGHo5wbcAUC15c423yAFelF7fF1QlwWD16sn61XrwqlaMPD5p
VZSuEkJtt3nEDQ9aNMzChC2Ldb3mrT9yqDsHBfkOHaFt5eoflxMXCrOpqJ2V3RAa
8tLe9FwGZe+1kUAIP2to1qNswEZHTQ==
=DWPw
-----END PGP SIGNATURE-----

--Y2MKUGxe9yiNE6fExtMIK6kFebhy1L5tT--

