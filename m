Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8E1CC83000
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 07:45:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C0C97206D6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 07:45:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="hOUykm/7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726596AbgD1Hpj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 03:45:39 -0400
Received: from mail.skyhub.de ([5.9.137.197]:57568 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726253AbgD1Hpj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 03:45:39 -0400
Received: from zn.tnic (p200300EC2F0EA50071685FEE5673AD7B.dip0.t-ipconnect.de [IPv6:2003:ec:2f0e:a500:7168:5fee:5673:ad7b])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 2CC3C1EC0CE6;
        Tue, 28 Apr 2020 09:45:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1588059938;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=cjj5Q4NWvyvHXwbuKwDJQoSET/uG75lyUxQf/sqpNns=;
        b=hOUykm/79/t/J1CUkNPEmbNhcVnT3ebkgx1RW7esSjsEc/zmB1uaNvzZ+14yJSGTOLK/fP
        Pp6rV8v2PKfa4hb3r4Fb7IicbfgbiEa3wEqVDla6UpTrd3YhzjAdrEI0AdC3VoMqg8JP7I
        Exe6Yx9kYYO0blMSez3sOX2dcTSARTk=
Date:   Tue, 28 Apr 2020 09:45:27 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Adam Borowski <kilobyte@angband.pl>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: boot failure: stack-protector: Kernel stack is corrupted in:
 start_secondary
Message-ID: <20200428074527.GA12579@zn.tnic>
References: <20200421013234.GA5393@angband.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200421013234.GA5393@angband.pl>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 21, 2020 at 03:32:34AM +0200, Adam Borowski wrote:
> Hi!
> With kernels compiled with gcc-10, on two different machines (AMD Phenom2,
> AMD 2990WX) I get the following panic during boot:

Welcome to the party:

https://git.kernel.org/tip/f670269a42bfdd2c83a1118cc3d1b475547eac22

Try this branch to check whether it works for ya:

https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/log/?h=x86/build

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
