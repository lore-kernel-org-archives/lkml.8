Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3571DC433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 17:31:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 14B8D20679
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 17:31:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="W7/ub9LY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726238AbgFCRbF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 13:31:05 -0400
Received: from mout.web.de ([212.227.15.4]:60509 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726046AbgFCRbE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 13:31:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1591205448;
        bh=uxNq+/R50bNcytWvRvLy4FnTPalWJrFy+DDwyIvaJuE=;
        h=X-UI-Sender-Class:Cc:Subject:To:From:Date;
        b=W7/ub9LYKfgjHSzXAAQ9ZjXavOlU7+AL2A5B9bfeuI4OWXFjqVgDXk3Jb7U8GkJEk
         TcnnE7shEJBJ+aTYMW+mg4wXNZMrbN3DZ9Wkz/tVXDWJ2sAyZ3k9wesS8MNfl4Holj
         vGOgXKwh4nVgWrJW/guU7r6q9u9EXEMrHpy5MblE=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.131.82.231]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LpwMZ-1j0qxL1pWJ-00fgPz; Wed, 03
 Jun 2020 19:30:48 +0200
Cc:     Akshu Agrawal <Akshu.Agrawal@amd.com>,
        Daniel Kurtz <djkurtz@chromium.org>,
        Michael Turquette <mturquette@baylibre.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Stephen Boyd <sboyd@kernel.org>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clk: clk-st: Add missed return value checks in
 st_clk_probe()
To:     Chuhong Yuan <hslester96@gmail.com>, linux-clk@vger.kernel.org
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <f0d21bd6-6db7-d643-b662-6ca26efd28ba@web.de>
Date:   Wed, 3 Jun 2020 19:30:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:j56XJ18EZU461i9NZRMu/2YpHxgPHt+f+OhsZZNgPDMoL/OIpBl
 hDmT5dryEyrw2XiQss1d54P7KIMBmRsgfNPbyLC+dGpmNLjnZ1OxezWccy/anIHAmxnyBy9
 BbuJRnT8eWcWpNaTr6zG7wa1CUcJtr8HNqqTIVIuVLWzcQmRVbjpsKZ8SeqL7co3D4cUPWm
 mPhrtuILHnLFL0OFFR6Gg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:e9Wb2Hgf0go=:FIlq08oCe82ESRKXeo/6+b
 OAB17DsJTeO2seIJncbgrlJBdmF8Iy7oijDaDVmHqjI6W+LY5i8xdpw+iUWCRVB7OCYlIfRvu
 +ae/tgnwo+y8B2zygWYPcpSaEOkFXooWgYl8kRLloU6Py8WXMJY0NfpQWrqb1TPO0bNgCTFwj
 1T8Pznwq3mU9GjgZ9mHq3URRIs+6oEn7gnUsh9ifX0ilkWqEuFuAIMdsgjNQGJmioC4ZKAvZD
 lvSrXlAvcw2hCUAJO8fOM+WcaSCNdP/wxud3/fN6lo9h/OZvGIRd7rBfLwWnNE3Ib1mFoLJzE
 sVoMlq7UHsgoxlRd8N32ivL4ThNCftU40t11C9mDjbYYehetPA6gm/RuVU4TviyCJDzPUwB6Z
 oEbvrAEHxx6h10I+cqEvS+Nd2ef/f9H+s64RwkBY/Q1A9XibYpBJ9jKbO+H/UdmBeOPSvGnD+
 slPuWlOkJ7eJ3hVI/Wma1oYLOaj1saKJtJR/fjeXlkqkvBcc8PvD5dafMJxDseqMHmcyV0dGt
 28GJoavSGSlAgsDTGK04tadEuvMbxYYYCSwVzNLstp6jpIKTR+SPI/bIrYSjkvaiJH3VBoJQw
 +AgFnLjfw2qQQApCVngZmyvypyS8vaj5A/MDiwzdv86MTAzvju7xDDDgiIG8Frnq/LV22F7Or
 MZwS6rfXdYjfV4ohdfOC4L7uDitY3M9IOUELWBGRa8xMZAwNu10yiZwSLWuN2M39WCBow0XGi
 Gtrs7g+oeS3aZVBT11eZls1XZTNH1nwbtj9G+27oceXxS6utjqEYepTmrtmOhtr0E6Dt+A1sE
 G70aCgeNt5cJNtMaLDkaz9j+JtI2Ky7gj2IgUr/DAE3yIuo3H9VXljp6VSzD+4ZTcooJGpcmn
 ePYvyzZz58RLm/b0MT7JNbj7OVp0pa+UIrbily6aZc8qhz2DOk0X6ob7UeBauf6Z7GRwSDkIZ
 JYVj1pE/aoUvi7QPhp8uXPfCmJvT8UmuuPRpNu9UQgmJK+1Q8Wemnn+DOuTfxvO8a2FQKQytI
 e4DqSkn0ECNxEZYbhRG2RHnNOB3NvqdU7t4qOCRvTJapAnvKqQti2p8xJ4CTlCANDf6lIoRtd
 Ny/lcnlDIbTC5UiGprRxDgiOCTWCW1VqwgvZ1qzc5lDQh9aYNgbT89kk5b9Iq+R3Yc6IAL2nq
 WuhHtMxx0y9LireaZ8ESsfxvJ+rKIlaZydWsdq3sSYyl5pqYV48Fx52fh9HhTuQuExUApCgT9
 do9Mr55f68Tw46w80
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> st_clk_probe() has not check for clk_hw_register_mux(), clk_hw_register_=
gate()
> and devm_clk_hw_register_clkdev().
> Add the missed checks and return devm_clk_hw_register_clkdev()'s return =
value
> to check errors.

How do you think about another wording variant?

   Return values were not checked after calls of the following functions.
   - clk_hw_register_mux
   - clk_hw_register_gate
   - devm_clk_hw_register_clkdev

   * Thus add error detection and the corresponding exception handling.

   * Return the value from the function call =E2=80=9Cdevm_clk_hw_register=
_clkdev=E2=80=9D
     at the end of this function implementation.

Regards,
Markus
