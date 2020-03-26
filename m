Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D91F2C43331
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 20:33:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A316D20722
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 20:33:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="NrpPlECo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728031AbgCZUdW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 16:33:22 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:44130 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727928AbgCZUdV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 16:33:21 -0400
Received: by mail-pl1-f195.google.com with SMTP id h11so2593066plr.11
        for <linux-kernel@vger.kernel.org>; Thu, 26 Mar 2020 13:33:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=31LBMmRcYe+yEGtoM08ZSaLwaQfDlxsblA8wVchHVi8=;
        b=NrpPlECo6AI/hAQE3I/XEDAjdjtUo9LXqFqVAUMuzk1z6cbpF8zmw6aox8LpgFf6/D
         e9DU2naiucIg6yd2Ts76fWA+ep+Gef7o5mHgq35y2n0lR8oGOCTdq8645lxKk264kt7M
         fGlozyLZ/YECGQkKZp3ZuIQ9TuAVcsw7vmeEXm/dV6M5pNEWF2e+HRV35RyDCM2Gg4b6
         QXl+vV0oSLfr7kuwXp1717znu1qp4xMgHFUHuCr0yvsK7sY6n/0WUSPg+IvDoZu0a/Db
         Kb+kPOT74J/2lhYllCcc/XEgBWVZ2HG4UDhkPAFvX0GLeaE0/gpaNxU2/rL02Dm+OYiU
         uU0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=31LBMmRcYe+yEGtoM08ZSaLwaQfDlxsblA8wVchHVi8=;
        b=s7pWvHnv4kS4o1f+R8rL9ykF/q7c1cfvaPF02VLtjqNuj25dkvpmhFexAeRLjlOOmZ
         danmPcrZkBd5cE99l9QPNFtSq7wkKuAQ5bNLHfaDmYJ8I3I8vgDyGyKAuDf8yMHc8Om4
         D5a+ykp/70W4ENco3mx9COErnIEX3STGImgHA/8cS3SgujVLR8kmDlsJjUNlynrjygsh
         6Sw7NIZLCOmZ95pPeitnIQ5OEu7WkB8q51WMcHJfkM0VeM/POixxZmFiCaeAknd7HjEd
         TIyyQMFVtQZKW5CKhi5lnBnDewYUv7caZG0iBCtf1VJw/8DEVoZb7tosXUifgHDqAbz/
         gkaA==
X-Gm-Message-State: ANhLgQ1inXposh679PbEzMphf11+EcinPe1553VJa27B5TSIOnKwPU1u
        VgCRM2rEnjdhxj+ogbBAsUH+Dg==
X-Google-Smtp-Source: ADFU+vu+gUBPTHCiLbo4oeQsnkYNtYX/UDxhFzKc+aeKr+GO4BTRKm7q6N09v+wRxLLr/n/j+YjkuA==
X-Received: by 2002:a17:902:b088:: with SMTP id p8mr10115931plr.106.1585254800408;
        Thu, 26 Mar 2020 13:33:20 -0700 (PDT)
Received: from ?IPv6:2601:646:c200:1ef2:6dcf:5ef7:9489:9d02? ([2601:646:c200:1ef2:6dcf:5ef7:9489:9d02])
        by smtp.gmail.com with ESMTPSA id 79sm2388418pfz.23.2020.03.26.13.33.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Mar 2020 13:33:19 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Andy Lutomirski <luto@amacapital.net>
Mime-Version: 1.0 (1.0)
Subject: Re: [RFC PATCH 00/12] x86: Trenchboot secure late launch Linux kernel support
Date:   Thu, 26 Mar 2020 13:33:17 -0700
Message-Id: <FE871C2B-15BB-4089-A912-40F2E9FE680B@amacapital.net>
References: <CACdnJutT1F7YJ5KFkyuaZv=nj8GqC+mrnoAsHZfMP1ZRNUQg3Q@mail.gmail.com>
Cc:     Daniel Kiper <daniel.kiper@oracle.com>,
        Ross Philipson <ross.philipson@oracle.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        linux-doc@vger.kernel.org, dpsmith@apertussolutions.com,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        trenchboot-devel@googlegroups.com,
        Ard Biesheuvel <ardb@kernel.org>, leif@nuviainc.com,
        eric.snowberg@oracle.com, piotr.krol@3mdeb.com,
        krystian.hebel@3mdeb.com, michal.zygowski@3mdeb.com,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        andrew.cooper3@citrix.com
