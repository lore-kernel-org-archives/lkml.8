Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CE4FC433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 19:39:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 62B98206E2
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 19:39:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="si1BWPtn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728133AbgFATjy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 15:39:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726201AbgFATjy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 15:39:54 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02971C061A0E
        for <linux-kernel@vger.kernel.org>; Mon,  1 Jun 2020 12:39:53 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id v2so3934966pfv.7
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jun 2020 12:39:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=uhiHHIxjB/bjQ93YSD/lAs3/au9BCMqjzPLjbXnYLRY=;
        b=si1BWPtnq1T2kQOmc+tCiCLJCHrzl1/xb2TbMtECfkjWeMnAOh1GSlwdlcxOVrpq05
         ugVzD2y04MXMbLDlqVSr9YqwZmtz3X6aJWw03zLnjgdVpNIGAgbmjhBYTZase73V4HTL
         Rr3NAIas3jMVjFtAItzvNQdYUN2aYufgQZDFmAvbNogvlBkUblzpqVPcz1PlyHFdvjbX
         vT5Ip1fSHJodwvw4XT4GFaBWGVRyrdT7+1wMBo8Mo3ca2eo+3m2r/VsOs0ULOr2NHnff
         OshOLtdcUOys3fibGcC6sm5utjEeB6TNevUAaJWFC8+ReGY22hB3ldSFP7AZPod4y5TZ
         WhHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=uhiHHIxjB/bjQ93YSD/lAs3/au9BCMqjzPLjbXnYLRY=;
        b=rHwUUylaGutAmOyZvMIEdtCViV/f1pZKhSD5iLw2yvw57oe34BXrHRcM6hxGTYcMqi
         QconFNJacwlL+T+FShRgnSKIWO6ITm3GmkdloKACFNNewHBs24PkF60eOvVLPP1bbzPd
         0/hcJXE1xvtmqEeOQ0fd4xlJ9kGitkmoF7LR0ONcZDYlR9QFihADaX9XO55d5U+LaDXl
         to6GINR041n9arrRtu7MBcjmK+Am4sdK9NP+BKVqGZzb/jLeHKMKIEWOgWENaeeNmqfu
         a+KFdes24RQqA1vq6wzsRxiQrBeYUdnSjb93nJLwHAec5muNQwflaDXk9z6k04isNYTo
         Hxpw==
X-Gm-Message-State: AOAM530DMex28Og9dPoYJ/6Dl/GjkmOsi2frklWkiRk7IpeTxkI124zZ
        TnD2sHonKqt9FKGn9sB9SozN/BvLzTU=
X-Google-Smtp-Source: ABdhPJz7ntRFBVsI4R4lQUKhrZSwPoyIC3XgZ4XGGZM/gnY0irtlLyngYupTQFBd8yqnMmVfpxL/OQ==
X-Received: by 2002:aa7:8084:: with SMTP id v4mr22449750pff.211.1591040393283;
        Mon, 01 Jun 2020 12:39:53 -0700 (PDT)
Received: from ?IPv6:2601:646:c200:1ef2:4c36:c319:254d:f36c? ([2601:646:c200:1ef2:4c36:c319:254d:f36c])
        by smtp.gmail.com with ESMTPSA id z140sm210921pfc.135.2020.06.01.12.39.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Jun 2020 12:39:52 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Andy Lutomirski <luto@amacapital.net>
Mime-Version: 1.0 (1.0)
Subject: Re: [GRUB PATCH RFC 00/18] i386: Intel TXT secure launcher
Date:   Mon, 1 Jun 2020 12:39:50 -0700
Message-Id: <120CC5EB-297D-46C4-91FC-E9D6E5B88C18@amacapital.net>
References: <8c82e8e4-d6bb-7cba-dd32-378dd1c30f3e@apertussolutions.com>
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
In-Reply-To: <8c82e8e4-d6bb-7cba-dd32-378dd1c30f3e@apertussolutions.com>
To:     "Daniel P. Smith" <dpsmith@apertussolutions.com>
X-Mailer: iPhone Mail (17E262)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On Jun 1, 2020, at 10:56 AM, Daniel P. Smith <dpsmith@apertussolutions.com=
> wrote:
>=20
> =EF=BB=BFOn 6/1/20 12:51 PM, Andy Lutomirski wrote:
>>> On Mon, Jun 1, 2020 at 8:33 AM Daniel P. Smith
>>> <dpsmith@apertussolutions.com> wrote:
>>>=20
>>> On 5/7/20 7:06 AM, Daniel Kiper wrote:
>>>> Hi =C5=81ukasz,
>>>>=20
>>>> On Tue, May 05, 2020 at 04:38:02PM +0200, Lukasz Hawrylko wrote:
>>>>>> On Tue, 2020-05-05 at 01:21 +0200, Daniel Kiper wrote:
>>>=20
>>> ...
>>>=20
>>>>> In OS-MLE table there is a buffer for TPM event log, however I see tha=
t
>>>>> you are not using it, but instead allocate space somewhere in the
>>>>=20
>>>> I think that this part requires more discussion. In my opinion we shoul=
d
>>>> have this region dynamically allocated because it gives us more flexibi=
lity.
>>>> Of course there is a question about the size of this buffer too. I am
>>>> not sure about that because I have not checked yet how many log entries=

