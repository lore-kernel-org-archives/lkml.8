Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C066AC3815B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 17:15:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 992BD208E4
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 17:15:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726512AbgDTRPD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 13:15:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725774AbgDTRPD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 13:15:03 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B0CAC061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 10:15:03 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jQa0N-0002tP-2Z; Mon, 20 Apr 2020 19:14:47 +0200
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id 81DDE101623; Mon, 20 Apr 2020 19:14:46 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Andi Kleen <ak@linux.intel.com>, Andy Lutomirski <luto@kernel.org>
Cc:     Sasha Levin <sashal@kernel.org>,
        "Bae\, Chang Seok" <chang.seok.bae@intel.com>,
        "Metzger\, Markus T" <markus.t.metzger@intel.com>,
        "hpa\@zytor.com" <hpa@zytor.com>, "bp\@alien8.de" <bp@alien8.de>,
        "Hansen\, Dave" <dave.hansen@intel.com>,
        "Luck\, Tony" <tony.luck@intel.com>,
        Pedro Alves <palves@redhat.com>,
        Simon Marchi <simark@simark.ca>,
        "Shankar\, Ravi V" <ravi.v.shankar@intel.com>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v9 00/17] Enable FSGSBASE instructions
In-Reply-To: <20200420141320.GC608746@tassilo.jf.intel.com>
References: <20191115191200.GD22747@tassilo.jf.intel.com> <A78C989F6D9628469189715575E55B236B50834A@IRSMSX104.ger.corp.intel.com> <CALCETrXc=-k3fQyxjBok0npjTMr6-Ho7+pkvzDUdG=b52Qz=9g@mail.gmail.com> <A78C989F6D9628469189715575E55B236B508C1A@IRSMSX104.ger.corp.intel.com> <CALCETrWb9jvwOPuupet4n5=JytbS-x37bnn=THniv_d8cNvf_Q@mail.gmail.com> <29FD6626-4347-4B79-A027-52E44C7FDE55@intel.com> <20200413200336.GA11216@sasha-vm> <20200414003205.GF397326@tassilo.jf.intel.com> <20200417133021.GT1068@sasha-vm> <CALCETrW6LLmFR5Y6tmH=nPThCHefysf_nNwxHOFp4tAY4Spunw@mail.gmail.com> <20200420141320.GC608746@tassilo.jf.intel.com>
Date:   Mon, 20 Apr 2020 19:14:46 +0200
Message-ID: <87y2qqaxkp.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen <ak@linux.intel.com> writes:
>> the *gdb developers* don't care.  But gdb isn't exactly a good example
>> of a piece of software that tries to work correctly when dealing with
>> unusual software.  Maybe other things like rr will care more.  It
>
> rr is used to replay modern software, and modern software
> doesn't care about selectors, thus rr doesn't care either.
>
> Please stop the FUD.

There is absolutely no FUD. Being careful about not breaking existing
user space is a legitimate request.

It's up to those who change the ABI to prove that it does not matter and
not up to the maintainers to figure it out.

This sits in limbo for months now just because Intel doesn't get it's
homework done.

Stop making false accusations and provide factual information instead.

Thanks,

        tglx
