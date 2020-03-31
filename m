Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFFE1C2D0F0
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 22:07:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B9542080C
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 22:07:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585692442;
	bh=xtYDDcAqIN7VOpFhiPB3YcBNlMQwrJarPAIGu7U/ktU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=h6FCF/uK6SGkEsB4PPttvGWhPBoOcm7YZvwZrnSFNsf9BiLTNN9Fq26f/NnLHqtxP
	 44XDgkwSXjC5qJNHo2RM7JUB47HI3JpNBiSiJBT1kV13DjyGm/fyp3sD7jF6gzT7NT
	 /42TjRa3mA6L5bWmVNYE7SRxdEcgnijolWvGWRpI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731436AbgCaWHV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 18:07:21 -0400
Received: from mail-il1-f194.google.com ([209.85.166.194]:36664 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730556AbgCaWHV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 18:07:21 -0400
Received: by mail-il1-f194.google.com with SMTP id p13so21030640ilp.3;
        Tue, 31 Mar 2020 15:07:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=gwWUAkb8abOTifbHiNXnwsQ9Dtd0p1eR1MIaYvko6Eo=;
        b=Ouj4a6lZIuWyFLfAJmHiqsdQmuz8f2ofwSzqdrySAHBICnJHkR/dKESiv0PTgtCZK+
         PnS3nFAPLdhucDXyjwaxFdzSE1I5lJdFTZNPWnl3w9fkj2w587jfkYAVeNjU49CMikW+
         1VFFFwctNoVXZsJHa13mE24OC+xPto80BClUz47ss7k704L2azUwsS1DT8YDJKYn3nid
         7OK6IyPYPj9Qo9ivHtPON8hIHQkFvr74HPIMXp32jwyRMvnfOq5Wpt7cI1I6SCVwqxMF
         9P2HzwJYAyt99vZhWGk6upfjQqA9Y/w3vkRjAIMlJIXuIuZQ3W/hBctZbNyJQB1maANL
         BC3g==
X-Gm-Message-State: ANhLgQ1lKzQ89uAEGW7Wk/thq7Di/sD0QGYyI9E50ofQEuvmciBv0Qg2
        1g2e4Zcd2zSEcWE9s/73aQ==
X-Google-Smtp-Source: ADFU+vtDNeOnim0HaWP5CQDpX6NvB9k8NLTc28IoNQAKLHA3sOrQLqnEllJxTDgRB6tbM1TZC74HUw==
X-Received: by 2002:a92:5bd7:: with SMTP id c84mr19057734ilg.26.1585692440128;
        Tue, 31 Mar 2020 15:07:20 -0700 (PDT)
Received: from rob-hp-laptop ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id g78sm50132ild.36.2020.03.31.15.07.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2020 15:07:19 -0700 (PDT)
Received: (nullmailer pid 32334 invoked by uid 1000);
        Tue, 31 Mar 2020 22:07:18 -0000
Date:   Tue, 31 Mar 2020 16:07:18 -0600
From:   Rob Herring <robh@kernel.org>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     narmstrong@baylibre.com, robh+dt@kernel.org,
        dri-devel@lists.freedesktop.org, linux-amlogic@lists.infradead.org,
        devicetree@vger.kernel.org, airlied@linux.ie, daniel@ffwll.ch,
        mark.rutland@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: Re: [PATCH] dt-bindings: display: meson-vpu: fix indentation of
 reg-names' "items"
Message-ID: <20200331220718.GA32235@bogus>
References: <20200328004157.1259385-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200328004157.1259385-1-martin.blumenstingl@googlemail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 28 Mar 2020 01:41:57 +0100, Martin Blumenstingl wrote:
> Use two spaces for indentation instead of one to be consistent with the
> rest of the file. No functional changes.
> 
> Fixes: 6b9ebf1e0e678b ("dt-bindings: display: amlogic, meson-vpu: convert to yaml")
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> ---
>  .../devicetree/bindings/display/amlogic,meson-vpu.yaml      | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 

Applied, thanks.

Rob
