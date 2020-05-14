Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16FF1C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 11:33:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D5744206A5
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 11:33:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726128AbgENLdT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 07:33:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726010AbgENLdS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 07:33:18 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94955C061A0C
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 04:33:18 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jZC6o-0004st-Pi; Thu, 14 May 2020 13:33:02 +0200
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id 168751004CE; Thu, 14 May 2020 13:33:02 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     "Singh\, Balbir" <sblbir@amazon.com>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     "keescook\@chromium.org" <keescook@chromium.org>,
        "thomas.lendacky\@amd.com" <thomas.lendacky@amd.com>,
        "tony.luck\@intel.com" <tony.luck@intel.com>,
        "benh\@kernel.crashing.org" <benh@kernel.crashing.org>,
        "jpoimboe\@redhat.com" <jpoimboe@redhat.com>,
        "x86\@kernel.org" <x86@kernel.org>,
        "dave.hansen\@intel.com" <dave.hansen@intel.com>
Subject: Re:  [PATCH v6 5/6] Optionally flush L1D on context switch
In-Reply-To: <c51109f10f6572f5cf60d2693f84ff8e65c7804a.camel@amazon.com>
References: <20200510014803.12190-1-sblbir@amazon.com> <20200510014803.12190-6-sblbir@amazon.com> <875zcz3j47.fsf@nanos.tec.linutronix.de> <c51109f10f6572f5cf60d2693f84ff8e65c7804a.camel@amazon.com>
Date:   Thu, 14 May 2020 13:33:02 +0200
Message-ID: <87pnb6zr81.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Balbir,

"Singh, Balbir" <sblbir@amazon.com> writes:
> On Wed, 2020-05-13 at 18:16 +0200, Thomas Gleixner wrote:
>> Balbir Singh <sblbir@amazon.com> writes:
>> But looking at this deeper (yes I should have noticed earlier):
>> 
>>     Why do we need yet another PRCTL?
>> 
>> We already have PR_SET_SPECULATION_CTRL/PR_GET_SPECULATION_CTRL. That
>> L1D flush thingy fits into this category, right?
>
> It does, I thought about it for a while when I was changing the code and
> left it aside because, looking at the definition
>
> 1    PR_SPEC_ENABLE         The speculation feature is enabled,
> mitigation is disabled.
> 2    PR_SPEC_DISABLE        The speculation feature is disabled,
> mitigation is enabled.
>
> With L1D flush, there is no overriding of the feature as such (as in
> enable when the mitigation is disabled and vice-versa). I am happy to
> reconsider my initial thought though.

L1D is always enabled as L1D will be a source of trouble forever :)

Thanks,

        tglx
