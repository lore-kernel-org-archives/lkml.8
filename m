Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D59CAC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 14:32:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 92A362087D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 14:32:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ug3i5S5j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728051AbgH0Obq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 10:31:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727069AbgH0O2R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 10:28:17 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B14B3C061264
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 07:28:16 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id a65so5361905wme.5
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 07:28:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=FshHx+iy1bAEWzQUJ7cQEVfyx5chyaL7080CcYDwA74=;
        b=ug3i5S5j6LnxQjeobT6WJyqsDG5rSL5cjC1KdHk/XUjSQaIBdPncWBRt+R+bZVW6KZ
         Jg0GgaKv3ULjDGiVw9sabdOuplNLQzTqpyEJXwvxpftphaysJGeTARCP6zSW8hJd6xG6
         ywaMaQ7nKxpvKWjo/D4ReXw5PtX6sJLmKc42PKKETft4/apJEQliSel1wrc5nYPv1xG4
         gS6EGRFQli0bF+SWIQ3o+AqylEMwBlQ/pdD82wlr8G+ce2rsbnRRDqDjPoPDv/fjLsRE
         XQTD7XQQqNpDRwN2Hu0bNv4c7Az1RlNh9b3ZzvarBWSHqhCLVnNiHTMmuCRDeUgrCB3s
         NWCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=FshHx+iy1bAEWzQUJ7cQEVfyx5chyaL7080CcYDwA74=;
        b=eSiu1j79B1Pzry6Ms/CJkSqx/ik9/RXMDClQThIh/e6kXFLlr2KgXi3FCKDtcU6zex
         M6DjxZrbi8Nr4HC66vIUrC/Qa/W+kirMGRE1pUDWlB/fq3Cl/WqiHsqj7NCo5OYm5XAP
         /NW8yHKVHWBOmrGlHRZG7hBKoHlJXb71HpbHiw0W6S80GsQI9GCGVe7N3suE3VBL6U82
         0fmeV2nou9o7wLFD/MZUwomxDEylqhhE+r4XELCtJNPkBbWp/r/XXo9VvbZPQ13aieJ6
         7OyJIIzjR/3pKG6M9VOZG7zxmabirVyf4nMuJBAAtegxdJXm9P7wM04DNyCf0LVrwfec
         FV6A==
X-Gm-Message-State: AOAM530u0tv17W3Isgn6deFRS4tzybd2VVDsilnf5Fxvt6rqU6nmU1ob
        S0Ty7Wnj94Up7PuxkQo0Cdo=
X-Google-Smtp-Source: ABdhPJxXV0L3SpjuwYIyAF5JoXygB8XwFBGwdswwyGmaWnMPJCE5eUzLF2LAxUdEaplJ9f+RBeopdw==
X-Received: by 2002:a1c:6a03:: with SMTP id f3mr12772161wmc.181.1598538495430;
        Thu, 27 Aug 2020 07:28:15 -0700 (PDT)
Received: from ziggy.stardust ([213.195.119.187])
        by smtp.gmail.com with ESMTPSA id 21sm6843823wrc.55.2020.08.27.07.28.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Aug 2020 07:28:14 -0700 (PDT)
Subject: Re: Aw: Re: [PATCH v5 3/7] drm/mediatek: disable tmds on mt2701
To:     Frank Wunderlich <frank-w@public-files.de>
Cc:     Frank Wunderlich <linux@fw-web.de>,
        chunkuang Hu <chunkuang.hu@kernel.org>,
        linux-mediatek@lists.infradead.org,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>,
        linux-arm-kernel@lists.infradead.org
References: <20200819081752.4805-1-linux@fw-web.de>
 <20200819081752.4805-4-linux@fw-web.de>
 <trinity-14a1b182-38ab-4f84-bb72-94d448b05fd5-1597994235320@3c-app-gmx-bs37>
 <81276d4c-8883-8bfd-d7d0-9b9ac025ed97@gmail.com>
 <trinity-ddd51146-41eb-49ae-9456-4588450d31aa-1598535710011@3c-app-gmx-bap26>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Message-ID: <e0edfd9f-5916-80ee-3bef-92d7050f97db@gmail.com>
Date:   Thu, 27 Aug 2020 16:28:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <trinity-ddd51146-41eb-49ae-9456-4588450d31aa-1598535710011@3c-app-gmx-bap26>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 27/08/2020 15:41, Frank Wunderlich wrote:
> Hi Matthias,
> 
> any opinions about the dts-changes?
> 

they look good to me.

> maybe series except the tmds-Patch get merged...so i add it only to my own repo till we find a better way?
> currently mainline does not support hdmi at all for the board. the tmds-patch is only a fix for specific resolutions which have a "flickering" without this Patch.
> 

Well let's see what CK's opinion.

Regards,
Matthias
