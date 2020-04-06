Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A02FC2BA80
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 22:08:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 720682078C
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 22:08:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="S27HT0kR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726396AbgDFWIW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 18:08:22 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:46285 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725933AbgDFWIW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 18:08:22 -0400
Received: by mail-lj1-f194.google.com with SMTP id r7so1394437ljg.13
        for <linux-kernel@vger.kernel.org>; Mon, 06 Apr 2020 15:08:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=i6EPio+XqTmpQjx6tkaBsOwcW96ts+qCKKJEhZ/lpb4=;
        b=S27HT0kRUdBCzrJLgfx+SkwGDQLYpyIto7d00PNS7hLwxJh/ClU0q1RlYyaint7PYr
         HUonR9NLwPPWfmIGavWmeBmH5R0xosim3Sswl1hErVIjwQ3qvL/VjzxSoHyv9tPwSzxz
         43RHm7N7zOlDDjw0va+5fGlq7y/gA3QUxAd+srWFYsuEhwBdmSxX6Gj2vO9J8lL5RWPd
         HKe2lFSF609Iu1Mg6qKk6/2fX7TckJZ+FHmIpVFXKzE19TD26DVX/E/A58L5XNcEzKqw
         XTqJ7RCFA1+omhgw+jD+g+doai2/qgS7VgjXXRcrnfW0zxehbMHxQTeog3qXHfVODJvE
         ku9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=i6EPio+XqTmpQjx6tkaBsOwcW96ts+qCKKJEhZ/lpb4=;
        b=N4Bg4/RCdhDJV3aUcuVxHe0dPHcNO04AVqPnUtbOJAHxUZaJUIXZy1zEK6VKjtGVNY
         wHPF7kC0vByeA6r22w3uPPYa9MMRjh+vjJmJLdBGRfTMA87F736Zp+og6/SYODncw+FZ
         l0U2iiifAV1zpvCMFiMYLC8IqgMUaGpsZwOi/PTzAhk2fZRvTAAEKAYRRYjHpMPTZCuG
         ot3RkADpDXAo6HVAFp86VAl7fvlEDmKTJmsC2IM8Fo6hwpNL8sQJz6aF6dEJJ2DoawLy
         YdJM8dNwhSZqbW3QRfuSlrFYnEOf8WwDsoko4lrwoz2ZjOMCuzY9Wn2vAcNlu4ziq5Iq
         QghQ==
X-Gm-Message-State: AGi0PuY4j7btWyxNxiHR9M2MBrRHAXl6iH608ex+scvwIOujo0o9bz0D
        am+fT31VdbJljnnwLYtWf2iNDIhaE/jp1XjIHr1kfg==
X-Google-Smtp-Source: APiQypJutuComtXjTAg4KhcKwjrBIchyTWTtR4JrsI2316VMEl8qDs4azgKK5SaZ74yqUigstDXM5vPRH7iEL3UdZBM=
X-Received: by 2002:a2e:9616:: with SMTP id v22mr779863ljh.107.1586210899428;
 Mon, 06 Apr 2020 15:08:19 -0700 (PDT)
MIME-Version: 1.0
References: <20200310000617.20662-1-rajatja@google.com> <20200310000617.20662-5-rajatja@google.com>
 <CACK8Z6FsN2WNF8z0OrKv-1sPPwJFeJVYf8taHMZn0QpwLj+t=Q@mail.gmail.com>
 <CACK8Z6F7CZckWP_98h=WERmnDgQL3e65VSiLpaks+biWQ1nk7A@mail.gmail.com> <87v9n9n7dp.fsf@intel.com>
In-Reply-To: <87v9n9n7dp.fsf@intel.com>
From:   Rajat Jain <rajatja@google.com>
Date:   Mon, 6 Apr 2020 15:07:42 -0700
Message-ID: <CACK8Z6FubonFJFts-Ymri8_zdeQJ1OFq3bfrizEXhMPnDXVJaQ@mail.gmail.com>
Subject: Re: [PATCH v7 4/4] drm/i915: Add support for integrated privacy screen
To:     Jani Nikula <jani.nikula@linux.intel.com>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Imre Deak <imre.deak@intel.com>,
        =?UTF-8?Q?Jos=C3=A9_Roberto_de_Souza?= <jose.souza@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        intel-gfx@lists.freedesktop.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mat King <mathewk@google.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>, Pavel Machek <pavel@denx.de>,
        Sean Paul <seanpaul@google.com>,
        Duncan Laurie <dlaurie@google.com>,
        Jesse Barnes <jsbarnes@google.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Mark Pearson <mpearson@lenovo.com>,
        Nitin Joshi1 <njoshi1@lenovo.com>,
        Sugumaran Lacshiminarayanan <slacshiminar@lenovo.com>,
        Tomoki Maruichi <maruichit@lenovo.com>,
        Rajat Jain <rajatxjain@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 12, 2020 at 4:24 AM Jani Nikula <jani.nikula@linux.intel.com> wrote:
>
> On Wed, 11 Mar 2020, Rajat Jain <rajatja@google.com> wrote:
> > I got a "failed to apply" email from the patchwork. Can you please let
> > me know on which branch is it trying to apply it? I have currently
> > rebased my patchset to drm-intel-next-queued.
>
> drm-tip branch of https://cgit.freedesktop.org/drm/drm-tip
>
> It's kind of like linux-next of drm.
>

Hi Jani,

Haven't heard any comments in a while, so just checking to see if you
got a chance to look at my last patchset. It is here:

https://patchwork.freedesktop.org/patch/357452/

Thanks & Best Regards,

Rajat Jain

> BR,
> Jani.
>
>
> --
> Jani Nikula, Intel Open Source Graphics Center