>>>> are created by the SINIT ACM. Though probably it should not be large...=

>>>>=20
>>>>> memory. I am just wondering if, from security perspective, it will be
>>>>> better to use memory from TXT heap for event log, like we do in TBOOT.=

>>>>=20
>>>> Appendix F, TPM Event Log, has following sentence: There are no
>>>> requirements for event log to be in DMA protected memory =E2=80=93 SINI=
T will
>>>> not enforce it.
>>>>=20
>>>> I was thinking about it and it seems to me that the TPM event log does
>>>> not require any special protections. Any changes in it can be quickly
>>>> detected by comparing hashes with the TPM PCRs. Does not it?
>>>>=20
>>>=20
>>> I think it would be beneficial to consider the following in deciding
>>> where the log is placed. There are two areas of attack/manipulation that=

>>> need to be considered. The first area is the log contents itself, which
>>> as Daniel has pointed out, the log contents do not really need to be
>>> protected from tampering as that would/should be detected during
>>> verification by the attestor. The second area that we need to consider
>>> is the log descriptors themselves. If these are in an area that can be
>>> manipulated, it is an opportunity for an attacker to attempt to
>>> influence the ACM's execution. For a little perspective, the ACM
>>> executes from CRAM to take the most possible precaution to ensure that
>>> it cannot be tampered with during execution. This is very important
>>> since it runs a CPU mode (ACM Mode) that I would consider to be higher
>>> (or lower depending on how you view it) than SMM. As a result, the txt
>>> heap is also included in what is mapped into CRAM. If the event log is
>>> place in the heap, this ensures that the ACM is not using memory outside=

>>> of CRAM during execution. Now as Daniel has pointed out, the down side
>>> to this is that it greatly restricts the log size and can only be
>>> managed by a combination of limiting the number of events and
>>> restricting what content is carried in the event data field.
>>=20
>> Can you clarify what the actual flow of control is?  If I had to guess, i=
t's:
>>=20
>> GRUB (or other bootloader) writes log.
>>=20
>> GRUB transfers control to the ACM.  At this point, GRUB is done
>> running and GRUB code will not run again.
>>=20
>> ACM validates system configuration and updates TPM state using magic
>> privileged TPM access.
>>=20
>> ACM transfers control to the shiny new Linux secure launch entry point
>>=20
>> Maybe this is right, and maybe this is wrong.  But I have some
>> questions about this whole setup.  Is the ACM code going to inspect
>> this log at all?  If so, why?  Who supplies the ACM code?  If the ACM
>> can be attacked by putting its inputs (e.g. this log) in the wrong
>> place in memory, why should this be considered anything other than a
>> bug in the ACM?
>=20
> There is a lot behind that, so to get a complete detail of the event
> sequence I would recommend looking at Section Vol. 2D 6.2.3 (pg Vol. 2D
> 6-5/ pdf pg 2531), 6.3 GETSEC[ENTERACCS](pg 6-10 Vol. 2D/pdf pg 2546),
> and 6.3 GETSEC[SENTER](pg Vol. 2D 6-21/pdf pg 2557) in the Intel SDM[1].
> Section 6.2.3 gives a slightly detailed overview. Section
> GETSEC[ENTERACCS] details the requirements/procedures for entering AC
> execution mode and ACRAM (Authenticated CRAM) and section GETSEC[SENTER]
> will detail requirements/procedures for SENTER.
>=20
> To answer you additional questions I would say if you look at all the
> work that goes into protecting the ACM execution, why would you want to
> then turn around and have it use memory outside of the protected region.
> On the other hand, you are right, if the Developer's Guide says it
> doesn't need to be protected and someone somehow finds a way to cause a
> failure in the ACM through the use of a log outside of CRAM, then
> rightfully that is a bug in the ACM. This is why I asked about making it
> configurable, paranoid people could set the configuration to use the
> heap and all others could just use an external location.

And this provides no protection whatsoever to paranoid people AFAICS, unless=
 the location gets hashed before any processing occurs.

But you haven=E2=80=99t answered the most important question: what is the AC=
M doing with this log?  I feel like a lot of details are being covered but t=
he big picture is missing.

>=20
>> If GRUB is indeed done by the time anyone consumes the log, why does
>> GRUB care where the log ends up?
>=20
> This is because the log buffer allocation was made the responsibility of
> the pre-launch environment, in this case GRUB, and is communicated to
> the ACM via the os_to_mle structure.
>=20
>> And finally, the log presumably has nonzero size, and it would be nice
>> not to pin some physical memory forever for the log.  Could the kernel
>> copy it into tmpfs during boot so it's at least swappable and then
>> allow userspace to delete it when userspace is done with it?
>>=20
>=20
> Actually yes we will want to do that because when we move to enabling
> relaunching, an implementation may want to preserve the log from the
> last launch before triggering the new launch which will result in a
> reset of the DRTM PCRs and an overwriting the log.

I=E2=80=99m having a bit of trouble understanding how this log is useful for=
 a relaunch. At the point that you=E2=80=99re relaunching, the log is even l=
ess trustworthy than on first launch. At least on first launch, if you dial u=
p your secure and verified boot settings tight enough, you can have some deg=
ree of confidence in the boot environment. But on a relaunch, I don=E2=80=99=
t see how the log is useful for anything more than any other piece of kernel=
 memory.

What am I missing?

