Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ED15C2D0E7
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 23:51:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E87420719
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 23:51:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=apertussolutions.com header.i=dpsmith@apertussolutions.com header.b="bKedeGKY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727549AbgCZXvC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 19:51:02 -0400
Received: from sender4-of-o51.zoho.com ([136.143.188.51]:21121 "EHLO
        sender4-of-o51.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726359AbgCZXvC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 19:51:02 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1585266619; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=YQbRPxyd9ah9EKCp/R4tQy1GaAFaoLrpcQGNk7cC9xI4uecSFh4ZosBhGf/Re0zRifsoKUV/Ls0CRLzp2v+AJDexBLwracSCIhRkkHWb2yXN6LoaAQ6PLd1f81lL8/TPdFspOt2FdY0fHNaAVek0hnYGkrRMxEVzL+iR1Tu931o=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1585266619; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=XvQUVUMC1U3FtlgpyhifprFb9gNYVa2UaN4aw1+TbpI=; 
        b=kiZkfmxgapZ/UKS+UrIvNSMYTsnz2tCmSt9WFY/MFZ3FjvpE+Jxy7eye4DeZRANlNpkwM62do/QyS11wos5sZ410eBKVWH7x1WoW7+HqOdypuP8cNTES2+CA9ZcV4FffWgtSK5sbMS4OTIa9xiihSdWJFs7InOoBwJbSfbYMHn4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=apertussolutions.com;
        spf=pass  smtp.mailfrom=dpsmith@apertussolutions.com;
        dmarc=pass header.from=<dpsmith@apertussolutions.com> header.from=<dpsmith@apertussolutions.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1585266619;
        s=zoho; d=apertussolutions.com; i=dpsmith@apertussolutions.com;
        h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:In-Reply-To:Content-Type:Content-Transfer-Encoding;
        bh=XvQUVUMC1U3FtlgpyhifprFb9gNYVa2UaN4aw1+TbpI=;
        b=bKedeGKYKUArp6C42eVJ6a2mCYhSun9f2i4JwtvzXZGPRlnF5ezvsTSyvp+BrbYj
        UDe+9mTyIo+ziAVXxWUonC6mlX9x+sS+7L+I5TG5Z9c5HBi/QFlh5JHOyumqHWTO2n7
        ZXz6jSODE0vktkvOKfNaq1AOmhh5iC0SDN5eUiXQ=
Received: from [10.10.1.24] (c-73-129-47-101.hsd1.md.comcast.net [73.129.47.101]) by mx.zohomail.com
        with SMTPS id 1585266617065843.1974355186344; Thu, 26 Mar 2020 16:50:17 -0700 (PDT)
Subject: Re: [RFC PATCH 00/12] x86: Trenchboot secure late launch Linux kernel
 support
To:     Andy Lutomirski <luto@kernel.org>,
        Matthew Garrett <mjg59@google.com>
Cc:     Daniel Kiper <daniel.kiper@oracle.com>,
        Ross Philipson <ross.philipson@oracle.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        trenchboot-devel@googlegroups.com,
        Ard Biesheuvel <ardb@kernel.org>, leif@nuviainc.com,
        eric.snowberg@oracle.com, piotr.krol@3mdeb.com,
        krystian.hebel@3mdeb.com, michal.zygowski@3mdeb.com,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>
References: <CACdnJusd7m-c0zLmAjSq9Sb9HxyCkhyyp5W=4FMdysgu7_g=Sw@mail.gmail.com>
 <BB670F86-9362-4A8C-8BE6-64A5AF9537A7@amacapital.net>
 <CACdnJus6H3LQww8hkTMpPKN7u_sb1PXmgPwQOCSVZR_fi7GMrA@mail.gmail.com>
 <CALCETrU4W7q=QyTX_iq_kN4nVK58WoOD0F_NBt7z8p7xiE7hfA@mail.gmail.com>
From:   "Daniel P. Smith" <dpsmith@apertussolutions.com>
Message-ID: <e9ff3b26-7103-6b56-611a-09ad13a8c96b@apertussolutions.com>
Autocrypt: addr=dpsmith@apertussolutions.com; prefer-encrypt=mutual; keydata=
 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
Date:   Thu, 26 Mar 2020 19:50:09 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <CALCETrU4W7q=QyTX_iq_kN4nVK58WoOD0F_NBt7z8p7xiE7hfA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-ZohoMailClient: External
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/26/20 6:52 PM, Andy Lutomirski wrote:
> On Thu, Mar 26, 2020 at 2:28 PM Matthew Garrett <mjg59@google.com> wrote:
>>
>> On Thu, Mar 26, 2020 at 2:07 PM Andy Lutomirski <luto@amacapital.net> wr=
ote:
>>>> On Mar 26, 2020, at 1:40 PM, Matthew Garrett <mjg59@google.com> wrote:
>>>>
>>>> =EF=BB=BFOn Thu, Mar 26, 2020 at 1:33 PM Andy Lutomirski <luto@amacapi=
tal.net> wrote:
>>>>> As a straw-man approach: make the rule that we never call EFI after s=
ecure launch. Instead we write out any firmware variables that we want to c=
hange on disk somewhere.  When we want to commit those changes, we reboot, =
commit the changes, and re-launch. Or we deactivate the kernel kexec-style,=
 seal the image against PCRs, blow away PCRs, call EFI, relaunch, unseal th=
e PCRs, and continue on our merry way.
>>>>
>>>> That breaks the memory overwrite protection code, where a variable is
>>>> set at boot and cleared on a controlled reboot.
>>>
>>> Can you elaborate?  I=E2=80=99m not familiar with this.
>>
>> https://trustedcomputinggroup.org/wp-content/uploads/TCG_PlatformResetAt=
tackMitigationSpecification_1.10_published.pdf
>> - you want to protect in-memory secrets from a physically present
>> attacker hitting the reset button, booting something else and just
>> dumping RAM. This is avoided by setting a variable at boot time (in
>> the boot stub), and then clearing it on reboot once the secrets have
>> been cleared from RAM. If the variable isn't cleared, the firmware
>> overwrites all RAM contents before booting anything else.
>=20
> I admit my information is rather dated, but I'm pretty sure that at
> least some and possibly all TXT implementations solve this more
> directly.  In particular, as I understand it, when you TXT-launch
> anything, a nonvolatile flag in the chipset is set.  On reboot, the
> chipset will not allow access to memory *at all* until an
> authenticated code module wipes memory and clears that flag.
>=20
> If your computer advertises TXT support but is missing that ACM, you
> are SOL.  I learned about this when I bricked my old Lenovo laptop. As
> far as I can tell, the flag was set, but the Lenovo BIOS didn't know
> how to wipe memory.  Whoops!
>=20

You are correct, there is the SECRETS flag. If it set during DL then
when the system comes back around to the BIOS ACM and it finds the flag
set it, it will take action. The exact details are locked up under NDA
but you could take a look at the recent work in coreboot to add TXT
support to see how they handled it.

>>
>>>> As for the second approach - how would we
>>>> verify that the EFI code hadn't modified any user pages? Those
>>>> wouldn't be measured during the second secure launch. If we're calling
>>>> the code at runtime then I think we need to assert that it's trusted.
>>>
>>> Maybe you=E2=80=99re misunderstanding my suggestion.  I=E2=80=99m sugge=
sting that we hibernate the whole running system to memory (more like kexec=
 jump than hibernate) and authenticated-encrypt the whole thing (including =
user memory) with a PCR-sealed key. We jump to a stub that zaps PCRs does E=
FI calls. Then we re-launch and decrypt memory.
>>
>> When you say "re-launch", you mean perform a second secure launch? I
>> think that would work, as long as we could reconstruct an identical
>> state to ensure that the PCR17 values matched - and that seems like a
>> hard problem.
>=20
> Exactly.  I would hope that performing a second secure launch would
> reproduce the same post-launch PCRs as the first launch.  If the
> kernel were wise enough to record all PCR extensions, it could replay
> them.
>=20
> (I can imagine an alternate universe in which the PCR extension used a
> more clever algorithm that allowed log-time fast forwarding.  As far
> as I know, this is not currently the case.)
>=20
> In any case, I'm kind of with Daniel here.  We survived for quite a
> long time without EFI variables at all.  The ability to write them is
> nice, and we certainly need some way, however awkward, to write them
> on rare occasions, but I don't think we really need painless runtime
> writes to EFI variables.
>=20


