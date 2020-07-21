Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C315C433E3
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 15:35:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 72305206F2
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 15:35:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595345746;
	bh=Jq+HO2ZE92p41uBQdq/BMb/mypTi/nYDecJWM1AihcM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=iVSeD3pAdyS7GrCSPiIPy1Ph6CG5++CaE+/pyrAEM/2RR9LkXGHhIYXARlPa7gI3j
	 c9NfF+uF2S/vy+tANi02aIqXxwJtOuuPHYzRilDg0yX7VcYiJhMB9Ae6G1Css5Vu9u
	 DsiqEnPWYMkR84XNWmrTq8au5Z9xrT7kfbCWNoxQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729353AbgGUPfp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 11:35:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:59076 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726654AbgGUPfo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 11:35:44 -0400
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 73E8B20792;
        Tue, 21 Jul 2020 15:35:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595345744;
        bh=Jq+HO2ZE92p41uBQdq/BMb/mypTi/nYDecJWM1AihcM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=uMvk+L3hsMaoMlasRaEj9I8zGcI/tqH0ZIJuLcQv4IC+JuWRDgpSxScQYBkC0nbQU
         OVveghfBbeGVxsp81V0eTkkUGYdoAs9zbyM8C+LBrEbT091oRUenY85sUXGhPDsS12
         V835OiF8a8D0Eq3LGGMcC6+AnWYvmvzPL/IhH8C4=
Received: by mail-qk1-f172.google.com with SMTP id h7so3865581qkk.7;
        Tue, 21 Jul 2020 08:35:44 -0700 (PDT)
X-Gm-Message-State: AOAM530qu0lXx91s/HfWU5iTxD/21Z2oduiPe6ze/W8syLQuHidqE6L/
        uYsogj+jDZPFlkenWRmRiXTWZ4A/VPgh7am6Jg==
X-Google-Smtp-Source: ABdhPJz4TgtCgchktOu/dOftli6ITM4jB5qBpP6WwLgR2Lc4OZWUMi1i07ta0w6iQeOAXiRtzIeIDiSq6wAE9rjmUjE=
X-Received: by 2002:a37:b341:: with SMTP id c62mr26653760qkf.128.1595345743622;
 Tue, 21 Jul 2020 08:35:43 -0700 (PDT)
MIME-Version: 1.0
References: <20200703114717.2140832-1-megous@megous.com>
In-Reply-To: <20200703114717.2140832-1-megous@megous.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Tue, 21 Jul 2020 09:35:32 -0600
X-Gmail-Original-Message-ID: <CAL_JsqK6hEiC0O5WeR6nKw38zvX3G=QeCq3-xZ+_9SHWcE6jrw@mail.gmail.com>
Message-ID: <CAL_JsqK6hEiC0O5WeR6nKw38zvX3G=QeCq3-xZ+_9SHWcE6jrw@mail.gmail.com>
Subject: Re: [PATCH 0/2] Fix warnings in display/bridge/nwl-dsi.yaml DT example
To:     Ondrej Jirman <megous@megous.com>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Fabio Estevam <festevam@gmail.com>,
        =?UTF-8?Q?Guido_G=C3=BCnther?= <agx@sigxcpu.org>,
        Robert Chiras <robert.chiras@nxp.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 3, 2020 at 5:47 AM Ondrej Jirman <megous@megous.com> wrote:
>
> This patchset fixes warnings in the example in display/bridge/nwl-dsi.yaml
> revealed during port of display/panel/rocktech,jh057n00900.yaml to
> yaml.
>
> Please take a look.
>
> thank you and regards,
>   Ondrej Jirman
>
> Ondrej Jirman (2):
>   dt-bindings: display: Fix example in nwl-dsi.yaml
>   dt-binding: display: Allow a single port node on rocktech,jh057n00900

Series applied to drm-misc.

Rob
