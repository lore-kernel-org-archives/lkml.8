Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6FB9C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 07:06:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 949B7204EA
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 07:06:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728611AbgGFHG4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 03:06:56 -0400
Received: from mx2.suse.de ([195.135.220.15]:57334 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728015AbgGFHG4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 03:06:56 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id AEFE1AC9F;
        Mon,  6 Jul 2020 07:06:54 +0000 (UTC)
From:   NeilBrown <neilb@suse.de>
To:     Matthew Wilcox <willy6545@gmail.com>,
        Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 06 Jul 2020 17:06:45 +1000
Cc:     ksummit <ksummit-discuss@lists.linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        tech-board-discuss@lists.linuxfoundation.org,
        Chris Mason <clm@fb.clm>
Subject: Re: [Ksummit-discuss] [PATCH] CodingStyle: Inclusive Terminology
In-Reply-To: <CAFhKne_ZVWVhZX5hNEbeGBfU6BMRN9JKQeTsVYOcMmEH1cd3xg@mail.gmail.com>
References: <159389297140.2210796.13590142254668787525.stgit@dwillia2-desk3.amr.corp.intel.com> <CAFhKne_ZVWVhZX5hNEbeGBfU6BMRN9JKQeTsVYOcMmEH1cd3xg@mail.gmail.com>
Message-ID: <87imf115ru.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain

On Sat, Jul 04 2020, Matthew Wilcox wrote:

> Another suggestion for "slave" replacement should be "device". This is in
> the context of the w1 bus which is by far the largest user of the
> master/slave terminology in the kernel.

Ugh.  Please, no.  "device" doesn't mean anything, in that you can use
it to refer to any thing.  (i.e. it is almost semantically equivalent to
"thing").
Look in /sys/devices.  Everything in there is a device, and (nearly)
every thing is in there.

NeilBrown

>
> On Sat., Jul. 4, 2020, 16:19 Dan Williams, <dan.j.williams@intel.com> wrote:
>
>> Recent events have prompted a Linux position statement on inclusive
>> terminology. Given that Linux maintains a coding-style and its own
>> idiomatic set of terminology here is a proposal to answer the call to
>> replace non-inclusive terminology.
>>
>> Cc: Jonathan Corbet <corbet@lwn.net>
>> Cc: Kees Cook <keescook@chromium.org>
>> Signed-off-by: Chris Mason <clm@fb.clm>
>> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
>> ---
>>  Documentation/process/coding-style.rst          |   12 ++++
>>  Documentation/process/inclusive-terminology.rst |   64
>> +++++++++++++++++++++++
>>  Documentation/process/index.rst                 |    1
>>  3 files changed, 77 insertions(+)
>>  create mode 100644 Documentation/process/inclusive-terminology.rst
>>
>> diff --git a/Documentation/process/coding-style.rst
>> b/Documentation/process/coding-style.rst
>> index 2657a55c6f12..4b15ab671089 100644
>> --- a/Documentation/process/coding-style.rst
>> +++ b/Documentation/process/coding-style.rst
>> @@ -319,6 +319,18 @@ If you are afraid to mix up your local variable
>> names, you have another
>>  problem, which is called the function-growth-hormone-imbalance syndrome.
>>  See chapter 6 (Functions).
>>
>> +For symbol names, avoid introducing new usage of the words 'slave' and
>> +'blacklist'. Recommended replacements for 'slave' are: 'secondary',
>> +'subordinate', 'replica', 'responder', 'follower', 'proxy', or
>> +'performer'.  Recommended replacements for blacklist are: 'blocklist' or
>> +'denylist'.
>> +
>> +Exceptions for introducing new usage is to maintain a userspace ABI, or
>> +when updating code for an existing (as of 2020) hardware or protocol
>> +specification that mandates those terms. For new specifications consider
>> +translating specification usage of the terminology to the kernel coding
>> +standard where possible. See :ref:`process/inclusive-terminology.rst
>> +<inclusiveterminology>` for details.
>>
>>  5) Typedefs
>>  -----------
>> diff --git a/Documentation/process/inclusive-terminology.rst
>> b/Documentation/process/inclusive-terminology.rst
>> new file mode 100644
>> index 000000000000..a8eb26690eb4
>> --- /dev/null
>> +++ b/Documentation/process/inclusive-terminology.rst
>> @@ -0,0 +1,64 @@
>> +.. _inclusiveterminology:
>> +
>> +Linux kernel inclusive terminology
>> +==================================
>> +
>> +The Linux kernel is a global software project, and in 2020 there was a
>> +global reckoning on race relations that caused many organizations to
>> +re-evaluate their policies and practices relative to the inclusion of
>> +people of African descent. This document describes why the 'Naming'
>> +section in :ref:`process/coding-style.rst <codingstyle>` recommends
>> +avoiding usage of 'slave' and 'blacklist' in new additions to the Linux
>> +kernel.
>> +
>> +On the triviality of replacing words
>> +====================================
>> +
>> +The African slave trade was a brutal system of human misery deployed at
>> +global scale. Some word choice decisions in a modern software project
>> +does next to nothing to compensate for that legacy. So why put any
>> +effort into something so trivial in comparison? Because the goal is not
>> +to repair, or erase the past. The goal is to maximize availability and
>> +efficiency of the global developer community to participate in the Linux
>> +kernel development process.
>> +
>> +Word choice and developer efficiency
>> +====================================
>> +
>> +Why does any software project go through the trouble of developing a
>> +document like :ref:`process/coding-style.rst <codingstyle>`? It does so
>> +because a common coding style maximizes the efficiency of both
>> +maintainers and developers. Developers learn common design patterns and
>> +idiomatic expressions while maintainers can spot deviations from those
>> +norms. Even non-compliant whitespace is considered a leading indicator
>> +to deeper problems in a patchset. Coding style violations are known to
>> +take a maintainer "out of the zone" of reviewing code. Maintainers are
>> +also sensitive to word choice across specifications and often choose to
>> +deploy Linux terminology to replace non-idiomatic word-choice in a
>> +specification.
>> +
>> +Non-inclusive terminology has that same distracting effect which is why
>> +it is a style issue for Linux, it injures developer efficiency.
>> +
>> +Of course it is around this point someone jumps in with an etymological
>> +argument about why people should not be offended. Etymological arguments
>> +do not scale. The scope and pace of Linux to reach new developers
>> +exceeds the ability of historical terminology defenders to describe "no,
>> +not that connotation". The revelation of 2020 was that black voices were
>> +heard on a global scale and the Linux kernel project has done its small
>> +part to answer that call as it wants black voices, among all voices, in
>> +its developer community.
>> +
>> +Really, 'blacklist' too?
>> +========================
>> +
>> +While 'slave' has a direct connection to human suffering the etymology
>> +of 'blacklist' is devoid of a historical racial connection. However, one
>> +thought exercise is to consider replacing 'blacklist/whitelist' with
>> +'redlist/greenlist'. Realize that the replacement only makes sense if
>> +you have been socialized with the concepts that 'red/green' implies
>> +'stop/go'. Colors to represent a policy requires an indirection. The
>> +socialization of 'black/white' to have the connotation of
>> +'impermissible/permissible' does not support inclusion.
>> +
>> +Inclusion == global developer community efficiency.
>> diff --git a/Documentation/process/index.rst
>> b/Documentation/process/index.rst
>> index f07c9250c3ac..ed861f6f8d25 100644
>> --- a/Documentation/process/index.rst
>> +++ b/Documentation/process/index.rst
>> @@ -27,6 +27,7 @@ Below are the essential guides that every developer
>> should read.
>>     submitting-patches
>>     programming-language
>>     coding-style
>> +   inclusive-terminology
>>     maintainer-pgp-guide
>>     email-clients
>>     kernel-enforcement-statement
>>
>> _______________________________________________
>> Ksummit-discuss mailing list
>> Ksummit-discuss@lists.linuxfoundation.org
>> https://lists.linuxfoundation.org/mailman/listinfo/ksummit-discuss
>>
> _______________________________________________
> Ksummit-discuss mailing list
> Ksummit-discuss@lists.linuxfoundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/ksummit-discuss

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAl8CzYUACgkQOeye3VZi
gbmscRAAoq9BjgfvwE8+ki/65ILY8dCDmw3GEwtn9KTodi7as+MAhT/i/O7lXG3Z
FA0UpWB2JoaBijEp0U9Dy8uKfZN8RmYLTf80s0RxVHRN+2pIpKXc97uNUeHuD6SS
zEfOicQ9OavlZuFVxm4RCFc3gOnuYJ/csVY7eMZm3L+4njSZizfqIRe5B25e9CLX
AykL6DmEPR5QC9JG22F2BX0FtjelksCIDVjgPxseJqg3c3+iEHp4tqi3nIYnyTy9
BNAXc/uqtJRtlzI1yfihtnXugEPEvbA1GArCHVgGbcEuziep2OoFljYun6Eeeo8e
FsFsjtLJ5XSupuB1rGD8IdRrrsGf+wZWm0o9Bntmo3YZWJnVq+3ImbtW0ImSx7mg
EWbVhA3p3cHA1fQVuQYGe8+00Kcm9JUpRWbl0kHJ3qcMr0LBsLNt+MRD+8eY2oZ9
OVslkKVlUFHZqPtJmDlkWydeW9mxXh7ktd3KqksRGIM9npGKwfudx/gZzAmS7Gai
8LovOrVtJSGYGzEPq7W0B3MwXjfA2ck8MEhEEVRbMntDuPRiWN5h+Tuf7yP7Ofee
h2N0rWHGiOaAG16YzInS4jk6BxDOrT8+02fYvyQQ2FPYiaVqBoNj25YwnCzosCT1
eJxPvI/gB7JfpWELhV3sXhAyvMEzVHbqV5+owIsgSylRrduK4Mg=
=eOmT
-----END PGP SIGNATURE-----
--=-=-=--
