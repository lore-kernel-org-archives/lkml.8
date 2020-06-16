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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1A91C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 21:16:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A357B208B3
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 21:16:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qwjrg/vI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726404AbgFPVQb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 17:16:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725967AbgFPVQa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 17:16:30 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 446A8C061573;
        Tue, 16 Jun 2020 14:16:30 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id i27so217926ljb.12;
        Tue, 16 Jun 2020 14:16:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=OnZOezgZVzOz9JB4hQqD3uRAyvohb+j0oda6sI9lrns=;
        b=Qwjrg/vI39KV/BVNwQVK88aehEvDlwgph3TCqPFTxNYt0KpwEpAZkM7KL3QcW+6wiN
         //kV1IzXUlHXUGjZJkHSmigiJwYb3KdwZDZObx1PXSP/xT2tmQJ1XzrmmvojkVWpPknL
         2PGOynS5ikN7+fi14+ISM3YTlFPZgMo9I8C+V+MH+JtJt/m0ZJhyMTcGqDOuKoW7ffsJ
         Q+A5Qn6otX4Qh8llD43kfCA2fpLoVC/Tp/2RPJmvPbhW+Kd8Vg3qo8KkwMfCZ6HUyk7k
         +oovK5b66w1iZmpek1dxhIChEWMds2ELKb77xO7dPqFV8pDIadt+vxDck/5UKD5GwqVV
         FNCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=OnZOezgZVzOz9JB4hQqD3uRAyvohb+j0oda6sI9lrns=;
        b=JJ5Bc+wLm4QowUFmh3xr6IzzonOqbh9QLLkOeQNaB5tjUIeiyX8tHwIF/ssK4rflKf
         SzOE/XS02EqcRjZ2xskPjWqZWeXylvma6a8CZpSMNJnKkCJEmLdwTxTtlzhhJlI1BDAF
         Nt15eVKJLmy/2ScXhmE1VoXzWj6m3I0IyzF7EXuEljgEBC/pv0Ioo3ZZzyDUJDNjGPes
         xN/Sft5T/LQt3FFpnhQCf91uQ1xX5HvCubMKA3mJN/zq5HIuYfdicXb9B0x2ys//c2oK
         bS0jLalEDvaIgr5MvlmrDB85nB3ROFcV69dF6Lq8tMAQmPokNVs1P8uco3l5tOujXVFp
         GQIg==
X-Gm-Message-State: AOAM530+C8qpLqr51663wOFjpAxbOJK2LfAZjEZHT/UF0AsjEKM9YmXM
        jvr3fAaEgag8olz//8d5QJo=
X-Google-Smtp-Source: ABdhPJxV0UzC1PmGkRHvtnIQwv36oY6aTT21lS7mK9zwEdagk0VyfLJ137UPRI8gR7YlMGQModFb7A==
X-Received: by 2002:a2e:1558:: with SMTP id 24mr2293460ljv.202.1592342188684;
        Tue, 16 Jun 2020 14:16:28 -0700 (PDT)
Received: from [192.168.2.145] (79-139-237-54.dynamic.spd-mgts.ru. [79.139.237.54])
        by smtp.googlemail.com with ESMTPSA id p19sm5516068lfc.91.2020.06.16.14.16.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Jun 2020 14:16:27 -0700 (PDT)
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
 <646b3f37-0f72-7f3b-388f-f71dbcdd5c84@gmail.com>
 <CACvgo50BFH5qsPyWx9a1aZ4k5bzjSN-3KTU0BvnZ-nG-hfzKOQ@mail.gmail.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <fe845434-cbf6-29d4-eeb6-8868d628fd04@gmail.com>
Date:   Wed, 17 Jun 2020 00:16:26 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CACvgo50BFH5qsPyWx9a1aZ4k5bzjSN-3KTU0BvnZ-nG-hfzKOQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

