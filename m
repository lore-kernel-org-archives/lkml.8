Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B89BAC10DCE
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 15:12:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FA2F2067C
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 15:12:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="oU1tB5Ss"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727794AbgCLPMl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 11:12:41 -0400
Received: from mail.skyhub.de ([5.9.137.197]:40660 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727505AbgCLPMl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 11:12:41 -0400
Received: from zn.tnic (p200300EC2F0DBF0041CBC9F757D3F2F8.dip0.t-ipconnect.de [IPv6:2003:ec:2f0d:bf00:41cb:c9f7:57d3:f2f8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id D8D7A1EC0CF0;
        Thu, 12 Mar 2020 16:12:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1584025960;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=aZ0sVPQUROsU7V9IOigOHw/180PZnvPfOg83xI6cKuo=;
        b=oU1tB5Ssi78snEumGc+PhfLiqz4gwvVcWAOdVdE5iXCaGB3ZTHTy9FvoJnOZ96YaCkxV3+
        YjgBHdHikPx+oCjGErEcXCj18DZjBnxKrBZYHBHtlkAGJS/hlQlQd+lgLQtKkCSjqwe7Zd
        LnS/CpFRQQS2oldYHXQw0XxptqSYx74=
Date:   Thu, 12 Mar 2020 16:12:44 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/2] x86/purgatory: Make sure we fail the build if
 purgatory.ro has missing symbols
Message-ID: <20200312151244.GH15619@zn.tnic>
References: <20200312001006.GA170175@rani.riverdale.lan>
 <3d58e77d-41e5-7927-fe84-4c058015e469@redhat.com>
 <20200312114225.GB15619@zn.tnic>
 <899f366e-385d-bafa-9051-4e93dc9ba321@redhat.com>
 <20200312125032.GC15619@zn.tnic>
 <8af51d90-27fa-6d2a-2159-ef0a9089453a@redhat.com>
 <20200312142553.GF15619@zn.tnic>
 <94c6f903-7dca-503e-aca7-1ee4641bcdac@redhat.com>
 <20200312144922.GG15619@zn.tnic>
 <69daa857-4dd0-730d-cebd-45c37cc5f66a@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <69daa857-4dd0-730d-cebd-45c37cc5f66a@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 12, 2020 at 03:57:41PM +0100, Hans de Goede wrote:
> I understand that you are pushing-back against people using 0day bot
> to find bugs for them and that was never my goal.

No, this is not it: the 0day bot is very helpful, when it works, to
catch issues like that. But it is not always reliable, thus I suggested
for you to do the testing yourself before sending your next patchset.
That's all.

But that's fine - I have a test setup on which to run this so we don't
have to wait for the 0day bot.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
