Return-Path: <SRS0=fqu/=3Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A50BDC35247
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 15:46:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77C8A218AC
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 15:46:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Hm+Z6gb+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727398AbgBEPq3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Feb 2020 10:46:29 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:24404 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726748AbgBEPq3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 10:46:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580917588;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FENJb9w+KXU/1rciBA47jt6l+2Cs5jKyIe0GXYrVUug=;
        b=Hm+Z6gb+xtW1Uo9bp58LQnRaEVt9Z+2PR9zkMAS5Wclo3u/wirne5nJX+JxJHV7tPo06Q4
        CEueME7yTGrokIKT206uMUGGl2pGbQdsUU2OgBn6tkPxqW6sfH9UdRHkrSD0zJPdWyQWlA
        WQhZGZJPkkuZki4SxYOfVg3DcwE9XXY=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-287-_DCIdZCjNt-MlqwAOaETyw-1; Wed, 05 Feb 2020 10:46:21 -0500
X-MC-Unique: _DCIdZCjNt-MlqwAOaETyw-1
Received: by mail-qv1-f70.google.com with SMTP id v3so1739557qvm.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Feb 2020 07:46:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FENJb9w+KXU/1rciBA47jt6l+2Cs5jKyIe0GXYrVUug=;
        b=BuTnQPzvq/2UGBFNsWZQHprPoQq9BIfZIriZV5ccsNCfCYu4S3O8fKDK4MWIC0iyMo
         5A5AhjLf9v08LvDrHgiRdJ1MqBAnpqK8F2Yxez/RVzD2nnyGClJDPpmQ4RWOssrUmatJ
         pt19ctjzLOPirYEWMZSWnuZsI94QYsADHhSWQShTPq6WfYI1fgtykvcAPI0klYWPJbTO
         MrakDDFKF97DqgoovKB6pAfOzOsTqe+PYdhjQce6JxFI/0bLk75Qh4edlrApAGCttby4
         15bOl6Kq8cKahxsFdv/sEZaz7c1yqAdRHX8F0rLMgWcSuIs4U8Xg9/xYPU/Fvjbw9rKj
         UrXQ==
X-Gm-Message-State: APjAAAXMMhEXGSnpXOIJ1k6co82GkIejOO7vzJlHHKMxp80Ro/vqmjTZ
        9S0Dm1aEIdkgzE6GlaljeVHLODtRJHp2JfcHX8LZ3O052WYY+aM2ge2Wi0i2ZF2WEQeq5yroHl7
        KF1W0H/BXSgYWeXh8XlPJ4mhJ
X-Received: by 2002:ac8:2ffa:: with SMTP id m55mr34039445qta.189.1580917581055;
        Wed, 05 Feb 2020 07:46:21 -0800 (PST)
X-Google-Smtp-Source: APXvYqzx4Pfhud7vNCt+/3W0RLYr4p1bUCrbt1Ji+vkPYYmsGcIGHC/CXq7YNni1H+s1Bh96VdATBw==
X-Received: by 2002:ac8:2ffa:: with SMTP id m55mr34039412qta.189.1580917580750;
        Wed, 05 Feb 2020 07:46:20 -0800 (PST)
Received: from xz-x1 ([2607:9880:19c8:32::2])
        by smtp.gmail.com with ESMTPSA id k5sm995810qkk.117.2020.02.05.07.46.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2020 07:46:19 -0800 (PST)
Date:   Wed, 5 Feb 2020 10:46:17 -0500
From:   Peter Xu <peterx@redhat.com>
To:     Andrew Jones <drjones@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        dinechin@redhat.com, sean.j.christopherson@intel.com,
        pbonzini@redhat.com, jasowang@redhat.com, yan.y.zhao@intel.com,
        mst@redhat.com, kevin.tian@intel.com, alex.williamson@redhat.com,
        dgilbert@redhat.com, vkuznets@redhat.com
Subject: Re: [PATCH 10/14] KVM: selftests: Use a single binary for
 dirty/clear log test
Message-ID: <20200205154617.GA378317@xz-x1>
References: <20200205025105.367213-1-peterx@redhat.com>
 <20200205025842.367575-1-peterx@redhat.com>
 <20200205025842.367575-7-peterx@redhat.com>
 <20200205092852.vjskgirqlnm5ebtv@kamzik.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200205092852.vjskgirqlnm5ebtv@kamzik.brq.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 05, 2020 at 10:28:52AM +0100, Andrew Jones wrote:
> On Tue, Feb 04, 2020 at 09:58:38PM -0500, Peter Xu wrote:
> > Remove the clear_dirty_log test, instead merge it into the existing
> > dirty_log_test.  It should be cleaner to use this single binary to do
> > both tests, also it's a preparation for the upcoming dirty ring test.
> > 
> > The default test will still be the dirty_log test.  To run the clear
> > dirty log test, we need to specify "-M clear-log".
> 
> How about keeping most of these changes, which nicely clean up the
> #ifdefs, but also keeping the separate test, which I think is the
> preferred way to organize and execute selftests. We can use argv[0]
> to determine which path to take rather than a command line parameter.

Hi, Drew,

How about we just create a few selftest links that points to the same
test binary in Makefile?  I'm fine with compiling it for mulitple
binaries too, just in case the makefile trick could be even easier.

Thanks,

-- 
Peter Xu

