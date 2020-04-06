Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C005C2BA80
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 19:30:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F27B42072F
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 19:30:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z17icQy6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726287AbgDFTay (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 15:30:54 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:40900 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725895AbgDFTax (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 15:30:53 -0400
Received: by mail-pf1-f196.google.com with SMTP id c20so8062135pfi.7;
        Mon, 06 Apr 2020 12:30:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=nh5t5HwqaZ5vwtLT3aQ5LPtySy+1nmXDpAkBkNh9qyc=;
        b=Z17icQy61jImrE8skOGEPbOqTmG9HyfmTZHJ9J4nDsMICEIMALuGTFfraW+NGGOger
         WWNTDt/WYlVXRQqUtOKRYznm5XdVAdS23I5p2WLLp0LEKzyY6Pny/FPVO0Mm/W8Ootak
         b4jaqqUZmbQ/XE50A31zs7bH9DxX/RzKnjA7BnWRdyx2eE/JNItutYtaFDpm0C2BPxd6
         +BB/q0KROQAgfS5eSHctOHZ4Kay8cKPXLHdsIEfSHR54mK+4RmkArDtBT4IhujG1TnlZ
         UhPgsZjV6GxCIBaffTOFOQiGbHsz5ZPQA+dqrJ7zplqxMnxQMYqbxStcaW7jUQdRJnRE
         tCJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=nh5t5HwqaZ5vwtLT3aQ5LPtySy+1nmXDpAkBkNh9qyc=;
        b=p0JOb7lCycA/jkBAsfPZ/ZBHbZnThYVs7SYVY9xZ0v0QwkQFt+2EoQxYIDF5yIVW5l
         ZNZC/ozGnLrO0bUvZYJqpFLjjZAGzZlaZf8ycOnXAudAsYZuiK+TfGDOy6nN0qD2Sc2E
         eLelrvh+Bp5gjoNcXTL9FJTtuqkeHB+aNwGLvtKk6MRjAWtS2sXHjvCpVvLtAXJb2EIt
         AvIokjkEzbAMCRpVrwB17rDmkj7Ws/qehIzrLz+dwtKs5AtaGzdT4fmvZosUS6bUsqwm
         lFkVAjZaqWffnpY9lh3wAkJg/eTGP/+Qzom8gztXNunhfYz5nXpPhiwxIwojKaUap7Jx
         Bm6Q==
X-Gm-Message-State: AGi0PubWqakPgUEdjtP4S2j4l8Q/VkuxN/eVHsmIw0XxB/0DINwN7oYw
        FzQG0xUng4YLnI/NN+c0zh8=
X-Google-Smtp-Source: APiQypIdxJFiZxwLmJw0oNITUEQIevo3vGxi8hwQjd0iINquNH4IGOvTh7aTLBwC6be3oGyutBQ5GA==
X-Received: by 2002:aa7:9695:: with SMTP id f21mr1030846pfk.93.1586201452092;
        Mon, 06 Apr 2020 12:30:52 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id y29sm11509937pge.22.2020.04.06.12.30.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 06 Apr 2020 12:30:51 -0700 (PDT)
Date:   Mon, 6 Apr 2020 12:30:50 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Lubomir Rintel <lkundrak@v3.sk>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 04/17] clk: mmp2: Add support for PLL clock sources
Message-ID: <20200406193050.GA53133@roeck-us.net>
References: <20200309194254.29009-1-lkundrak@v3.sk>
 <20200309194254.29009-5-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200309194254.29009-5-lkundrak@v3.sk>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 09, 2020 at 08:42:41PM +0100, Lubomir Rintel wrote:
> The clk-of-mmp2 driver pretends that the clock outputs from the PLLs are
> constant, but in fact they are configurable.
> 
> Add logic for obtaining the actual clock rates on MMP2 as well as MMP3.
> There is no documentation for either SoC, but the "systemsetting" drivers
> from Marvell GPL code dump provide some clue as far as MPMU registers on
> MMP2 [1] and MMP3 [2] go.
> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/lkundrak/linux-mmp3-dell-ariel.git/tree/drivers/char/mmp2_systemsetting.c
> [2] https://git.kernel.org/pub/scm/linux/kernel/git/lkundrak/linux-mmp3-dell-ariel.git/tree/drivers/char/mmp3_systemsetting.c
> 
> A separate commit will adjust the clk-of-mmp2 driver.
> 
> Tested on a MMP3-based Dell Wyse 3020 as well as MMP2-based OLPC
> XO-1.75 laptop.
> 
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>

This patch results in:

arm-linux-gnueabi-ld: drivers/clk/mmp/clk.o: in function `mmp_register_pll_clks':
drivers/clk/mmp/clk.c:192: undefined reference to `mmp_clk_register_pll'

when building arm:pxa910_defconfig.

Bisect log is attached.

Guenter

---
# bad: [a10c9c710f9ecea87b9f4bbb837467893b4bef01] Merge tag 'for-v5.7' of git://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply
# good: [4c205c84e249e0a91dcfabe461d77667ec9b2d05] Merge tag 'keys-fixes-20200329' of git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs
git bisect start 'a10c9c710f9e' '4c205c84e249'
# bad: [31c0aa87ec8a30b1e9e4cf862905a369560f7705] Merge tag 'random_for_linus' of git://git.kernel.org/pub/scm/linux/kernel/git/tytso/random
git bisect bad 31c0aa87ec8a30b1e9e4cf862905a369560f7705
# bad: [53a2cc5cc36fd97728e1b418dbfa8f70bf23391a] Merge branches 'clk-ti', 'clk-ingenic', 'clk-typo', 'clk-at91', 'clk-mmp2' and 'clk-arm-icst' into clk-next
git bisect bad 53a2cc5cc36fd97728e1b418dbfa8f70bf23391a
# good: [2d11e9a1fd2abe784b334442b36f7d83ff914287] Merge branches 'clk-phase-errors', 'clk-amlogic', 'clk-renesas' and 'clk-allwinner' into clk-next
git bisect good 2d11e9a1fd2abe784b334442b36f7d83ff914287
# bad: [de17be999cb07effacf6a1129602f63396f5af27] clk: mmp2: Fix bit masks for LCDC I/O and pixel clocks
git bisect bad de17be999cb07effacf6a1129602f63396f5af27
# bad: [4d6da655d1871fadcb2b5de086e5a35883e22c95] dt-bindings: marvell,mmp2: Add clock ids for MMP3 PLLs
git bisect bad 4d6da655d1871fadcb2b5de086e5a35883e22c95
# bad: [5d34d0b32d6c13947b0aa890fc4c68f203491169] clk: mmp2: Add support for PLL clock sources
git bisect bad 5d34d0b32d6c13947b0aa890fc4c68f203491169
# good: [cb8dbfe831758fb2ba52d8c30db5249e48f57b8b] clk: mmp2: Constify some strings
git bisect good cb8dbfe831758fb2ba52d8c30db5249e48f57b8b
# good: [7de0b8b8b0508af5fed2f2a07e3abb6acac0c466] dt-bindings: clock: Convert marvell,mmp2-clock to json-schema
git bisect good 7de0b8b8b0508af5fed2f2a07e3abb6acac0c466
# first bad commit: [5d34d0b32d6c13947b0aa890fc4c68f203491169] clk: mmp2: Add support for PLL clock sources
