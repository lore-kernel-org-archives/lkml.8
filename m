Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3DE3C28CBC
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 16:06:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 79385208DB
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 16:06:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WSM959kN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730015AbgEFQG3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 12:06:29 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:56716 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729418AbgEFQG3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 12:06:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588781188;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Z+3t3+wbayhKG8ZXNezVyF4RkQnz2wqH6eG7rnJ3rL4=;
        b=WSM959kNlX54aVlI9ICmv4C0Z+n07VzejcL6swFopxJKyFEW2SCUWoxTZZHWtmhhZLr2JV
        BDzgvoqKXd8HoQEMfZDQm0QabLQZjy0nO4DGck7wmwSxOusLL7h6PzbTMkYl8vZMVeC3GD
        F/hP1rRicAhooBUmw5dzLUUmH9uc9yI=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-70-PAALFTapOl-0qmtUMm-N-w-1; Wed, 06 May 2020 12:06:25 -0400
X-MC-Unique: PAALFTapOl-0qmtUMm-N-w-1
Received: by mail-qv1-f72.google.com with SMTP id p12so2553391qvm.21
        for <linux-kernel@vger.kernel.org>; Wed, 06 May 2020 09:06:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Z+3t3+wbayhKG8ZXNezVyF4RkQnz2wqH6eG7rnJ3rL4=;
        b=E3NYKv0SaLDwmdbCL7U8VNnqspq7L90juAdrj8QAo3nPuFY80JdZXuMG1UpjU+Cvqf
         9RRjn5ZX9rHmZCbQapDqvF25oC0MPdd6/Ev0mxCtCFEEq/ZlZrBsZDLN+UQ9AffKhqh4
         CaMGF9wgONQr69aszhDldIhtcdy2BcGYbJE+xzi6h/RBNy4js7b4PsRy30mabfNYUYgV
         x+toctwpacuMbLEOXsdM0sHXd1VyCuAj/t29ZZyTuaX43DEhFp/NGWPj2tT73+3PYMca
         DxdJ76twoU6YTG3yOfnquscwV0qj8wsR7fvJ+SOq8zm4dU11R53VmkfdXT8nVWPzOko7
         FjKQ==
X-Gm-Message-State: AGi0PuZtxF2zXj6NuCEyWnqI6neVzdASuBg8ihkYJ3EXS4bbSceJXwzD
        +7UnBC0De2BY40kUJegoCissQs1GmdyVhF3QDWjtYVx/PvK33LAZDecJceuVD732Sh6A+C7dQhs
        3zXMoDBLHylBnuRAeumlJJKB0
X-Received: by 2002:a37:688c:: with SMTP id d134mr9717421qkc.450.1588781185497;
        Wed, 06 May 2020 09:06:25 -0700 (PDT)
X-Google-Smtp-Source: APiQypLrcd8xS+ttqTUL6EUvZBMmsM8/E0ENKYL/qimkT3zmv3LL8KFrfLcKfTeF0a+trZnV5sTZNw==
X-Received: by 2002:a37:688c:: with SMTP id d134mr9717398qkc.450.1588781185252;
        Wed, 06 May 2020 09:06:25 -0700 (PDT)
Received: from xz-x1 ([2607:9880:19c0:32::2])
        by smtp.gmail.com with ESMTPSA id a27sm1912587qtb.26.2020.05.06.09.06.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2020 09:06:24 -0700 (PDT)
Date:   Wed, 6 May 2020 12:06:23 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Sean Christopherson <sean.j.christopherson@intel.com>
Subject: Re: [PATCH 7/9] KVM: x86: simplify dr6 accessors in kvm_x86_ops
Message-ID: <20200506160623.GO6299@xz-x1>
References: <20200506111034.11756-1-pbonzini@redhat.com>
 <20200506111034.11756-8-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200506111034.11756-8-pbonzini@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 06, 2020 at 07:10:32AM -0400, Paolo Bonzini wrote:
> kvm_x86_ops.set_dr6 is only ever called with vcpu->arch.dr6 as the
> second argument, and for both SVM and VMX the VMCB value is kept
> synchronized with vcpu->arch.dr6 on #DB; we can therefore remove the
> read accessor.
> 
> For the write accessor we can avoid the retpoline penalty on Intel
> by accepting a NULL value and just skipping the call in that case.
> 
> Suggested-by: Sean Christopherson <sean.j.christopherson@intel.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

(I think this patch and the previous one seem to be the same as the previous
 version.  Anyway...)

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu

