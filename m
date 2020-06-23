Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 736FAC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 10:28:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A6E22072E
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 10:28:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="ZgyGxZhX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732257AbgFWK2l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 06:28:41 -0400
Received: from mail.skyhub.de ([5.9.137.197]:34790 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732185AbgFWK2l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 06:28:41 -0400
Received: from zn.tnic (p200300ec2f0d4700a4f87d2388e67af4.dip0.t-ipconnect.de [IPv6:2003:ec:2f0d:4700:a4f8:7d23:88e6:7af4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 123241EC0315;
        Tue, 23 Jun 2020 12:28:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1592908120;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/3Qxgw+JGpQd1w+eS0YH5dc/UFYPQULz6YKkopOeRRU=;
        b=ZgyGxZhXy2E9ld2hsggbtfXONlx/SoGu3rmuq2Pc/A4+LJU1R2ecTOIPoiu1aFzQtOH4kY
        WHNHsBcVjw45UkuiYxf6OhgYKKnb5lXBmr1tdrfP+cVg8WIwgGyHIYp16qVBw8C7+eEpk2
        m8SrfIWIc12ZlUDzAcd9zygH2f5BjdY=
Date:   Tue, 23 Jun 2020 12:28:31 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Andy Lutomirski <luto@kernel.org>, X86 ML <x86@kernel.org>,
        jpa@kernelbug.mail.kapsi.fi, Dave Hansen <dave.hansen@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] selftests/fpu: Add an FPU selftest
Message-ID: <20200623102831.GB32590@zn.tnic>
References: <20200622190149.GL32200@zn.tnic>
 <B4D00859-000A-4F8C-8CFB-45B9BBCCA16D@amacapital.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <B4D00859-000A-4F8C-8CFB-45B9BBCCA16D@amacapital.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 22, 2020 at 12:37:12PM -0700, Andy Lutomirski wrote:
> It’s this whole mess:
> 
> https://gcc.gnu.org/bugzilla/show_bug.cgi?id=53383

It really is a mess because our option detection doesn't really work. I did:

ifdef CONFIG_CC_IS_GCC
  ifeq ($(call cc-option-yn,-mpreferred-stack-boundary=3),y)
        dummy := $(error "gcc supports -mpreferred-stack-boundary=3")
  endif
  ...

and doing:

$ make CC=gcc-4.8 HOSTCC=gcc-4.8 V=1 lib/test_fpu.ko

gives

lib/Makefile:110: *** "gcc supports -mpreferred-stack-boundary=3".  Stop.

That same compiler, however, says:

$ gcc-4.8 -mpreferred-stack-boundary=3 -c /tmp/foo.c
/tmp/foo.c:1:0: error: -mpreferred-stack-boundary=3 is not between 4 and 12

so I need to dig deep into cc-option* fun.

Or, I can be lazy and simply cut off all compiler versions to >= 8
and be done with it. If people wanna run selftests, they can upgrade
toolchain too...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
