Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1642EC433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 12:25:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CECC12053B
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 12:25:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="JpS44jws"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726977AbgFBMZR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 08:25:17 -0400
Received: from mout.web.de ([212.227.17.12]:41123 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725940AbgFBMZQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 08:25:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1591100668;
        bh=JuyLwIYLMaFR2t/oQoFSPcT4slduqGwAFMkOqpi5Nok=;
        h=X-UI-Sender-Class:To:Cc:Subject:From:Date;
        b=JpS44jws+gVh2bMjwttj0jap5WC4+vF12712XWXBqgBMQHv+Pq2PJmNexQzUZeZ88
         Lcvth1qyBDyx3pG0Bw0A+jkKkh9sCe2O5ZriJ7wzS2MEsY9YwhcXVixvatKQnaQ8yL
         XKbvqx80YWbG+p3Pk/rjohNST9e51aQ6BGsMQCd8=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([2.243.186.246]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MZUS9-1jPo8H22ov-00LGHl; Tue, 02
 Jun 2020 14:24:28 +0200
To:     zhucancan@vivo.com, alsa-devel@alsa-project.org, kernel@vivo.com
Cc:     linux-kernel@vger.kernel.org, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, Wang Wenhu <wenhu.wang@vivo.com>
Subject: Re: [PATCH] ALSA: core: Fix control device release issue
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <2d17a48f-f633-4704-f0d9-ce3b668ccc9c@web.de>
Date:   Tue, 2 Jun 2020 14:24:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
X-Provags-ID: V03:K1:5+SZRiX7HHnkkzWdJPkX6PlXxafpR7793U5LLJQQQ8BYTAmbRxh
 hzzkd1ZiIafe4h3CQH9L/BElG+Ow46dCEQVC3PMMyMr5Fd5mcMSGm3ZD0FwlefwfgQhr/Xb
 Hv8BRha9q2z/bBIkyQ8gsjkm+pZiqqcno9EjWYiJcEHJctIWI7+bqR/hSerB2b64tHiaWFO
 3DHt2tXbLaP0PxHONqQdA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:yHVodJjuMLo=:bwko08NmA+kjlArhLShLVj
 CF9X42uZJt4PGx7QAMXL92VSsI7HD4cOlPvvv8DvZjun12BOqhQBYPwzfJqRVSkhzmZPRD7Vu
 MS29r9hmR2taxbPpNmCrilDPtL+sKuqG8553A0tN7mZc75HIyPwKWgGZ/WkvBRbe2GyY1byZx
 TpEl1xBUUQQXdxVyWkYgj94WoBLDX7nnttzFZCgVbu5B9+/ol+ret4GIgVg5/WErwFwN4Mhu9
 vaULpztVoT0jvmkgk/zz6VsPlf4kZN9+Y/ZgIaVxqQQ2+QSWzN5L6F/6ZKM+ALqy9mPYCS9Qy
 hWk7qbKI6iEt/1zf9BMSy7fnMIuOwbNIvPsXkigJoVMBcHARqmJX3X5eKBfWm/zouNTVfS+cS
 unlp9g7UGMNH4hCJZqzGG/A3RwNN43Y/d5j5mjw+Zqpn6rqJ9FQwWnBKK+W3LtiGfs4nfCYRs
 r7eUgRheyomJw6TqP1YrQreaxgEZ0WKuV1Q04C3gALiE6mbocIJQCRiuaYFWO/sthRQD+HwB+
 /0YUZ/u3sLTgZfHoX1xK4ncN7shNpLU64xiVRG9sYdQ5ps0wuRVJ80VqimUklMyG6KOD9VTMD
 vm7cSXo405ASf/ZpUoW6Dib4yS7Qgw5U4hiGgqwhw50qCAaIjEbxruyEbLBuW3yWkldiMtoyF
 YU7Q/JXyaIsLNIQqgdT1Fbq0zRAj3NCJVbdU0ngj1rsjxRQ/NObHU2GBkDxjOHwldHWzMz3NQ
 /lekPrpX0mg9vDg42lkqzV7Jh4/GSDITo0F2ItvobGk1DUDH/9/a62OXZRd7/i1wwb10k3+NQ
 2V6f611rCmL4dlyWMnq6CHUqLg2mKSjXAHc9Iise2hVluazCQ9VbzKHKkRnj7eWMogdXwcR4U
 ZK6+liVBCUwp0IBrx5+vQ5esDePaRx/FN0TxKNILDv9aMJ8Fq1tTGtEZFx5+Nxx0M4PAu9kEo
 FbXxtZYLJP3qETBhkpHVIz3QoTKtqOvhLk1pkGrH042ufd0YHdTpICmuRBKM7qnheFM+pYA2J
 5uKnUgo5WsLkdtzO1i5l/4sJEgdelUqa/eLXxdxDe99LarGFpFF0AdDbWCDX38Q0OB7AW453+
 alxq136itDlHK+u3RS/B4zKEnAUkvnR9aom/xcoPn9vU3/3/l9/7yHTfjdaZ21xAKJdRqCYQJ
 0SsscwdN9XgxxWPjc19+KO24Y7WJF6nM4LxHAhiu+cdB4azlUgNQfhpGNh4jPKa4ASOOdfiUt
 oTUrNXR2qVZKmivkX
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> We use snd_pcm_add_usr_ctls() in component's .pcm_new(),
> unfortunately snd_soc_dapm_add_routes() meets error during
> adding card->dapm_routes/of_dapm_routes, it will goto probe_end
> to call soc_cleanup_card_resources().
>
> The commit dc82e52492f6 ("ALSA: core: Assure control device
> to be registered at last") will make pcm device release is
> prior to control device release, but the control device needs
> to use pcm pointor, which is already freed by pcm device release.

I suggest to improve this change description.

Regards,
Markus
