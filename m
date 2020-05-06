Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E65DFC4724C
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 16:05:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE0A1208DB
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 16:05:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NJ3cssIf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729981AbgEFQFF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 12:05:05 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:58348 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729251AbgEFQFF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 12:05:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588781104;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EjQrx7huxOAEezjt1ZsltALd6iDUYrh3aKybbxhxR0E=;
        b=NJ3cssIfygfYCgqtfZVxFQudo9SFFMrtHP4WiYh1hqqt3xcJoTa1iagpbzehbe2JYcNY5R
        IylCrbLSROo06J1t/W9/LWAiVsoDCptixlx6WmJvehQPWgq27xfocL18CqJd8zuASlLwh/
        nvoUHVCZz25WUu+nQ8AeCxdf+1Y3Xd0=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-103-f-nY5IvCOK6R_BWaSYOY6Q-1; Wed, 06 May 2020 12:05:02 -0400
X-MC-Unique: f-nY5IvCOK6R_BWaSYOY6Q-1
Received: by mail-qt1-f200.google.com with SMTP id x24so3327134qta.4
        for <linux-kernel@vger.kernel.org>; Wed, 06 May 2020 09:05:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=EjQrx7huxOAEezjt1ZsltALd6iDUYrh3aKybbxhxR0E=;
        b=mfNxJEdWCkDHnDlNyzSC1uJrRQJMcXnfI0ATAQ5az2wgBNFsXt1pNagUZA2xmCEfVM
         fQQwlkN5sQXIV9hT6mi1VGy+Ok91uFm9hxYztONMAQM04JtiLZy6iGjbZAcdH91H6Su8
         jdwlSnGrP9kRhaVxrL0Bp0nIV+2OpAAJRzXSFJN/0SoXNhU4b/VK2ND6rMWewojQ6nuC
         TWdgLJPVSrhpG0RfGnCg6GwwPoKbyG0ZvkpZ660prWUa4biWhNs7+1QQW2I3ZuWrvySz
         7ErqyDMdX33jtcfEtFCR0dtAZQ6RqzrJAK716LZLF9hMmC93Rf+k1YNSXTBC0mJ24USQ
         lBrg==
X-Gm-Message-State: AGi0PuZwb0z2lILpIJmQ6QVUPr8ZsCR6/yZ2r+oUOEJ2TfwKvJLcd4aZ
        4qQg9LlpvJgGfk8VN8s3VXI5F83zVZGgA5dO7qz1tpOLloATPOCdNyMB/2+qa627W3FzOa2GD1Z
        gI4Ea1PC8oK2/2dL4C2RxJwwt
X-Received: by 2002:ac8:d86:: with SMTP id s6mr8814786qti.199.1588781101563;
        Wed, 06 May 2020 09:05:01 -0700 (PDT)
X-Google-Smtp-Source: APiQypIL0UQVhBLUOOXhtquJMMHvklh7J05are5WMG2EL+1MK+mNLkdxo7ZfxFE4DNlpfNv4qdNukg==
X-Received: by 2002:ac8:d86:: with SMTP id s6mr8814772qti.199.1588781101336;
        Wed, 06 May 2020 09:05:01 -0700 (PDT)
Received: from xz-x1 ([2607:9880:19c0:32::2])
        by smtp.gmail.com with ESMTPSA id k2sm1956414qta.39.2020.05.06.09.05.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2020 09:05:00 -0700 (PDT)
Date:   Wed, 6 May 2020 12:04:59 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Sean Christopherson <sean.j.christopherson@intel.com>
Subject: Re: [PATCH 6/9] KVM: SVM: keep DR6 synchronized with vcpu->arch.dr6
Message-ID: <20200506160459.GN6299@xz-x1>
References: <20200506111034.11756-1-pbonzini@redhat.com>
 <20200506111034.11756-7-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200506111034.11756-7-pbonzini@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 06, 2020 at 07:10:31AM -0400, Paolo Bonzini wrote:
> Ensure that the current value of DR6 is always available in vcpu->arch.dr6,
> so that the get_dr6 callback can just access vcpu->arch.dr6 and becomes
> redundant.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu

