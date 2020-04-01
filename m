Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C0A3C43331
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 23:24:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E56520719
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 23:24:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E70eYhBp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733290AbgDAXYH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 19:24:07 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:40446 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1732637AbgDAXYG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 19:24:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585783445;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AUx9a9NcckmBmbGmt8k9ozR5fOJNJ4SVtbmheE+GSig=;
        b=E70eYhBpdmDCfFB/yyKtMy/HpSVH+Uiz0C3lCATNO3ypdcqTlPjPO8i2nWzW46IWW6I4UX
        1AtIoDpwQAaiCvt1qq35SXqfpLz8TQIYiPkVBPfFbEtSZBzdU6LxEf/+Fmk7KYVCQW1LZf
        2E5ibijXGfEj8gYcC1h0tr6OfbF1oK0=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-120-lvLI-nbHP_OveMtOtw4_Nw-1; Wed, 01 Apr 2020 19:24:03 -0400
X-MC-Unique: lvLI-nbHP_OveMtOtw4_Nw-1
Received: by mail-qv1-f72.google.com with SMTP id dh19so1074698qvb.23
        for <linux-kernel@vger.kernel.org>; Wed, 01 Apr 2020 16:24:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=AUx9a9NcckmBmbGmt8k9ozR5fOJNJ4SVtbmheE+GSig=;
        b=DVr+ILUdcpNLuyojJgdOXQx8zxJvIMxM681AgTOAyR2lFNvc3ucm3h7yAvLp8n+Dhm
         9eytpFuEXhEWqCBVMpaqIpAgk6TaA8swVfQNYD+OuBcwo2i+7bAhv/sJ9lAXuikZWOwo
         DuD0lcAWvszBVwvF+RdYh9C3eXhn/SC0o1ezi6xREqXqAaFTXaGfd84t6qz+MLDL6MPq
         n1G39Sk3A6+u3WdKxbS9bdEqnLkVyy74pRbUyOkp6pLquZxqBn483EENRcMQzVJNv/Jo
         23m7zhkgK+faNad211znGmE9gM/FoBMCT371HMkVwPlykxJ0157UwKTuqtEmVPaQidRc
         m2yg==
X-Gm-Message-State: AGi0PuYh9rze9QRK7TEL+tcwB9ia2nHA3RTGilgV26xlp/H4DGqUbEbj
        fvI4j5RWcDH+W9O2s0yVyQ+9VgPPTtT9h8b9RGfmCKkmUWtBbSfQSihC8tAUHT+XS2RxEOS0YOl
        qnqjyBd6koM8QRNeET/ANk+eo
X-Received: by 2002:ac8:1c17:: with SMTP id a23mr205340qtk.239.1585783443329;
        Wed, 01 Apr 2020 16:24:03 -0700 (PDT)
X-Google-Smtp-Source: APiQypKs2sdWLelVFwa5wWDt7NfXNR0nWmfsLZw9a6O+nx9rOQNylkUrMsr/Rn+mFQtaWUda9LkQzA==
X-Received: by 2002:ac8:1c17:: with SMTP id a23mr205318qtk.239.1585783443115;
        Wed, 01 Apr 2020 16:24:03 -0700 (PDT)
Received: from xz-x1 ([2607:9880:19c0:32::2])
        by smtp.gmail.com with ESMTPSA id y41sm2502266qtc.72.2020.04.01.16.24.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2020 16:24:02 -0700 (PDT)
Date:   Wed, 1 Apr 2020 19:24:21 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Andrew Jones <drjones@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Kevin Tian <kevin.tian@intel.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Christophe de Dinechin <dinechin@redhat.com>,
        Yan Zhao <yan.y.zhao@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>
Subject: Re: [PATCH v8 11/14] KVM: selftests: Introduce after_vcpu_run hook
 for dirty log test
Message-ID: <20200401232421.GA7174@xz-x1>
References: <20200331190000.659614-1-peterx@redhat.com>
 <20200331190000.659614-12-peterx@redhat.com>
 <20200401070322.yqdp5g2amzlbftk6@kamzik.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200401070322.yqdp5g2amzlbftk6@kamzik.brq.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 01, 2020 at 09:03:22AM +0200, Andrew Jones wrote:
> On Tue, Mar 31, 2020 at 02:59:57PM -0400, Peter Xu wrote:
> > Provide a hook for the checks after vcpu_run() completes.  Preparation
> > for the dirty ring test because we'll need to take care of another
> > exit reason.
> > 
> > Since at it, drop the pages_count because after all we have a better
> > summary right now with statistics, and clean it up a bit.
> 
> I don't see what you mean by "drop the pages_count", because it's still
> there. But otherwise
> 
> Reviewed-by: Andrew Jones <drjones@redhat.com>

I think the pages_count was dropped in some versions, at least the 1st
version when I wrote the commit, but it must have went back during one
of the rebases upon dirty_log_test.c...  To make it simple, I'll just
remove this paragraph and pick the r-b (assuming it's valid with that).

Thanks,

-- 
Peter Xu

