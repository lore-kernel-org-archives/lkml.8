Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A833C33CA4
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 19:00:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBCAA2072A
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 19:00:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Jjcs0Qp5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728715AbgAJTAW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 14:00:22 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:55126 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728652AbgAJTAV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 14:00:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578682819;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lZ3MJlwKsmTahhEKZ7liwmdaP72hxHg0nFRVSSgd63k=;
        b=Jjcs0Qp5ZzEmoD/tSTHSAnd/k656FWep+sDVev1lFrE1EzmxGpPVsg7Eh6PIdhJUyRe7gF
        yA4j8Urpoaczuk3Eo4rRhGysvhVd5wDeeGudJNdIRbJQt7Nol0O1JN2Aq856B9tSMSMmO8
        Edy64Bw/Ffb04V40Rjk8KwSQ78OqCHA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-42-JSww2fMSNV2NKcoejt9luw-1; Fri, 10 Jan 2020 14:00:15 -0500
X-MC-Unique: JSww2fMSNV2NKcoejt9luw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B4E2B8048F1;
        Fri, 10 Jan 2020 19:00:11 +0000 (UTC)
Received: from colo-mx.corp.redhat.com (colo-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.21])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 878E35E241;
        Fri, 10 Jan 2020 19:00:11 +0000 (UTC)
Received: from zmail24.collab.prod.int.phx2.redhat.com (zmail24.collab.prod.int.phx2.redhat.com [10.5.83.30])
        by colo-mx.corp.redhat.com (Postfix) with ESMTP id 301E581C72;
        Fri, 10 Jan 2020 19:00:11 +0000 (UTC)
Date:   Fri, 10 Jan 2020 14:00:10 -0500 (EST)
From:   Dave Anderson <anderson@redhat.com>
To:     James Morse <james.morse@arm.com>
Cc:     Bhupesh Sharma <bhsharma@redhat.com>, linux-kernel@vger.kernel.org,
        bhupesh linux <bhupesh.linux@gmail.com>, x86@kernel.org,
        linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        kexec@lists.infradead.org, Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will@kernel.org>,
        Steve Capper <steve.capper@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Kazuhito Hagio <k-hagio@ab.jp.nec.com>
Message-ID: <351975548.1986001.1578682810951.JavaMail.zimbra@redhat.com>
In-Reply-To: <f791e777-781c-86ce-7619-1de3fe3e7b90@arm.com>
References: <1575057559-25496-1-git-send-email-bhsharma@redhat.com> <1575057559-25496-3-git-send-email-bhsharma@redhat.com> <63d6e63c-7218-d2dd-8767-4464be83603f@arm.com> <af0fd2b0-99db-9d58-bc8d-0dd9d640b1eb@redhat.com> <f791e777-781c-86ce-7619-1de3fe3e7b90@arm.com>
Subject: Re: [RESEND PATCH v5 2/5] arm64/crash_core: Export TCR_EL1.T1SZ in
 vmcoreinfo
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [10.10.120.164, 10.4.195.27]
Thread-Topic: arm64/crash_core: Export TCR_EL1.T1SZ in vmcoreinfo
Thread-Index: ic50YQVuXt31PDeSAHGv7IV2UM9mpA==
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



----- Original Message -----
> Hi Bhupesh,
>=20
> On 25/12/2019 19:01, Bhupesh Sharma wrote:
> > On 12/12/2019 04:02 PM, James Morse wrote:
> >> On 29/11/2019 19:59, Bhupesh Sharma wrote:
> >>> vabits_actual variable on arm64 indicates the actual VA space size,
> >>> and allows a single binary to support both 48-bit and 52-bit VA
> >>> spaces.
> >>>
> >>> If the ARMv8.2-LVA optional feature is present, and we are running
> >>> with a 64KB page size; then it is possible to use 52-bits of address
> >>> space for both userspace and kernel addresses. However, any kernel
> >>> binary that supports 52-bit must also be able to fall back to 48-bit
> >>> at early boot time if the hardware feature is not present.
> >>>
> >>> Since TCR_EL1.T1SZ indicates the size offset of the memory region
> >>> addressed by TTBR1_EL1 (and hence can be used for determining the
> >>> vabits_actual value) it makes more sense to export the same in
> >>> vmcoreinfo rather than vabits_actual variable, as the name of the
> >>> variable can change in future kernel versions, but the architectural
> >>> constructs like TCR_EL1.T1SZ can be used better to indicate intended
> >>> specific fields to user-space.
> >>>
> >>> User-space utilities like makedumpfile and crash-utility, need to
> >>> read/write this value from/to vmcoreinfo
> >>
> >> (write?)
> >=20
> > Yes, also write so that the vmcoreinfo from an (crashing) arm64 system =
can
> > be used for
> > analysis of the root-cause of panic/crash on say an x86_64 host using
> > utilities like
> > crash-utility/gdb.
>=20
> I read this as as "User-space [...] needs to write to vmcoreinfo".
>=20
>=20
> >>> for determining if a virtual address lies in the linear map range.
> >>
> >> I think this is a fragile example. The debugger shouldn't need to know
> >> this.
> >=20
> > Well that the current user-space utility design, so I am not sure we ca=
n
> > tweak that too much.
> >=20
> >>> The user-space computation for determining whether an address lies in
> >>> the linear map range is the same as we have in kernel-space:
> >>>
> >>> =C2=A0=C2=A0 #define __is_lm_address(addr)=C2=A0=C2=A0=C2=A0 (!(((u64=
)addr) & BIT(vabits_actual -
> >>> =C2=A0=C2=A0 1)))
> >>
> >> This was changed with 14c127c957c1 ("arm64: mm: Flip kernel VA space")=
. If
> >> user-space
> >> tools rely on 'knowing' the kernel memory layout, they must have to
> >> constantly be fixed
> >> and updated. This is a poor argument for adding this to something that
> >> ends up as ABI.
> >=20
> > See above. The user-space has to rely on some ABI/guaranteed
> > hardware-symbols which can be
> > used for 'determining' the kernel memory layout.
>=20
> I disagree. Everything and anything in the kernel will change. The ABI ru=
les apply to
> stuff exposed via syscalls and kernel filesystems. It does not apply to k=
ernel internals,
> like the memory layout we used yesterday. 14c127c957c1 is a case in point=
.
>=20
> A debugger trying to rely on this sort of thing would have to play catchu=
p whenever it
> changes.

Exactly.  That's the whole point.

The crash utility and makedumpfile are not in the same league as other user=
-space tools.
They have always had to "play catchup" precisely because they depend upon k=
ernel internals,
which constantly change.

Dave=20

