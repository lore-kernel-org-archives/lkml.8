Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9503C2D0E8
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 22:50:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDC3B20714
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 22:50:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=apertussolutions.com header.i=dpsmith@apertussolutions.com header.b="Y9X3WRfg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727585AbgCZWuQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 18:50:16 -0400
Received: from sender4-of-o51.zoho.com ([136.143.188.51]:21189 "EHLO
        sender4-of-o51.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726296AbgCZWuP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 18:50:15 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1585262998; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=MwHpp9lo9/JEwoEx5Fs/Sk8XJpG9093FeCXe5UOdpVHvJFWLcDiSboqWe/VVTs29EQE5xA+Ayjhxe1PSKylYdCV5weNkPKSCh9Gq4Wh7KAhntaHyN4Fn1DAuUs4qmrEILhzMEn5tMImzDOLoy+oewH3sSWYklU1pfIDTR0p3vc0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1585262998; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=8D/KyE1YFPqKDtrWv+DJGQKoAdddlWufVRFz/+QF7wM=; 
        b=EvHwiOaI21pGrPC5zIArJhx5qGL2jALkaSmpsEH9n1h1ogCAcV9q90Ml8nGBlxn/mRPA9vSNs5zv3/k/Ry5JVy5L8MW1OofQq0ci+jCYQQrLjeHiJxhC5zBDTdySZNxNXwoDOTk4n7nbOl87GreuT/MvzD1kBI20Rdbo4ZY8RfU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=apertussolutions.com;
        spf=pass  smtp.mailfrom=dpsmith@apertussolutions.com;
        dmarc=pass header.from=<dpsmith@apertussolutions.com> header.from=<dpsmith@apertussolutions.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1585262998;
        s=zoho; d=apertussolutions.com; i=dpsmith@apertussolutions.com;
        h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:In-Reply-To:Content-Type:Content-Transfer-Encoding;
        bh=8D/KyE1YFPqKDtrWv+DJGQKoAdddlWufVRFz/+QF7wM=;
        b=Y9X3WRfgyI7J4HZWC9su23q9Sx6XcUNOH/M7Em0+eeGsKZSTPoYsAOg8Hrbd31M4
        W9wgkiOvsDn8qg95uipRdDkPobl2MKOw9S2wHnoBecwjjPg9VlFHLYc9LPok2sbafaN
        YF2hyUYCP61tXKuNy/8MpoZozbIg4uYgkDQTTxo0=
Received: from [10.10.1.24] (c-73-129-47-101.hsd1.md.comcast.net [73.129.47.101]) by mx.zohomail.com
        with SMTPS id 1585262995928553.9786856217474; Thu, 26 Mar 2020 15:49:55 -0700 (PDT)
Subject: Re: [RFC PATCH 03/12] x86: Add early SHA support for Secure Launch
 early measurements
To:     Andy Lutomirski <luto@kernel.org>,
        Ross Philipson <ross.philipson@oracle.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, trenchboot-devel@googlegroups.com
References: <20200325194317.526492-1-ross.philipson@oracle.com>
 <20200325194317.526492-4-ross.philipson@oracle.com>
 <CALCETrUoA9dgi2omjePtzjL9=5AqHKhy57UksnxbohZVdLo_pQ@mail.gmail.com>
From:   "Daniel P. Smith" <dpsmith@apertussolutions.com>
Message-ID: <b3e7003e-9019-5402-0205-0248a4c24584@apertussolutions.com>
Autocrypt: addr=dpsmith@apertussolutions.com; prefer-encrypt=mutual; keydata=
 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
Date:   Thu, 26 Mar 2020 18:49:49 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <CALCETrUoA9dgi2omjePtzjL9=5AqHKhy57UksnxbohZVdLo_pQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-ZohoMailClient: External
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/25/20 11:44 PM, Andy Lutomirski wrote:
> On Wed, Mar 25, 2020 at 12:43 PM Ross Philipson
> <ross.philipson@oracle.com> wrote:
>>
>> From: "Daniel P. Smith" <dpsmith@apertussolutions.com>
>>
>> The SHA algorithms are necessary to measure configuration information in=
to
>> the TPM as early as possible before using the values. This implementatio=
n
>> uses the established approach of #including the SHA libraries directly i=
n
>> the code since the compressed kernel is not uncompressed at this point.
>>
>> The SHA1 code here has its origins in the code in
>> include/crypto/sha1_base.h. That code could not be pulled directly into
>> the setup portion of the compressed kernel because of other dependencies
>> it pulls in. So this is a modified copy of that code that still leverage=
s
>> the core SHA1 algorithm.
>>
>> Signed-off-by: Daniel P. Smith <dpsmith@apertussolutions.com>
>> ---
>>  arch/x86/Kconfig                        |  24 +++
>>  arch/x86/boot/compressed/Makefile       |   4 +
>>  arch/x86/boot/compressed/early_sha1.c   | 104 ++++++++++++
>>  arch/x86/boot/compressed/early_sha1.h   |  17 ++
>>  arch/x86/boot/compressed/early_sha256.c |   6 +
>>  arch/x86/boot/compressed/early_sha512.c |   6 +
>>  include/linux/sha512.h                  |  21 +++
>>  lib/sha1.c                              |   4 +
>>  lib/sha512.c                            | 209 ++++++++++++++++++++++++
>>  9 files changed, 395 insertions(+)
>>  create mode 100644 arch/x86/boot/compressed/early_sha1.c
>>  create mode 100644 arch/x86/boot/compressed/early_sha1.h
>>  create mode 100644 arch/x86/boot/compressed/early_sha256.c
>>  create mode 100644 arch/x86/boot/compressed/early_sha512.c
>>  create mode 100644 include/linux/sha512.h
>>  create mode 100644 lib/sha512.c
>>
>> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
>> index 7f3406a9948b..f37057d3ce9f 100644
>> --- a/arch/x86/Kconfig
>> +++ b/arch/x86/Kconfig
>> @@ -2025,6 +2025,30 @@ config SECURE_LAUNCH
>>           of all the modules and configuration information used for
>>           boooting the operating system.
>>
>> +choice
>> +       prompt "Select Secure Launch Algorithm for TPM2"
>> +       depends on SECURE_LAUNCH
>> +
>> +config SECURE_LAUNCH_SHA1
>> +       bool "Secure Launch TPM2 SHA1"
>> +       help
>> +         When using Secure Launch and TPM2 is present, use SHA1 hash
>> +         algorithm for measurements.
>> +
>=20
> I'm surprised this is supported at all.  Why allow SHA1?
>=20

The SHA1 code is already there for TPM1.2 and it is a valid supported
mode for TPM2 therefore we made it available. We could add a big glaring
warning that SHA1 is broken and should not be used unless you have a
very specific reason.

