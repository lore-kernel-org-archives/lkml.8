Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEE0BC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 07:36:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 70D9720715
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 07:36:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LwxT2dbE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726976AbgERHgR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 03:36:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726489AbgERHgR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 03:36:17 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D15BBC061A0C;
        Mon, 18 May 2020 00:36:16 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id z18so494765lji.12;
        Mon, 18 May 2020 00:36:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=GLuSEpDkxbRCowgvSh3SeCEIDw8QwMJHOr1bbB7Cpyo=;
        b=LwxT2dbEJ7gOqng7mC9yPXRksFgJLS1PErbV94hynNBXE1Xro+28KCbEapKVXNHY9j
         8fg4EhjQXS4k6zykpFLymfKqmmC5Vbj7h7hi8beouN7wmaGkW8bbHchXlooOFywxt/yx
         I8aLf25BqP7h17q+Zf+qYkj05GVeq4ThwK7AotHweMiKBRSbg+JlOw3EhrNeeTgbY6IU
         KDYiogorlxJxUom2cDtPiJyDifFZqbatbW5BzlIhH4yggLywZwy49RZqws3gHOXEdSNe
         SiPM6qJZUlTFziQI4dJP3ThE9rPdS5npNYjK4B65eD/Ajzj3Sk0wYdRmZKJzy0+JMdU5
         JWDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GLuSEpDkxbRCowgvSh3SeCEIDw8QwMJHOr1bbB7Cpyo=;
        b=oLJhUxmG0NMcDiAjdQB1dZMlTZ7hv7qoV82FFj6WIikQn7nQKB+4FMAdOJa0GgCQnk
         ynQSvvcMoNDVOCBKVboJ2MO/3yT20IG0rNQsmrSq1r6zI2ng5aVw8Vw5c6r2IYnvKh65
         zZl7Z7KHcy36nus6blkCc1Q2V9Xbl52mGp/bpPWnv7uv+9w6td9wxLVtzVKWmuohdbFx
         P+6/wsEnKO0r56wzc/fhZ+gj5Hoy48ghXQC1b+kUcK3aKIgt6hR2xZf4T756fErxgPzJ
         nx+L8KDA1Yc4DAZ3bK+jZ8pfM0ofA+dUPRFlQaT+sOBG1wxjkv34R3Jflaq9hRND/6JY
         60gw==
X-Gm-Message-State: AOAM5327kQ0JAFZ8LVp3u/IIpB8yAie4l0dHuL6iCjXoh3XxjEqJJvFS
        ShhVu3t+grOtP15u64vo46UXptlf
X-Google-Smtp-Source: ABdhPJztXwHnw/eNsd+e6rSdLZtpRAJ7fk3tYqf/2h3SlRC27XECadeX7s2y5YnLKzL/LT36TMDqYA==
X-Received: by 2002:a2e:b0c4:: with SMTP id g4mr9347764ljl.235.1589787374697;
        Mon, 18 May 2020 00:36:14 -0700 (PDT)
Received: from [192.168.2.145] (ppp91-78-208-152.pppoe.mtu-net.ru. [91.78.208.152])
        by smtp.googlemail.com with ESMTPSA id n23sm5234245ljj.48.2020.05.18.00.36.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 May 2020 00:36:13 -0700 (PDT)
Subject: Re: [PATCH v10 0/2] Panel rotation patches
To:     Sean Paul <sean@poorly.run>
Cc:     "dbasehore ." <dbasehore@chromium.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
References: <20200306002112.255361-1-dbasehore@chromium.org>
 <ecbfb5f8-615a-4a88-5dac-de17158125bf@gmail.com>
 <CAGAzgsqpjZxh7PEL_Dy7HrFeFGm7+=F6cL3QG9KmK9CHvDWZ9g@mail.gmail.com>
 <6dc9ef16-9671-6ce8-27e6-aa1f4c009ee2@gmail.com>
 <CAGAzgsrNrq+S+-5KEFVnJn6S5DRn1fKkToD5=KR911T9AOAF-w@mail.gmail.com>
 <736ad1d2-4a28-87e8-62f7-28a5582c9fcf@gmail.com>
 <CAMavQKJtbha_o==X+MX6GmjfAMYvdLyubvCFg48Tbn1mdgo40w@mail.gmail.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <fa443308-7610-9060-68eb-e14e446dd4bf@gmail.com>
Date:   Mon, 18 May 2020 10:36:12 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAMavQKJtbha_o==X+MX6GmjfAMYvdLyubvCFg48Tbn1mdgo40w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

