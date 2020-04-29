Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89B63C83003
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 12:41:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 68D962072A
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 12:41:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="UaViZMK3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726871AbgD2MlX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 08:41:23 -0400
Received: from mout.web.de ([212.227.15.14]:49127 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726516AbgD2MlW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 08:41:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1588164074;
        bh=ek8MC0b4lR5i0CRwnqCbHTUsJCB+JZUB/7yb6qdfUt8=;
        h=X-UI-Sender-Class:Cc:Subject:From:To:Date;
        b=UaViZMK3Q35LhEYcS0rZtg5Y4N43FkqPSH1VyK62Ke6Yq/F/6rqlBmsxklD6ULE2J
         xpuFDJmMmr+Piujxb3HJK02NpzviU10J42GvwMYY1cn1/udrjF48aPHDqOf8HbBOIm
         pmJq3NfWgG0DF6ID5QlanaQIltwjYqLW/LKYQ0ko=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.133.72.72]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0M0f1C-1jBhPL2Oxq-00urLq; Wed, 29
 Apr 2020 14:41:13 +0200
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alan Tull <atull@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Moritz Fischer <mdf@kernel.org>
Subject: Re: [PATCH 4/4 v2] firmware: stratix10-svc: Slightly simplify code
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
To:     Christophe Jaillet <christophe.jaillet@wanadoo.fr>,
        Richard Gong <richard.gong@linux.intel.com>
Message-ID: <75f9f165-cfa8-d43d-e7c0-17ccee673de5@web.de>
Date:   Wed, 29 Apr 2020 14:41:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
X-Provags-ID: V03:K1:NO6xgLZE0Tu+wB8iARJQRd4VYII5ZoYCfT048+o7+WRvpsy3o/H
 whDOw4zgBYd2FXPIIhRgnEKw45nlM6waEItUhRMHyR+c3JtHEOfzzmQif6VQaYInxc4j4gg
 Cn0YI8v+RlhHCFKEsh/F91mszBbb25QHDgyAmKIaIQcTyahhelWLheiNeo+Hl/JEyf3v0NL
 mfxhi7PpNm3iv1e4TTPWg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:vOzqF7bRI70=:ABcf2UFq9Awy8K+6ebS2dE
 TzgDV3a8Dl7m6+FVFXG4mRLudqmxXfFIXz7cJ3s30w27IyJAgkmsTtVNF0y2uLDLzyF/PBj6i
 A0vJop8nwwcvzwx42z+cSktJAAzGewC41EwZOgO9y85IB8kEe35qNqQxckNNN+vRSIAhI+XrR
 zNVejdKFo1ZcOgLd3FuzMBa9uxNrfCLSWQBQS4E6bxFYtf1aP3na7YJeL0UJ8SGuIanJPSivD
 lwH8jfVWdS3BO83W2JA03Ig7TiA7ed9omq4slxQdbDNU9DKP/51djbGM9csbrlKe39Op14I+u
 MKA01Yqwojw5Y3Se3lM02ai9xoe86hE/XO9zpWbEsUzPg1WriPR+a6Z8VcbGWepYbQ7Bb4g4+
 7nNOz0CVdP7ChTGzQzgrp++t8gQ4W+ZrOXS4jo+HDLyR9rqjm1aFP2UfeZBYW+QvY/JnY5yoJ
 S9jfdO7Iin4C4dZWZRPDI+TJDpk27R2Nq/X3zCDdE3i4SiEyoLhY3K6QfDVP9n4hnaABBz2bd
 kAVnCZg0Muirz/2UzQA3qOFR6FKj58GbR5QeB8uk51bo4GEyhHzkPP2bB6qmEH174PscsuSo9
 FUTiTUH1C4YkoKn7lKb7iJ9+ys9FVqTsuldg23oKTgknYUjX93IHMbzNwzp3Lvea8a0xpT0FU
 57Eg50/VkOiZ6ipNGiGcTSreyJUjaRNRxZ5zxMwWTD3Ehkceuu+rwWEQqskyTolT6l5C2yCYk
 BM54ueoROPa8u4tB0r0sNuP1RBxyN3+Ud9Y8GBDCGQttLsHaMhzI4OOXwcNQIKxSUcmammqL3
 pA1zQhnfw4tbVWuVJ5p5YtAU4DJSCQAJkJWz0YZWK8nFFXRg+AVi5FTi001ardqPmNHlaRSmp
 PviM58Ut7O5hPJLk4NkFxMSIIfc8D+NXUi8BvxqVSjV8D7YOsCjsc/oGYYl/B3rvJaE52Kgk8
 qMU9M9I94MMWqKsCVP+ZviFVXfKyAotc2wpLuljABZGASp1otXyGbWm+K2H/Wr7SpoFu29pHw
 7g9XBX9/qinM6HVwKRat03MrNUw6GeoPwlYJuZgU278mehGvrn92Q3zR1kapChHltElisxyHa
 ABx0+rlPx3/P2Ikk/gfgyu3zYXq2VWdDFKfH1KFKPzpMe/P1ASeeTqklHEN7i71mlAwegiQPt
 IwX4Dg1e1Hr/q3fW1YRJUyNJMo2mwl/br6WhF6Q6dc1KJPPEq3zpaNXjhIZFK279E9uL2PLsI
 5hni2tOmZjIKQ/V4T
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Replace 'devm_kmalloc_array(... | __GFP_ZERO)' with the equivalent and
> shorter 'devm_kcalloc(...)'.
>
> 'ctrl->genpool' can not be NULL, so axe a useless test in the remove
> function.

I would find it clearer to integrate also such small source code improvements
by separate patches.

Regards,
Markus
