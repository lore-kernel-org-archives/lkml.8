Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 327EFC433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 19:08:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D6B8206A2
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 19:08:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="qBOwYG5g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729683AbgFDTIV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 15:08:21 -0400
Received: from mout.web.de ([212.227.17.12]:57747 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729310AbgFDTIV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 15:08:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1591297676;
        bh=JbzMdzFOzCTsibWwfsPpxK0BShMK2VsDXLIYdKprY00=;
        h=X-UI-Sender-Class:Cc:Subject:From:To:Date;
        b=qBOwYG5gxDn5aB9WWdq9lQ95XfJKD231xBcY1NSN9+Mam2M9ZpJr2T9T1CT9Xqwu9
         rEX81vUCk1c98mK2oUEiqqjXKDzpq2ptH6iAncHwjQQm/HPAw7hh+N4TETULCKnbLP
         NXUm9j02x18HWONoBlK5LjeagXXfatqwdRv8BpYw=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.132.94.220]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MsrhK-1io0DE25No-00t6Da; Thu, 04
 Jun 2020 21:07:56 +0200
Cc:     Anson Huang <Anson.Huang@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Yi Zhang <yi.zhang@huawei.com>,
        kernel-janitors@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ARM: imx6: add missing put_device() call in
 imx6q_suspend_init()
From:   Markus Elfring <Markus.Elfring@web.de>
To:     Yu Kuai <yukuai3@huawei.com>, kernel@pengutronix.de,
        linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <cf810c93-297c-c02c-9bba-8c3d097b8e31@web.de>
Date:   Thu, 4 Jun 2020 21:07:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:XFGsV0QKIXJfaz2i0ga3WHMhzuzk6lKF+KUAnTOGnoBnphAbrMV
 nyx1x1gvgaCb41DMh90xa/ORO29oOH7RG46fya33Wz+wa6qnrqVKG1bNnxvhF3/8NlT1yKX
 YiSynMk/6NZskf7lr/s0whnQsxu/MkNedXcZ8u3uA3TD7pS8/Gi0kg8IB2iwYZ0mxZ+PqXh
 uytUaPMiiZrkC3HkI8DCg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:eKr1vF7wTfk=:4U46qkCn9wPU67wuYyaE0S
 jUWXai863XDATWGg4zj3PE+M0j9LvdKQtwibK4EI9e2tSZeoz6ryYsuQaSWWigw5/1Y5bYQIN
 zOTf5ntbm78cMxZU/j9wfx7MVbvtO7I/0mYtGFYGXtZfkuEz+NCTSMG7MVboKDCo+AUpArctG
 lQhQvYaWf0vpEaoLMe0/7vejgIWuEh79iYsL67HTW1CLiJq7JGzLDKQ8UVM11fYf9xngAZOIg
 XBUkwuu/8yicEnDl8trP1YTfmLhb0ykJcUXuI+TqwbhxB8ecjlpdCO/fPg5rwR2rRgty7OsxG
 lvkfBTFnCOE6/XkqQL7OsvSdNrgyoFoJI1mq7KC2wUdBuLevzUtuP5S34VG9blibRI76D+WBR
 Af1eD7vsKZPDabjq4l8tba3tE7iHDolJtePMT1QqL45wVdo7Aa1OQjtuihOik+Q7B/Aed4F1i
 s9AtPPUhYdJjpNI5RSB6klvjr34WQvIh8blMb+JeP+jd0N3wHPkyYkvhoScB1KVMiNRsWkA8x
 wC8yQhHyAs+d6HkZJNkahcM50QIrGYYebwyB4Q6/2ovQ2ymnO+1FSCBptFndiHzsJsDc6J3K5
 yCbXYpFirKyS/BrpGy/8lNrN6Mh6eqMUo3XdRxjBe4PANrhoYDzFIwl0tCIXKMTssRLyt1iY2
 fZ0aKHyxdcOpC4xrXQjx42nFhMR9iwmPl/6LwMHd4+NSFw6sjRHbfmJBN1MDgiLQAhpg1ip8r
 DwHNodCTZMWhQYUIoFHzUVbJItuSSa0oKc6XZ4IcUddSINVuK87zZrZZ0mNmjaaGU3p8Rd9uP
 Frl6NW2rZCraq1H6wkc8W8tYZWXtRCRZU5xeUARC5S2T+LAUvlFVkqzrp7xrjwde6hOAjR2BL
 1d2MWg3/Ar2zzHTAOE5f0GpWveBj6rN5nwAxxir8ju1Z86dRw0IUWR6Kyn93WL/QX7Yvb4j5H
 uq9LFZOfS78JSc/8T2bPH5YDCdrBsqikiIFYoTF28PrHsxbkeevYYrQruq8bbItIBn7Pdioid
 QREe0V9J7E/rcd9RPnlY+7CoPu6iqpU9caqr6bK1vrv+IgpOdUk8uNRVJLquBbzuWGm9YaOo3
 kufJ6cR4OCArj3pA/9J2rkd34rPV9q0Oe4eEsm/oaMFbKU3XpU8DWSlrS41l35TN3LSoUGWPt
 9gx0zqVkWrFtUjRdJDW6MDoqJGEddOrvPQO6GZOx818/p9e1ewdEsKVAgYpAnDsydPQD5XwcF
 UeqzIX6m3nLNzRWL9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> if of_find_device_by_node() succeed, imx6q_suspend_init() doesn't have a
> corresponding put_device(). Thus add a jump target to fix the exception
> handling for this function implementation.

Do you find a previous update suggestion useful?

ARM: imx6: Add missing put_device() call in imx6q_suspend_init()
https://lore.kernel.org/linux-arm-kernel/5acd7308-f6e1-4b1e-c744-bb2e5fdca1be@web.de/
https://lore.kernel.org/patchwork/patch/1151158/
https://lkml.org/lkml/2019/11/9/125

Regards,
Markus
