Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B756DC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 17:21:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9289220B1F
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 17:21:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cqHsDB8j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729839AbgFPRVB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 13:21:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726573AbgFPRVB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 13:21:01 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BB5FC061573;
        Tue, 16 Jun 2020 10:21:00 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id u25so5740896lfm.1;
        Tue, 16 Jun 2020 10:21:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=xz/J2mfr4ZLz3Nv4ZC1hfD6KYzp10cq3v/xXkiMhBe8=;
        b=cqHsDB8jT5NZgtLBCl9w/wds8fgGQCEFg8oiukWotf2MWoE6K9YydrTOlKgqicTIjp
         EqGYEo7mNBJEekdGbZ3z59MFYyxh31iTIOFqIMwIfJPZ+qDxEpmOBniiCzPvjQIyrfFh
         T68Fes70FKWOaAM+bttpvi0zxIkqnkGTn83KU1U/TknuX75OiJs6jWPra7MdtsIZr/Jd
         roT0oNld+8+cam/01kba37cbkdc+FbEjg9724IcKGnlKQLBPAlXtUODBVRMb2/5mVedI
         e4M355vTl3X0TSBi2d5+9y4BOXQhTqsq7bPXb4dfSPmNg3CjycHAYs2qWSqZoBO/7qH+
         AW9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xz/J2mfr4ZLz3Nv4ZC1hfD6KYzp10cq3v/xXkiMhBe8=;
        b=MEjH9Nyp0BnvZLDDKA1j0UYHPTYlkqz/UQq+AdtSrd5PiSQcFtLnijS3xkJ9F6YWGP
         kj2LCoJMj06ZF+viy2oliqXXBTeftCGiQSfvowDs4BOCPfwh5N3/S15W91bZDj8Kzrfw
         1c/Bofp7jcLSeRne4g/Z1HbyoUQPFv7NnNuC4D8vQukh95sP0OLFzYoEHf91rxWwcVWe
         X+6WhrTPsFyy8swcfRBtq11j8emBJwllRgEpXcuuNVjJpkiIUKB2Rrzhu6oss/p7JDDW
         8x3r1jDQviV5i4C2epGgXILEIrru8KtfLvzxWSgKNiSfIjGwg7wJDPdQx2B/u6gk4CYy
         S6Fw==
X-Gm-Message-State: AOAM530c5TpMYgOAHk6Oca+OjiE7xGdKMTFDv9knkOVkMChJgVv/17oo
        QyiCyeY6wVDWCQUEgl1r6os=
X-Google-Smtp-Source: ABdhPJwmRS1Y2/ri0XsSXCFuEMSpKb0CsVkzRMi5+vL2Z292q2XEKJgXhlValE8FdhA4+4/xgOJBFg==
X-Received: by 2002:ac2:4c23:: with SMTP id u3mr1127081lfq.84.1592328058834;
        Tue, 16 Jun 2020 10:20:58 -0700 (PDT)
Received: from [192.168.2.145] (79-139-237-54.dynamic.spd-mgts.ru. [79.139.237.54])
        by smtp.googlemail.com with ESMTPSA id s18sm5353810ljj.63.2020.06.16.10.20.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Jun 2020 10:20:58 -0700 (PDT)
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
 <8f789ef5-bebf-c869-784d-afda70fc1fb8@gmail.com>
 <CACvgo50oSMbgXw1vHwVT4hhGe6g3YzKQEohCLJdfDq+0UaN1jw@mail.gmail.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <646b3f37-0f72-7f3b-388f-f71dbcdd5c84@gmail.com>
Date:   Tue, 16 Jun 2020 20:20:57 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CACvgo50oSMbgXw1vHwVT4hhGe6g3YzKQEohCLJdfDq+0UaN1jw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

