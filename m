Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F86AC41621
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 16:12:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79583208E0
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 16:12:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="aSyqwGew"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728834AbgCXQMF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 12:12:05 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:51070 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728571AbgCXQME (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 12:12:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=1UNukJNSl6CmN8g/B7TvDZCfcdT81GU+Tg6yepq83q4=; b=aSyqwGewwRNOrGoIu6iHCe9UD5
        cMkwEsYYlKnhJytvjpQPofzS4feDAZYgCfgDICk2nYjB4CfLbIVVdHuP6I/z2i+bPhKlEcPoiaGUa
        FpR7ktwZqyCKkmjzzEiW1UoT7f8w9uCyB+f179J4TFBGeUfaonh5ODahgZizmvDnSgNY1wEZBy+tr
        wp3gww3r7iuw6i0IbPxueTA+EQ7alq9AQ33OvobMnK4LS/I+sIhtaE1w4WbOfgeCobv2SByfb5WE8
        yBbO1XwqtLfDwtRlqCOHX5T8fOUMpfUlQofsA5DPi6f4zh8PwjK2zQNh1kXaubQZuXQbh0QaHpvon
        GzeJivlQ==;
Received: from [2601:1c0:6280:3f0::19c2]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jGm9s-0000Ix-02; Tue, 24 Mar 2020 16:12:04 +0000
Subject: Re: [PATCH 1/1] x86 support for the initrd= command line option
To:     ron minnich <rminnich@gmail.com>, "H. Peter Anvin" <hpa@zytor.com>
Cc:     Matthew Garrett <mjg59@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "maintainer:X86 ARCHITECTURE..." <x86@kernel.org>,
        lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <CAP6exY+LnUXaOVRZUXmi2wajCPZoJVMFFAwbCzN3YywWyhi8ZA@mail.gmail.com>
 <D31718CF-1755-4846-8043-6E62D57E4937@zytor.com>
 <CAP6exYJHgqsNq84DCjgNP=nOjp1Aud9J5JAiEZMXe=+dtm-QGA@mail.gmail.com>
 <8E80838A-7A3F-4600-AF58-923EDA3DE91D@zytor.com>
 <CACdnJusmAHJYauKvHEXNZKaUWPqZoabB_pSn5WokSy_gOnRtTw@mail.gmail.com>
 <A814A71D-0450-4724-885B-859BCD2B7CBD@zytor.com>
 <CAP6exYJdCzG5EOPB9uaWz+uG-KKt+j7aJMGMfqqD3vthco_Y_g@mail.gmail.com>
 <CF1457CD-0BE2-4806-9703-E99146218BEC@zytor.com>
 <CAP6exYJj5n8tLibwnAPA554ax9gjUFvyMntCx4OYULUOknWQ0g@mail.gmail.com>
 <C2B3BE61-665A-47FD-87E0-BDB5C30CEFF4@zytor.com>
 <CAP6exY+avh0G3nuqbxJj2ZgKkRdvwGTKeWyazqXJHbp+X-2u+A@mail.gmail.com>
 <CAP6exYLEg+iu4Hs0+vdk0b6rgB5ZT7ZTvuhe--biCg9dGbNCTQ@mail.gmail.com>
 <CAP6exYLCFp8AMFx_d3XJtYiSibF76Fo-km4vB5MwSbqE8D8DNA@mail.gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <2837291a-b682-bd6d-4e08-ffa76d3097b0@infradead.org>
Date:   Tue, 24 Mar 2020 09:12:02 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <CAP6exYLCFp8AMFx_d3XJtYiSibF76Fo-km4vB5MwSbqE8D8DNA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/24/20 9:05 AM, ron minnich wrote:
> diff --git a/Documentation/admin-guide/kernel-parameters.txt
> b/Documentation/admin-guide/kernel-parameters.txt
> index c07815d230bc..9cd356958a7f 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -1714,6 +1714,13 @@
> 
>      initrd=        [BOOT] Specify the location of the initial ramdisk
> 
> +    initrdmem=    [KNL] Specify a physical adddress and size from which
> +            to load the inird. If an initrd is compiled in or

                           initrd.

> +            specified in the bootparams, it takes priority
> +            over this setting.
> +            Format: ss[KMG],nn[KMG]
> +            Defaut is 0, 0

               Default

> +
>      init_on_alloc=    [MM] Fill newly allocated pages and heap objects with
>              zeroes.
>              Format: 0 | 1


-- 
~Randy

