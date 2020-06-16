Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A010C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 11:40:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0EA4F2074D
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 11:40:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AC6wJsM+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728357AbgFPLkw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 07:40:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725901AbgFPLkv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 07:40:51 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 337A6C08C5C2;
        Tue, 16 Jun 2020 04:40:50 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id i27so23072267ljb.12;
        Tue, 16 Jun 2020 04:40:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=A8sjUOHgL9nLLR2sMURME3uc++A65bxuMDnX6JVkBQo=;
        b=AC6wJsM+iB4GQj4KCesjm8UoDUwmJGWwcWIaFm8rPrhjZB/QLj1wp9F1tgaLbicawK
         c9ix8MvGQQRFB3jMBO6+socsLuDysCg10/yq/URwjqAfhXTaV4I+XSt4rqh+6Giikd7y
         gY7wJei8glemZPecS7e+LG3qc1tx8qQDtky2HVaDRdymekFnXc/UAvXJtqvyPPBmXEvp
         /n91eNJ7k6ODnr0WmCbg6CSY0N+nfsUOTRpt1gtH1btJBliFDO3A3bhJSOX7Z2bH/QTF
         tcnJtdsYdEoG1bZV/TGf/drmaxh2iMY+kN0y9IPSfMmi857L8LNE0rYmNaMxdZ+vvOe1
         o5nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=A8sjUOHgL9nLLR2sMURME3uc++A65bxuMDnX6JVkBQo=;
        b=iZumMZIA9QRWWGH/TFebvC+Y+wgSDauPhddepEpr6QQO9gVcaEhEQBaRAv+b0mu2q0
         DxQ8bi4FyUTI+E8XprvpYd8dyd6Kr5ukNKZwyqFDfbh8osP+tNKONaEYyRESJ1P5jWz3
         zRZEihfZnPr0WOBBfHyyuGDjm9n2gF0OwBmC0C75IHu8BgZcVt1CwoCc9yoJXCh50x7U
         J1dV/i/08zIU9c+Xr8uzcx/QNxWrUFs9LuC0iZc9J6ghYate3S0iA3ZTAHTPSZsSeZZ0
         YNpnbngAxhB66hDnStRePG6xBuMY4y+QlXpv8tQPGi2bYRocyIMdi/gYqSy7mPQpmZrP
         YRcA==
X-Gm-Message-State: AOAM530dyf4ZX6Ze/ptiYzOsAlJPIQCEyWuceO6+IWgcF9ICCmKk36zw
        yEdpr2ku9c6NeT3UUNcgm8A=
X-Google-Smtp-Source: ABdhPJx+OvaBSKVFf8zGIZ/Op1IKf6bq1CbM9Y9hFU9yCnNt8l/j+gfKpD/5jCtPNYqKn/rVUV/Oqw==
X-Received: by 2002:a2e:9a59:: with SMTP id k25mr1343434ljj.114.1592307648668;
        Tue, 16 Jun 2020 04:40:48 -0700 (PDT)
Received: from [192.168.2.145] (79-139-237-54.dynamic.spd-mgts.ru. [79.139.237.54])
        by smtp.googlemail.com with ESMTPSA id r9sm4343500ljj.127.2020.06.16.04.40.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Jun 2020 04:40:48 -0700 (PDT)
Subject: Re: [PATCH v2 0/5] 180 degrees rotation support for NVIDIA Tegra DRM
To:     Emil Velikov <emil.l.velikov@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Derek Basehore <dbasehore@chromium.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Sean Paul <sean@poorly.run>, linux-tegra@vger.kernel.org,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
        ML dri-devel <dri-devel@lists.freedesktop.org>
References: <20200614200121.14147-1-digetx@gmail.com>
 <CACvgo51QuXMgWhFk4C=3rGvUZDX1_W0RZtVb5RtRPiHTpMebWQ@mail.gmail.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <8f789ef5-bebf-c869-784d-afda70fc1fb8@gmail.com>
Date:   Tue, 16 Jun 2020 14:40:47 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CACvgo51QuXMgWhFk4C=3rGvUZDX1_W0RZtVb5RtRPiHTpMebWQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

16.06.2020 01:26, Emil Velikov пишет:
> Hi Dmitry,
> 
> On Mon, 15 Jun 2020 at 08:28, Dmitry Osipenko <digetx@gmail.com> wrote:
>>
>> Hello!
>>
>> This series adds 180° display plane rotation support to the NVIDIA Tegra
>> DRM driver which is needed for devices that have display panel physically
>> mounted upside-down, like Nexus 7 tablet device for example [1]. Since
>> DRM panel rotation is a new thing for a userspace, currently only
>> Opentegra Xorg driver handles the rotated display panel [2], but this
>> is good enough for the start.
>>
>> Note that later on it should be possible to implement a transparent 180°
>> display rotation for Tegra DRM driver which will remove the need to have
>> a bleeding edge userspace that knows how to rotate display planes and I'm
>> slowly working on it. For the starter we can go with the minimal rotation
>> support, so it's not a blocker.
>>
>> This series is based on the work that was made by Derek Basehore for the
>> Mediatek driver [3], his patch is included into this patchset. I added
>> my tested-by tag to the Derek's patch.
>>
>> Please review and apply, thanks in advance!
>>
>> [1] https://patchwork.ozlabs.org/project/linux-tegra/patch/20200607154327.18589-3-digetx@gmail.com/
>> [2] https://github.com/grate-driver/xf86-video-opentegra/commit/28eb20a3959bbe5bc3a3b67e55977093fd5114ca
>> [3] https://lkml.org/lkml/2020/3/5/1119
>>
>> Changelog:
>>
>> v2: - Dropped "drm/panel: Set display info in panel attach" patch, which
>>       turned out to be obsolete now.
>>
>>     - Renamed the cover-latter, hopefully this will fix the bouncing emails.
>>
>> Derek Basehore (1):
>>   drm/panel: Add helper for reading DT rotation
>>
>> Dmitry Osipenko (4):
>>   drm/panel: lvds: Set up panel orientation
> 
> IMHO it's perfectly reasonable to report the panel orientation to
> userspace, which can apply plane rotation as needed.
> 
> Although I see that this series, alike Derek's, has a couple of issues:
>  - only a single panel driver is updated
>  - rotation is _not_ listed as supported property, in said panel
> driver device-tree bindings
> 
> My personal inclination is that we should aim for a comprehensive solution:
>  - wire all panel drivers, as currently documented (quick grep list below)
>  - document and wire-up the lvds and boe panels - as proposed by you
> and Derek respectively
> 
> HTH
> Emil
> 
> Documentation/devicetree/bindings/display/himax,hx8357d.txt:2
> Documentation/devicetree/bindings/display/ilitek,ili9225.txt:2
> Documentation/devicetree/bindings/display/ilitek,ili9341.txt:2
> Documentation/devicetree/bindings/display/ilitek,ili9486.yaml:2
> Documentation/devicetree/bindings/display/multi-inno,mi0283qt.txt:2
> Documentation/devicetree/bindings/display/panel/panel-common.yaml:2
> Documentation/devicetree/bindings/display/sitronix,st7586.txt:1
> Documentation/devicetree/bindings/display/sitronix,st7735r.yaml:2

Rotation is a common DT panel property that is described in the
panel-common.yaml. This property is supported by all panel bindings
because these bindings inherent the common properties from the
panel-common.yaml.

I don't think that it makes sense to wire up rotation property to all
panel drivers at once because those drivers will be untested, at least I
don't know anything about those other panels and can't test them. It
will be much better to support the rotation on by as-needed basis for
each panel driver individually.