12.05.2020 23:59, Sean Paul пишет:
> On Thu, Apr 16, 2020 at 7:03 PM Dmitry Osipenko <digetx@gmail.com> wrote:
>>
>> 15.04.2020 00:32, dbasehore . пишет:
>>> On Tue, Apr 14, 2020 at 2:18 PM Dmitry Osipenko <digetx@gmail.com> wrote:
>>>>
>>>> 14.04.2020 22:32, dbasehore . пишет:
>>>>> Hi Dmitry, sorry for the late reply.
>>>>>
>>>>> On Sun, Mar 8, 2020 at 12:25 PM Dmitry Osipenko <digetx@gmail.com> wrote:
>>>>>>
>>>>>> 06.03.2020 03:21, Derek Basehore пишет:
>>>>>>> This adds the plumbing for reading panel rotation from the devicetree
>>>>>>> and sets up adding a panel property for the panel orientation on
>>>>>>> Mediatek SoCs when a rotation is present.
>>>>>>
>>>>>> Hello Derek and everyone,
>>>>>>
>>>>>> I'm looking at adding display rotation support to NVIDIA Tegra DRM
>>>>>> driver because some devices have display panel physically mounted
>>>>>> upside-down, and thus, display controller's scan-out needs to be rotated
>>>>>> by 180° in this case.
>>>>>>
>>>>>> Derek, yours panel-rotation patches add support for assigning panel's
>>>>>> orientation to the connector, but then only primary display plane
>>>>>> receives rotation value in [1], while rotation needs to be applied to
>>>>>> all available overlay/cursor planes and this should happen in other
>>>>>> places than [1] as well.
>>>>>
>>>>> This is intended. We don't correct the output in the kernel. We
>>>>> instead rely on notifying userspace that the panel is rotated, then we
>>>>> handle it there.
>>>>>
>>>>>>
>>>>>> [1] drm_client_modeset_commit_atomic()
>>>>>>
>>>>>> Please also note that in a case of the scan-out rotation, plane's
>>>>>> coordinates need to be changed in accordance to the display's rotation.
>>>>>>
>>>>>> I looked briefly through the DRM code and my understanding that the DRM
>>>>>> core currently doesn't support use-case where scan-out needs to rotated
>>>>>> based on a panel's orientation, correct? Is it the use-case you're
>>>>>> working on for the Mediatek driver?
>>>>>
>>>>> Yes, we rely on userspace to rotate the output. The major reason for
>>>>> this is because there may not be a "free" hardware rotation that can
>>>>> be applied to the overlay. Sean Paul and others also preferred that
>>>>> userspace control what is output to the screen instead of the kernel
>>>>> taking care of it. This code just adds the drm property to the panel.
>>>>>
>>>>
>>>> Could you please explain what that userspace is?
>>>
>>> This was added for Chrome OS, which uses its own graphics stack,
>>> Ozone, instead of Xorg.
>>>
>>
>> Thank you very much for the clarification.
>>
>> It's probably not a big problem for something monolithic and customized
>> like ChromeOS to issue a software update in order to take into account
>> all specifics of a particular device, but this doesn't work nicely for a
>> generic software, like a usual Linux distro.
>>
>>>> AFAIK, things like Xorg modesetting don't support that orientation property.
>>
>> In my case it's not only the display panel which is upside-down, but
>> also the touchscreen. Hence both display output and touchscreen input
>> need to be rotated at once, otherwise you'll end up with either display
>> or input being upside-down.
>>
>> The 180° rotation should be free on NVIDIA Tegra. There are no known
>> limitations for the planes and BSP kernel video driver handles the
>> plane's coordinates/framebuffer rotation within the driver.
>>
>> The kernel's input subsystem allows us to transparently (for userspace)
>> remap the touchscreen input (by specifying generic touchscreen
>> device-tree properties), while this is not the case for the DRM subsystem.
>>
>> @Thierry, @Sean, @Daniel, could you please help me to understand how a
>> coordinated display / input rotation could be implemented, making the
>> rotation transparent to the user (i.e. avoiding xorg.conf hacking and
>> etc)? It should be nice if display's output could be flipped within the
>> DRM driver, hiding this fact from userspace.
> 
> I think the right thing to do is to fix userspace to respect this
> property, since that has the most communal benefit.

Hello Sean,

This will be ideal, but it's difficult to achieve in a loosely
controlled userspace environment.

> However(!!) if you don't want to do that, how about inspecting the
> info->panel_orientation value after drm_panel_attach in tegra driver
> and then adjusting rotation values in the driver. Of course, you
> wouldn't want to expose the panel orientation property since you don't
> want userspaces to be double-rotating on you, but it's optional so
> you'd be fine.

Thank you very much for the suggestion, I'll be trying it out soon.

>>
>> Will it be okay if we'll add a transparent-rotation support specifically
>> to the Tegra DRM driver? For example if device-tree contains
>> nvidia,display-flip-y property, then the Tegra DRM driver will take care
>> of rotating coordinates/framebuffer of the display planes.
> 
> I don't think this is necessary, but it also wouldn't really be
> appropriate to put software attributes into devicetree anyways.

Yes, I'm also not feeling very excited about this variant.