In-Reply-To: <CACdnJutT1F7YJ5KFkyuaZv=nj8GqC+mrnoAsHZfMP1ZRNUQg3Q@mail.gmail.com>
To:     Matthew Garrett <mjg59@google.com>
X-Mailer: iPhone Mail (17D50)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Mar 26, 2020, at 1:19 PM, Matthew Garrett <mjg59@google.com> wrote:
>=20
> =EF=BB=BFOn Thu, Mar 26, 2020 at 6:40 AM Daniel Kiper <daniel.kiper@oracle=
.com> wrote:
>>> On Wed, Mar 25, 2020 at 01:29:03PM -0700, 'Matthew Garrett' via trenchbo=
ot-devel wrote:
>>> On Wed, Mar 25, 2020 at 12:43 PM Ross Philipson
>>> <ross.philipson@oracle.com> wrote:
>>>> To enable the kernel to be launched by GETSEC or SKINIT, a stub must be=

>>>> built into the setup section of the compressed kernel to handle the
>>>> specific state that the late launch process leaves the BSP. This is a
>>>> lot like the EFI stub that is found in the same area. Also this stub
>>>> must measure everything that is going to be used as early as possible.
>>>> This stub code and subsequent code must also deal with the specific
>>>> state that the late launch leaves the APs in.
>>>=20
>>> How does this integrate with the EFI entry point? That's the expected
>>=20
>> It does not. We do not want and need to tie secure launch with UEFI.
>=20
> I agree that it shouldn't be required, but it should be possible. We
> shouldn't add new entry points that don't integrate with the standard
> way of booting the kernel.
>=20
>>> What's calling ExitBootServices() in
>>=20
>> Currently it is a bootloader, the GRUB which I am working on... OK, this
>> is not perfect but if we want to call ExitBootServices() from the kernel
>> then we have to move all pre-launch code from the bootloader to the
>> kernel. Not nice because then everybody who wants to implement secure
>> launch in different kernel, hypervisor, etc. has to re-implement whole
>> pre-launch code again.
>=20
> We call ExitBootServices() in the EFI stub, so this is fine as long as
> the EFI stub hands over control to the SL code. But yes, I think it's
> a requirement that it be kernel-owned code calling ExitBootServices().
>=20
>>> this flow, and does the secure launch have to occur after it? It'd be
>>=20
>> Yes, it does.
>=20
> Ok. The firmware TPM interfaces are gone after ExitBootServices(), so
> we're going to need an additional implementation.
>=20
>> I think any post-launch code in the kernel should not call anything from
>> the gap. And UEFI belongs to the gap. OK, we can potentially re-use UEFI
>> TPM code in the pre-launch phase but I am not convinced that we should
>> (I am looking at it right now). And this leads us to other question
>> which pops up here and there. How to call UEFI runtime services, e.g. to
>> modify UEFI variables, update firmware, etc., from MLE or even from the
>> OS started from MLE? In my opinion it is not safe to call anything from
>> the gap after secure launch. However, on the other hand we have to give
>> an option to change the boot order or update the firmware. So, how to
>> do that? I do not have an easy answer yet...
>=20
> How does Windows manage this? Retaining access to EFI runtime services
> is necessary, and the areas in the memory map marked as runtime
> services code or data should be considered part of the TCB and
> measured - they're very much not part of the gap.

As a straw-man approach: make the rule that we never call EFI after secure l=
aunch. Instead we write out any firmware variables that we want to change on=
 disk somewhere.  When we want to commit those changes, we reboot, commit th=
e changes, and re-launch. Or we deactivate the kernel kexec-style, seal the i=
mage against PCRs, blow away PCRs, call EFI, relaunch, unseal the PCRs, and c=
ontinue on our merry way.

I=E2=80=99m not sure how SMM fits in to this whole mess.

If we insist on allowing EFI calls and SMM, then we may be able to *measure*=
 our exposure to potentially malicious firmware, but we can=E2=80=99t elimin=
ate it. I personally trust OEM firmware about as far as I can throw it.=
