Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D6F5C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 00:14:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F3FD206A4
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 00:14:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=apertussolutions.com header.i=dpsmith@apertussolutions.com header.b="lt/T1ShJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728648AbgFBAOX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 20:14:23 -0400
Received: from sender4-of-o51.zoho.com ([136.143.188.51]:21176 "EHLO
        sender4-of-o51.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725927AbgFBAOX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 20:14:23 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1591056819; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=Yzt3hg008Ewiw74Etbe1GbNVXIXlxRtR6+jlS219s6pgNwa06rkdTYH1J4nKuysl8RtykTiN/MxetIgwXcsYHPsVpCV+nJUpb6C60y27uC7qDUMdy1xhEB+Kxf8JiFXlXl7sAil+HkVno/cazHTw1aiVwBol/dO3TzzbDns2iRs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1591056819; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=NVJPpaameDMBHmsIlIvvze+ivRpNSajnYHqCmKWyZNA=; 
        b=mtW5Ko0uNTFREPywKDPFju4J0YfXH8TXmfaXhCkpWFZ5hZM3LvnMew43XzQsacTaDui4cm9AzRxe3oWKTemZm01eSZ1/U66PSe9DY4OWKvT1Mh5mL4Wy1Psap1DW2zyeqXhZiT89iaq5rBsx0sBif/Cw5HU5D5jp+IWEJwlyVV8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=apertussolutions.com;
        spf=pass  smtp.mailfrom=dpsmith@apertussolutions.com;
        dmarc=pass header.from=<dpsmith@apertussolutions.com> header.from=<dpsmith@apertussolutions.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1591056819;
        s=zoho; d=apertussolutions.com; i=dpsmith@apertussolutions.com;
        h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:In-Reply-To:Content-Type:Content-Transfer-Encoding;
        bh=NVJPpaameDMBHmsIlIvvze+ivRpNSajnYHqCmKWyZNA=;
        b=lt/T1ShJppYVdEPQXUTHgw5z3ZkdXYWjQbDHmasVo9uwrRh3kw60D1jSV6NQffXI
        xiwf10Y48SPfXwQ3VSIat/ole1eH9bUQQk0IRien0OAvIu8JnPpsp3CBE/rRw6+7Qkj
        RqVQ3njWvTT5vlcM4xWZ/KoSTqOfInjqDNdVeIFI=
Received: from [10.10.1.24] (c-73-129-47-101.hsd1.md.comcast.net [73.129.47.101]) by mx.zohomail.com
        with SMTPS id 15910568151281010.0398280518084; Mon, 1 Jun 2020 17:13:35 -0700 (PDT)
Subject: Re: [GRUB PATCH RFC 00/18] i386: Intel TXT secure launcher
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Daniel Kiper <daniel.kiper@oracle.com>,
        Lukasz Hawrylko <lukasz.hawrylko@linux.intel.com>,
        grub-devel@gnu.org, LKML <linux-kernel@vger.kernel.org>,
        trenchboot-devel@googlegroups.com, X86 ML <x86@kernel.org>,
        alexander.burmashev@oracle.com,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        eric.snowberg@oracle.com, javierm@redhat.com,
        kanth.ghatraju@oracle.com,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        krystian.hebel@3mdeb.com, michal.zygowski@3mdeb.com,
        Matthew Garrett <mjg59@google.com>, phcoder@gmail.com,
        piotr.krol@3mdeb.com, Peter Jones <pjones@redhat.com>,
        Ross Philipson <ross.philipson@oracle.com>
References: <8c82e8e4-d6bb-7cba-dd32-378dd1c30f3e@apertussolutions.com>
 <120CC5EB-297D-46C4-91FC-E9D6E5B88C18@amacapital.net>
From:   "Daniel P. Smith" <dpsmith@apertussolutions.com>
Message-ID: <f954e9ef-295a-a8ce-0ff8-a88ad81b01a3@apertussolutions.com>
Autocrypt: addr=dpsmith@apertussolutions.com; prefer-encrypt=mutual; keydata=
 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
Date:   Mon, 1 Jun 2020 20:13:31 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <120CC5EB-297D-46C4-91FC-E9D6E5B88C18@amacapital.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-ZohoMailClient: External
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/1/20 3:39 PM, Andy Lutomirski wrote:
>=20
>> On Jun 1, 2020, at 10:56 AM, Daniel P. Smith <dpsmith@apertussolutions.c=
om> wrote:
>>
>> =EF=BB=BFOn 6/1/20 12:51 PM, Andy Lutomirski wrote:
>>>> On Mon, Jun 1, 2020 at 8:33 AM Daniel P. Smith
>>>> <dpsmith@apertussolutions.com> wrote:
>>>>
>>>> On 5/7/20 7:06 AM, Daniel Kiper wrote:
>>>>> Hi =C5=81ukasz,
>>>>>
>>>>> On Tue, May 05, 2020 at 04:38:02PM +0200, Lukasz Hawrylko wrote:
>>>>>>> On Tue, 2020-05-05 at 01:21 +0200, Daniel Kiper wrote:
>>>>
>>>> ...
>>>>
>>>>>> In OS-MLE table there is a buffer for TPM event log, however I see t=
hat
>>>>>> you are not using it, but instead allocate space somewhere in the
>>>>>
>>>>> I think that this part requires more discussion. In my opinion we sho=
uld
>>>>> have this region dynamically allocated because it gives us more flexi=
bility.
>>>>> Of course there is a question about the size of this buffer too. I am
>>>>> not sure about that because I have not checked yet how many log entri=
es
>>>>> are created by the SINIT ACM. Though probably it should not be large.=
..
>>>>>
>>>>>> memory. I am just wondering if, from security perspective, it will b=
e
>>>>>> better to use memory from TXT heap for event log, like we do in TBOO=
T.
>>>>>
>>>>> Appendix F, TPM Event Log, has following sentence: There are no
>>>>> requirements for event log to be in DMA protected memory =E2=80=93 SI=
NIT will
>>>>> not enforce it.
>>>>>
>>>>> I was thinking about it and it seems to me that the TPM event log doe=
s
>>>>> not require any special protections. Any changes in it can be quickly
>>>>> detected by comparing hashes with the TPM PCRs. Does not it?
>>>>>
>>>>
>>>> I think it would be beneficial to consider the following in deciding
>>>> where the log is placed. There are two areas of attack/manipulation th=
at
>>>> need to be considered. The first area is the log contents itself, whic=
h
>>>> as Daniel has pointed out, the log contents do not really need to be
>>>> protected from tampering as that would/should be detected during
>>>> verification by the attestor. The second area that we need to consider
>>>> is the log descriptors themselves. If these are in an area that can be
>>>> manipulated, it is an opportunity for an attacker to attempt to
>>>> influence the ACM's execution. For a little perspective, the ACM
>>>> executes from CRAM to take the most possible precaution to ensure that
>>>> it cannot be tampered with during execution. This is very important
>>>> since it runs a CPU mode (ACM Mode) that I would consider to be higher
>>>> (or lower depending on how you view it) than SMM. As a result, the txt
>>>> heap is also included in what is mapped into CRAM. If the event log is
>>>> place in the heap, this ensures that the ACM is not using memory outsi=
de
>>>> of CRAM during execution. Now as Daniel has pointed out, the down side
>>>> to this is that it greatly restricts the log size and can only be
>>>> managed by a combination of limiting the number of events and
>>>> restricting what content is carried in the event data field.
>>>
>>> Can you clarify what the actual flow of control is?  If I had to guess,=
 it's:
>>>
>>> GRUB (or other bootloader) writes log.
>>>
>>> GRUB transfers control to the ACM.  At this point, GRUB is done
>>> running and GRUB code will not run again.
>>>
>>> ACM validates system configuration and updates TPM state using magic
>>> privileged TPM access.
>>>
>>> ACM transfers control to the shiny new Linux secure launch entry point
>>>
>>> Maybe this is right, and maybe this is wrong.  But I have some
>>> questions about this whole setup.  Is the ACM code going to inspect
>>> this log at all?  If so, why?  Who supplies the ACM code?  If the ACM
>>> can be attacked by putting its inputs (e.g. this log) in the wrong
>>> place in memory, why should this be considered anything other than a
>>> bug in the ACM?
>>
>> There is a lot behind that, so to get a complete detail of the event
>> sequence I would recommend looking at Section Vol. 2D 6.2.3 (pg Vol. 2D
>> 6-5/ pdf pg 2531), 6.3 GETSEC[ENTERACCS](pg 6-10 Vol. 2D/pdf pg 2546),
>> and 6.3 GETSEC[SENTER](pg Vol. 2D 6-21/pdf pg 2557) in the Intel SDM[1].
>> Section 6.2.3 gives a slightly detailed overview. Section
>> GETSEC[ENTERACCS] details the requirements/procedures for entering AC
>> execution mode and ACRAM (Authenticated CRAM) and section GETSEC[SENTER]
>> will detail requirements/procedures for SENTER.
>>
>> To answer you additional questions I would say if you look at all the
>> work that goes into protecting the ACM execution, why would you want to
>> then turn around and have it use memory outside of the protected region.
>> On the other hand, you are right, if the Developer's Guide says it
>> doesn't need to be protected and someone somehow finds a way to cause a
>> failure in the ACM through the use of a log outside of CRAM, then
>> rightfully that is a bug in the ACM. This is why I asked about making it
>> configurable, paranoid people could set the configuration to use the
>> heap and all others could just use an external location.
>=20
> And this provides no protection whatsoever to paranoid people AFAICS, unl=
ess the location gets hashed before any processing occurs.

Apologies but that is exactly what it says. From section 6.2.3,

"After the GETSEC[SENTER] rendezvous handshake is performed between all
logical processors in the platform, the ILP loads the chipset
authenticated code module (SINIT) and performs an authentication check.
If the check passes, the processor hashes the SINIT AC module and stores
the result into TPM PCR 17. It then switches execution context to the
SINIT AC module."

To get a little into the details, the ACM is signed with an RSA key that
is deeply embedded into the CPU, thus why there is an ACM per
architecture as each one gets a new key. The authentication check is
detailed in the section GETSEC[ENTERACCS], but in the end the ACM has
had a crypto signature check carried out by the CPU (not firmware) and
is also cryptographically hashed by the CPU (again not firmware). On top
of this, both operations are executed after all interrupts have been
disabled and the ACM has been loaded into ACRAM from memory that was
protected by the IOMMU. Only after all this succeeds is the ACM allowed
to execute.

> But you haven=E2=80=99t answered the most important question: what is the=
 ACM doing with this log?  I feel like a lot of details are being covered b=
ut the big picture is missing.

To the ACM, this is just an allocated buffer for it to record a TPM
event log for all the measurements it takes. It has been a while since I
 have manually reviewed a TXT event log but I want to say there are
about five measurements taken before the ACM exits, including recording
the CRTM taken by the CPU. As such, it initialize the beginning of the
buffer with a TXT log header and records a UEFI TPM Event for each
measurement it takes. In theory, it will only ever write to this memory
but seeing that the ACM is a binary blob, I have never seen
programmatically if it ever tries reading from the memory.

>>
>>> If GRUB is indeed done by the time anyone consumes the log, why does
>>> GRUB care where the log ends up?
>>
>> This is because the log buffer allocation was made the responsibility of
>> the pre-launch environment, in this case GRUB, and is communicated to
>> the ACM via the os_to_mle structure.
>>
>>> And finally, the log presumably has nonzero size, and it would be nice
>>> not to pin some physical memory forever for the log.  Could the kernel
>>> copy it into tmpfs during boot so it's at least swappable and then
>>> allow userspace to delete it when userspace is done with it?
>>>
>>
>> Actually yes we will want to do that because when we move to enabling
>> relaunching, an implementation may want to preserve the log from the
>> last launch before triggering the new launch which will result in a
>> reset of the DRTM PCRs and an overwriting the log.
>=20
> I=E2=80=99m having a bit of trouble understanding how this log is useful =
for a relaunch. At the point that you=E2=80=99re relaunching, the log is ev=
en less trustworthy than on first launch. At least on first launch, if you =
dial up your secure and verified boot settings tight enough, you can have s=
ome degree of confidence in the boot environment. But on a relaunch, I don=
=E2=80=99t see how the log is useful for anything more than any other piece=
 of kernel memory.
>=20
> What am I missing?
>=20

Before relaunch you can have the TPM do a sign quote of the log to bind
the contents to the state of the PCRs. The why you would do that is more
about enterprise use-cases concerned with the lifecycle of enterprise
devices.When relaunch occurs, the DRTM PCRs will be reset by the CPU
before the CRTM for the relaunch is taken by the CPU and the ACM will
overwrite the existing log with new log entries. As highlighted above,
the CRTM and all measurements take by the ACM will have an extremely low
risk of external/attacker influence. When the MLE takes control,
interrupts will still be disabled and any measurements it takes prior to
enabling them will have a low risk of external/attacker influence. Once
the MLE enables the interrupts is when you have the situation whereby
the integrity you just established about the runtime can be compromised
by hostile firmware (UEFI runtime services, SMI handler, EC firmware,
PCI devices, etc.), hostile applications, and a hostile network. At this
point we could devolve into discourse over how long can load time
integrity measurements be considered trustworthy but I don't think that
is relevant to the issue at hand.

In other words, the log for the relaunch to attest what is currently
running is really no less useful than using the first launch log to
attest to the what was running in the first launch.

