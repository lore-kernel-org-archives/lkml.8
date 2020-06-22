Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8459C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 19:01:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B6B0720706
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 19:01:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="VlGvQK+D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730252AbgFVTBy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 15:01:54 -0400
Received: from mail.skyhub.de ([5.9.137.197]:36000 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730020AbgFVTBx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 15:01:53 -0400
Received: from zn.tnic (p200300ec2f0a2500329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ec:2f0a:2500:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 8F4741EC0103;
        Mon, 22 Jun 2020 21:01:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1592852512;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=fFTXe6NWvwELBv+XCutWGcjhfy4SKXvhxjJFh6sDiCk=;
        b=VlGvQK+DIsz77R8A9TE/Su03CLM04cveRdKHy3K2nUfnNc/aXSXTwwjyklo9fA61Kf1P8h
        nvntN/boqCA5FPVml22Xxs+AP9QaJVPal+5Uz6iFTUUZFtmxgkQpMfQnX6UC8DLwqcgcD0
        SozFUwJCuuQfQ+49iJHIfIK2zsmigow=
Date:   Mon, 22 Jun 2020 21:01:49 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     X86 ML <x86@kernel.org>, jpa@kernelbug.mail.kapsi.fi,
        Dave Hansen <dave.hansen@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] selftests/fpu: Add an FPU selftest
Message-ID: <20200622190149.GL32200@zn.tnic>
References: <20200619174127.22304-1-bp@alien8.de>
 <20200619174127.22304-3-bp@alien8.de>
 <CALCETrXXzt8WZMs3dsReCJ5wdF3zhxFmUtGnmdCgV7_exFUKKQ@mail.gmail.com>
 <20200622171240.GI32200@zn.tnic>
 <CALCETrV87t=meNgb1zqz_E5=XaifttX79DMeLK87k1DvzVER1Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CALCETrV87t=meNgb1zqz_E5=XaifttX79DMeLK87k1DvzVER1Q@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 22, 2020 at 11:26:50AM -0700, Andy Lutomirski wrote:
> For all the ridiculous distro gcc versions out there.  Also, it seems
> less fragile, since it tests for what you actually care about

Let's cross that bridge when we get there.

Do you know of an actual compiler not supporting
-mpreferred-stack-boundary?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