16.06.2020 18:48, Emil Velikov пишет:
> On Tue, 16 Jun 2020 at 12:40, Dmitry Osipenko <digetx@gmail.com> wrote:
>>
>> 16.06.2020 01:26, Emil Velikov пишет:
>>> Hi Dmitry,
>>>
>>> On Mon, 15 Jun 2020 at 08:28, Dmitry Osipenko <digetx@gmail.com> wrote:
>>>>
>>>> Hello!
>>>>
>>>> This series adds 180° display plane rotation support to the NVIDIA Tegra
>>>> DRM driver which is needed for devices that have display panel physically
>>>> mounted upside-down, like Nexus 7 tablet device for example [1]. Since
>>>> DRM panel rotation is a new thing for a userspace, currently only
>>>> Opentegra Xorg driver handles the rotated display panel [2], but this
>>>> is good enough for the start.
>>>>
>>>> Note that later on it should be possible to implement a transparent 180°
>>>> display rotation for Tegra DRM driver which will remove the need to have
>>>> a bleeding edge userspace that knows how to rotate display planes and I'm
>>>> slowly working on it. For the starter we can go with the minimal rotation
>>>> support, so it's not a blocker.
>>>>
>>>> This series is based on the work that was made by Derek Basehore for the
>>>> Mediatek driver [3], his patch is included into this patchset. I added
>>>> my tested-by tag to the Derek's patch.
>>>>
>>>> Please review and apply, thanks in advance!
>>>>
>>>> [1] https://patchwork.ozlabs.org/project/linux-tegra/patch/20200607154327.18589-3-digetx@gmail.com/
>>>> [2] https://github.com/grate-driver/xf86-video-opentegra/commit/28eb20a3959bbe5bc3a3b67e55977093fd5114ca
>>>> [3] https://lkml.org/lkml/2020/3/5/1119
>>>>
>>>> Changelog:
>>>>
>>>> v2: - Dropped "drm/panel: Set display info in panel attach" patch, which
>>>>       turned out to be obsolete now.
>>>>
>>>>     - Renamed the cover-latter, hopefully this will fix the bouncing emails.
>>>>
>>>> Derek Basehore (1):
>>>>   drm/panel: Add helper for reading DT rotation
>>>>
>>>> Dmitry Osipenko (4):
>>>>   drm/panel: lvds: Set up panel orientation
>>>
>>> IMHO it's perfectly reasonable to report the panel orientation to
>>> userspace, which can apply plane rotation as needed.
>>>
>>> Although I see that this series, alike Derek's, has a couple of issues:
>>>  - only a single panel driver is updated
>>>  - rotation is _not_ listed as supported property, in said panel
>>> driver device-tree bindings
>>>
>>> My personal inclination is that we should aim for a comprehensive solution:
>>>  - wire all panel drivers, as currently documented (quick grep list below)
>>>  - document and wire-up the lvds and boe panels - as proposed by you
>>> and Derek respectively
>>>
>>> HTH
>>> Emil
>>>
>>> Documentation/devicetree/bindings/display/himax,hx8357d.txt:2
>>> Documentation/devicetree/bindings/display/ilitek,ili9225.txt:2
>>> Documentation/devicetree/bindings/display/ilitek,ili9341.txt:2
>>> Documentation/devicetree/bindings/display/ilitek,ili9486.yaml:2
>>> Documentation/devicetree/bindings/display/multi-inno,mi0283qt.txt:2
>>> Documentation/devicetree/bindings/display/panel/panel-common.yaml:2
>>> Documentation/devicetree/bindings/display/sitronix,st7586.txt:1
>>> Documentation/devicetree/bindings/display/sitronix,st7735r.yaml:2
>>
>> Rotation is a common DT panel property that is described in the
>> panel-common.yaml.
> The property was introduced almost exclusively for tiny drm panels.
> Those ones are a bit different from the rest (in panel/) -
> MIPI-DBI/SPI w/o (not connected at least) an actual GPU.
> 
> To make it a bit better, the rotation is seemingly performed in the
> tiny driver itself ouch.
> 
>> This property is supported by all panel bindings
>> because these bindings inherent the common properties from the
>> panel-common.yaml.
>>
> Seems like that was an unintentional change with the conversion to YAML.
> Beforehand only a few selected panels had rotation. Upon closer look -
> some panels do have follow-up fixes, to remove/limit the implicit
> inclusion.

Interesting.. my understanding that the rotation property is supposed to
be a generic property which represents physical orientation of a display
panel and hence it should be applicable to all panels.

> Sam seems like you've done most of the YAML conversion. IMHO it would
> make sense to revisit the patches and inherit common properties only
> as applicable.
> 
>> I don't think that it makes sense to wire up rotation property to all
>> panel drivers at once because those drivers will be untested, at least I
>> don't know anything about those other panels and can't test them. It
>> will be much better to support the rotation on by as-needed basis for
>> each panel driver individually.
> 
> How about CCing the author and reviewer asking them to test the patch?
> The only place where the patches might cause an issue is with tiny,
> although patches would still be appreciated.

There are quite a lot of panel drivers and I'm a bit doubtful that at
least half of devices that use those panels have any real use for the
rotation property. I could write the patches.. but in the end it could
be a wasted effort if nobody needs it, so I'd prefer not to do it.
