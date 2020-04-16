Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 853FCC2BA2B
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 23:03:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B9CC20857
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 23:03:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vgzVO6BB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728530AbgDPXDe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 19:03:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725988AbgDPXDd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 19:03:33 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEB19C061A0C;
        Thu, 16 Apr 2020 16:03:32 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id q22so211750ljg.0;
        Thu, 16 Apr 2020 16:03:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Z8uoOXp4twM9P9CL3wU74kwZNLbCUFRTsmV6ladVv10=;
        b=vgzVO6BB7c3OiUt+kzDq772Qp/Lnqd1TScfYm9t/pCh5T1n/iF8jepLsBtpRY227pF
         vCJ6HSZcjxe/hlnWWEU2H+8rkH+gp+IiaXd8xyvWrTP6hPROy+88zw3i2kDOKNuhsH3D
         PaBqJeVqNmt2xxJwLhGmqnE121Vv1HyV3U3tMV7lLejOqkHiWLiIJZDDDC93Ld3rn0Bb
         IltAalp9w37ura37IyuYr73eRh9XnqjbUa7jRVKoXGLDhBA6pi+T+nlm49z8zCMVe3Nt
         F7hrq7Y/bAl5FsxmNTZ4rvbJTRiKl6VmzTh7I53LHDRP/defhKpqORj4TVC0R3cxkSkP
         w3cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Z8uoOXp4twM9P9CL3wU74kwZNLbCUFRTsmV6ladVv10=;
        b=s/xuW7rmoNj8+oR9R6RmFGo7MdNJtoiLbZo3FVm1dcUX1GYnm5k1vd4MODdym8rrR8
         njWobSp/a2D/XcP4ecLB6UWZd0PWuIMjrG7fHuwLtQKWJsTe7IaFZvSxNU5PhJIZiA+j
         gbhjumGylbY8BDYOJd64FlaGekTujboxq/bWyxf9DrWBHsZgtf8Wu8mXXEeaVTjo63QT
         mrzX3iYom6z+bW2AxOJbv+RhzkMMCo6xmlzh/7i0gWfP9+9ukzpoZE0elvzsFQis9zYI
         mmbSppUaj9lHWD6WAVgLT+lPJrrtHgcn45Gg66Jccq7q3UUsZSxdnLoEosn21AZBgVpn
         jTYg==
X-Gm-Message-State: AGi0PuYfLZVyVH85VeDeSU35mikfAz0KPk0ye3yIIjoni/bBzNLyFT4u
        QeNzYVvKwBXm+X3DZtie48bSquE9
X-Google-Smtp-Source: APiQypK8WnUVD8hasXWixMVEp3FXnqD+7VdEf8+IsRlUpiO6lZKJ8z3vonz33E14poQGWj1nvc6+rw==
X-Received: by 2002:a2e:854e:: with SMTP id u14mr248556ljj.95.1587078211071;
        Thu, 16 Apr 2020 16:03:31 -0700 (PDT)
Received: from [192.168.2.145] (ppp91-78-208-152.pppoe.mtu-net.ru. [91.78.208.152])
        by smtp.googlemail.com with ESMTPSA id d3sm14000341lfq.63.2020.04.16.16.03.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Apr 2020 16:03:30 -0700 (PDT)
Subject: Re: [PATCH v10 0/2] Panel rotation patches
To:     "dbasehore ." <dbasehore@chromium.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sean Paul <sean@poorly.run>, Daniel Vetter <daniel@ffwll.ch>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
References: <20200306002112.255361-1-dbasehore@chromium.org>
 <ecbfb5f8-615a-4a88-5dac-de17158125bf@gmail.com>
 <CAGAzgsqpjZxh7PEL_Dy7HrFeFGm7+=F6cL3QG9KmK9CHvDWZ9g@mail.gmail.com>
 <6dc9ef16-9671-6ce8-27e6-aa1f4c009ee2@gmail.com>
 <CAGAzgsrNrq+S+-5KEFVnJn6S5DRn1fKkToD5=KR911T9AOAF-w@mail.gmail.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <736ad1d2-4a28-87e8-62f7-28a5582c9fcf@gmail.com>
