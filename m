Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF791C33CB1
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 15:02:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A087224681
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 15:02:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="OTv8zT97"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729127AbgANPCC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 10:02:02 -0500
Received: from mail.skyhub.de ([5.9.137.197]:50536 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725904AbgANPCC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 10:02:02 -0500
Received: from zn.tnic (p200300EC2F0C7700ADF35ADE4D579DE7.dip0.t-ipconnect.de [IPv6:2003:ec:2f0c:7700:adf3:5ade:4d57:9de7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 6A9731EC05B5;
        Tue, 14 Jan 2020 16:02:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1579014120;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=9YHAUf+HVbRcxNsVSVxZgIqxmENPcoeEZpjyzh/7bSE=;
        b=OTv8zT975ZmENxQ7LdOGv64D/CiGDH92trHwhPpY2jscN2k2fuK11Guuo1PSqTb5qT33le
        xgdiZe+9xtu6H1PdA1KGomGofkyX3whQwWnddC92J3B7UQ6fZFBNwCQ4UxK1yY1yQFN52B
        oBx1Ab4JdKLEjrsvqjQjyiVJpU7FDHA=
Date:   Tue, 14 Jan 2020 16:01:53 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Colin Ian King <colin.king@canonical.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/microcode/amd: fix uninitalized structure cp
Message-ID: <20200114150153.GJ31032@zn.tnic>
References: <20200114111505.320186-1-colin.king@canonical.com>
 <20200114113834.GE31032@zn.tnic>
 <b59bb156-891e-3a26-3204-f5a0a1cc60d3@canonical.com>
 <20200114120156.GG31032@zn.tnic>
 <54eca4f8-33ca-24b1-9123-70df3b164043@canonical.com>
 <20200114121000.GH31032@zn.tnic>
 <fcbb34b0-203e-0c7c-66cc-a3ae6fa3680c@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <fcbb34b0-203e-0c7c-66cc-a3ae6fa3680c@canonical.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 14, 2020 at 02:08:50PM +0000, Colin Ian King wrote:
> If I understand the question, it seems that get_builtin_microcode()
> tries to load in the appropriate amd microcode binary from the cpio data
> and this can potentially fail if the microcode is not provided for the
> specific processor family, so I believe this is a legitimate fix.

If the microcode for the specific processor family is not provided,
get_builtin_firmware() will return false and then we'll call
find_microcode_in_initrd() which will definitely return either a proper
pointer or a NULL-initialized cpio_data struct.

So I still don't see it.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
