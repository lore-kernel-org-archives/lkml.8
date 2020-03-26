Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F91BC2D0E9
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 20:51:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE4E02070A
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 20:51:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=apertussolutions.com header.i=dpsmith@apertussolutions.com header.b="mdJeEgi7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727650AbgCZUvD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 16:51:03 -0400
Received: from sender4-of-o51.zoho.com ([136.143.188.51]:21150 "EHLO
        sender4-of-o51.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726422AbgCZUvC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 16:51:02 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1585255833; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=HdeXMevfOIcsbuowu41x8Yr2L9uaB6M/xb4QdjgKqwbXa9sQcutx/elAdHpNvqq5aCJ7Z70X3ooYW6Hj4FAOlKwTPpHf85sCU40sA4+35QWPTXx69Ssjtx2FvekWJSjhgMZn15/n4spypvAUbKrR0nIa8XwnymXDio7+yS221N0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1585255833; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=tCEEChtqaTQC6wwZW6TB4bgghKsc5x69oKkMslX1HKE=; 
        b=lf/Tco9I1L75zEfRm6envwaFIieccoygEzITqLUSm5tr+sD5NHjfRcbKRQ1ub2Ofr7sRIUWlRTnfknn7pYPBrfiDYF0ojaSIaqtzmza8XYJtN19UJzelqMtKWKsbDXPbYFWrpCPcCr/6l6/C3oTMkS/NH4ac+RbIU7DvA0FbVyk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=apertussolutions.com;
        spf=pass  smtp.mailfrom=dpsmith@apertussolutions.com;
        dmarc=pass header.from=<dpsmith@apertussolutions.com> header.from=<dpsmith@apertussolutions.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1585255833;
        s=zoho; d=apertussolutions.com; i=dpsmith@apertussolutions.com;
        h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:In-Reply-To:Content-Type:Content-Transfer-Encoding;
        bh=tCEEChtqaTQC6wwZW6TB4bgghKsc5x69oKkMslX1HKE=;
        b=mdJeEgi7rHkiWipHS/sFroK97XTMRhOp8btgzH3pSN1eblcUz4ait9UEcAdqj05K
        g5CAMCMgTLXx8LfysIZNrqnHcW5Txr19Xvn4fNpdPOXKZMVsy8FuhaZTuEgNhnFuK39
        j4IxyAbH4YCUYUReNeeaAMANqFhx4wEda3LTvPTg=
Received: from [10.10.1.24] (c-73-129-47-101.hsd1.md.comcast.net [73.129.47.101]) by mx.zohomail.com
        with SMTPS id 1585255832320978.2395265047164; Thu, 26 Mar 2020 13:50:32 -0700 (PDT)
Subject: Re: [RFC PATCH 00/12] x86: Trenchboot secure late launch Linux kernel
 support
To:     Matthew Garrett <mjg59@google.com>,
        Ross Philipson <ross.philipson@oracle.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        linux-doc@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, trenchboot-devel@googlegroups.com
References: <20200325194317.526492-1-ross.philipson@oracle.com>
 <CACdnJut56WuqO=uLff0qy1Jp=C6f_sRxLpRBsrzb6byBsFYdCg@mail.gmail.com>
From:   "Daniel P. Smith" <dpsmith@apertussolutions.com>
Message-ID: <bacbc25a-c724-d2fd-40bd-065799cd6195@apertussolutions.com>
Autocrypt: addr=dpsmith@apertussolutions.com; prefer-encrypt=mutual; keydata=
 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
Date:   Thu, 26 Mar 2020 16:50:25 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <CACdnJut56WuqO=uLff0qy1Jp=C6f_sRxLpRBsrzb6byBsFYdCg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-ZohoMailClient: External
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/25/20 4:29 PM, Matthew Garrett wrote:
> On Wed, Mar 25, 2020 at 12:43 PM Ross Philipson
> <ross.philipson@oracle.com> wrote:
>> To enable the kernel to be launched by GETSEC or SKINIT, a stub must be
>> built into the setup section of the compressed kernel to handle the
>> specific state that the late launch process leaves the BSP. This is a
>> lot like the EFI stub that is found in the same area. Also this stub
>> must measure everything that is going to be used as early as possible.
>> This stub code and subsequent code must also deal with the specific
>> state that the late launch leaves the APs in.
>=20
> How does this integrate with the EFI entry point? That's the expected
> entry point on most modern x86. What's calling ExitBootServices() in
> this flow, and does the secure launch have to occur after it? It'd be
> a lot easier if you could still use the firmware's TPM code rather
> than carrying yet another copy.


It is not part of the EFI entry point as we are not entering the kernel
from EFI but I will address that further in my response to Andy. The
expectation is that if you are on an UEFI platform then EBS should have
already been called. With respect to using the firmware's TPM code, one
of the purposes of a TCG Dynamic Launch is to remove the firmware from
the code being trusted in making the integrity measurement of the
kernel. I trust the firmware to initialize the hardware because I have
to and it does give a trust chain, aka the SRTM, that can attest to what
was used during that process. When the OS kernel is being started that
trust chain has become weak (or even broken). I want a new trust chain
that can provide better footing for asserting the integrity of the
kernel and this is what Dynamic Launch gives us. I would like to think I
did a fair job explaining this at LSS last fall[1][2] and would
recommend those that are curious to review the slides/watch the
presentation.

V/r,
Daniel P. Smith

[1]
https://lssna19.sched.com/event/RHb0/trenchboot-how-to-nicely-boot-system-w=
ith-intel-txt-and-amd-svm-daniel-kiper-oracle-daniel-smith-apertus-solution=
s
[2] https://youtu.be/DbpCU9iSi4g


