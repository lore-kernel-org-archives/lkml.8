Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 284BDC43461
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 11:54:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CEB2C2145D
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 11:54:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Mk1gsq4j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730285AbgIJLyd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 07:54:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:38256 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730400AbgIJLwJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 07:52:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599738724;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Sjkjxl7XUETbHB6ANruWZFnmDHT7amDR67npklsZH2s=;
        b=Mk1gsq4jP6JqrEb5NoZcxLDRIAdUm66NloJai3FMW9wKrr9YLoQEAE4JaJIAMGthuiNYXH
        E0xzh4GOl4fE23uLbWtz0kT8lK/qZZWFRAF7ZBV6RZS2YfIlIU2/Rf42lAAodvQuWUBZWt
        HAybvSiEozrIUNUafxFL06rgRorl3tc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-63-SgqgcIBnNWOnuR5o4e7goA-1; Thu, 10 Sep 2020 07:49:51 -0400
X-MC-Unique: SgqgcIBnNWOnuR5o4e7goA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6A6E9802B6C;
        Thu, 10 Sep 2020 11:49:49 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.40.192.124])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id EC8FF1A923;
        Thu, 10 Sep 2020 11:49:45 +0000 (UTC)
Date:   Thu, 10 Sep 2020 13:49:43 +0200
From:   Andrew Jones <drjones@redhat.com>
To:     Steven Price <steven.price@arm.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        Peter Maydell <Peter.Maydell@arm.com>, qemu-devel@nongnu.org,
        Dave Martin <Dave.Martin@arm.com>,
        Juan Quintela <quintela@redhat.com>,
        Richard Henderson <richard.henderson@linaro.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 2/2] arm64: kvm: Introduce MTE VCPU feature
Message-ID: <20200910114943.cedbzlqfcgxg7jqs@kamzik.brq.redhat.com>
References: <20200904160018.29481-1-steven.price@arm.com>
 <20200904160018.29481-3-steven.price@arm.com>
 <20200909154804.mide6szbzgdy7jju@kamzik.brq.redhat.com>
 <3a7e18af-84bd-cee3-d68f-e08f225fc166@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3a7e18af-84bd-cee3-d68f-e08f225fc166@arm.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 10, 2020 at 10:21:07AM +0100, Steven Price wrote:
> > We either need a KVM cap or a new CPU feature probing interface to avoid
> > making userspace try features one at a time. It's too bad that VCPU_INIT
> > doesn't clear all offending features from the feature set when returning
> > EINVAL, because then userspace could create a scratch VCPU with everything
> > it supports in order to see what KVM also supports in one go.
> 
> If Peter's TELL_ME_WHAT_YOU_HAVE idea works out then perhaps we don't need
> the cap? Or would it still be useful?
>

We wouldn't need it, but we don't _need_ it now either. It's not very
convenient to probe vcpu features with scratch vcpus, especially if we
must probe one at a time, but it works. The TELL_ME_WHAT_YOU_HAVE idea
will only fix the one at a time issue, but still require a vcpu fd. If
this feature becomes a VM feature then a cap or VM level API would help
reduce the userspace probing work.

Thanks,
drew

