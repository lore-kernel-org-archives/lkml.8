Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D629C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 01:29:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 09D482073B
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 01:29:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=apertussolutions.com header.i=dpsmith@apertussolutions.com header.b="hW/f3fxV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726363AbgFBB3y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 21:29:54 -0400
Received: from sender4-of-o51.zoho.com ([136.143.188.51]:21198 "EHLO
        sender4-of-o51.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725804AbgFBB3x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 21:29:53 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1591061351; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=X8YxfuPazl7mHnj3IxfR+M405TYMuZxNB09ddihbLVcWq4wa8Wq288iYKiDBTabkEVV//NdJSF3vOMaYzAh1e81jiT+/HRy5fG7NM1d+ZzRKa11hdoYKObR2MNYp3MELk/0n+1CZV2biMbOVxSaEhWQUKt5me+UCjsPUmkdR9d4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1591061351; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=I+UGxvPJIllkMa39UOn+I1LFV6NgfWusHXOM8wN/vO4=; 
        b=SeAbEfI6UQlWUHnuMxDPtxSEMxuRD+2AWNjbg5j6a4LaFjdY2LLzU6xTnylwDdaynLn6WPEakHC9us98uGhz6LSe9dCY/Qj9xmNEmr/oyVm39Bm2kKHLYjsxkyeeZLnAASjQNzUV+Fu7wd1GDuGw8R0YoKRLjr9C2dm/myWmCb4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=apertussolutions.com;
        spf=pass  smtp.mailfrom=dpsmith@apertussolutions.com;
        dmarc=pass header.from=<dpsmith@apertussolutions.com> header.from=<dpsmith@apertussolutions.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1591061351;
        s=zoho; d=apertussolutions.com; i=dpsmith@apertussolutions.com;
        h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:In-Reply-To:Content-Type:Content-Transfer-Encoding;
        bh=I+UGxvPJIllkMa39UOn+I1LFV6NgfWusHXOM8wN/vO4=;
        b=hW/f3fxVOGD7YCFd+5KsGL74sgwFOK/v+FpykSGK24tNYtyFhEbxmeJtxRxyHE1E
        3N5G3qXNmd2RC4o2dcEwJgiPE7vOnzu1BXcwOYT+sPB7M4rkd9ZIr5gehEjOcuJdfKe
        yZWx219hkcdzI7v5fLzjAzgzhXnfPPKbICApLXNY=
Received: from [10.10.1.24] (c-73-129-47-101.hsd1.md.comcast.net [73.129.47.101]) by mx.zohomail.com
        with SMTPS id 1591061348180264.5929256851624; Mon, 1 Jun 2020 18:29:08 -0700 (PDT)
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
References: <f954e9ef-295a-a8ce-0ff8-a88ad81b01a3@apertussolutions.com>
 <C6007C2B-AEFF-4A48-B791-323CDC04266D@amacapital.net>
From:   "Daniel P. Smith" <dpsmith@apertussolutions.com>
Message-ID: <01cc067e-f2f2-d4da-6944-2724dbc7b61e@apertussolutions.com>
Autocrypt: addr=dpsmith@apertussolutions.com; prefer-encrypt=mutual; keydata=
 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
Date:   Mon, 1 Jun 2020 21:29:05 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <C6007C2B-AEFF-4A48-B791-323CDC04266D@amacapital.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-ZohoMailClient: External
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/1/20 8:49 PM, Andy Lutomirski wrote:
>=20
>=20
>> On Jun 1, 2020, at 5:14 PM, Daniel P. Smith <dpsmith@apertussolutions.co=
m> wrote:
>>
>> =EF=BB=BFOn 6/1/20 3:39 PM, Andy Lutomirski wrote:
>>>>> .
>>
>> In other words, the log for the relaunch to attest what is currently
>> running is really no less useful than using the first launch log to
>> attest to the what was running in the first launch.
>>
>=20
> Maybe it would help if you give some examples of what=E2=80=99s actually =
in this log and why anyone, Linux or otherwise, cares for any purpose other=
 than debugging.  We=E2=80=99re talking about a log written by something li=
ke GRUB, right?  If so, I=E2=80=99m imagining things like:
>=20
> GRUB: loading such-and-such module
> GRUB: loading the other module
> GRUB: loading Linux at /boot/vmlinuz-whatever
> GRUB: about to do the DRTM launch. Bye-bye.
>=20
> This is surely useful for debugging.  But, if I understand your security =
model correctly, it=E2=80=99s untrustworthy in the sense that this all come=
s from before the DRTM launch and it could have been tampered with by SMM c=
ode or even just a malicious USB stick.  Or even a malicious compromised ke=
rnel on the same machine. So you could hash this log into a PCR, but I don=
=E2=80=99t see what you=E2=80=99ve accomplished by doing so.
>=20
> Or have I misunderstood what this log is?  Perhaps you=E2=80=99re talking=
 about something else entirely.
>=20

Oh I see! Yes we are discussing two different logs and yes there are two
"logs" in play here. The start of this thread by Lukasz was on the TPM
Event log. This is the log that is a record of TPM events for the DRTM
chain, you can see the equivalent for SRTM with `cat
/sys/kernel/security/tpm0/ascii_bios_measurements`(provided you system
configuration is set up for SRTM). The second log, which for lack of a
better name is the "debug log", is what you are referring to and is in
another proposal that just recently came out, "[BOOTLOADER SPECIFICATION
RFC] The bootloader log format for TrenchBoot"[1].

You are correct, the "debug log" is just filled with messages from
components during the DRTM launch chain. While relaunch is being kept in
mind as we work through getting first launch complete, not all aspects
have been considered. What happens to the debug log on relaunch has no
security relevance, as you called out earlier, and at this point I would
say is an exercise for those integrating relaunch when it becomes
available. I would expect them to treat it no different than the kmesg
and syslog buffers on kexec/reboot, some may opt to kept a historical
record and others will just let it disappear into the ether.

Apologies that we got disconnected, I hope we are in sync now.

[1] https://lists.gnu.org/archive/html/grub-devel/2020-05/msg00223.html

