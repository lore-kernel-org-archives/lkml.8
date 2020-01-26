Return-Path: <SRS0=fzvl=3P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A44AFC35240
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jan 2020 10:26:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74D972071A
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jan 2020 10:26:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="D27wrEu/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729397AbgAZK0B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Jan 2020 05:26:01 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:43097 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729213AbgAZK0A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jan 2020 05:26:00 -0500
Received: by mail-io1-f68.google.com with SMTP id n21so6752668ioo.10
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jan 2020 02:26:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=I5ss2A9PhpaPL+Y6/Eq0fV6rb1bJtLZPNb/zRGwXMTE=;
        b=D27wrEu/CsAGY5dRH3TN2ZKuFTn5laOBjvVfcM1Dw80HaP/96lJhwPSpGcphnf4P7l
         /97PsAfIHisHOsXwN6XAWK49wscMV82zk/6WTQJMSi3HOOyDuvpDnwUizm4xOs7VHGkc
         wzP59SUoBy/ZHhg49zAgQOuOsoioFYRyhYMv8opfli6+HZNEJzif+rukPRgpIQNPkxQz
         NhlSEf+RqIWizq16mTNkzS1FBqlGGpDQ89Yp34/v8jD6wRCPc/DVdPtFND8l5QtBnfqU
         xqJ6LtQxlBCVej/KSCDIENnA47d2Md0Q5ZYTT7zHH9NQKejWY6VqqYtusjqeG8Y1zKGB
         +i4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=I5ss2A9PhpaPL+Y6/Eq0fV6rb1bJtLZPNb/zRGwXMTE=;
        b=PxCU/GKDrLg9Xar43A79mOkGafRT+xI9oDJCI/U+EzvrJEXAmfkN8h0HaSEOl0iJ2i
         kSew5WG4FMCY3nA8OGTi3vZjwA52SdGGMvhhrrUXc7Ea0vbKGxdplx4qh4iq+l9tELB0
         8pahBbIX6WZMsusHkpsox1weosAwwEMA9d/1Zh7uv1idt1LD63PlHO2vqEG2UaToPsHK
         HFpAid+0Atbd7L0zIJ784c7rt8yx13KWxms8RNi9TsH7CaXuKXELj6iu/lsiabPBbcpx
         nUJ/gBgd3ogqyF9BUquU5BPAaddxa3N69MYoXRseY/s/QlpnJle7qmmagXjspiKkQplj
         Fn5g==
X-Gm-Message-State: APjAAAUMVY15xwJ6TwPmSYxYr/WFbxADg/LbIXCflPwGj4Vf68xOsjUI
        QCX8OuZ5HMF7nWa9UR8N+9edKGhqNiIcziPNPI2VXw==
X-Google-Smtp-Source: APXvYqy/OgLhH2YrMUUnwdGcownsvFIpuD+QssaiI+S932cX8vLLDRtGbVAw6t5Xz6uzY5DtwPKwinFv6tqzMMZmNhg=
X-Received: by 2002:a02:b615:: with SMTP id h21mr9013386jam.109.1580034359905;
 Sun, 26 Jan 2020 02:25:59 -0800 (PST)
MIME-Version: 1.0
References: <20200125162917.247485-1-yuhsuan@chromium.org>
In-Reply-To: <20200125162917.247485-1-yuhsuan@chromium.org>
From:   Tzung-Bi Shih <tzungbi@google.com>
Date:   Sun, 26 Jan 2020 18:25:48 +0800
Message-ID: <CA+Px+wU4kxGbZy7VpZ5hb==m7-BYPEOYd5EiWLpNvdD+h9vPOA@mail.gmail.com>
Subject: Re: [PATCH v2] ASoC: cros_ec_codec: Support setting bclk ratio
To:     Yu-Hsuan Hsu <yuhsuan@chromium.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Cheng-Yi Chiang <cychiang@chromium.org>,
        Tzung-Bi Shih <tzungbi@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Benson Leung <bleung@chromium.org>,
        ALSA development <alsa-devel@alsa-project.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 26, 2020 at 12:29 AM Yu-Hsuan Hsu <yuhsuan@chromium.org> wrote:
>
> Support setting bclk ratio from machine drivers.
>
> Signed-off-by: Yu-Hsuan Hsu <yuhsuan@chromium.org>

Reviewed-by: Tzung-Bi Shih <tzungbi@google.com>
