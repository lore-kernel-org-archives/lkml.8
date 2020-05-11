Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D89A4C54E8D
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 19:00:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B573C206E6
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 19:00:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=apertussolutions.com header.i=dpsmith@apertussolutions.com header.b="cGqfsP5E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731345AbgEKTA5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 15:00:57 -0400
Received: from sender4-of-o51.zoho.com ([136.143.188.51]:21127 "EHLO
        sender4-of-o51.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729215AbgEKTAz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 15:00:55 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1589223616; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=B1X7gjK0SaSBbOecihU3V1h723kvH3VUtqyei/Tk47yktixnA8jRtViQ2Swe6GlDY/ndXfOsEu/ZwjEKJefQG5qy2Gr2ztHgP9kmMzHO007aXjInppJFM7gbP5U+frhmBMGjhhAF7xb4jQ5O4Wbh0X/rl71WX8C19YV24RMUtvI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1589223616; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=S00r81D2Ko0kQyZGpHMx3uADqFI0Su0WIYx5Ou1xMzU=; 
        b=LsdPd7vACFwL+7d62NcGJt/3H0U8tBMUrkCvH9fPx7/4juGaJhnrjz7Uf8yl4D6kTDkupD15ddAruQC7wvzKQfOWGJXnjpNJV7AzStbDOQdbLtIUB7MnX36qhfvJBmrrUT4MAIX3kdK4HnxUP7gyyM5bcUPzhq10gioHnKNMHrM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=apertussolutions.com;
        spf=pass  smtp.mailfrom=dpsmith@apertussolutions.com;
        dmarc=pass header.from=<dpsmith@apertussolutions.com> header.from=<dpsmith@apertussolutions.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1589223616;
        s=zoho; d=apertussolutions.com; i=dpsmith@apertussolutions.com;
        h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:In-Reply-To:Content-Type:Content-Transfer-Encoding;
        bh=S00r81D2Ko0kQyZGpHMx3uADqFI0Su0WIYx5Ou1xMzU=;
        b=cGqfsP5ELyTFhdDVij90EepZASDYn+7THT4xRajLzeGY6VbXex/WuSAWOvsyqohR
        HDepon/jwE1q4CczEAojnBh/M6AUAfXjX+w3uBk/+FziqniIlXSTPLKT5cJdJ1+rgSE
        VsdBoEID8KaOnGhyPkgKRvqxRsNcTjigN3ERF53k=
Received: from [10.10.1.24] (c-73-129-47-101.hsd1.md.comcast.net [73.129.47.101]) by mx.zohomail.com
        with SMTPS id 1589223613759454.8456864775825; Mon, 11 May 2020 12:00:13 -0700 (PDT)
Subject: Re: [RFC PATCH 00/12] x86: Trenchboot secure late launch Linux kernel
 support
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Matthew Garrett <mjg59@google.com>,
        Ross Philipson <ross.philipson@oracle.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, trenchboot-devel@googlegroups.com
References: <20200325194317.526492-1-ross.philipson@oracle.com>
 <CACdnJut56WuqO=uLff0qy1Jp=C6f_sRxLpRBsrzb6byBsFYdCg@mail.gmail.com>
 <CALCETrUshiLMHyf4DShgDRtCvnzUVyRQgmgCiudvhuhw05cDxg@mail.gmail.com>
 <6bb09673-292e-b056-3755-ffc51a1d6b59@apertussolutions.com>
 <CALCETrUnyTbihpqjZ-rwKDsyS=1yMg1KGTD60PJMj7R1-5PbhA@mail.gmail.com>
From:   "Daniel P. Smith" <dpsmith@apertussolutions.com>
Message-ID: <d72b87f4-4e71-0b32-7faf-35f910ea76a4@apertussolutions.com>
Autocrypt: addr=dpsmith@apertussolutions.com; prefer-encrypt=mutual; keydata=
 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
Date:   Mon, 11 May 2020 15:00:11 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CALCETrUnyTbihpqjZ-rwKDsyS=1yMg1KGTD60PJMj7R1-5PbhA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-ZohoMailClient: External
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/26/20 7:13 PM, Andy Lutomirski wrote:
>=20
> Hmm.  I don't have any real objection to the kernel supporting this
> type of secure launch, but I do have some more questions first.

Coming back through the thread to ensure all questions have been
responded before a submission patch set is sent.

> One of the problems with the old tboot code and the general state of
> dynamic-root-of-trust is that it's an incredible pain in the neck to
> even test.  I think it would be helpful if I could build a kernel that
> supported secure launch (Intel or AMD) and just run the thing.  I
> realize that you're planning to integrate this into GRUB, etc, but it
> might be nice if even existing GRUB and EFI shell can do this.  How
> hard would it be to make the kernel support a mode where whatever
> blobs are required are in the initrd or built in like firmware and
> where I could set a command line argument like secure_launch=3Don and
> have the kernel secure launch itself?
>=20
> Are you planning on supporting a mode where kernel A kexecs to kernel
> B, kernel B is secure launched, and then kernel B resumes kernel A and
> re-launches it?  If so, would it work better if the measured state of
> the kernel were the *uncompressed* text or even the uncompressed and
> alternative-ified text?  Or is the idea that the secure launch entry
> will figure out that it's actually a resume and not a fresh boot and
> behave accordingly?

A primary purpose of the TrenchBoot project is to make using DRTM
seamless for people, e.g. a few config settings and it just works(tm).
To achieve what you are proposing, the kernel would have to know how to
do both the DL preamble (pre-launch in tboot) and DL entry (post-launch
in tboot). The short answer is we are working towards that capability.
First is the ability to handle the DL entry, which is SecureLaunch. For
now we are clearing the SECRETS bit and doing the SEXIT leaf on kexec
and S5 to minimize the risk of bricking your system with TXT. Later the
DL preamble can be added to kexec such that the user space can
coordinate a DRTM launch. Not sure if this is exactly what you are
envisioning but albeit at least a close approximation.


> What's the situation like in a VM?  Can I run the secure launch entry
> in a VM somehow?  Can I actually initiate the dynamic launch from the
> VM?

A DL entails calling a CPU instruction which take over full control of
the system. If a hypervisor blindly allowed a VM to directly call the
op, it would end up with full control of the system outside of the
hypervisor. With that said, An approach on the roadmap for TrenchBoot is
how a hypervisor and a VM might coordinate the use of a DL to establish
a new measurement chain consisting of runtime inspection of the
hypervisor which in-turn has a means to establish the integrity of the VM.

V/r,
DPS

