Return-Path: <SRS0=hCRD=6J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB28EC54FCB
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Apr 2020 22:39:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C635C20714
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Apr 2020 22:39:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726371AbgDYWjl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Apr 2020 18:39:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726232AbgDYWjl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Apr 2020 18:39:41 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59430C09B04F
        for <linux-kernel@vger.kernel.org>; Sat, 25 Apr 2020 15:39:41 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jSTSJ-0004lU-Nd; Sun, 26 Apr 2020 00:39:28 +0200
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id 4688C100605; Sun, 26 Apr 2020 00:39:27 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Sasha Levin <sashal@kernel.org>,
        Andy Lutomirski <luto@amacapital.net>
Cc:     Andi Kleen <ak@linux.intel.com>, Andy Lutomirski <luto@kernel.org>,
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
In-Reply-To: <20200423040850.GY1809@sasha-vm>
References: <20200421195629.GE608746@tassilo.jf.intel.com> <5957D3CC-B54B-4A1A-998A-0E6F58589CF4@amacapital.net> <20200421205119.GK1809@sasha-vm> <CALCETrUGuvMgvcsUWsdmUr-=6c6BpRpOKC1MN+E16g17U7vyMQ@mail.gmail.com> <20200423040850.GY1809@sasha-vm>
Date:   Sun, 26 Apr 2020 00:39:27 +0200
Message-ID: <87ftcrtckg.fsf@nanos.tec.linutronix.de>
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
> On Wed, Apr 22, 2020 at 04:00:16PM -0700, Andy Lutomirski wrote:
>>
>>gdb and rr are certainly a good start.  If patches show up, I'll take a look.
>
> I'm sorry, but what patches are we talking about?

About patches which:

  - Are rebased to current upstream

  - Addressed the outstanding review comments

  - Have proper documentation in the changelog of the user space visible
    ABI changes why it does not break any existing usage and having the
    relevant people who maintain tools which utilize the affected
    interfaces Cc'ed on submission.

  - Made sure that the cleanups I did when merging them initially have
    been picked up. I'm not going to waste another couple of days on
    this mess just to revert it because it hadn't seen any serious
    testing in development.

Thanks,

        tglx
