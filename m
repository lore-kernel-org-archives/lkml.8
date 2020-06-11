Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB661C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 08:31:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8355F2072F
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 08:31:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YaVJRixh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726790AbgFKIbR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 04:31:17 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:44694 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726729AbgFKIbQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 04:31:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591864275;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wqYVXT69UvryAYl9lNEvAFDCi4lpCbFocG1/WeDxI7w=;
        b=YaVJRixhO+iK71lOKNhdpFg91DyK5PaPT5ulEo84e7DM2hqnV/kkrVzMUl2L91JSwP5b3o
        EPyRM2bN777C768oAnJfG7IkpzRcObEe6MiSb9JVUV4yBq2GgXm6x95qU6fekizy1Qlk2y
        BwNpJtJqcORr2jbH/syqVsGGu1JRADk=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-282-YqJka_LJPEGIAk1z6EvdWQ-1; Thu, 11 Jun 2020 04:31:12 -0400
X-MC-Unique: YqJka_LJPEGIAk1z6EvdWQ-1
Received: by mail-ed1-f69.google.com with SMTP id y5so1432394edt.3
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jun 2020 01:31:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=wqYVXT69UvryAYl9lNEvAFDCi4lpCbFocG1/WeDxI7w=;
        b=CuBCKcHb13Pz8WLJehCQXTeRLyW+guU778WDVuI/o1FIKJ6xAMjiAvnAUm7ml6llGQ
         nokjcnXyTiWUT4WRq0+Yve7kr3Qvu9lXXBRs/uo5/YAcEsauGQs/v1eIPzfXgse17tsf
         dSngFlq2WNmem8IrYQP3+PbOOAICIT+MNavoXkWcXfXFzY/QBUcfdb7nHgnIjVux90HE
         vywn6v3IvFf7ReHgeClbXQvF5IKbeI5Hw+vr7OXL8x9IeutQ7e/vHCSD3vz0MRB4xre6
         varmeJgV1g+ljRPMPryEBTnbZvV3jX+gOvGe5Dz0cuiLAma2N6hkcQQ7LqcYQaAf1tQE
         q1RQ==
X-Gm-Message-State: AOAM530ycI4R6ecey9zpcodKJx7LVEPvfq/ptztLuTVcTRuOmup2CwUG
        wOF9xDvcUD4RVI4SRqA35JKSSxaIdXRkBqd1cFanXeVQif+FEM4+m1b5A6EJqGx+7JkbkcENy7q
        aApGR8OKHO585lAKh9XzBNjM/
X-Received: by 2002:a17:906:7f94:: with SMTP id f20mr7554730ejr.394.1591864270806;
        Thu, 11 Jun 2020 01:31:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwKlzTe4j+zEAO903+5izsigh9isK3JSgGRfJjNeyODoD2a9lb20KYC0JPI7N6g+dJC4qcPBw==
X-Received: by 2002:a17:906:7f94:: with SMTP id f20mr7554717ejr.394.1591864270580;
        Thu, 11 Jun 2020 01:31:10 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id qp16sm1487705ejb.64.2020.06.11.01.31.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2020 01:31:09 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Vivek Goyal <vgoyal@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] KVM: async_pf: Cleanup kvm_setup_async_pf()
In-Reply-To: <20200610181453.GC18790@linux.intel.com>
References: <20200610175532.779793-1-vkuznets@redhat.com> <20200610181453.GC18790@linux.intel.com>
Date:   Thu, 11 Jun 2020 10:31:08 +0200
Message-ID: <87sgf29f77.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sean Christopherson <sean.j.christopherson@intel.com> writes:

>
> I'd also be in favor of changing the return type to a boolean.  I think
> you alluded to it earlier, the current semantics are quite confusing as they
> invert the normal "return 0 on success".

Yes, will do a follow-up.

KVM/x86 code has an intertwined mix of:
- normal 'int' functions ('0 on success')
- bool functions ('true'/'1' on success)
- 'int' exit handlers ('1'/'0' on success depending if exit to userspace
  was required)
- ...

I think we can try to standardize this to:
- 'int' when error is propagated outside of KVM (userspace, other kernel
  subsystem,...)
- 'bool' when the function is internal to KVM and the result is binary
 ('is_exit_required()', 'was_pf_injected()', 'will_have_another_beer()',
 ...)
- 'enum' for the rest.
And, if there's a good reason for making an exception, require a
comment. (leaving aside everything returning a pointer, of course as
these are self-explanatory -- unless it's 'void *' :-))

>
> For this patch:
>
> Reviewed-by: Sean Christopherson <sean.j.christopherson@intel.com>
>

Thank you!

-- 
Vitaly

