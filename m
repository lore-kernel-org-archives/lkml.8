Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 375BCC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 10:32:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 069A220771
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 10:32:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="jECSS8OD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729095AbgGUKc0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 06:32:26 -0400
Received: from mout.web.de ([212.227.15.4]:40235 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726521AbgGUKcX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 06:32:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1595327535;
        bh=Zm2JXMiyg6b6CBsdKVLPLiV7bch7AvexnXTHwYD79WQ=;
        h=X-UI-Sender-Class:Cc:Subject:To:From:Date;
        b=jECSS8ODPWlnvpEarnmcAjURrJ5dNQKnMb/t3O0yGJ6CAEH5qN92nArnqoe3nIMM4
         +ivqP9MoBGb6bcOFmD6JNsxGU68f+XZfCTnqVLM3XcXEDA6ir2MI7aHlwP/JOTqB7R
         eppQvc81omA21+0Ab+GWvQOEEV/hDcECH57uVPc8=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.131.170.58]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MBkal-1k5HwW2mlL-00Amcv; Tue, 21
 Jul 2020 12:32:15 +0200
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH v3 3/3] coccinelle: api: filter out memdup_user
 definitions
To:     Denis Efremov <efremov@linux.com>,
        Coccinelle <cocci@systeme.lip6.fr>,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Julia Lawall <julia.lawall@inria.fr>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nicolas Palix <nicolas.palix@imag.fr>
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <db5edbdf-0bde-870d-ac8d-9df19fc10906@web.de>
Date:   Tue, 21 Jul 2020 12:32:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
X-Provags-ID: V03:K1:yrbjegluI3Ra8C5Z28oPVXgKUSlFey5Q+zXJsMUxm84VfcU1HD8
 AayZWJVv0Hd/7tRKpLiB+QgbZbQjgmLNIQS5NZWo87pzI3A12EM7D4F2uPPyUAoiiByQRtA
 wvNhwjkIkIvUltejMq4q8bhzreyO5SgvJyKJplZZ31eD/NFgQhJ4orpqyZ24i/xycmAFw/l
 h9625pcooN3dkOr6ItCiw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:fTnoPlTxtWM=:OjYe/wboRCWjn4E7XBmfmL
 pl1EJsXQCo+00NWj2+n2LAnxtXuNf8GUyXU9JdCubqEcl6kuaWlFem6L4Y88Km+amohIy+OaZ
 25ZYryT7QpIhHIUNAIuCa0WXSx8oGoifYCd1ot/8bNX1EwiLvTdJ6WLsvndgRw0nk+CNIlYSV
 cENfBtlmjhiRAfPwLgZ8fhafjsPksN96vGQZyHQI5rs7XcNvjvgflhQCSZs32tVc/QrMKuh6r
 zFZzbNvaRME5lKw8YA01At9l4UJTBnFRo6+c360yLvxE2HKzqbHzjGJYwL7+lh8d11s5S/4ie
 WaotfCvGskSTttz06jKq+NI+kgNqfF+D+jqqo6VexxhSSm5kn/sML6Rlwhs4hl5uQrpstlk7H
 Yyct650ifrlJLRGwvrqKd3k5cyg0FqeWE8gR30eym3KofuNf4gZ1QD/QavQlym/akNphqKRQF
 uddOoCesaPK5VeMR7blHr6u7eyBSBGzWfx5BlZ/05LSdVu/16PcMTUiPgQT1WjfzRZvZosQ0g
 BDq4/5xWuinlO0CnA75LXzKRRCW6CdmmU2QXd6AsTvoTjvPleKJZSuwex1Bq+bxXRwyL/0nA6
 iw7JTtp3wEdaNClivrIzjMwAr5osbl4G0vte9N5XIQyNPb/MFy/7ehMUgyejfs3l/gpyP76iG
 enDmwp9nYjecoRSK7i1nxBcV//Trjs4QOLQqe1PoGFvV28ok/5xT0E7ZFG1ugqQf801XE4kam
 77OQ+dAGM+WmmLW+rGGuG+St+V4NvBC78fAS5GiRjq60/kdRcI0bSNf7VL+/m64f69X123PmY
 PPB3eBCyLue6XynCd8/lKA9fthPs90nzXaG4vccjtw9Z323RsgLgcUNjIJl9I0Q6kL3G62m5X
 t4/UYZ5d6etdATt6w96jKgAY117gcD6LLNkW/YiY4i80+MT09uoRSFk8kcwdUaImlHIWALEbU
 i81rlatO67Hb09Y0XkVrsUA0kYNvRuJyufcauDT8WT27zUnnslJL9l7t6K2au9iVdeQhN7Q3k
 bQyAKmESDAQQ1RfQju9UtYKISyYW98LQ13PWGlPIek7bOwXtjkwuIv6NLc51AM8dxEcmFyCZl
 Z7K1v9fWefoc0UL2FK4OEqYW+P7ntWVnjce0cpCiwifMiRPRSRNcGpGuBlS2bJxYN1xdfDK0l
 XPd0tig3obH1G1OENKfVk/qsM89hcggv76uioRd/8HrA3HyHTVmgAicro2WO0sqiyJ94i9VXC
 UzI8GbrWK+FaW6bkCk2wD4pnxTFabzdtg9UG3hg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Don't match memdup_user/vmemdup_user.

I find such a change description insufficient.

Regards,
Markus
