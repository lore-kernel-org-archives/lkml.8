Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F20FC28CBC
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 17:52:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C12B20663
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 17:52:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O030j6FV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729567AbgEFRwM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 13:52:12 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:30748 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728682AbgEFRwL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 13:52:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588787530;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PccgT4HcaWivoQJELX6s064gYPyC7GJ8hEzArxp6bSo=;
        b=O030j6FVTQFKVjU4FIp86y4Ea9RA3Jl3NIv4fOgMDghEvVgknKp2TYCE4VGqWRE4Yj+aci
        sNvKadbKN2RBGhTpWdqXlXKuYTBNO8jH5712rpixm9p+KPRktEDmcXydKhUdwh5crEASpS
        O5Wx5kwI7CxBm+a8B6X/RJblhvFsZ70=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-18-_9hIsZFvO4CVbuqmJET5Rg-1; Wed, 06 May 2020 13:52:08 -0400
X-MC-Unique: _9hIsZFvO4CVbuqmJET5Rg-1
Received: by mail-qv1-f72.google.com with SMTP id dh14so3110199qvb.4
        for <linux-kernel@vger.kernel.org>; Wed, 06 May 2020 10:52:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PccgT4HcaWivoQJELX6s064gYPyC7GJ8hEzArxp6bSo=;
        b=tMPG4RitiSTP41ercvxn0qt3UsiH+uUBtrs7oQmYokCa3VRc74jqjM5mnVVozmDfx5
         /eCdcwPhOAWCTC6msrjeQ654VufeM3mFjKCdYpuvZa2a975iwQRAuyJaqCw9d8MzBmkA
         VeTajHky6/acat9hoTPkqXhrPyx1ocQIKbG6XN3akL5wpe1LtZE9hofdwaZKUlEn2BYI
         5h9om6I/xP8JYzL3bzAX7bJNRRSIE23gRDXTFoU1GYMaBjrXdoPOWr9hSp0+B7Zi01FR
         yw/zWeY/rqeJ4wlMC+b44ecpMcH4tfpsO9gzZ9X4bNfGuKNNwO2pATuRX1H8eoNvSn4j
         l7zA==
X-Gm-Message-State: AGi0PuaxZazFEjzY/x/PQttSwGvMiaDZ4PUf8koYFTo4LZtI4de449ee
        w22KtHHQ4al296zVLUQ0iuU4pmk9/KqD0R66Zk2ve9LJRnffecVUEtQOPt+HrhOfU0mRrXVj9Sr
        o7uiRB/AMNUo1JRiyXkHc14w0
X-Received: by 2002:a0c:eb0e:: with SMTP id j14mr8833832qvp.230.1588787528179;
        Wed, 06 May 2020 10:52:08 -0700 (PDT)
X-Google-Smtp-Source: APiQypIEJqjL0kBwvh6GJDj8Y+OGS2ZJU8ac0dpoSTDogz807A439jh3hQqMmnsT0hI1Wj4xBIwqBw==
X-Received: by 2002:a0c:eb0e:: with SMTP id j14mr8833802qvp.230.1588787527914;
        Wed, 06 May 2020 10:52:07 -0700 (PDT)
Received: from xz-x1 ([2607:9880:19c0:32::2])
        by smtp.gmail.com with ESMTPSA id k43sm2237118qtk.67.2020.05.06.10.52.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2020 10:52:07 -0700 (PDT)
Date:   Wed, 6 May 2020 13:52:06 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Sean Christopherson <sean.j.christopherson@intel.com>
Subject: Re: [PATCH 7/9] KVM: x86: simplify dr6 accessors in kvm_x86_ops
Message-ID: <20200506175206.GQ6299@xz-x1>
References: <20200506111034.11756-1-pbonzini@redhat.com>
 <20200506111034.11756-8-pbonzini@redhat.com>
 <20200506160623.GO6299@xz-x1>
 <2d44c75f-00df-3cae-31a8-982a0b95f0b0@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2d44c75f-00df-3cae-31a8-982a0b95f0b0@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 06, 2020 at 06:09:23PM +0200, Paolo Bonzini wrote:
> On 06/05/20 18:06, Peter Xu wrote:
> > On Wed, May 06, 2020 at 07:10:32AM -0400, Paolo Bonzini wrote:
> >> kvm_x86_ops.set_dr6 is only ever called with vcpu->arch.dr6 as the
> >> second argument, and for both SVM and VMX the VMCB value is kept
> >> synchronized with vcpu->arch.dr6 on #DB; we can therefore remove the
> >> read accessor.
> >>
> >> For the write accessor we can avoid the retpoline penalty on Intel
> >> by accepting a NULL value and just skipping the call in that case.
> >>
> >> Suggested-by: Sean Christopherson <sean.j.christopherson@intel.com>
> >> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> > (I think this patch and the previous one seem to be the same as the previous
> >  version.  Anyway...)
> 
> Yes, I placed them here because they are needed to solve the SVM bugs in
> patch 8.  Sorry for not adding your Reviewed-by.

That's not a problem to me. :) Instead I'm more afraid of not noticing some
trivial difference in the patch comparing to the last one.

Thanks,

-- 
Peter Xu

