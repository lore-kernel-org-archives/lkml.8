Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C488C43331
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 21:45:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63AB420737
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 21:45:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389053AbgDBVpN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 17:45:13 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:39068 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388008AbgDBVpN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 17:45:13 -0400
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jK7e2-0003jo-Ii; Thu, 02 Apr 2020 23:45:02 +0200
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id B3201100D52; Thu,  2 Apr 2020 23:45:01 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Josh Poimboeuf <jpoimboe@redhat.com>,
        "Singh\, Balbir" <sblbir@amazon.com>
Cc:     "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tony.luck\@intel.com" <tony.luck@intel.com>,
        "keescook\@chromium.org" <keescook@chromium.org>,
        "benh\@kernel.crashing.org" <benh@kernel.crashing.org>,
        "x86\@kernel.org" <x86@kernel.org>,
        "dave.hansen\@intel.com" <dave.hansen@intel.com>
Subject: Re: [PATCH 0/3] arch/x86: Optionally flush L1D on context switch
In-Reply-To: <20200402204749.33ulub5jx66dktxg@treble>
References: <20200402062401.29856-1-sblbir@amazon.com> <20200402201328.zqnxwaetpk4ubg56@treble> <31c9720eff18ce167378e9a0017dcd73e0552164.camel@amazon.com> <20200402204749.33ulub5jx66dktxg@treble>
Date:   Thu, 02 Apr 2020 23:45:01 +0200
Message-ID: <875zehmujm.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Josh Poimboeuf <jpoimboe@redhat.com> writes:
> On Thu, Apr 02, 2020 at 08:35:46PM +0000, Singh, Balbir wrote:
>> Yes, that CVE the motivation, the mitigation for CVE-2020-0550 does suggest
>> flushing the cache on context switch. But in general, as we begin to find more
>> ways of evicting data or snopping data, a generic mechanism is more useful and
>> that is why I am making it an opt-in.
>
> Ok.  I think it would be a good idea to expand on that justification
> more precisely in the commit message.  That would help both reviewers of
> the code and users of the new option understand what level of paranoia
> they're opting in to :-)

The commit message is mostly useful for reviewers and people who have to
do code archeaology. 

Documentation/admin-guide/hw-vuln/ has plenty of space to host a
document with explanations. paranoia.rst comes to my mind. :)

Thanks,

        tglx
 