16.06.2020 21:54, Emil Velikov пишет:
> On Tue, 16 Jun 2020 at 18:20, Dmitry Osipenko <digetx@gmail.com> wrote:
>>
>> 16.06.2020 18:48, Emil Velikov пишет:
>>> On Tue, 16 Jun 2020 at 12:40, Dmitry Osipenko <digetx@gmail.com> wrote:
>>>>
>>>> 16.06.2020 01:26, Emil Velikov пишет:
>>>>> Hi Dmitry,
>>>>>
>>>>> On Mon, 15 Jun 2020 at 08:28, Dmitry Osipenko <digetx@gmail.com> wrote:
>>>>>>
>>>>>> Hello!
>>>>>>
>>>>>> This series adds 180° display plane rotation support to the NVIDIA Tegra
>>>>>> DRM driver which is needed for devices that have display panel physically
>>>>>> mounted upside-down, like Nexus 7 tablet device for example [1]. Since
>>>>>> DRM panel rotation is a new thing for a userspace, currently only
>>>>>> Opentegra Xorg driver handles the rotated display panel [2], but this
>>>>>> is good enough for the start.
>>>>>>
>>>>>> Note that later on it should be possible to implement a transparent 180°
>>>>>> display rotation for Tegra DRM driver which will remove the need to have
>>>>>> a bleeding edge userspace that knows how to rotate display planes and I'm
>>>>>> slowly working on it. For the starter we can go with the minimal rotation
>>>>>> support, so it's not a blocker.
>>>>>>
>>>>>> This series is based on the work that was made by Derek Basehore for the
>>>>>> Mediatek driver [3], his patch is included into this patchset. I added
>>>>>> my tested-by tag to the Derek's patch.
>>>>>>
>>>>>> Please review and apply, thanks in advance!
>>>>>>
>>>>>> [1] https://patchwork.ozlabs.org/project/linux-tegra/patch/20200607154327.18589-3-digetx@gmail.com/
>>>>>> [2] https://github.com/grate-driver/xf86-video-opentegra/commit/28eb20a3959bbe5bc3a3b67e55977093fd5114ca
>>>>>> [3] https://lkml.org/lkml/2020/3/5/1119
>>>>>>
>>>>>> Changelog:
>>>>>>
>>>>>> v2: - Dropped "drm/panel: Set display info in panel attach" patch, which
>>>>>>       turned out to be obsolete now.
>>>>>>
>>>>>>     - Renamed the cover-latter, hopefully this will fix the bouncing emails.
>>>>>>
>>>>>> Derek Basehore (1):
>>>>>>   drm/panel: Add helper for reading DT rotation
>>>>>>
>>>>>> Dmitry Osipenko (4):
>>>>>>   drm/panel: lvds: Set up panel orientation
>>>>>
>>>>> IMHO it's perfectly reasonable to report the panel orientation to
>>>>> userspace, which can apply plane rotation as needed.
>>>>>
>>>>> Although I see that this series, alike Derek's, has a couple of issues:
>>>>>  - only a single panel driver is updated
>>>>>  - rotation is _not_ listed as supported property, in said panel
>>>>> driver device-tree bindings
>>>>>
>>>>> My personal inclination is that we should aim for a comprehensive solution:
>>>>>  - wire all panel drivers, as currently documented (quick grep list below)
>>>>>  - document and wire-up the lvds and boe panels - as proposed by you
>>>>> and Derek respectively
>>>>>
>>>>> HTH
>>>>> Emil
>>>>>
>>>>> Documentation/devicetree/bindings/display/himax,hx8357d.txt:2
>>>>> Documentation/devicetree/bindings/display/ilitek,ili9225.txt:2
>>>>> Documentation/devicetree/bindings/display/ilitek,ili9341.txt:2
>>>>> Documentation/devicetree/bindings/display/ilitek,ili9486.yaml:2
>>>>> Documentation/devicetree/bindings/display/multi-inno,mi0283qt.txt:2
>>>>> Documentation/devicetree/bindings/display/panel/panel-common.yaml:2
>>>>> Documentation/devicetree/bindings/display/sitronix,st7586.txt:1
>>>>> Documentation/devicetree/bindings/display/sitronix,st7735r.yaml:2
>>>>
>>>> Rotation is a common DT panel property that is described in the
>>>> panel-common.yaml.
>>> The property was introduced almost exclusively for tiny drm panels.
>>> Those ones are a bit different from the rest (in panel/) -
>>> MIPI-DBI/SPI w/o (not connected at least) an actual GPU.
>>>
>>> To make it a bit better, the rotation is seemingly performed in the
>>> tiny driver itself ouch.
>>>
>>>> This property is supported by all panel bindings
>>>> because these bindings inherent the common properties from the
>>>> panel-common.yaml.
>>>>
>>> Seems like that was an unintentional change with the conversion to YAML.
>>> Beforehand only a few selected panels had rotation. Upon closer look -
>>> some panels do have follow-up fixes, to remove/limit the implicit
>>> inclusion.
>>
>> Interesting.. my understanding that the rotation property is supposed to
>> be a generic property which represents physical orientation of a display
>> panel and hence it should be applicable to all panels.
>>
> You're spot on - it is/should be a generic property.
> 
> I believe that in general many panels were mounted in the correct
> orientation so the property, kernel and userspace were slow to catch
> up. In some cases panels will use flip x+y to denote 180 rotation, yet
> lacking the rotation property.
> The s6e8aa0 is an example of the last oddity. To make it better, the
> two dts in-tree always set both flip x and y.
> 
> Tl;Dr: Hysterical raisins
> 
>>> Sam seems like you've done most of the YAML conversion. IMHO it would
>>> make sense to revisit the patches and inherit common properties only
>>> as applicable.

