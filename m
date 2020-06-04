Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCB5FC433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 18:48:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A3E4020885
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 18:48:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="S3iC1Yb5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728809AbgFDSsp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 14:48:45 -0400
Received: from mout.web.de ([217.72.192.78]:41871 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728124AbgFDSsm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 14:48:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1591296500;
        bh=Q1AXMZK8PtFx7kYNgVwlx0o4/ubYO/O0mVp0OLQDl9Q=;
        h=X-UI-Sender-Class:Cc:Subject:From:To:Date;
        b=S3iC1Yb5AvOFgTcY8hHOMnJ52Rl/iYkr75/ROueE+VmejA7AOQhwETDcSumLSMSKj
         lFyCEdpF/1081M32j//T12xwGyKwCH4O8U5NlZ7wCpfpzXyfq68M1Wex8JVid+pTgz
         QFMcyTCdh6+/9HccLOwEpDgefTyg5Dyia2nh4Yu0=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.132.94.220]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0M2uWg-1irqQU0iGs-00scxZ; Thu, 04
 Jun 2020 20:48:20 +0200
Cc:     Alan Tull <atull@opensource.altera.com>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Kevin Hilman <khilman@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Russell King <linux@armlinux.org.uk>,
        kernel-janitors@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ARM: socfpga: add missing put_device() call in
 socfpga_setup_ocram_self_refresh()
From:   Markus Elfring <Markus.Elfring@web.de>
To:     Yu Kuai <yukuai3@huawei.com>, linux-arm-kernel@lists.infradead.org
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <cb094a16-8017-704f-7811-530be8cfb16c@web.de>
Date:   Thu, 4 Jun 2020 20:48:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:roIQUmjMcQ9JA7ELZ3VYf4oVeWlQLgXczG4tyrng0pNoIVHmciw
 MnsMgXUcVSXF5YiPbOytR+FcN8K9YtRPY9bwMQEzcJsSH5mMyxyFZJcs2L1DrltrHfesueV
 WQYAqbuRP1Uvt75qmCTTvMCdQJeX8UNBS/tIOGNRlenSRsaWYE4Y/C6g8hqbkThR9brVJU8
 J128LibgItgrf1AoNwwSg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:lEuFbxsgU50=:3nkK0iwrYAl5fnXmfwri2b
 bIibQh6gAReZcyPM2jVQ66aG64mZ4LxuYuCUjU19aK7f2xDtG/L+h0hiN1yrGCm/qUP5+tjR8
 bzKy9pnlewORP/OXqQ+0fmYzAAE9RFevSJeVT6n5qvzQ1RggY12VrpeTfrszgHLL7P6CbGJS5
 PtAjgZiLZchsJMOgXA/iz+H9NW3L8Dhg59bxIp2tb0mfmsQHpqsQ0TygclWKQAstblLdjp1kZ
 BVs+KRWMOUTuwC2xD8AntqLaGfGTDdoUZQyrfMGTNlJW4xqE7PRniKs1fErTSYCvN4IG1gII6
 NRhH4URGUl+0t6NgKs2w82UIfyDdObwCjouGTkVVPAzZKGnTjeW8chB/MhFH8p+62wtDLbxa+
 YXapJotK9iLVBBroSPJbbhTVhN5yQpPtQWZqQYEKVeHkjt3cONz3vcP8aSJsQTgOY8Ee6Kq2W
 HEMZfaXTt6xwIvRX1YDO5jCJx/7iCqd133tTgdeiayjtJ3ODT4R/mcTQV8/GW8flZ6S3asrrN
 V+ckfr0e3Leiw5G28q7tEnIXNZ33b5CFqVEJfT0U5IAdlSpi+igeTU5UHdda0VnREfhJQL5R2
 es1ru9dZfCNAoty5+KWRInoVJ8Tl0CPpAmB8vfC4QTbV6e9zhvTtX05hMNu7hCk1CkqGshv5d
 2yNTejuZon3ing0DsKuvfs4viXngX/P0Ops5BYKux8b2+0hYH+nOzK3IcF2aWBa25Kz5mV1N6
 MxSsRLqDFzUjN9V6wCIfoBMsKv4hZYPEQFri01IdpJZiH4uuS0LpsL6/IHrc3q2n+OiWKerId
 a5B8qzGGSOAQJYVWjuzV36XOoZahr19KYzG+axM5azHcvbOgktKOVrA1uKO0tstx78wdVJ23G
 bTBxmZNNpuGLhtpvi8+/dFaU0nhgt3Qtxl1JPzHhITvJGziuYsoLQuBld5LTxzWYuVtCpr5gR
 i+MifQ1IZ0QjrgivnH5mzfjxrPprBZ5xiEmqZHMOwRPqQjDBHyuF6TgUBiwjo8RZB5PomyEXH
 lellK+4xInnP9HkBrJ4xDOtUbAnmACAjuY6ZCCNganGevVys0pNN1HQsie+GzOjzw0X39cru5
 Gi+pJ/YZHZ2lza6UuYwRzvvDyTgVmyQOgv89/ryrnIizF0rkIfUAbkJohNKtpmeSC1DbTUgH5
 x8MfU1hTD4ssJx21I37CRyWo7xQp6pwWzjKV1ATp7gknYRDeYw7Iz4LodYEvnaBhi51X4WTYA
 w+wuOVvtV9lw5PJdx
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> if of_find_device_by_node() succeed, socfpga_setup_ocram_self_refresh()
> doesn't have a corresponding put_device(). Thus add a jump target to fix
> the exception handling for this function implementation.

Do you find a previous update suggestion interesting?

ARM: socfpga: PM: Add missing put_device() call in socfpga_setup_ocram_self_refresh()
https://lore.kernel.org/linux-arm-kernel/c45a8e00-3fc9-adba-1a46-5f2c4149953e@web.de/
https://lore.kernel.org/patchwork/patch/1151166/
https://lkml.org/lkml/2019/11/9/156

Do you propose to adjust the source code a bit more?

Regards,
Markus