Date:   Fri, 17 Apr 2020 02:03:29 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAGAzgsrNrq+S+-5KEFVnJn6S5DRn1fKkToD5=KR911T9AOAF-w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

15.04.2020 00:32, dbasehore . пишет:
> On Tue, Apr 14, 2020 at 2:18 PM Dmitry Osipenko <digetx@gmail.com> wrote:
>>
>> 14.04.2020 22:32, dbasehore . пишет:
>>> Hi Dmitry, sorry for the late reply.
>>>
>>> On Sun, Mar 8, 2020 at 12:25 PM Dmitry Osipenko <digetx@gmail.com> wrote:
>>>>
>>>> 06.03.2020 03:21, Derek Basehore пишет:
>>>>> This adds the plumbing for reading panel rotation from the devicetree
>>>>> and sets up adding a panel property for the panel orientation on
>>>>> Mediatek SoCs when a rotation is present.
>>>>
>>>> Hello Derek and everyone,
>>>>
>>>> I'm looking at adding display rotation support to NVIDIA Tegra DRM
>>>> driver because some devices have display panel physically mounted
>>>> upside-down, and thus, display controller's scan-out needs to be rotated
>>>> by 180° in this case.
>>>>
>>>> Derek, yours panel-rotation patches add support for assigning panel's
>>>> orientation to the connector, but then only primary display plane
>>>> receives rotation value in [1], while rotation needs to be applied to
>>>> all available overlay/cursor planes and this should happen in other
>>>> places than [1] as well.
>>>
>>> This is intended. We don't correct the output in the kernel. We
>>> instead rely on notifying userspace that the panel is rotated, then we
>>> handle it there.
>>>
>>>>
>>>> [1] drm_client_modeset_commit_atomic()
>>>>
>>>> Please also note that in a case of the scan-out rotation, plane's
>>>> coordinates need to be changed in accordance to the display's rotation.
>>>>
>>>> I looked briefly through the DRM code and my understanding that the DRM
>>>> core currently doesn't support use-case where scan-out needs to rotated
>>>> based on a panel's orientation, correct? Is it the use-case you're
>>>> working on for the Mediatek driver?
>>>
>>> Yes, we rely on userspace to rotate the output. The major reason for
>>> this is because there may not be a "free" hardware rotation that can
>>> be applied to the overlay. Sean Paul and others also preferred that
>>> userspace control what is output to the screen instead of the kernel
>>> taking care of it. This code just adds the drm property to the panel.
>>>
>>
>> Could you please explain what that userspace is?
> 
> This was added for Chrome OS, which uses its own graphics stack,
> Ozone, instead of Xorg.
> 

Thank you very much for the clarification.

It's probably not a big problem for something monolithic and customized
like ChromeOS to issue a software update in order to take into account
all specifics of a particular device, but this doesn't work nicely for a
generic software, like a usual Linux distro.

>> AFAIK, things like Xorg modesetting don't support that orientation property.

In my case it's not only the display panel which is upside-down, but
also the touchscreen. Hence both display output and touchscreen input
need to be rotated at once, otherwise you'll end up with either display
or input being upside-down.

The 180° rotation should be free on NVIDIA Tegra. There are no known
limitations for the planes and BSP kernel video driver handles the
plane's coordinates/framebuffer rotation within the driver.

The kernel's input subsystem allows us to transparently (for userspace)
remap the touchscreen input (by specifying generic touchscreen
device-tree properties), while this is not the case for the DRM subsystem.

@Thierry, @Sean, @Daniel, could you please help me to understand how a
coordinated display / input rotation could be implemented, making the
rotation transparent to the user (i.e. avoiding xorg.conf hacking and
etc)? It should be nice if display's output could be flipped within the
DRM driver, hiding this fact from userspace.

Will it be okay if we'll add a transparent-rotation support specifically
to the Tegra DRM driver? For example if device-tree contains
nvidia,display-flip-y property, then the Tegra DRM driver will take care
of rotating coordinates/framebuffer of the display planes.
