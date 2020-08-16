Return-Path: <SRS0=yO2T=B2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17982C433E1
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Aug 2020 16:17:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E8A20206C0
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Aug 2020 16:17:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VoumfpBG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729164AbgHPQRh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Aug 2020 12:17:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726339AbgHPQR1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Aug 2020 12:17:27 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32A0CC061786;
        Sun, 16 Aug 2020 09:17:26 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id s9so7154650lfs.4;
        Sun, 16 Aug 2020 09:17:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=L2Tn5wRvOs/DSBbKAD6j6c1/papflA9Lc8de+NweZX8=;
        b=VoumfpBG/21qxzj+0ZlSLzuG3wfSOi7D+wRpUUt3o6jD76eRHBO+19V9K6IxIM2qMp
         o0TWgcZzmIYr/XZhx+1PQWDTVOaI2B/Fqpq838Y6A8wannrIKgg1HDyN0egE9+mQB1CD
         DVPzg08Fn8T5enmTf5HSuYykt/Sr4EV+J0+LfF9rygx2jhC1315JwA/RFJMRSqEpX1A7
         YMj5/sbhFp6JYWpu5tOvBXJM/D4dAiI6ylke95d5ipgUt7Nw0iAwXsO3WvNzB3oouDtN
         wmGLf2M5XoKV+IdWyblItCWEh8FinO/bkRxe07Gxzba6BhosidjtYSAtnoYD7zZaHRJ6
         rKVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=L2Tn5wRvOs/DSBbKAD6j6c1/papflA9Lc8de+NweZX8=;
        b=E6VjmEmHoqkWFy/H+0lvLoLnRjcvE/xqRen6mXFzzBA/M1e9DmFHFOCoQevoZJPPUk
         zIErdd8ltqrob1nYl0hRE5QrWJKR/fRb8rLVMSA+j3IQQfUxNrNEHGU0PD/x6/aftIOq
         Rcjq3V5E+rrglDWfhx6azs0P8PceU33OhMAkfK5CrXjy7JEMHAOlejqTY5gdYwy2A5bd
         x41zTuJePzRmN2UYK//1+D9ljsEeY4g23/K1tu3hRvNya0gK/cvMzhLRo6q0DtQfV8uf
         k/143wOrl+sBUw9RBc3VkTiGvv+EhnpeF1zfgkr5NOhXBZlZGjcTXjBbYdH7j62nHr18
         C/KA==
X-Gm-Message-State: AOAM533Bn+os6BSWoh8v0NtL/5SSoY0HCU1grjs8OY2BsPncrYe0tqWy
        Ih/B9O3QaQo/eUoEjcZwanAMp5QYvgo=
X-Google-Smtp-Source: ABdhPJziCVK3idhEDoxtMrVVaiDN9SWIPK00GHPbNv1yI21z8kcSHD6CbPuaCcaDnDEPAnM98C21Rg==
X-Received: by 2002:ac2:494c:: with SMTP id o12mr5558237lfi.181.1597594643715;
        Sun, 16 Aug 2020 09:17:23 -0700 (PDT)
Received: from [192.168.2.145] (109-252-170-211.dynamic.spd-mgts.ru. [109.252.170.211])
        by smtp.googlemail.com with ESMTPSA id e17sm3860081ljg.85.2020.08.16.09.17.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Aug 2020 09:17:22 -0700 (PDT)
Subject: Re: [PATCH RESEND v12 0/4] Panel rotation patches
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Derek Basehore <dbasehore@chromium.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Sean Paul <sean@poorly.run>, Daniel Vetter <daniel@ffwll.ch>,
        =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
        Emil Velikov <emil.l.velikov@gmail.com>,
        Daniel Stone <daniel@fooishbar.org>,
        dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200813215609.28643-1-digetx@gmail.com>
 <20200816151749.GA1394979@ravnborg.org>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <f98d8952-18e6-f761-ae5c-da7738919d08@gmail.com>
Date:   Sun, 16 Aug 2020 19:17:22 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200816151749.GA1394979@ravnborg.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

16.08.2020 18:17, Sam Ravnborg пишет:
> Hi Dmitry
> 
> On Fri, Aug 14, 2020 at 12:56:05AM +0300, Dmitry Osipenko wrote:
>> Hello!
>>
>> This series adds support for display panel's DT rotation property. It's a
>> continuation of the work that was initially started by Derek Basehore for
>> the panel driver that is used by some Mediatek device [1]. I picked up the
>> Derek's patches and added my t-b and r-b tags to them, I also added
>> rotation support to the panel-lvds and panel-simple drivers.
>>
>> We need the rotation support for the Nexus 7 tablet device which is now
>> supported by the upstream kernel, the device has display panel mounted
>> upside-down and it uses panel-lvds [2].
>>
>> [1] https://lkml.org/lkml/2020/3/5/1119
>> [2] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/arch/arm/boot/dts/tegra30-asus-nexus7-grouper-common.dtsi?#n1036
>>
>> Changelog:
>>
>> v12: - No code changes. The v11 missed v5.9 release, re-sending patches
>>        for the v5.10 kernel. Please review and apply patches to linux-next,
>>        thanks in advance!
>>
>> v11: - This series is factored out from this patchset [3] because these
>>        patches do not have hard dependency on the Tegra DRM patches and
>>        it should be nicer to review and apply the properly grouped patches.
>>
>>      - Initially [3] only touched the panel-lvds driver and Emil Velikov
>>        suggested that it will be better to support more panels in the review
>>        comments to [3]. So I included the Derek's patch for the BOE panel
>>        and added rotation support to the panel-simple driver. I tested that
>>        panel-lvds and panel-simple work properly with the rotated panel using
>>        the Opentegra Xorg driver [4] and Wayland Weston [5].
>>
>>      - The panel-lvds driver now prints a error message if rotation property
>>        fails to be parsed.
>>
>> [3] https://lore.kernel.org/lkml/20200614200121.14147-1-digetx@gmail.com/
>> [4] https://github.com/grate-driver/xf86-video-opentegra/commit/28eb20a3959bbe5bc3a3b67e55977093fd5114ca
>> [5] https://gitlab.freedesktop.org/wayland/weston/-/merge_requests/315
>>
>> Derek Basehore (2):
>>   drm/panel: Add helper for reading DT rotation
>>   drm/panel: Read panel orientation for BOE TV101WUM-NL6
>>
>> Dmitry Osipenko (2):
>>   drm/panel: lvds: Read panel orientation
>>   drm/panel-simple: Read panel orientation
> 
> Thanks for your persistence with these patches.
> While applying I made a few updates:
> - fixed two trivial checkpatch warnings
> - small update to kernel-doc for the new function, to better match
>   surrounding wording
> - added error message to panel-boe-tv101wum-nl6.c when failed to get
>   orientation
> - use same wording in all error messages and use "orientation" and not
>   rotation as this matches the called function

Hello, Sam! Very nice to see the progress! Thank you very much!
