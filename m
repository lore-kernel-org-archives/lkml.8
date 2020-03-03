Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0A28C3F2C6
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 19:47:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92A66208C3
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 19:47:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GSAXVdrI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731196AbgCCTrO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 14:47:14 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:33347 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730842AbgCCTrO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 14:47:14 -0500
Received: by mail-io1-f68.google.com with SMTP id r15so5052412iog.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Mar 2020 11:47:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SYEGzJaqhNf5Si1WVdKYuss+VQrNfRTnUDch8h1VFp4=;
        b=GSAXVdrI94SUESSdBleH3jDgP6jRMnxgLq0+ftHpcgUnXl6qfl6zsTSineXHyhlR0d
         zfbbhVcRqrY5js/PG8qg3opRphcGnP8wYsOUWFeLe+98o3oLUozWOtOm7e8OS1KzR5Dp
         xgqbUSNbW4YiZ36A2rZyuTk/6vpP/9U/nAu/0/Viu/WxXB3gFdeZ+0hsfi62pyrqrzGn
         UwsnMjRIe3yYHfjvU983WhbxXUU5HyJPyblipc22n6c1RxWV25iMgxB7uAVyOI6mnc/l
         N3LWJwcwCZBXZQqgNvA19yhufVFMUbfpu2P6wJJFyn6sSheWUR1PUDjoKzWy3yvQ+/yk
         jMiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SYEGzJaqhNf5Si1WVdKYuss+VQrNfRTnUDch8h1VFp4=;
        b=uNRRTwL5HfILUtRIKAJo0FNmcWg52z4tbD2DCfTUnZ9Y9ouDfS5s6mACczJGoUAqjW
         GYmxXTBJtCO+ub751+vvKjZWNT9tVPpmpVRqSFX+zYyylcVEF36ybLEFYrZFmzmUqtWY
         gXK0miK2AS1Ln+Hem+xkaOzr348v+JN6AwJKS/dXgE0SWwvGO4qefU5nE1wd7xiBpy42
         zEMU/XZa7+U4XiKFuPm3hBEbsZGQMVKqlTEQftIDQrs6ZU54yLVcDKgoQqxDD8zBmOD+
         3CRciwZ7OVGOs5nmIj+hOB/BLmxY4aMGGMVb2epcnMnFOR7W2ZGqvvRi55daNVqU0hIq
         FUmQ==
X-Gm-Message-State: ANhLgQ1+6rY+LErG/mnN3yoiXJ5qrc+y6QMZrmC0l8lY8wS8PvvEdzBk
        u6Nj3JYVAYGHWCCwiyzc68N7Q5YtTRn2Edw0dEMaIg==
X-Google-Smtp-Source: ADFU+vsurLOTxbMmQh0mQALAJjNIg4PKrV6qg1gLP2CeSmwzyJeG4Gzbcu3Be16z4ljpWT0t36ooK5e+P5aI4MVWqI4=
X-Received: by 2002:a6b:e807:: with SMTP id f7mr5411334ioh.26.1583264833075;
 Tue, 03 Mar 2020 11:47:13 -0800 (PST)
MIME-Version: 1.0
References: <20200302235709.27467-1-sean.j.christopherson@intel.com> <20200302235709.27467-2-sean.j.christopherson@intel.com>
In-Reply-To: <20200302235709.27467-2-sean.j.christopherson@intel.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Tue, 3 Mar 2020 11:47:01 -0800
Message-ID: <CALMp9eQthG5SMFhNuF4UJeRS+FXq16pD09fv=itNPX4sPgWN6w@mail.gmail.com>
Subject: Re: [PATCH v2 01/66] KVM: x86: Return -E2BIG when KVM_GET_SUPPORTED_CPUID
 hits max entries
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Joerg Roedel <joro@8bytes.org>, kvm list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Xiaoyao Li <xiaoyao.li@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 2, 2020 at 3:57 PM Sean Christopherson
<sean.j.christopherson@intel.com> wrote:
>
> Fix a long-standing bug that causes KVM to return 0 instead of -E2BIG
> when userspace's array is insufficiently sized.
>
> This technically breaks backwards compatibility, e.g. a userspace with a
> hardcoded cpuid->nent could theoretically be broken as it would see an
> error instead of success if cpuid->nent is less than the number of
> entries required to fully enumerate the host CPU.  But, the lowest known
> cpuid->nent hardcoded by a VMM is 100 (lkvm and selftests), and the

I have an existence proof for 98. :-)

> largest realistic limit on Intel and AMD is well under a 100.  E.g.
> Intel's Icelake server with all the bells and whistles tops out at ~60
> entries (variable due to SGX sub-leafs), and AMD's CPUID documentation
> allows for less than 50 (KVM hard caps CPUID 0xD at a single sub-leaf).
>
> Note, while the Fixes: tag is accurate with respect to the immediate
> bug, it's likely that similar bugs in KVM_GET_SUPPORTED_CPUID existed
> prior to the refactoring, e.g. Qemu contains a workaround for the broken
> KVM_GET_SUPPORTED_CPUID behavior that predates the buggy commit by over
> two years.  The Qemu workaround is also likely the main reason the bug
> has gone unreported for so long.
>
> Qemu hack:
>   commit 76ae317f7c16aec6b469604b1764094870a75470
>   Author: Mark McLoughlin <markmc@redhat.com>
>   Date:   Tue May 19 18:55:21 2009 +0100
>
>     kvm: work around supported cpuid ioctl() brokenness
>
>     KVM_GET_SUPPORTED_CPUID has been known to fail to return -E2BIG
>     when it runs out of entries. Detect this by always trying again
>     with a bigger table if the ioctl() fills the table.
>
> Fixes: 831bf664e9c1f ("KVM: Refactor and simplify kvm_dev_ioctl_get_supported_cpuid")
> Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
Reviewed-by: Jim Mattson <jmattson@google.com>
