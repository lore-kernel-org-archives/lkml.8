Return-Path: <SRS0=fqu/=3Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0D64C35247
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 22:28:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7150C214AF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 22:28:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iApYAl9y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727491AbgBEW2h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Feb 2020 17:28:37 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:43987 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727441AbgBEW2h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 17:28:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580941716;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xN2n9jkJvkSR0RH/zWMkRvEj2quGdHH6HsawLgUOQOY=;
        b=iApYAl9yv6I1Bh97IB2lo6sf8+RYIKr6mH/HP0P4pzfLX6KSdCc8PFmzIGAGDzcArmo8Xd
        /1FT0cx4FBvoNU89Fb9cYotDIApzO5vHrzfI/84L2xEbrtPPouyn9IE8FS5CenbD6PnzXu
        0MeOvtZOe5Z63znWPoCl1MoIaDZ4xe4=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-281-R0wBmhagMhqQmveTy_dsVw-1; Wed, 05 Feb 2020 17:28:34 -0500
X-MC-Unique: R0wBmhagMhqQmveTy_dsVw-1
Received: by mail-qv1-f70.google.com with SMTP id g15so2434712qvq.20
        for <linux-kernel@vger.kernel.org>; Wed, 05 Feb 2020 14:28:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xN2n9jkJvkSR0RH/zWMkRvEj2quGdHH6HsawLgUOQOY=;
        b=WOPHiHxxF6KhITwOSv4VdhqsBYoExoTFDnPFvBapJFFRDgFdi3M3A96sdKkyOfLnlG
         DI/4BaIhOuNgzP+VbRn/JP5MAVxX8IkxaM5Lb2trvO0mAG8QPtrTitYYpppahHp/VTFJ
         cWvWfZeQb2CMrShVMVZdbZp2c1QVdgEsYNfhQN2qUAJ9XLICfS5463pkOQEYp7qHNRiT
         33tAjk5sRyHetmFfQHvnvGYbrqB0F/xc4alccs2bG/d2hQxxbKFMUF7j643fs8Pvimkr
         BflpsxjIHl0GAbYZBUkQNYMu6o+2gJ92eqHKz8MwzmPMa6ZbcuhF0RFsiBLmIkX2OOeN
         tr3Q==
X-Gm-Message-State: APjAAAW4NdwgYzbidRsGxDM2J1vzodVZYNk9R57q0zMgcwwB2JZKPB+E
        I3fS7mQXOpMNlOqsTPoWg3G24TaZtsnJvzkapP7P3VV0IsUWWwqTlTLRGmyaAe0L7BNrwSoouBD
        ymTLP43I08YGRhAH/ldiUMPFp
X-Received: by 2002:a05:620a:a46:: with SMTP id j6mr13683qka.164.1580941714103;
        Wed, 05 Feb 2020 14:28:34 -0800 (PST)
X-Google-Smtp-Source: APXvYqzgDC/fBZ4GnRbk3BQEXE+eWIhbbieAb4nE+MGEKdPSLikBImrRnbk5qAuaCcwE1K66PslinA==
X-Received: by 2002:a05:620a:a46:: with SMTP id j6mr13650qka.164.1580941713724;
        Wed, 05 Feb 2020 14:28:33 -0800 (PST)
Received: from xz-x1 ([2607:9880:19c8:32::2])
        by smtp.gmail.com with ESMTPSA id c184sm503353qke.118.2020.02.05.14.28.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2020 14:28:33 -0800 (PST)
Date:   Wed, 5 Feb 2020 17:28:29 -0500
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
Subject: Re: [PATCH v5 03/19] KVM: Don't free new memslot if allocation of
 said memslot fails
Message-ID: <20200205222829.GF387680@xz-x1>
References: <20200121223157.15263-1-sean.j.christopherson@intel.com>
 <20200121223157.15263-4-sean.j.christopherson@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200121223157.15263-4-sean.j.christopherson@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 21, 2020 at 02:31:41PM -0800, Sean Christopherson wrote:
> The two implementations of kvm_arch_create_memslot() in x86 and PPC are
> both good citizens and free up all local resources if creation fails.
> Return immediately (via a superfluous goto) instead of calling
> kvm_free_memslot().
> 
> Note, the call to kvm_free_memslot() is effectively an expensive nop in
> this case as there are no resources to be freed.

(I failed to understand why that is expensive.. but the change looks OK)

> 
> No functional change intended.
> 
> Acked-by: Christoffer Dall <christoffer.dall@arm.com>
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu

