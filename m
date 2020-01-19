Return-Path: <SRS0=pPEE=3I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3255BC3F68F
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jan 2020 09:01:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 098742073A
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jan 2020 09:01:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VQzyKFu1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726827AbgASJB4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Jan 2020 04:01:56 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:41932 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726538AbgASJB4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jan 2020 04:01:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579424514;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=E6uOIXtplXczZ5J5TTB/qREzR/gOXMQuJdW4hYcAmw0=;
        b=VQzyKFu1GsGzUuvdAjEq6/rO37VlFG7JPt7hRAmZpZv/kggJlkYrVG95MubkIva7tho5+x
        UPPxOUsxese6BqsLeg5JbzfDvkoR0eQFtQyEj91RbbHm2ABe0Yx8uBO0uNiphnewGH29A9
        7KXCL0E2D+mH6AVvtQhG/nEr92eiqFs=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-111-3EcvR-bKNNaOE3BJA7iwbA-1; Sun, 19 Jan 2020 04:01:51 -0500
X-MC-Unique: 3EcvR-bKNNaOE3BJA7iwbA-1
Received: by mail-wr1-f70.google.com with SMTP id z14so12718604wrs.4
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jan 2020 01:01:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=E6uOIXtplXczZ5J5TTB/qREzR/gOXMQuJdW4hYcAmw0=;
        b=SSFdjdghiGSp6YSLQsjYO09dIkMsGSBrPgQHkmjlZo9ZRG1t5bC61OxxN4+xJ4Xq9I
         bMCOAiePpDZzVu/9kSsD56F5ZnxYMntkwG0SCF7nlpRVA1YaQ6vqNElJAHJ2WqitnarL
         aHvf646nVsfqIC0NQ1+e2Ru8Muj4qtrhEvVvYvxpklqerZdMedJjNCGkk+9eFueyMOeM
         cbpa8qqJDyf0302ez6FFwhpbvBndD2tp/cQ0E3yB9E8BVtH2HBnL/iBEucHgXo3M5Raz
         qgusnJrgPielfA0RhtGGuF9/hkPqt4bxT5XoV/GwLpxjHZQ/q6XGkx11eJC/V+o5AzLh
         KHEQ==
X-Gm-Message-State: APjAAAXw/nIfsxgD9PYqPfiBPU/Es6qMUq/Q+HsUhi1mEDffFhEnorDs
        b78cdDZfIw2rVXQMCBcwDQTaau9Uakv7sY9foE574R1Dd5CGxSedGArjNIpA3D+JIVgfHub+EBA
        LN6CV/jjiAXifDOt4vGZMdiqZ
X-Received: by 2002:a7b:cfc9:: with SMTP id f9mr13440816wmm.1.1579424510372;
        Sun, 19 Jan 2020 01:01:50 -0800 (PST)
X-Google-Smtp-Source: APXvYqz9cwlUMerOGBaIsqCvwFOOnm3YB+1U2JN4fr/0bbA4Yr+y+255aVffL/QuYKCXhICbVON19w==
X-Received: by 2002:a7b:cfc9:: with SMTP id f9mr13440787wmm.1.1579424510181;
        Sun, 19 Jan 2020 01:01:50 -0800 (PST)
Received: from [192.168.10.150] ([93.56.166.5])
        by smtp.gmail.com with ESMTPSA id p17sm2900651wmk.30.2020.01.19.01.01.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 19 Jan 2020 01:01:49 -0800 (PST)
Subject: Re: [PATCH v3 09/21] KVM: X86: Don't track dirty for
 KVM_SET_[TSS_ADDR|IDENTITY_MAP_ADDR]
To:     Peter Xu <peterx@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Christophe de Dinechin <dinechin@redhat.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Yan Zhao <yan.y.zhao@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Kevin Kevin <kevin.tian@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>
References: <20200109145729.32898-1-peterx@redhat.com>
 <20200109145729.32898-10-peterx@redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <5af8e2ff-4bde-9652-fb25-4fe1f74daae2@redhat.com>
Date:   Sun, 19 Jan 2020 10:01:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20200109145729.32898-10-peterx@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/01/20 15:57, Peter Xu wrote:
> -int __x86_set_memory_region(struct kvm *kvm, int id, gpa_t gpa, u32 size)
> +/*
> + * If `uaddr' is specified, `*uaddr' will be returned with the
> + * userspace address that was just allocated.  `uaddr' is only
> + * meaningful if the function returns zero, and `uaddr' will only be
> + * valid when with either the slots_lock or with the SRCU read lock
> + * held.  After we release the lock, the returned `uaddr' will be invalid.
> + */

In practice the address is still protected by the refcount, isn't it?
Only destroying the VM could invalidate it.

Paolo

