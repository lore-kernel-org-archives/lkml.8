Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0028C3B188
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 07:45:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6216021734
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 07:45:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="biWiIy6c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729890AbgBMHpd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 02:45:33 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:38613 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729706AbgBMHpd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 02:45:33 -0500
Received: by mail-lf1-f66.google.com with SMTP id r14so3540086lfm.5
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2020 23:45:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=tccHDFw8Be0tCiwLFmvqNHBCYLNSpms3aI/0Nu1Lkcw=;
        b=biWiIy6cSpYBYseYC5rG9zg0yZrhQDMcxudJjex+4XKfDJs5X9uRsoByIs3ZPg2On5
         jo9rIt6nZQenqD3JNRPCsh+HcCyg6TQGtIvpn6dorob+z2JtRRyIsV08SbF1Ftkt+eMX
         +sSnpaCuqr43G996HOyFc+XyiKQV+fRGDUvsQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=tccHDFw8Be0tCiwLFmvqNHBCYLNSpms3aI/0Nu1Lkcw=;
        b=aK+9hZVJ/jZ3AtaQoFM+VsQ9idI+IAnND46fNp6CGN9X6dvESmD7BwONDkkY6uzgYI
         GGuDbHvdvWRhbs2Gj30ATf/UAl8buznB7rz5tmkWtJivcihk5Vkp+nWglV3H64THiAV8
         XtDOIfCDrrSnuU8ndoyOO8EPynQYnryzRg9gD0Ds/xcquftBQpvbbc6jB2isX5tw1au3
         L8+qxfFlqb0nV6Q57DdIumIxEC8R9xJKbkdEbAXrqydzy7SQZXWRK591weOw5urMWsXB
         iIC3vOyBdHx9qacILvVHz8yIcbtQyIAoOL0FQBtlh3/tcp8NYaZhe2EfFh/MMFVMTh4B
         fteg==
X-Gm-Message-State: APjAAAUDOxM0rrLRbKG8MAyE7bAYy5NRiYWABKnIHj2dUDedWlMwwNUN
        79PQHrHJd5j2101fc9MlXQ3VAWreVb9d4FPB
X-Google-Smtp-Source: APXvYqw0quAloIVavV+0KAsCtOQX6LMqkFeiTVZoBqg/BRZSHx3nU8/X33CUk+TdrSB1k2JH4qEHWg==
X-Received: by 2002:ac2:5391:: with SMTP id g17mr6979327lfh.93.1581579930294;
        Wed, 12 Feb 2020 23:45:30 -0800 (PST)
Received: from [172.16.11.50] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id h7sm745141lfj.29.2020.02.12.23.45.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Feb 2020 23:45:29 -0800 (PST)
Subject: Re: [Regression 5.6-rc1][Bisected b6231ea2b3c6] Powerpc 8xx doesn't
 boot anymore
To:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Li Yang <leoyang.li@nxp.com>, Qiang Zhao <qiang.zhao@nxp.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        Scott Wood <oss@buserror.net>,
        linux-arm-kernel@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>
References: <0d45fa64-51ee-0052-cb34-58c770c5b3ce@c-s.fr>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <f67f7566-24f2-9c71-36be-2e55ec436097@rasmusvillemoes.dk>
Date:   Thu, 13 Feb 2020 08:45:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <0d45fa64-51ee-0052-cb34-58c770c5b3ce@c-s.fr>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/02/2020 15.24, Christophe Leroy wrote:
> Hi Rasmus,
> 
> Kernel 5.6-rc1 silently fails on boot.
> 
> I bisected the problem to commit b6231ea2b3c6 ("soc: fsl: qe: drop
> broken lazy call of cpm_muram_init()")
> 
> I get a bad_page_fault() for an access at address 8 in
> cpm_muram_alloc_common(), called from cpm_uart_console_setup() via
> cpm_uart_allocbuf()

Sorry about that. But I'm afraid I don't see what I could have done
differently - the patch series, including b6231ea2b3c6, has been in
-next since 20191210, both you and ppc-dev were cc'ed on the entire
series (last revision sent November 28). And I've been dogfooding the
patches on both arm- and ppc-derived boards ever since (but obviously
only for a few cpus).

> Reverting the guilty commit on top of 5.6-rc1 is not trivial.
> 
> In your commit text you explain that cpm_muram_init() is called via
> subsys_initcall. But console init is done before that, so it cannot work.

No, but neither did the code I removed seem to work - how does doing
spin_lock_init on a held spinlock, and then unlocking it, work? Is
everything-spinlock always a no-op in your configuration? And even so,
I'd think a GFP_KERNEL allocation under spin_lock_irqsave() would
trigger some splat somewhere?

Please note I'm not claiming my patch is not at fault, it clearly is, I
just want to try to understand how I could have been wrong about the
"nobody can have been relying on it" part.

> Do you have a fix for that ?

Not right now, but I'll have a look. It's true that the patch probably
doesn't revert cleanly, but it shouldn't be hard to add back those few
lines in the appropriate spot, with a big fat comment that this does
something very fishy (at least as a temporary measure if we don't find a
proper solution soonish).

Rasmus
