Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1961C38A2A
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 16:38:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7CA4020936
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 16:38:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N59dd6p7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726636AbgEGQip (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 12:38:45 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:29306 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726222AbgEGQip (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 12:38:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588869523;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0GJUSBwd6yajjE7Du/EDRG7BQr30DrFCiogxpggmT4Y=;
        b=N59dd6p78IBw8jtprf9//xA2yIt38Yhy3cDFctLXoaEGOn73ZjEyFXEjakZKizpB8UEAgw
        EXHZXrCQcNoWx7si+B8YCA7zOdp3TAyTX9dHN+1nMjzQLJe6NFmlAufUatI9QmJL79GbwV
        L1+crcOGl8jIQ0FcUyMs6Gva5ek6AW0=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-356-AoOccD20PjGvcgKTKSvKGg-1; Thu, 07 May 2020 12:38:41 -0400
X-MC-Unique: AoOccD20PjGvcgKTKSvKGg-1
Received: by mail-qt1-f200.google.com with SMTP id y31so7386975qta.16
        for <linux-kernel@vger.kernel.org>; Thu, 07 May 2020 09:38:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0GJUSBwd6yajjE7Du/EDRG7BQr30DrFCiogxpggmT4Y=;
        b=c+mj1+0RVp7zkTHyTwobwFYASTDmaTdeu96DK9agEl95iv3/M0WHWhoiMu1831wYOp
         dR76WXJTatO31bl6FZOzTF2ZiQ+HZPWHzyKCvO10CpoTeg1nMHjNM4zXUIiYeCAC5ZfN
         Bsb5QzvDN2b5veofDaVyQyUyufidJFJEiD++jqlwcX5Pmc+o3li1Eea/E2ehmO9FsdwR
         Keh0Z8LnoknRxgJl6o3OG/yL0mbqJ5zW6/o0TbchX9UophIFr4Mjq6VX5l3Zt2tBP9h4
         GJm1QIId4M4qtA3KlT72y9Ug68oKunL1rcf/jmOipp0OZTkT0secjD/oszS/j2ndIwDM
         WHhA==
X-Gm-Message-State: AGi0PuYuCEI82rpDWe5grQUVksRZsKhLwPP5NR7I21Uh8K6jlU7sXceZ
        ja4Ezr8LEmBXjXmojWtpN+AMWOWjLVxk27tziuWG94VWGHNoqdW2spQPLFaD5szuj1CHh/ix6zo
        5slgjuTdxeZbNapFudsEaPoOY
X-Received: by 2002:a37:68c9:: with SMTP id d192mr15660757qkc.168.1588869521151;
        Thu, 07 May 2020 09:38:41 -0700 (PDT)
X-Google-Smtp-Source: APiQypIMOsald+8dpvEMLnkxwF+4OesJDv1LTD2qOjQwQClxhhNqfZeDggoBqidjPHz/P9Dh64NRpg==
X-Received: by 2002:a37:68c9:: with SMTP id d192mr15660728qkc.168.1588869520871;
        Thu, 07 May 2020 09:38:40 -0700 (PDT)
Received: from xz-x1 ([2607:9880:19c0:32::2])
        by smtp.gmail.com with ESMTPSA id a194sm4596136qkb.21.2020.05.07.09.38.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2020 09:38:40 -0700 (PDT)
Date:   Thu, 7 May 2020 12:38:39 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Subject: Re: [PATCH 9/9] KVM: VMX: pass correct DR6 for GD userspace exit
Message-ID: <20200507163839.GG228260@xz-x1>
References: <20200507115011.494562-1-pbonzini@redhat.com>
 <20200507115011.494562-10-pbonzini@redhat.com>
 <20200507161854.GF228260@xz-x1>
 <7abe5f7b-2b5a-4e32-34e2-f37d0afef00a@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7abe5f7b-2b5a-4e32-34e2-f37d0afef00a@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 07, 2020 at 06:21:18PM +0200, Paolo Bonzini wrote:
> On 07/05/20 18:18, Peter Xu wrote:
> >>  		if (vcpu->guest_debug & KVM_GUESTDBG_USE_HW_BP) {
> >> -			vcpu->run->debug.arch.dr6 = vcpu->arch.dr6;
> >> +			vcpu->run->debug.arch.dr6 = DR6_BD | DR6_RTM | DR6_FIXED_1;
> > After a second thought I'm thinking whether it would be okay to have BS set in
> > that test case.  I just remembered there's a test case in the kvm-unit-test
> > that checks explicitly against BS leftover as long as dr6 is not cleared
> > explicitly by the guest code, while the spec seems to have no explicit
> > description on this case.
> 
> Yes, I noticed that test as well.  But I don't like having different
> behavior for Intel and AMD, and the Intel behavior is more sensible.
> Also...

Do you mean the AMD behavior is more sensible instead? :)

> 
> > Intead of above, I'm thinking whether we should allow the userspace to also
> > change dr6 with the KVM_SET_GUEST_DEBUG ioctl when they wanted to (right now
> > iiuc dr6 from userspace is completely ignored), instead of offering a fake dr6.
> > Or to make it simple, maybe we can just check BD bit only?
> 
> ... I'm afraid that this would be a backwards-incompatible change, and
> it would require changes in userspace.  If you look at v2, emulating the
> Intel behavior in AMD turns out to be self-contained and relatively
> elegant (will be better when we finish cleaning up nested SVM).

I'm still trying to read the other patches (I need some more digest because I'm
even less familiar with nested...).  I agree that it would be good to keep the
same behavior across Intel/AMD.  Actually that also does not violate Intel spec
because the AMD one is stricter.  However I guess then we might also want to
fixup the kvm-unit-test too to aligh with the behaviors on leftover set bits.

Thanks,

-- 
Peter Xu

