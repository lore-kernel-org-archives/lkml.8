Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 159F2C47258
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 21:24:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E3EBF206B8
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 21:24:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mjnNLkkp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729111AbgEEVYi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 17:24:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726350AbgEEVYh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 17:24:37 -0400
Received: from mail-ua1-x941.google.com (mail-ua1-x941.google.com [IPv6:2607:f8b0:4864:20::941])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 614D2C061A0F
        for <linux-kernel@vger.kernel.org>; Tue,  5 May 2020 14:24:37 -0700 (PDT)
Received: by mail-ua1-x941.google.com with SMTP id a16so997227uaq.5
        for <linux-kernel@vger.kernel.org>; Tue, 05 May 2020 14:24:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xD9oC230/p7xdIyNhq/DI72VMWwLQ0pXEid/2VB2RIE=;
        b=mjnNLkkpMuBQM4TIComyfZixfgQHhE7tuFWValYOOMp5lib8ve2bEYRSkPoc6w3DfW
         x+MXBWW0cMkQbuC/d4jz2iCfV4rJYanNXcJZAoAycgsG6CSrTebEpKdKS1Jiumphdr4L
         iCabexNFAQFv7/oUMBhn7gE3sdcfhe6/b55/Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xD9oC230/p7xdIyNhq/DI72VMWwLQ0pXEid/2VB2RIE=;
        b=P6XZzPNEN6/s98lBvt3ys6DEVUG3ME7ObUOL+6nX3QnqRvoe0PhBQ5kqIR2sje7oBP
         NEyHYtyibczXeWdn8SVDWAQNjCoJ6K9eTpBZhwnOJsbaoMjESJnyZjHn8j9fUs0JzEgJ
         hQYXY6L0spFhLR+MeTYhZWN/dp2I5pSqPVyzyCYzWFnS/2H0a51niS20U3N2WQ+PLMwU
         VutyuRm2ydYgiggO9tOuNT3UVvUjMCXQuzdLL5/J1Uv+gK7Ych0SWpi6CM96G0D3Jkuj
         embkq9+t+/VrgZtQxz+rdEWXfDCFVQaiZAjfX8IQ4UsaLr6c9L95DK3DoFEBQVtTdQNn
         MdXA==
X-Gm-Message-State: AGi0PuYpu2kE7MHhkVnflxwMVqBdxSI3zAemy1saf/YKWqiprwFtqpjR
        768IxlbOlqyK+cfeCKEanYn2zRIJ0xk=
X-Google-Smtp-Source: APiQypLecxjgvGOF4WVegIkBn8qwub54kUi+QgUlL2raBkT7Exa6lhZmpADTSNP6gvqqW9is9HdMFw==
X-Received: by 2002:ab0:20aa:: with SMTP id y10mr4325074ual.60.1588713876410;
        Tue, 05 May 2020 14:24:36 -0700 (PDT)
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com. [209.85.217.42])
        by smtp.gmail.com with ESMTPSA id z191sm1525006vsz.32.2020.05.05.14.24.35
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 May 2020 14:24:35 -0700 (PDT)
Received: by mail-vs1-f42.google.com with SMTP id a5so145297vsm.7
        for <linux-kernel@vger.kernel.org>; Tue, 05 May 2020 14:24:35 -0700 (PDT)
X-Received: by 2002:a05:6102:4d:: with SMTP id k13mr4884961vsp.198.1588713874617;
 Tue, 05 May 2020 14:24:34 -0700 (PDT)
MIME-Version: 1.0
References: <20200504213624.1.Ibc8eeddcee94984a608d6900b46f9ffde4045da4@changeid>
 <20200505082436.GD9658@pendragon.ideasonboard.com> <CAD=FV=WjUpwu5204K8yHzqsJv4vQX5S5CArH1Kj_kqjhZzTc9A@mail.gmail.com>
 <20200505210609.GA6094@pendragon.ideasonboard.com> <CAD=FV=UnGOYh8JX2=fEAqPN7wqANc0QevTirNO-WUDYMPqXcrg@mail.gmail.com>
 <20200505211401.GC6094@pendragon.ideasonboard.com>
In-Reply-To: <20200505211401.GC6094@pendragon.ideasonboard.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 5 May 2020 14:24:23 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WgRC-HViMxttF4VK+n48HNRuqAau8S7mgx6oSWsbZcgA@mail.gmail.com>
Message-ID: <CAD=FV=WgRC-HViMxttF4VK+n48HNRuqAau8S7mgx6oSWsbZcgA@mail.gmail.com>
Subject: Re: [PATCH] drm/bridge: ti-sn65dsi86: Implement lane reordering + polarity
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Rob Clark <robdclark@chromium.org>,
        Sean Paul <seanpaul@chromium.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Jonas Karlman <jonas@kwiboo.se>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, May 5, 2020 at 2:14 PM Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>
> > I'll add this documentation into the comments of the yaml, but I'm not
> > going to try to implement enforcement at the yaml level.
>
> Why not ? :-)

Because trying to describe anything in the yaml bindings that doesn't
fit in the exact pattern of things that the yaml bindings are designed
to check is like constructing the empire state building with only
toothpicks.

If you want to suggest some syntax that would actually make this
doable without blowing out the yaml bindings then I'm happy to add it.
Me being naive would assume that we'd need to do an exhaustive list of
the OK combinations.  That would be fine for the 1-land and 2-lane
cases, but for 4 lanes that means adding 256 entries to the bindings.

I think the correct way to do this would require adding code in the
<https://github.com/devicetree-org/dt-schema> project but that's
really only done for generic subsystem-level concepts and not for a
single driver.

-Doug
