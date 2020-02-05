Return-Path: <SRS0=fqu/=3Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F2CCC35247
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 15:56:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 446CD217BA
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 15:56:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WAuEc186"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727725AbgBEPz7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Feb 2020 10:55:59 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:58767 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726661AbgBEPz6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 10:55:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580918158;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=efV8S+DLqDmq+X1JgLrPt59ALotCaXcv3mMze6v9B9g=;
        b=WAuEc186gVJUYim0Fb0zPuUuOZ0tJfOAc9qL6U5pGwCw38d0z7CJ9KvIa6ibS3ZfTHhZf2
        DXNA9gWSQkYqL7Grd2Crls7yO6WEBkffqP0I6H6l2CJ1OP6nMaOk6OU8RD5IF0NqSJBK8P
        gmW+lrKo1Yl/cW1by2LUQqs8C+EBipA=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-221-iicD0ZUePuGFZgIyFWqbSA-1; Wed, 05 Feb 2020 10:55:57 -0500
X-MC-Unique: iicD0ZUePuGFZgIyFWqbSA-1
Received: by mail-qt1-f199.google.com with SMTP id l25so1632652qtu.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Feb 2020 07:55:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=efV8S+DLqDmq+X1JgLrPt59ALotCaXcv3mMze6v9B9g=;
        b=Av4VyMD2iJiCR8KlU1xFk9FNr2ptXptOhePxG+gQ7fvROtS8+N9ilsgojrOUJ+0bPf
         91wHS2dWPd8yf16rQ2NLlfxcwF6F1+gLBnpJzCfun3zr+gz3C3lrwWpcXqvQo46OnpKF
         8xElwpYyDljQfHnQIw9j+GRA1JGn2U7NHgid3uK0lwEkhc0l+EFhFx7mI5JkLtz5hX8n
         Bwv23aBqYMmoxiyjcOFvWdLpshGvXWuOzDebzuG4kJhAptLD3EK0rnd0tO9e6X3jnOIn
         uifx9CGu0bGWezV0x7x4BzCcZG6tb3GIQLRK38T3m8Ixi2sMC0K0KdJN9Pkj1igOqlxw
         5iTg==
X-Gm-Message-State: APjAAAWs610MD8an/e1DquBAG7jkNwjaorIva32xmN2v6IzlBvlqxRPE
        xzI9CvynJg7ZUTQqlai/0YYhzS0lpzyIMifXVURmR79PQ9Rg/Vlp6FuaQl/hR+GjYRlGTBiTYuy
        IvYR3wKUn/6DSm6ai7p6EQ8sE
X-Received: by 2002:a05:620a:662:: with SMTP id a2mr35406422qkh.329.1580918155060;
        Wed, 05 Feb 2020 07:55:55 -0800 (PST)
X-Google-Smtp-Source: APXvYqwFOamF0fw44YxctBelueuIit+7na62ANL6TulX8nNY0doj5ywuQ2bYPN4enBP7XgojeUNorQ==
X-Received: by 2002:a05:620a:662:: with SMTP id a2mr35406398qkh.329.1580918154828;
        Wed, 05 Feb 2020 07:55:54 -0800 (PST)
Received: from xz-x1 ([2607:9880:19c8:32::2])
        by smtp.gmail.com with ESMTPSA id w26sm14948qkj.46.2020.02.05.07.55.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2020 07:55:54 -0800 (PST)
Date:   Wed, 5 Feb 2020 10:55:51 -0500
From:   Peter Xu <peterx@redhat.com>
To:     Andrew Jones <drjones@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        dinechin@redhat.com, sean.j.christopherson@intel.com,
        pbonzini@redhat.com, jasowang@redhat.com, yan.y.zhao@intel.com,
        mst@redhat.com, kevin.tian@intel.com, alex.williamson@redhat.com,
        dgilbert@redhat.com, vkuznets@redhat.com
Subject: Re: [PATCH 13/14] KVM: selftests: Let dirty_log_test async for dirty
 ring test
Message-ID: <20200205155551.GB378317@xz-x1>
References: <20200205025105.367213-1-peterx@redhat.com>
 <20200205025842.367575-1-peterx@redhat.com>
 <20200205025842.367575-10-peterx@redhat.com>
 <20200205094806.dqkzpxhrndocjl6g@kamzik.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200205094806.dqkzpxhrndocjl6g@kamzik.brq.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 05, 2020 at 10:48:06AM +0100, Andrew Jones wrote:
> On Tue, Feb 04, 2020 at 09:58:41PM -0500, Peter Xu wrote:
> > diff --git a/tools/testing/selftests/kvm/include/kvm_util.h b/tools/testing/selftests/kvm/include/kvm_util.h
> > index 4b78a8d3e773..e64fbfe6bbd5 100644
> > --- a/tools/testing/selftests/kvm/include/kvm_util.h
> > +++ b/tools/testing/selftests/kvm/include/kvm_util.h
> > @@ -115,6 +115,7 @@ vm_paddr_t addr_gva2gpa(struct kvm_vm *vm, vm_vaddr_t gva);
> >  struct kvm_run *vcpu_state(struct kvm_vm *vm, uint32_t vcpuid);
> >  void vcpu_run(struct kvm_vm *vm, uint32_t vcpuid);
> >  int _vcpu_run(struct kvm_vm *vm, uint32_t vcpuid);
> > +int __vcpu_run(struct kvm_vm *vm, uint32_t vcpuid);
> >  void vcpu_run_complete_io(struct kvm_vm *vm, uint32_t vcpuid);
> >  void vcpu_set_mp_state(struct kvm_vm *vm, uint32_t vcpuid,
> >  		       struct kvm_mp_state *mp_state);
> > diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
> > index 25edf20d1962..5137882503bd 100644
> > --- a/tools/testing/selftests/kvm/lib/kvm_util.c
> > +++ b/tools/testing/selftests/kvm/lib/kvm_util.c
> > @@ -1203,6 +1203,14 @@ int _vcpu_run(struct kvm_vm *vm, uint32_t vcpuid)
> >  	return rc;
> >  }
> >  
> > +int __vcpu_run(struct kvm_vm *vm, uint32_t vcpuid)
> > +{
> > +	struct vcpu *vcpu = vcpu_find(vm, vcpuid);
> > +
> > +	TEST_ASSERT(vcpu != NULL, "vcpu not found, vcpuid: %u", vcpuid);
> > +	return ioctl(vcpu->fd, KVM_RUN, NULL);
> > +}
> > +
> >  void vcpu_run_complete_io(struct kvm_vm *vm, uint32_t vcpuid)
> >  {
> >  	struct vcpu *vcpu = vcpu_find(vm, vcpuid);
> 
> I think we should add a vcpu_get_fd(vm, vcpuid) function instead, and
> then call ioctl directly from the test.

Currently the vcpu struct is still internal to the lib/ directory (as
defined in lib/kvm_util_internal.h).  Wit that, it seems the vcpu fd
should also be limited to the lib/ as well?

But I feel like I got your point, because when I worked on the
selftests I did notice that in many places it's easier to expose all
these things for test cases (e.g., the struct vcpu).  For me, it's not
only for the vcpu fd, but also for the rest of internal structures to
be able to be accessed from tests directly.  Not sure whether that's
what you thought too.  It's just a separate topic of what this series
was trying to do.

Thanks,

-- 
Peter Xu

