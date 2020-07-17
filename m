Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2955DC433E3
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 15:00:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F014D2076D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 15:00:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WlX0FGgF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727049AbgGQPAB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 11:00:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726998AbgGQO77 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 10:59:59 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65C51C0619D2;
        Fri, 17 Jul 2020 07:59:59 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id k17so6240150lfg.3;
        Fri, 17 Jul 2020 07:59:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=AIsBzWloYNimsmc0KYIOUkctLP/uf91NO5ZeFcTqUAc=;
        b=WlX0FGgFU85j8INNp504Kl83RplOa+9JaoeAAgEOl+Ri1vXBcWmpGf57guccR1cSAj
         8PfbKMwdkeI2GFlqNvC4zHIUMjWV5rxbCFl+FKROe+wUnvqXYgKugrK9sbaQhSjxE9JZ
         BnCH6fjmVEd9iDW7e8J/P+2M53XNDOnKM1iqCGY1lfUIFR0v25drbtzcgCCOzCzHo1lk
         mCC4I9ENAXb4xP60G0tAUU6tvVi39O6xND5yLvvbUvqNOD4dSKlXin2ag81IqSOStDJv
         IXcHABoG8Ux1FahCEGG4wlHq1BvCQ7WiD72cGg6WJsj+8Z6DL+oEHTDlDJDfVZspzXcJ
         D8Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=AIsBzWloYNimsmc0KYIOUkctLP/uf91NO5ZeFcTqUAc=;
        b=K5fbkf7dyIZhQrcxFo6KPjicWk15IBUccIInijZJ2pBTCb17UN2aB0IWaSiiz812p8
         zUeYWiB9/dNH3NAosUjFoM/ENDvnjJFb3k6sCj/bNxQc+zqxooEgIo5ZwDls3TxnJpik
         Q8Py3iTea/xR+5FTllFAjkISwD7IYv5qAQ6/DAzg8mqHnJKvLnfmzPiuSS7XesrTKaT2
         HWYxfiG7kx2s/HUq81WOoEIte5+nMWOVawz8wHzQgCM4bngGEcauhyST8EytImmv7bck
         WOW3px1X9yz8uJlIxJcVJum8V2wkqoUA8lAMFM8hdM04m02LIRFpoX2SVr9AUSKu1NOL
         /e1w==
X-Gm-Message-State: AOAM532Irk5juE4fRIYUwl48Mb81YsxCn9I2b735Q0q09+4vncrUcv8K
        C1WvYXOAURjzeIOV0eAi5f+1AgXn
X-Google-Smtp-Source: ABdhPJxa7d1sHKn11CgpK0Ph/XatNiYFYWQAvAn8F/chdThCJJ9I4yvmQ86DMvope5Tkh9DnrYp+LA==
X-Received: by 2002:a19:4247:: with SMTP id p68mr4922622lfa.22.1594997997589;
        Fri, 17 Jul 2020 07:59:57 -0700 (PDT)
Received: from [192.168.2.145] (ppp91-76-4-184.pppoe.mtu-net.ru. [91.76.4.184])
        by smtp.googlemail.com with ESMTPSA id m14sm2279017lfp.18.2020.07.17.07.59.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Jul 2020 07:59:56 -0700 (PDT)
Subject: Re: [PATCH v11 0/4] Panel rotation patches
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Derek Basehore <dbasehore@chromium.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Sean Paul <sean@poorly.run>, Daniel Vetter <daniel@ffwll.ch>,
        =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
        Emil Velikov <emil.l.velikov@gmail.com>,
        Daniel Stone <daniel@fooishbar.org>
Cc:     dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200617231842.30671-1-digetx@gmail.com>
Message-ID: <848a586a-060c-1244-e057-99f5b56baf09@gmail.com>
Date:   Fri, 17 Jul 2020 17:59:55 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200617231842.30671-1-digetx@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

18.06.2020 02:18, Dmitry Osipenko пишет:
> Hello!
> 
> This series adds support for display panel's DT rotation property. It's a
> continuation of the work that was initially started by Derek Basehore for
> the panel driver that is used by some Mediatek device [1]. I picked up the
> Derek's patches and added my t-b and r-b tags to them, I also added
> rotation support to the panel-lvds and panel-simple drivers.
> 
> We need the rotation support for the Nexus 7 tablet device which is pending
> to become supported by upstream kernel, the device has display panel mounted
> upside-down and it uses panel-lvds [2].
> 
> [1] https://lkml.org/lkml/2020/3/5/1119
> [2] https://patchwork.ozlabs.org/project/linux-tegra/patch/20200607154327.18589-3-digetx@gmail.com/
> 
> Changelog:
> 
> v11: - This series is factored out from this patchset [3] because these
>        patches do not have hard dependency on the Tegra DRM patches and
>        it should be nicer to review and apply the properly grouped patches.
> 
>      - Initially [3] only touched the panel-lvds driver and Emil Velikov
>        suggested that it will be better to support more panels in the review
>        comments to [3]. So I included the Derek's patch for the BOE panel
>        and added rotation support to the panel-simple driver. I tested that
>        panel-lvds and panel-simple work properly with the rotated panel using
>        the Opentegra Xorg driver [4] and Wayland Weston [5].
> 
>      - The panel-lvds driver now prints a error message if rotation property
>        fails to be parsed.
> 
> [3] https://lore.kernel.org/lkml/20200614200121.14147-1-digetx@gmail.com/
> [4] https://github.com/grate-driver/xf86-video-opentegra/commit/28eb20a3959bbe5bc3a3b67e55977093fd5114ca
> [5] https://gitlab.freedesktop.org/wayland/weston/-/merge_requests/315
> 
> Derek Basehore (2):
>   drm/panel: Add helper for reading DT rotation
>   drm/panel: Read panel orientation for BOE TV101WUM-NL6
> 
> Dmitry Osipenko (2):
>   drm/panel: lvds: Read panel orientation
>   drm/panel-simple: Read panel orientation
> 
>  drivers/gpu/drm/drm_panel.c                   | 43 +++++++++++++++++++
>  .../gpu/drm/panel/panel-boe-tv101wum-nl6.c    |  6 +++
>  drivers/gpu/drm/panel/panel-lvds.c            | 10 +++++
>  drivers/gpu/drm/panel/panel-simple.c          | 11 +++++
>  include/drm/drm_panel.h                       |  9 ++++
>  5 files changed, 79 insertions(+)
> 

Hi! Does anyone have any comments to this patchset? Will be nice if it
could get into 5.9 :) Thanks in advance!
