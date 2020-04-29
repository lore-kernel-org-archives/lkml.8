Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27DF7C83004
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 17:28:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 04E75214D8
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 17:28:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588181309;
	bh=e4adZR13ceKvY27Tczl/vvzBls86x14/xQ1moNF9clY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=1+OW4xL1rl70z14+Yn7uv8BLhlpewF6lr0pRnq2buvEBrt0EX+mRsvq9m/gQE0SaF
	 lVjd0si4+lrqCxy7pALBIyApSATXkC5qwHwrKETMxAAyxn+DXOyBcodU04Ev6r9YvY
	 pdueCLJldEAXBcbT9Gzeb//mJHt/45Ior3twqewI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727078AbgD2R22 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 13:28:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:43054 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726530AbgD2R21 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 13:28:27 -0400
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EBD0F21775
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 17:28:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588181307;
        bh=e4adZR13ceKvY27Tczl/vvzBls86x14/xQ1moNF9clY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ifpHj2WfGhYFO9gzbWPHmLs/K1wjTuVdIEfY9517DNnCJSb0ZcsUEAQUYFNzTA1F4
         FDPQ8njCs50hRJAOSxJ9abgtKKvzaX06cU2dhT6C4D0FpIfWpBBAIefsuawYSokxit
         L3ZDsdwbxRXi/SEN3Y0szahqiLooUBRl2nOHNLMI=
Received: by mail-wr1-f42.google.com with SMTP id d15so3552159wrx.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 10:28:26 -0700 (PDT)
X-Gm-Message-State: AGi0PuZcX2yvtpygQgJfv4uy4PAv2BrO68SxBIa34coFRGxW4gfJP0Nc
        y9OhcHBiNy3G9aPJSK3Rg/cgCeL0eC5rr51UbpD44A==
X-Google-Smtp-Source: APiQypLINyUOBda4p08hLCSvolj6Ffjr7AYPyJV/2xKtH05BshwghWnyOs7fh1sktmt6VWFMo8WmuV1Eh5nZ0ucmCfQ=
X-Received: by 2002:adf:f648:: with SMTP id x8mr39628514wrp.257.1588181305343;
 Wed, 29 Apr 2020 10:28:25 -0700 (PDT)
MIME-Version: 1.0
References: <20200429093634.1514902-1-vkuznets@redhat.com> <20200429093634.1514902-5-vkuznets@redhat.com>
In-Reply-To: <20200429093634.1514902-5-vkuznets@redhat.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Wed, 29 Apr 2020 10:28:11 -0700
X-Gmail-Original-Message-ID: <CALCETrXEzpKNhNJQm+SshiEfyHjYkB7+1c+7iusZy66rRsWunA@mail.gmail.com>
Message-ID: <CALCETrXEzpKNhNJQm+SshiEfyHjYkB7+1c+7iusZy66rRsWunA@mail.gmail.com>
Subject: Re: [PATCH RFC 4/6] KVM: x86: acknowledgment mechanism for async pf
 page ready notifications
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     X86 ML <x86@kernel.org>, kvm list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 29, 2020 at 2:36 AM Vitaly Kuznetsov <vkuznets@redhat.com> wrote:
>
> If two page ready notifications happen back to back the second one is not
> delivered and the only mechanism we currently have is
> kvm_check_async_pf_completion() check in vcpu_run() loop. The check will
> only be performed with the next vmexit when it happens and in some cases
> it may take a while. With interrupt based page ready notification delivery
> the situation is even worse: unlike exceptions, interrupts are not handled
> immediately so we must check if the slot is empty. This is slow and
> unnecessary. Introduce dedicated MSR_KVM_ASYNC_PF_ACK MSR to communicate
> the fact that the slot is free and host should check its notification
> queue. Mandate using it for interrupt based type 2 APF event delivery.

This seems functional, but I'm wondering if it could a bit simpler and
more efficient if the data structure was a normal descriptor ring with
the same number slots as whatever the maximum number of waiting pages
is.  Then there would never need to be any notification from the guest
back to the host, since there would always be room for a notification.

It might be even better if a single unified data structure was used
for both notifications.
