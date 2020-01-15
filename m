Return-Path: <SRS0=7RkH=3E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95487C33CB1
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 12:42:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67BEB222C3
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 12:42:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="OJA9TUse"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729014AbgAOMm6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jan 2020 07:42:58 -0500
Received: from mail.skyhub.de ([5.9.137.197]:46176 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725999AbgAOMm6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 07:42:58 -0500
Received: from zn.tnic (p200300EC2F0C7700ACD7CA379FB916C9.dip0.t-ipconnect.de [IPv6:2003:ec:2f0c:7700:acd7:ca37:9fb9:16c9])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A157F1EC05B5;
        Wed, 15 Jan 2020 13:42:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1579092176;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=y3oho2aNY8UwvRDfCx5mQ3BUUigA9TYFqaFmO03HUTI=;
        b=OJA9TUseIhqEsTmr0tvqaXy4uA1+8UcXTxVhQwezUI9NJL5hpqB71BAj1flDE8xQmLZXyb
        tdkWyFVvwEfkxSSpIPHNWwdmUdYN20o9qLjN6bYR3cQ4NyZuqvO1l2OaE+0E16Abc4IhBq
        Zz0VLvmnJgmTEB4ni1832ddDo1i/leg=
Date:   Wed, 15 Jan 2020 13:42:52 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Colin Ian King <colin.king@canonical.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/microcode/amd: fix uninitalized structure cp
Message-ID: <20200115124252.GD20975@zn.tnic>
References: <20200114111505.320186-1-colin.king@canonical.com>
 <20200114113834.GE31032@zn.tnic>
 <b59bb156-891e-3a26-3204-f5a0a1cc60d3@canonical.com>
 <20200114120156.GG31032@zn.tnic>
 <54eca4f8-33ca-24b1-9123-70df3b164043@canonical.com>
 <20200114121000.GH31032@zn.tnic>
 <fcbb34b0-203e-0c7c-66cc-a3ae6fa3680c@canonical.com>
 <20200114150153.GJ31032@zn.tnic>
 <20200115042507.GE3719@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200115042507.GE3719@kadam>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 15, 2020 at 07:25:07AM +0300, Dan Carpenter wrote:
> It's probably complaining that cp.name[] isn't initialized.

That is possible.

> UBSan will probably generate a warning at runtime when we do:
> 
> 	*ret = cp;
> 
> But otherwise it's harmless.

Yes, because we don't do anything with cpio_data.name.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
