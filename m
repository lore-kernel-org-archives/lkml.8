Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16738C34026
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 13:38:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEE2A2173E
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 13:38:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="dYjV/1Hj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726683AbgBRNiB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 08:38:01 -0500
Received: from mail.skyhub.de ([5.9.137.197]:56176 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726347AbgBRNiB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 08:38:01 -0500
Received: from zn.tnic (p200300EC2F0C1F0028FD4265E0CDE335.dip0.t-ipconnect.de [IPv6:2003:ec:2f0c:1f00:28fd:4265:e0cd:e335])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 0E70B1EC0CD1;
        Tue, 18 Feb 2020 14:38:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1582033080;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=3fEGQmlRrx7Ve1nJ21t9s4LB01DniXaNSXB1qQeQEOk=;
        b=dYjV/1HjQgoWDktIVXa9DVTBajaxdUS/8ISqM4yublqc3UXsUzugiyrpGNwZV/1KMn49Rp
        jz7wPaRvqKPStP/ZXlncUaBypSNv2NTa5dhFiwCyzEMLg0cC/AebNBbmgizaqOH0UB4280
        ZJC61b3E3Zeof9bkHlPU+rTO3sSJOhE=
Date:   Tue, 18 Feb 2020 14:37:56 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     "H.J. Lu" <hjl.tools@gmail.com>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>
Subject: Re: [PATCH] x86: Don't declare __force_order in kaslr_64.c
Message-ID: <20200218133756.GD14449@zn.tnic>
References: <20200124181811.4780-1-hjl.tools@gmail.com>
 <E184715B-30CD-4951-BAF4-E95135AEE938@amacapital.net>
 <CAMe9rOov9pLYcDLcu2CR7-i5VJhWzz4n95MYiXZDd9p79nQFyQ@mail.gmail.com>
 <CAMe9rOrtj-Hrr6tmSrwg_V9bawXXB2WjsSedL=aCaaH-=ZSKsA@mail.gmail.com>
 <20200218104552.GA14449@zn.tnic>
 <CAMe9rOpyb0-DZME8fdqjvD4fM7-0ZugM3YcPfX9i-kGM1Yj_QA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMe9rOpyb0-DZME8fdqjvD4fM7-0ZugM3YcPfX9i-kGM1Yj_QA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 18, 2020 at 03:38:54AM -0800, H.J. Lu wrote:
> I wrote this patch as the part of the previous CET patch set Yu-cheng submitted.
> Since this is a standalone patch, he asked me to send it separately.  I didn't
> remove Yu-cheng's SOB when I submitted this patch.

Ok, dropping it.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
