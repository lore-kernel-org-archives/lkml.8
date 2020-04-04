Return-Path: <SRS0=bQGS=5U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 141A0C2BA16
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Apr 2020 08:28:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D76A9206B8
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Apr 2020 08:28:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="iDlR/6TV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725962AbgDDI2S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Apr 2020 04:28:18 -0400
Received: from mail.skyhub.de ([5.9.137.197]:34858 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725730AbgDDI2S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Apr 2020 04:28:18 -0400
Received: from zn.tnic (p200300EC2F1E3400040841973BDD3BB0.dip0.t-ipconnect.de [IPv6:2003:ec:2f1e:3400:408:4197:3bdd:3bb0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 26EFA1EC02FE;
        Sat,  4 Apr 2020 10:28:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1585988897;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=KD7/EU25J2NOqaxnICLmUh19mbe66wMyELa4SPkmqR0=;
        b=iDlR/6TV5HB0fSFqnTt3UZRpzcG1jvgV6kBv7ev6GXOPFt1J2w1QUwFJeopty9CyHY3YdP
        gXlRQ8lzCzTuV3AjWX1KwZgtcVQiFkOP00VriGfxJdkml7/99GYQ6D/1XzFbCBAkN8UheU
        cWMny/FqQFTL0tyGEgDy6BRWjNJ0nmc=
Date:   Sat, 4 Apr 2020 10:28:09 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Ricardo Neri <ricardo.neri@intel.com>, x86@kernel.org,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>
Subject: Re: [PATCH] x86/cpufeatures: Add enumeration for serialize
 instruction
Message-ID: <20200404082809.GA7356@zn.tnic>
References: <20200403014026.19137-1-ricardo.neri-calderon@linux.intel.com>
 <20200403081217.GA20218@zn.tnic>
 <20200404052039.GA14886@ranerica-svr.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200404052039.GA14886@ranerica-svr.sc.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 03, 2020 at 10:20:39PM -0700, Ricardo Neri wrote:
> Do you mean code in the kernel using this instructions. Thus far, I
> don't have any kernel use cases for this instruction.

I'm sure you can find at least a couple of places in the kernel
which use CPUID to serialize and could switch to this new insn with
alternatives, for example. Or all those memory barrier uses. Would it be
better to switch to SERIALIZE there? Dunno, but would be good to know.
And so on.

> My intention is to expose this instruction to user space via
> /proc/cpuinfo. Is that not acceptable?

I know what your intention is. What good is the string "serialize" in
/proc/cpuinfo if nothing uses it?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