It looks to me that the conversion was done properly because rotation
property was added as a common panel property from the start.

https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?id=b60c1be747418a07fbe04f8533394a64b27b6181

>>>> I don't think that it makes sense to wire up rotation property to all
>>>> panel drivers at once because those drivers will be untested, at least I
>>>> don't know anything about those other panels and can't test them. It
>>>> will be much better to support the rotation on by as-needed basis for
>>>> each panel driver individually.
>>>
>>> How about CCing the author and reviewer asking them to test the patch?
>>> The only place where the patches might cause an issue is with tiny,
>>> although patches would still be appreciated.
>>
>> There are quite a lot of panel drivers and I'm a bit doubtful that at
>> least half of devices that use those panels have any real use for the
>> rotation property. I could write the patches.. but in the end it could
>> be a wasted effort if nobody needs it, so I'd prefer not to do it.
> 
> That's why I mentioned the rotation introduction or "confusion" if I
> may. Skimming through the pre/post YAML device tree bindings and grep
> through the panel themselves will greatly reduce the list.
> In other words: if neither binding documentation/in-tree dts nor panel
> mentions rotation - omit it.

I looked through the DT bindings and only those few tiny-DRM drivers use
the DT rotation property. The parsed rotation value passed to the MIPI
DBI core where it's validated and utilized further. I don't feel that
it's worthwhile to touch that code because switching it to the common
DRM helper for reading out DT orientation won't bring any real benefits.

The samsung-s6e8aa0 panel driver indeed uses the non-standard flip-x/y
DT properties in order to achieve the 180 rotation, but I'm not sure
whether it's worthwhile to touch this driver as well because it will
require the board's DT change.

The panel's orientation could be parsed by any panel driver and then
assigned as the connector's property in order to allow userspace/FB-core
to decide what to do with the rotated display. Apparently upstream
kernel supports only that one Samsung device which has display panel
mounted upside-down and it already uses the custom DT properties for
achieving the 180 rotation. So I don't quite see any panel drivers that
instantly could benefit from using the rotation property. Perhaps I can
add the orientation support to the panel-simple driver, but will it be
useful to anyone?
