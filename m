Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D878C433E2
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 16:00:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D2CD820720
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 16:00:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YrfWTqvQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729930AbgGUQAq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 12:00:46 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:60223 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726892AbgGUQAq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 12:00:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1595347244;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eeKT2rOIxGNaO2zvUjaNxphvmuUrFZ8hkCC7PUINRIc=;
        b=YrfWTqvQXyKjkuiWc6ZOydKWh69bj4wTlU/A4Chkn7nc7CRoKqpzjtzFBOlx55aoq2B20Y
        QUCyknB4WE12+lbJ94cvrtHzhAwuQwV/59U8pKG/muUsiV51kWENi55Nzo7Hm1l3mIDNUI
        c7McEd9wq0/0Ct0a2Xnx7BZiDyJSgi8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-268-xqQdX3AQN2uqd872ket1QQ-1; Tue, 21 Jul 2020 12:00:42 -0400
X-MC-Unique: xqQdX3AQN2uqd872ket1QQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A00E780BCCC;
        Tue, 21 Jul 2020 16:00:40 +0000 (UTC)
Received: from w520.home (ovpn-112-71.phx2.redhat.com [10.3.112.71])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0ECD76FECD;
        Tue, 21 Jul 2020 16:00:36 +0000 (UTC)
Date:   Tue, 21 Jul 2020 10:00:36 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Xiong Zhang <xiong.y.zhang@intel.com>,
        Wayne Boyer <wayne.boyer@intel.com>,
        Zhenyu Wang <zhenyuw@linux.intel.com>,
        Jun Nakajima <jun.nakajima@intel.com>,
        Weijiang Yang <weijiang.yang@intel.com>
Subject: Re: [PATCH] KVM: x86/mmu: Add capability to zap only sptes for the
 affected memslot
Message-ID: <20200721100036.464d4440@w520.home>
In-Reply-To: <20200721030319.GD20375@linux.intel.com>
References: <20200703025047.13987-1-sean.j.christopherson@intel.com>
        <51637a13-f23b-8b76-c93a-76346b4cc982@redhat.com>
        <20200709211253.GW24919@linux.intel.com>
        <49c7907a-3ab4-b5db-ccb4-190b990c8be3@redhat.com>
        <20200710042922.GA24919@linux.intel.com>
        <20200713122226.28188f93@x1.home>
        <20200713190649.GE29725@linux.intel.com>
        <20200721030319.GD20375@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Jul 2020 20:03:19 -0700
Sean Christopherson <sean.j.christopherson@intel.com> wrote:

> +Weijiang
> 
> On Mon, Jul 13, 2020 at 12:06:50PM -0700, Sean Christopherson wrote:
> > The only ideas I have going forward are to:
> > 
> >   a) Reproduce the bug outside of your environment and find a resource that
> >      can go through the painful bisection.  
> 
> We're trying to reproduce the original issue in the hopes of biesecting, but
> have not yet discovered the secret sauce.  A few questions:
> 
>   - Are there any known hardware requirements, e.g. specific flavor of GPU?

I'm using an old GeForce GT635, I don't think there's anything special
about this card.

>   - What's the average time to failure when running FurMark/PassMark?  E.g.
>     what's a reasonable time to wait before rebooting to rerun the tests (I
>     assume this is what you meant when you said you sometimes needed to
>     reboot to observe failure).

The failure mode ranges from graphics glitches, ex. vectors drawn
across a window during the test or stray lines when interacting with
the Windows menu button, to graphics driver failures triggering an
error dialog, usually from PassMark.  I usually start FurMark, run the
stress test for ~10s, kill it, then run a PassMark benchmark.  If I
don't observe any glitching during the run, I'll trigger the Windows
menu a few times, then reboot and try again.  The graphics tests within
PassMark are generally when the glitches are triggered, both 2D and 3D,
sometimes it's sufficient to only run those tests rather than the full
system benchmark.  That's largely the trouble with this bisect is that
the test is very interactive and requires observation.  Sometimes when
it fails it snowballs into worse and worse errors and there's high
confidence that it's bad, but other times you'll be suspicious that
something occurred and need to repeat the testing.  Thanks,

Alex

