Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E998C43331
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 14:47:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C79FE2071A
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 14:47:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="fZ3KoR9C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733130AbgDAOr0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 10:47:26 -0400
Received: from esa1.hc3370-68.iphmx.com ([216.71.145.142]:52142 "EHLO
        esa1.hc3370-68.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732749AbgDAOr0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 10:47:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1585752446;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=5lpXtxQo/+BW9i4IsA0t1c5kZDYQrEHSE0Zt9frttU8=;
  b=fZ3KoR9CSn8LSTYFYSThIaU1+RpOQ6LayE+Wn666Pdc6uU7HMjb2LK1R
   Qwdo11wB2ckPWwRmg5n2DggxzKBx6YCkEukZd9kXF1EesA85Fx1m5cPsT
   WaflGo+s43ksrfeNbdur9eHzheMVPOLf5EW0VF6tOzLu3MA/SO8Pt0FbZ
   k=;
Authentication-Results: esa1.hc3370-68.iphmx.com; dkim=none (message not signed) header.i=none; spf=None smtp.pra=andrew.cooper3@citrix.com; spf=Pass smtp.mailfrom=Andrew.Cooper3@citrix.com; spf=None smtp.helo=postmaster@mail.citrix.com
Received-SPF: None (esa1.hc3370-68.iphmx.com: no sender
  authenticity information available from domain of
  andrew.cooper3@citrix.com) identity=pra;
  client-ip=162.221.158.21; receiver=esa1.hc3370-68.iphmx.com;
  envelope-from="Andrew.Cooper3@citrix.com";
  x-sender="andrew.cooper3@citrix.com";
  x-conformance=sidf_compatible
Received-SPF: Pass (esa1.hc3370-68.iphmx.com: domain of
  Andrew.Cooper3@citrix.com designates 162.221.158.21 as
  permitted sender) identity=mailfrom;
  client-ip=162.221.158.21; receiver=esa1.hc3370-68.iphmx.com;
  envelope-from="Andrew.Cooper3@citrix.com";
  x-sender="Andrew.Cooper3@citrix.com";
  x-conformance=sidf_compatible; x-record-type="v=spf1";
  x-record-text="v=spf1 ip4:209.167.231.154 ip4:178.63.86.133
  ip4:195.66.111.40/30 ip4:85.115.9.32/28 ip4:199.102.83.4
  ip4:192.28.146.160 ip4:192.28.146.107 ip4:216.52.6.88
  ip4:216.52.6.188 ip4:162.221.158.21 ip4:162.221.156.83
  ip4:168.245.78.127 ~all"
Received-SPF: None (esa1.hc3370-68.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@mail.citrix.com) identity=helo;
  client-ip=162.221.158.21; receiver=esa1.hc3370-68.iphmx.com;
  envelope-from="Andrew.Cooper3@citrix.com";
  x-sender="postmaster@mail.citrix.com";
  x-conformance=sidf_compatible
IronPort-SDR: qGuEcadWZ4+4r3BUt94OBTAasnNsLwdE4ZHx/AdIbJyLqMuLH+k06nUg5eDKzlLozHdJs8V/B6
 NhoJsLL3aE0qTxCtaqPg9EW0yOYinYK15G/AQZ/pLVsuUPjOxyxfFGCT0ObbGMTyMokioZuIG6
 sCpiui3I/uZti4luZwmvlEJ+oIRXKbca5CbzK4W+i0FYQ5Ym4OQWFCq3ReLkO11Lt+Rd8DJf6w
 jrg/nn6Q2k0eRfw3vcLE9ciMnafSeR4pohtlUj3XnkL0cyDhaVay6VMGzQwjGg7RwBz7KgkWiQ
 4AU=
X-SBRS: 2.7
X-MesageID: 15226252
X-Ironport-Server: esa1.hc3370-68.iphmx.com
X-Remote-IP: 162.221.158.21
X-Policy: $RELAYED
X-IronPort-AV: E=Sophos;i="5.72,332,1580792400"; 
   d="scan'208";a="15226252"
Subject: Re: [PATCH v2] x86/smpboot: Remove 486-isms from the modern AP boot
 path
To:     Brian Gerst <brgerst@gmail.com>
CC:     LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        James Morris <jmorris@namei.org>,
        David Howells <dhowells@redhat.com>,
        Matthew Garrett <mjg59@google.com>,
        Josh Boyer <jwboyer@redhat.com>,
        Steve Wahl <steve.wahl@hpe.com>,
        Mike Travis <mike.travis@hpe.com>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        "Arnd Bergmann" <arnd@arndb.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Giovanni Gherdovich <ggherdovich@suse.cz>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Len Brown <len.brown@intel.com>,
        Kees Cook <keescook@chromium.org>,
        Martin Molnar <martin.molnar.programming@gmail.com>,
        Pingfan Liu <kernelfans@gmail.com>,
        <jailhouse-dev@googlegroups.com>
References: <20200325101431.12341-1-andrew.cooper3@citrix.com>
 <20200331175810.30204-1-andrew.cooper3@citrix.com>
 <CAMzpN2i6Nf0VDZ82mXyFixN879FC4eZfqe-LzWGkvygcz1gH_Q@mail.gmail.com>
 <c46bcb6d-4256-2d65-9cd9-33e010846de4@citrix.com>
 <CAMzpN2gdkmYYbQatFk66QMpiuZSfnUQUVtJ30VYF7nsX_+XVgA@mail.gmail.com>
 <bdf7995d-2d50-9bb9-8066-6c4ccfaa5b52@citrix.com>
 <CAMzpN2g0LS5anGc7CXco4pgBHhGzc8hw+shMOg8WEWGsx+BHpg@mail.gmail.com>
 <b1aa5cdf-b446-17b0-6d31-fa8947f67592@citrix.com>
 <CAMzpN2h5u3gbRFfew-BSUH_=E509QirQaopiTBrVQc6Oq2AcvA@mail.gmail.com>
From:   Andrew Cooper <andrew.cooper3@citrix.com>
Message-ID: <b15b8cf2-a579-10ec-06b1-fb674295c993@citrix.com>
Date:   Wed, 1 Apr 2020 15:47:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAMzpN2h5u3gbRFfew-BSUH_=E509QirQaopiTBrVQc6Oq2AcvA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
X-ClientProxiedBy: AMSPEX02CAS01.citrite.net (10.69.22.112) To
 AMSPEX02CL02.citrite.net (10.69.22.126)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/04/2020 15:38, Brian Gerst wrote:
>>>>>>> You removed x86_platform.legacy.warm_reset in the original patch, but
>>>>>>> that is missing in V2.
>>>>>> Second hunk?  Or are you referring to something different?
>>>>> Removing the warm_reset field from struct x86_legacy_features.
>>>> Ok, but that is still present as the 2nd hunk of the patch.
>>> My apologies, Gmail was hiding that section of the patch because it
>>> was a reply to the original patch.  For future reference, add the
>>> version number to the title when resubmitting a patch (ie. [PATCH
>>> v2]).
>> Erm... is Gmail hiding that too?
>>
>> Lore thinks it is there:
>> https://lore.kernel.org/lkml/CAMzpN2g0LS5anGc7CXco4pgBHhGzc8hw+shMOg8WEWGsx+BHpg@mail.gmail.com/
> Ugh, yes.  I thought it was the title that Gmail threaded on, but it
> must be the In-Reply-To: header.  Sorry for the confusion.
>
> That said, I think the v1 patch is probably the better way to go (but
> adjusting the comments to include early Pentium-era systems without
> integrated APICs).

Yes - I'm afraid I'm showing my age here, being the same vintage as the 486.

I'll happily rephrase as suggested.

> Then the decision to drop support for external
> APICs could be a separate patch.

I have no vested interest.

This was a fix from Xen that I tried to upstream (if you can really call
it that, seeing as the common point in history was the Linux 2.4 days),
given the rather rude UEFI behaviour.

Ultimately, this will be down to the maintainers for which approach to take.

~Andrew
