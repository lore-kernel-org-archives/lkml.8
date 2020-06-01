Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56F40C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 17:56:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A16720776
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 17:56:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=apertussolutions.com header.i=dpsmith@apertussolutions.com header.b="jwTpDEnx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728751AbgFAR4w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 13:56:52 -0400
Received: from sender4-of-o51.zoho.com ([136.143.188.51]:21103 "EHLO
        sender4-of-o51.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728726AbgFAR4u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 13:56:50 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1591034177; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=fxo7TKOvI37RlJuryi8f4vwwnkj/6xuxeN7D/dFcH5NKZVy1XJ6kVPml77FgjqdHJX+A0xZmDRwpCfjg3WE96iuZXrJWYKAtSqFrcX8Kr9LjKay+H3tT+RvRDaa8gqmMDdYCD0apwtzdVFim4vdrAWA4PXVOM+6BAsw2lEZNEZE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1591034177; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=XHTQ5h5I8tLf+Zn0iCml9uUNPQv68uEXLDQqvmS4FGg=; 
        b=cVKalnzDaTuVEJ+oNcCjT7d3jAayK/USRGfqkNkpv6LCSQ7YYpij+ItfjO9LxmKXjheGgKe7qWiZ2y/zoh0zYtKpEsCstVbDq6znbpgDbGeQe4T8wRp3mvo5y5YLFXl6KUVF/EAjEQj2q4PiGTTm2bOEOI0H0EN6HHWE1XDCSC4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=apertussolutions.com;
        spf=pass  smtp.mailfrom=dpsmith@apertussolutions.com;
        dmarc=pass header.from=<dpsmith@apertussolutions.com> header.from=<dpsmith@apertussolutions.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1591034177;
        s=zoho; d=apertussolutions.com; i=dpsmith@apertussolutions.com;
        h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:In-Reply-To:Content-Type:Content-Transfer-Encoding;
        bh=XHTQ5h5I8tLf+Zn0iCml9uUNPQv68uEXLDQqvmS4FGg=;
        b=jwTpDEnxHWuLBzAkLmxfLqNo0ntL3gsolt/iePcKvC2t7TcmKEettV5rr6NpkVRB
        C/YEAHOtw/aG+EDLf3Uh3nX+mjSoZFgfw65WARvYIWYs48WTWvN7Vmcx/zIBPlSvM72
        G9MNJEWsD5LaBkI8RtH643QL4OxEMn2tg6CQIM8k=
Received: from [10.10.1.24] (c-73-129-47-101.hsd1.md.comcast.net [73.129.47.101]) by mx.zohomail.com
        with SMTPS id 1591034173657543.409932559172; Mon, 1 Jun 2020 10:56:13 -0700 (PDT)
Subject: Re: [GRUB PATCH RFC 00/18] i386: Intel TXT secure launcher
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Daniel Kiper <daniel.kiper@oracle.com>,
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
References: <20200504232132.23570-1-daniel.kiper@oracle.com>
 <2dad6366d2fceb0a9e36f284a8ed5a8ed86d8756.camel@linux.intel.com>
 <20200507110634.2yvzirauq5md7d2q@tomti.i.net-space.pl>
 <d1b55f25-e54c-b259-8836-d834a572de3b@apertussolutions.com>
 <CALCETrVPK=m3F84NtiU59SLyDrBNxi1ONyhH1GuOhx4aGU=_fQ@mail.gmail.com>
From:   "Daniel P. Smith" <dpsmith@apertussolutions.com>
Message-ID: <8c82e8e4-d6bb-7cba-dd32-378dd1c30f3e@apertussolutions.com>
Autocrypt: addr=dpsmith@apertussolutions.com; prefer-encrypt=mutual; keydata=
 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
Date:   Mon, 1 Jun 2020 13:56:10 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <CALCETrVPK=m3F84NtiU59SLyDrBNxi1ONyhH1GuOhx4aGU=_fQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-ZohoMailClient: External
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/1/20 12:51 PM, Andy Lutomirski wrote:
> On Mon, Jun 1, 2020 at 8:33 AM Daniel P. Smith
> <dpsmith@apertussolutions.com> wrote:
>>
>> On 5/7/20 7:06 AM, Daniel Kiper wrote:
>>> Hi =C5=81ukasz,
>>>
>>> On Tue, May 05, 2020 at 04:38:02PM +0200, Lukasz Hawrylko wrote:
>>>> On Tue, 2020-05-05 at 01:21 +0200, Daniel Kiper wrote:
>>
>> ...
>>
>>>> In OS-MLE table there is a buffer for TPM event log, however I see tha=
t
>>>> you are not using it, but instead allocate space somewhere in the
>>>
>>> I think that this part requires more discussion. In my opinion we shoul=
d
>>> have this region dynamically allocated because it gives us more flexibi=
lity.
>>> Of course there is a question about the size of this buffer too. I am
>>> not sure about that because I have not checked yet how many log entries
>>> are created by the SINIT ACM. Though probably it should not be large...
>>>
>>>> memory. I am just wondering if, from security perspective, it will be
>>>> better to use memory from TXT heap for event log, like we do in TBOOT.
>>>
>>> Appendix F, TPM Event Log, has following sentence: There are no
>>> requirements for event log to be in DMA protected memory =E2=80=93 SINI=
T will
>>> not enforce it.
>>>
>>> I was thinking about it and it seems to me that the TPM event log does
>>> not require any special protections. Any changes in it can be quickly
>>> detected by comparing hashes with the TPM PCRs. Does not it?
>>>
>>
>> I think it would be beneficial to consider the following in deciding
>> where the log is placed. There are two areas of attack/manipulation that
>> need to be considered. The first area is the log contents itself, which
>> as Daniel has pointed out, the log contents do not really need to be
>> protected from tampering as that would/should be detected during
>> verification by the attestor. The second area that we need to consider
>> is the log descriptors themselves. If these are in an area that can be
>> manipulated, it is an opportunity for an attacker to attempt to
>> influence the ACM's execution. For a little perspective, the ACM
>> executes from CRAM to take the most possible precaution to ensure that
>> it cannot be tampered with during execution. This is very important
>> since it runs a CPU mode (ACM Mode) that I would consider to be higher
>> (or lower depending on how you view it) than SMM. As a result, the txt
>> heap is also included in what is mapped into CRAM. If the event log is
>> place in the heap, this ensures that the ACM is not using memory outside
>> of CRAM during execution. Now as Daniel has pointed out, the down side
>> to this is that it greatly restricts the log size and can only be
>> managed by a combination of limiting the number of events and
>> restricting what content is carried in the event data field.
>=20
> Can you clarify what the actual flow of control is?  If I had to guess, i=
t's:
>=20
> GRUB (or other bootloader) writes log.
>=20
> GRUB transfers control to the ACM.  At this point, GRUB is done
> running and GRUB code will not run again.
>=20
> ACM validates system configuration and updates TPM state using magic
> privileged TPM access.
>=20
> ACM transfers control to the shiny new Linux secure launch entry point
>=20
> Maybe this is right, and maybe this is wrong.  But I have some
> questions about this whole setup.  Is the ACM code going to inspect
> this log at all?  If so, why?  Who supplies the ACM code?  If the ACM
> can be attacked by putting its inputs (e.g. this log) in the wrong
> place in memory, why should this be considered anything other than a
> bug in the ACM?

There is a lot behind that, so to get a complete detail of the event
sequence I would recommend looking at Section Vol. 2D 6.2.3 (pg Vol. 2D
6-5/ pdf pg 2531), 6.3 GETSEC[ENTERACCS](pg 6-10 Vol. 2D/pdf pg 2546),
and 6.3 GETSEC[SENTER](pg Vol. 2D 6-21/pdf pg 2557) in the Intel SDM[1].
Section 6.2.3 gives a slightly detailed overview. Section
GETSEC[ENTERACCS] details the requirements/procedures for entering AC
execution mode and ACRAM (Authenticated CRAM) and section GETSEC[SENTER]
will detail requirements/procedures for SENTER.

To answer you additional questions I would say if you look at all the
work that goes into protecting the ACM execution, why would you want to
then turn around and have it use memory outside of the protected region.
On the other hand, you are right, if the Developer's Guide says it
doesn't need to be protected and someone somehow finds a way to cause a
failure in the ACM through the use of a log outside of CRAM, then
rightfully that is a bug in the ACM. This is why I asked about making it
configurable, paranoid people could set the configuration to use the
heap and all others could just use an external location.

> If GRUB is indeed done by the time anyone consumes the log, why does
> GRUB care where the log ends up?

This is because the log buffer allocation was made the responsibility of
the pre-launch environment, in this case GRUB, and is communicated to
the ACM via the os_to_mle structure.

> And finally, the log presumably has nonzero size, and it would be nice
> not to pin some physical memory forever for the log.  Could the kernel
> copy it into tmpfs during boot so it's at least swappable and then
> allow userspace to delete it when userspace is done with it?
>=20

Actually yes we will want to do that because when we move to enabling
relaunching, an implementation may want to preserve the log from the
last launch before triggering the new launch which will result in a
reset of the DRTM PCRs and an overwriting the log.

[1]
https://software.intel.com/sites/default/files/managed/39/c5/325462-sdm-vol=
-1-2abcd-3abcd.pdf

