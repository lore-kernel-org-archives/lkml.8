Return-Path: <SRS0=PEot=6K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6077CC55191
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Apr 2020 10:04:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 45A882071C
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Apr 2020 10:04:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726165AbgDZKEm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Apr 2020 06:04:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726132AbgDZKEl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Apr 2020 06:04:41 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73253C061A0C
        for <linux-kernel@vger.kernel.org>; Sun, 26 Apr 2020 03:04:41 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jSe93-000217-Ui; Sun, 26 Apr 2020 12:04:18 +0200
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id B379A100605; Sun, 26 Apr 2020 12:04:16 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Sasha Levin <sashal@kernel.org>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        Andi Kleen <ak@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
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
In-Reply-To: <20200426025243.GJ13035@sasha-vm>
References: <20200421195629.GE608746@tassilo.jf.intel.com> <5957D3CC-B54B-4A1A-998A-0E6F58589CF4@amacapital.net> <20200421205119.GK1809@sasha-vm> <CALCETrUGuvMgvcsUWsdmUr-=6c6BpRpOKC1MN+E16g17U7vyMQ@mail.gmail.com> <20200423040850.GY1809@sasha-vm> <87ftcrtckg.fsf@nanos.tec.linutronix.de> <20200426025243.GJ13035@sasha-vm>
Date:   Sun, 26 Apr 2020 12:04:16 +0200
Message-ID: <878siitvfj.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sasha Levin <sashal@kernel.org> writes:
> On Sun, Apr 26, 2020 at 12:39:27AM +0200, Thomas Gleixner wrote:
>>  - Addressed the outstanding review comments
>
> I saw a review that Andy has just sent on patch #1 from the new series,
> I'll address that.

Please look at the last version from Intel as well whether there is anything
outstanding.

>>  - Have proper documentation in the changelog of the user space visible
>>    ABI changes why it does not break any existing usage and having the
>>    relevant people who maintain tools which utilize the affected
>>    interfaces Cc'ed on submission.
>
> The cover letter has references to mail correspondence with maintainers
> of these tools that are affected by this change. Each of those exchanges
> goes over what FSGSBASE does and answers any specific questions those
> maintainers had.
>
> If you want it out of the cover letter and into one of the patches I'd
> be happy to do that. If you want me to go chase down another userspace
> which we might be breaking just let me know which.

Yes, please add the information to the changelogs. That's where it
really belongs.

> I didn't want to have them on the Cc line as they have already acked
> this change from their end and I wanted to avoid additional noise. I'll
> be happy to add them back to the next spin of this.
>
>>  - Made sure that the cleanups I did when merging them initially have
>>    been picked up. I'm not going to waste another couple of days on
>>    this mess just to revert it because it hadn't seen any serious
>>    testing in development.
>
> Based on your revert
> (https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/commit/?h=x86/cpu&id=049331f277fef1c3f2527c2c9afa1d285e9a1247)
> I believe that we have all the relevant patches in the series.

Ok.

Thanks,

        tglx
