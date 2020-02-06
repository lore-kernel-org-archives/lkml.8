Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5068C33CAC
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 16:29:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9999A217BA
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 16:29:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Nx72f++G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727788AbgBFQ3a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 11:29:30 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:43460 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727358AbgBFQ33 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 11:29:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581006568;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BT971wG6wPhX7VJFd1sOcOxmL5huobHf2O2WL2kB92A=;
        b=Nx72f++GAN4ixyRhhAyya/aJXGxMt1oqFXpyVkeZ1M5WDbTLstmy2Hj+g5al4tEChYpAW/
        aehl+Fe552ymxzBGMALt7XxmZRkOLrByYpS6JbanzVxfIlPCvMz2Cb8wuJvja0z/sD9HsD
        BGeZ35j5eL0O8jPDiYGsTOyUM+ipPy8=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-161-wnAPhEPNNUarMsd9-Khi0Q-1; Thu, 06 Feb 2020 11:29:26 -0500
X-MC-Unique: wnAPhEPNNUarMsd9-Khi0Q-1
Received: by mail-qk1-f199.google.com with SMTP id q135so3918358qke.22
        for <linux-kernel@vger.kernel.org>; Thu, 06 Feb 2020 08:29:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BT971wG6wPhX7VJFd1sOcOxmL5huobHf2O2WL2kB92A=;
        b=cfnDlkFMVpbiAUUf8VJAy0tTkIG2tCjxeAiQI/zP0YcrySDnw29/byBW11gsX2oHO3
         CH4gzxcDEKecpCpCGkoJso8ekNeyyxkKAQEcluw6+kkVBUzJ79vea5FpEQiCVFtpS5fH
         CXJwwmMMIOWq/TDpoSRpH4AA4nKEPZ758ohxkMESO2a4HX1n0zGy51pYLVbFqj2vInAp
         yiKKdmzPsYcQi6P6tHGOlJiO/aawTWHGWE//s7diLWdR0r2OJ+VzevQQIC67t/kRbFxr
         AEW559JIZ71Lw+Cf0FvY+F9+9Y/26PMsmmd2Ftxx+hm4rl1aWHqKS52QzSfyvyQfrcDh
         n/Wg==
X-Gm-Message-State: APjAAAWrsC0BxJWd2gHPPXii+tkGdf7QXYpFwVHCQvMvJPR/EBWWqu26
        t0XQ+Q/+1fIPhdz3mESs5PoKmiS6mKLSnZzGT+PjdyjhKQLsGWLWYdseazF7ARsgQruJEyrinHN
        Uxh0KYq6d/GwCZZI0MXE7anOc
X-Received: by 2002:a37:94d:: with SMTP id 74mr3342074qkj.352.1581006566409;
        Thu, 06 Feb 2020 08:29:26 -0800 (PST)
X-Google-Smtp-Source: APXvYqw79o/OSwP8qcG9zRkYGvX/+TD2xb8/Jp5SJeC8yu8obGrRcXecqs/KUsVKwfDvaLoqKhSpHg==
X-Received: by 2002:a37:94d:: with SMTP id 74mr3342054qkj.352.1581006566202;
        Thu, 06 Feb 2020 08:29:26 -0800 (PST)
Received: from xz-x1 ([2607:9880:19c8:32::2])
        by smtp.gmail.com with ESMTPSA id o55sm1966271qtf.46.2020.02.06.08.29.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2020 08:29:25 -0800 (PST)
Date:   Thu, 6 Feb 2020 11:29:22 -0500
From:   Peter Xu <peterx@redhat.com>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Paul Mackerras <paulus@ozlabs.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-mips@vger.kernel.org, kvm@vger.kernel.org,
        kvm-ppc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kvmarm@lists.cs.columbia.edu, linux-kernel@vger.kernel.org,
        Christoffer Dall <christoffer.dall@arm.com>,
        Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Subject: Re: [PATCH v5 13/19] KVM: Simplify kvm_free_memslot() and all its
 descendents
Message-ID: <20200206162922.GD695333@xz-x1>
References: <20200121223157.15263-1-sean.j.christopherson@intel.com>
 <20200121223157.15263-14-sean.j.christopherson@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200121223157.15263-14-sean.j.christopherson@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 21, 2020 at 02:31:51PM -0800, Sean Christopherson wrote:
> Now that all callers of kvm_free_memslot() pass NULL for @dont, remove
> the param from the top-level routine and all arch's implementations.
> 
> No functional change intended.
> 
> Tested-by: Christoffer Dall <christoffer.dall@arm.com>
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu

