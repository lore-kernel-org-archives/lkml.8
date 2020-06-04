Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7465C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 15:15:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 94B9C206DC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 15:15:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591283731;
	bh=ehTRmixmctGTG2rIendMHkrDCa4Xx6HZ+HL+iKOW2Es=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=D3wfsH3LelnOU+BoYTqlWRocTrknQ/55wtpJZGf7M8pDMZ3HOJ5ksOQ6KRBy2E1oa
	 lQu99rWKtwIKXGEbOvLIRLwyKBHe9Jnzz6AqcXK9QhZQJdX4+pxS+yMCgz10aYs0AI
	 yDH26ye5lk8sUmgP5aZOZUmw6e7lfLPsuYkYwKEc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729373AbgFDPPa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 11:15:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:39596 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729215AbgFDPP1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 11:15:27 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C92422072E;
        Thu,  4 Jun 2020 15:15:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591283726;
        bh=ehTRmixmctGTG2rIendMHkrDCa4Xx6HZ+HL+iKOW2Es=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=AzUKdjZsEdsVO/muRW82FLhh+tkqkBsCTIvWLS4USDM3sS+PhXlEGhYN2AoO3MUky
         qDeDLwPPklB8HVdpx6QGGwSpl3gGSmN9oUfIKPqJ/Ztn2YzdX4ywZKxBWeBlNPpgZf
         sx/8OtL/Acm09hxo47MoGY/XB+VhUBS7XO8orxq8=
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=why)
        by disco-boy.misterjones.org with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1jgraX-000HRX-9N; Thu, 04 Jun 2020 16:15:25 +0100
Date:   Thu, 4 Jun 2020 16:15:23 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        David Rientjes <rientjes@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Will Drewry <wad@chromium.org>,
        "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
        "Kleen, Andi" <andi.kleen@intel.com>, x86@kernel.org,
        kvm@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        kernel-team@android.com, will@kernel.org
Subject: Re: [RFC 00/16] KVM protected memory extension
Message-ID: <20200604161523.39962919@why>
In-Reply-To: <20200522125214.31348-1-kirill.shutemov@linux.intel.com>
References: <20200522125214.31348-1-kirill.shutemov@linux.intel.com>
Organization: Approximate
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: kirill@shutemov.name, dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org, pbonzini@redhat.com, sean.j.christopherson@intel.com, vkuznets@redhat.com, wanpengli@tencent.com, jmattson@google.com, joro@8bytes.org, rientjes@google.com, aarcange@redhat.com, keescook@chromium.org, wad@chromium.org, rick.p.edgecombe@intel.com, andi.kleen@intel.com, x86@kernel.org, kvm@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, kirill.shutemov@linux.intel.com, kernel-team@android.com, will@kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kirill,

Thanks for this.

On Fri, 22 May 2020 15:51:58 +0300
"Kirill A. Shutemov" <kirill@shutemov.name> wrote:

> =3D=3D Background / Problem =3D=3D
>=20
> There are a number of hardware features (MKTME, SEV) which protect guest
> memory from some unauthorized host access. The patchset proposes a purely
> software feature that mitigates some of the same host-side read-only
> attacks.
>=20
>=20
> =3D=3D What does this set mitigate? =3D=3D
>=20
>  - Host kernel =E2=80=9Daccidental=E2=80=9D access to guest data (think s=
peculation)
>=20
>  - Host kernel induced access to guest data (write(fd, &guest_data_ptr, l=
en))
>=20
>  - Host userspace access to guest data (compromised qemu)
>=20
> =3D=3D What does this set NOT mitigate? =3D=3D
>=20
>  - Full host kernel compromise.  Kernel will just map the pages again.
>=20
>  - Hardware attacks

Just as a heads up, we (the Android kernel team) are currently
involved in something pretty similar for KVM/arm64 in order to bring
some level of confidentiality to guests.

The main idea is to de-privilege the host kernel by wrapping it in its
own nested set of page tables which allows us to remove memory
allocated to guests on a per-page basis. The core hypervisor runs more
or less independently at its own privilege level. It still is KVM
though, as we don't intend to reinvent the wheel.

Will has written a much more lingo-heavy description here:
https://lore.kernel.org/kvmarm/20200327165935.GA8048@willie-the-truck/

This works for one of the virtualization modes that arm64 can use (what
we call non-VHE, or nVHE for short). The other mode (VHE), is much more
similar to what happens on other architectures, where the kernel and
the hypervisor are one single entity. In this case, we cannot use the
same trick with nested page tables, and have to rely on something that
would very much look like what you're proposing.

Note that the two modes of the architecture would benefit from this
work anyway, as I'd like the host to know that we've pulled memory
from under its feet. Since you have done most of the initial work, I
intend to give it a go on arm64 shortly and see what sticks.

Thanks,

	M.
--=20
Jazz is not dead. It just smells funny...
