Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF6E2C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 23:43:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC94720823
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 23:43:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730160AbgEUXnd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 19:43:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728537AbgEUXnc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 19:43:32 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AB01C061A0E
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 16:43:32 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jbuqK-0003mM-IE; Fri, 22 May 2020 01:43:16 +0200
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id A0975100CA6; Fri, 22 May 2020 01:43:15 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Kees Cook <keescook@chromium.org>
Cc:     Kristen Carlson Accardi <kristen@linux.intel.com>,
        mingo@redhat.com, bp@alien8.de, arjan@linux.intel.com,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        kernel-hardening@lists.openwall.com, rick.p.edgecombe@intel.com
Subject: Re: [PATCH v2 0/9] Function Granular KASLR
In-Reply-To: <202005211604.86AE1C2@keescook>
Date:   Fri, 22 May 2020 01:43:15 +0200
Message-ID: <87tv08svl8.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kees,

Kees Cook <keescook@chromium.org> writes:
> On Fri, May 22, 2020 at 12:26:30AM +0200, Thomas Gleixner wrote:
>> I understand how this is supposed to work, but I fail to find an
>> explanation how all of this is preserving the text subsections we have,
>> i.e. .kprobes.text, .entry.text ...?
>
> I had the same question when I first started looking at earlier versions
> of this series! :)
>
>> I assume that the functions in these subsections are reshuffled within
>> their own randomized address space so that __xxx_text_start and
>> __xxx_text_end markers still make sense, right?
>
> No, but perhaps in the future. Right now, they are entirely ignored and
> left untouched.

I'm fine with that restriction, but for a moment I got worried that this
might screw up explicit subsections.

This really want's to be clearly expressed in the cover letter and the
changelogs so that such questions don't arise again.

<SNIP>

> So, before any of that, just .text.* is a good first step, and after
> that I think next would be getting .text randomized relative to the other
> .text.* sections (IIUC, it is entirely untouched currently, so only the
> standard KASLR base offset moves it around). Only after that do we start
> poking around trying to munge the special section contents (which
> requires use solving a few problems simultaneously). :)

Thanks for the detailed explanation!

       tglx
