Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A363BC35242
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 18:42:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DBDC2072C
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 18:42:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="h2DAYTb9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391451AbgAXSmH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 13:42:07 -0500
Received: from mail-vs1-f66.google.com ([209.85.217.66]:32996 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390147AbgAXSmH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 13:42:07 -0500
Received: by mail-vs1-f66.google.com with SMTP id n27so1894362vsa.0
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jan 2020 10:42:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=48FEuH9EzQeY2PBZotAukaxCb1+PqqfajszpsDI4a/I=;
        b=h2DAYTb9VsQ+QjqncuR5l68KeBwSCp968ZGMuifSCzx2SFdsigmou1urYD8Qli/yIB
         ULZ0o/3CoryFzCD4BFqX954rkrHj470+rHobBAglYt1Vxiwm7khjQG/kjmroNTFrCvsi
         I329X/GLMuSBuWI8KCtdY5NBsyORT8NbXyDuQgmFnxmUlvz9Cf0PXPHXJxKHo+kVRo4l
         P2UKLmHy2GX9TupKjVOdg155kOC+XwGwiV0oRLpjIhPR6FxlVtifpDh+VhCIufozcHMv
         bQPfhLDNAoc3eo20FQRCH+xZ+YybjoqD37GFmGIFPQB8tVNwpEwxt82eDzxc7tDL+Lym
         ilhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=48FEuH9EzQeY2PBZotAukaxCb1+PqqfajszpsDI4a/I=;
        b=KhX9dsEwHEGvSBmzka6TkngtjGXLR78TLGQVnZIfWs4e0Fu3V2krXhrhcywwlsUFpM
         6ylvpVnwTt94ZV90hyT2G4BhbC29GLhqZA/87oQ8IXeA3igt3ni/65FT+23bh/oA8pSC
         Bo+rOFfL+yvhUhT0hioO/p4175Mfv09qxqL1pntKT6KPvoipCJFPw6cmRnI1CqV4Dhpe
         kPJ5ezrv277mdZmFCtPOn4TKzwl7gsn0osjAcnhzbYOO3YPfZ3v6SGB2DeniwqNXWAyB
         Bcrsw8SgySsi3X8M/Ay2WB4ypaxYpKCs4GdGEMQedajIMTM2p4d8IRh51oDDGKq42yer
         aSWQ==
X-Gm-Message-State: APjAAAUsE1YGkO8NMQcrJ39FbnuZL1dRXqTzl59KyT6HU1/RCY7DfmUn
        VWGX0fqyI1rpJIB7Rnldh3arhXld2RNsnzesK5As2g==
X-Google-Smtp-Source: APXvYqwBMegd+R+iEIyOxrLLSSG25ZR0bNGvDF2TyU33C6lJzgeFsPuzLdUFCxmatMXomV9oKoh27bIVvPlErYJbBqs=
X-Received: by 2002:a67:df96:: with SMTP id x22mr953575vsk.235.1579891326150;
 Fri, 24 Jan 2020 10:42:06 -0800 (PST)
MIME-Version: 1.0
References: <20200123180436.99487-1-bgardon@google.com> <20200123180436.99487-10-bgardon@google.com>
 <92042648-e43a-d996-dc38-aded106b976b@redhat.com>
In-Reply-To: <92042648-e43a-d996-dc38-aded106b976b@redhat.com>
From:   Ben Gardon <bgardon@google.com>
Date:   Fri, 24 Jan 2020 10:41:55 -0800
Message-ID: <CANgfPd8jpUykwrOnToXx+zhJOJvnWvxhZPSKhAwST=wwYdtA3A@mail.gmail.com>
Subject: Re: [PATCH v4 09/10] KVM: selftests: Stop memslot creation in KVM
 internal memslot region
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Cannon Matthews <cannonmatthews@google.com>,
        Peter Xu <peterx@redhat.com>,
        Andrew Jones <drjones@redhat.com>,
        Peter Shier <pshier@google.com>,
        Oliver Upton <oupton@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 24, 2020 at 12:58 AM Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> On 23/01/20 19:04, Ben Gardon wrote:
> > KVM creates internal memslots covering the region between 3G and 4G in
> > the guest physical address space, when the first vCPU is created.
> > Mapping this region before creation of the first vCPU causes vCPU
> > creation to fail. Prohibit tests from creating such a memslot and fail
> > with a helpful warning when they try to.
> >
> > Signed-off-by: Ben Gardon <bgardon@google.com>
> > ---
>
> The internal memslots are much higher than this (0xfffbc000 and
> 0xfee00000).  I'm changing the patch to block 0xfe0000000 and above,
> otherwise it breaks vmx_dirty_log_test.

Perhaps we're working in different units, but I believe paddrs
0xfffbc000 and 0xfee00000 are between 3GiB and 4GiB.
"Proof by Python":
>>> B=1
>>> KB=1024*B
>>> MB=1024*KB
>>> GB=1024*MB
>>> hex(3*GB)
'0xc0000000'
>>> hex(4*GB)
'0x100000000'
>>> 3*GB == 3<<30
True
>>> 0xfffbc000 > 3*GB
True
>>> 0xfffbc000 < 4*GB
True
>>> 0xfee00000 > 3*GB
True
>>> 0xfee00000 < 4*GB
True

Am I missing something?

I don't think blocking 0xfe0000000 and above is useful, as there's
nothing mapped in that region and AFAIK it's perfectly valid to create
memslots there.


>
> Paolo
>
