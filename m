Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8BEFC433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 04:14:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7086C20707
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 04:14:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="EcXQ31HM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725932AbgFAEOg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 00:14:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725283AbgFAEOg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 00:14:36 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 084ABC08C5C0
        for <linux-kernel@vger.kernel.org>; Sun, 31 May 2020 21:14:35 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id b5so1958115iln.5
        for <linux-kernel@vger.kernel.org>; Sun, 31 May 2020 21:14:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=x8a609a5qZV/8uK75Z+5pZGlJvWxTwewnSI1kRcruvg=;
        b=EcXQ31HMxvgQLQA3X19WLJf7eLN+UICimuf8ahojOCfjxhipVAcPXK6rUNSLcFoWM7
         zCy9sXmj/KUmWr0BQpFzAMQhWpIMOQ6OvYkeLH+SRjwIhwVvpjQZsBv21/QRCGKjODHM
         qSHaOnht3ufj3s18UykNubcE3++uJC4wO0C9s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=x8a609a5qZV/8uK75Z+5pZGlJvWxTwewnSI1kRcruvg=;
        b=f6pd8xSCvpoO7/oNOVv620PbYbw8QYMpqlDNhuGk9TO9E/9DmIcHzppVrdxelgyJuJ
         twjAUFyOS44CCoC8K5UTrkmor67tJurpZWLPcoqwU7pB571eecOFjk/pFRGuqWXyz2lk
         q5FvWt2MLBPEkr21mKHwTzhfPnSJWzprcSzQz5xSSmwwLq3MbfSsNapka/TkPRE3Un3H
         O86JBE3VVHfl+/mfSBsjiYttLXkchyN5n4izs5pQQR5ipwEljhl956j9kh9Y8PRy65jS
         bruAjGrB51MG7vVjt7SYFikLODpihn9EvpB5kMqrpr+oDnJ90xpyYirlzYquujaTb5ym
         6FSg==
X-Gm-Message-State: AOAM5314viveZTqDT+1xkTaZt3fH7Ung+WTBRDwaJJSK1fXOO5zYuYiw
        e07gjYemXM4Trho9gENVChCkdSBhIFPLtIWLtDMd7Q==
X-Google-Smtp-Source: ABdhPJwDkiEP8Fr2F3U+zwZn2Cnk0c+q57D8FlJ0+ONjXpxJhdRbpWqi0aGoLKsD8uIuEDU5EshV/8yDSE1Eqot3/Qs=
X-Received: by 2002:a92:d908:: with SMTP id s8mr18767942iln.283.1590984875133;
 Sun, 31 May 2020 21:14:35 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1589511894.git.xji@analogixsemi.com> <3946984ac1024b53b72c2eb39ee41967a2bf9c3d.1589511894.git.xji@analogixsemi.com>
In-Reply-To: <3946984ac1024b53b72c2eb39ee41967a2bf9c3d.1589511894.git.xji@analogixsemi.com>
From:   Hsin-Yi Wang <hsinyi@chromium.org>
Date:   Mon, 1 Jun 2020 12:14:09 +0800
Message-ID: <CAJMQK-hkrsgbvi91=uBhPfn0scwTSh3OJBGLcy9tC3GYiW1i9Q@mail.gmail.com>
Subject: Re: [PATCH v11 2/2] drm/bridge: anx7625: Add anx7625 MIPI DSI/DPI to
 DP bridge driver
To:     Xin Ji <xji@analogixsemi.com>
Cc:     devel@driverdev.osuosl.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Nicolas Boichat <drinkcat@google.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Pi-Hsun Shih <pihsun@chromium.org>,
        Jonas Karlman <jonas@kwiboo.se>,
        David Airlie <airlied@linux.ie>,
        Neil Armstrong <narmstrong@baylibre.com>,
        lkml <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Sheng Pan <span@analogixsemi.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 15, 2020 at 2:53 PM Xin Ji <xji@analogixsemi.com> wrote:

> +
> +static int anx7625_bridge_attach(struct drm_bridge *bridge)

Latest drm_bridge api:

int (*attach)(struct drm_bridge *bridge,
     enum drm_bridge_attach_flags flags);

https://elixir.bootlin.com/linux/v5.7-rc7/source/include/drm/drm_bridge.h#L70

> +{
> +       struct anx7625_data *ctx = bridge_to_anx7625(bridge);
> +       int err;
