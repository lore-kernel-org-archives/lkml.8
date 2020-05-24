Return-Path: <SRS0=XgUW=7G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 412C4C433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 24 May 2020 18:41:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 21B442088E
	for <linux-kernel@archiver.kernel.org>; Sun, 24 May 2020 18:41:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BqhRT/gd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388002AbgEXSlV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 May 2020 14:41:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387656AbgEXSlV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 May 2020 14:41:21 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98B81C061A0E;
        Sun, 24 May 2020 11:41:19 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id a25so6832399ljp.3;
        Sun, 24 May 2020 11:41:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=i8KyzXHKIumyKcOOKIQxQqqoRSvdhyjaN9Ou/p7liK8=;
        b=BqhRT/gd4E44riA6Wiy8Om0tHR69jQXMYmbdhNefaQphsk3H7v9+/R4I4EuLk/MrEP
         +Dv2TRzhLwOpCc0n597mnkqxjySzcoio4vs5V0pPN+M+sYCjBDcFbMxrCiCswJh0QY4N
         yzsg7iTNM4tTwkfFmmn7ZXuzXSy2ZcX8DNj+UBKpPMLu1EtZcgXxroyvdH7HPHp+ikfl
         xuNzKBCj3bziZCjoV8U5N5dXY4cxhsdWtcveEi52GXgaX1HidVQJ6mBoKvpmWhJ9bdrN
         oi9jyv6NLMP9rnzK+Vo6/cJGAr5sAL7GM95v2vLs0N70raolMn+Bml8LzNAeyqsIEKeX
         W8iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=i8KyzXHKIumyKcOOKIQxQqqoRSvdhyjaN9Ou/p7liK8=;
        b=qznJ4Jk2hper6ALol7ON5LuFiZtLpY807ks1A7D2tFQxHgpSNpVYDcE32GQf14odxq
         MBh4Zdrj0f3UzrX6h2K3i3YmpE3TEW476DdMm1va+xiDmpVwkbo+/hCZMjLsBBvCl+Cx
         2qNy2+AHC68AveAQhINZu8HsE/8soxBebAXCkimJn/7Bmcaf17soDC+eQacswSrk/oei
         +hx2CAuoemgZkVollcPiHX7HKf9sMx58DC1ExHT6zz0AW/SZrr/HQdv5QdAVC9BwvRJD
         5+po9FSdxWIXpE8SCLDdRomHGVtxlUvpmDbDnOo4M7YjCm20WjLmp09C92hkco/RtFie
         I58g==
X-Gm-Message-State: AOAM532CdBINbadCxW9rJVjKgkOpoWXAadIv8xBGzta2r2/I/itzC4/6
        gblJVgK2sLswKgp31NChlBzgM95n
X-Google-Smtp-Source: ABdhPJzswEHQjqu7AlJZeRjZr+f5jmG4PSyaBms0l5qUUhd3hzXmhpqNt+e61OpwIJBsdLbfxMAAbw==
X-Received: by 2002:a2e:9746:: with SMTP id f6mr12032867ljj.189.1590345677778;
        Sun, 24 May 2020 11:41:17 -0700 (PDT)
Received: from [192.168.2.145] (ppp91-76-17-204.pppoe.mtu-net.ru. [91.76.17.204])
        by smtp.googlemail.com with ESMTPSA id o4sm4063239lfb.75.2020.05.24.11.41.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 24 May 2020 11:41:17 -0700 (PDT)
Subject: Re: [PATCH v5 0/6] Support DRM bridges on NVIDIA Tegra
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Sam Ravnborg <sam@ravnborg.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200418170703.1583-1-digetx@gmail.com>
Message-ID: <65a9c464-7031-586d-3b5e-d29ec01934ab@gmail.com>
Date:   Sun, 24 May 2020 21:41:16 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200418170703.1583-1-digetx@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

18.04.2020 20:06, Dmitry Osipenko пишет:
> Hello,
> 
> This series adds initial support for the DRM bridges to NVIDIA Tegra DRM
> driver. This is required by newer device-trees where we model the LVDS
> encoder bridge properly.
> 
> Changelog:
> 
> v5: - Added new patches that make drm_of_find_panel_or_bridge() more usable
>       if graph isn't defined in a device-tree:
> 
>         of_graph: add of_graph_get_local_port()
>         drm/of: Make drm_of_find_panel_or_bridge() to check graph's presence
> 
>     - Updated "Support DRM bridges" patch to use drm_of_find_panel_or_bridge()
>       directly and added WARN_ON(output->panel || output->bridge) sanity-check.
> 
>     - Added new "Wrap directly-connected panel into DRM bridge" patch, as
>       was suggested by Laurent Pinchart.
> 
> v4: - Following review comments that were made by Laurent Pinchart to the v3,
>       we now create and use the "bridge connector".
> 
> v3: - Following recommendation from Sam Ravnborg, the new bridge attachment
>       model is now being used, i.e. we ask bridge to *not* create a connector
>       using the DRM_BRIDGE_ATTACH_NO_CONNECTOR flag.
> 
>     - The bridge is now created only for the RGB (LVDS) output, and only
>       when necessary. For now we don't need bridges for HDMI or DSI outputs.
> 
>     - I noticed that we're leaking OF node in the panel's error code path,
>       this is fixed now by the new patch "Don't leak OF node on error".
> 
> v2: - Added the new "rgb: Don't register connector if bridge is used"
>       patch, which hides the unused connector provided by the Tegra DRM
>       driver when bridge is used, since bridge provides its own connector
>       to us.
> 
>     - Please notice that the first "Support DRM bridges" patch was previously
>       sent out as a standalone v1 change.
> 
> Dmitry Osipenko (6):
>   of_graph: add of_graph_get_local_port()
>   drm/of: Make drm_of_find_panel_or_bridge() to check graph's presence
>   drm/tegra: output: Don't leak OF node on error
>   drm/tegra: output: Support DRM bridges
>   drm/tegra: output: rgb: Support LVDS encoder bridge
>   drm/tegra: output: rgb: Wrap directly-connected panel into DRM bridge
> 
>  drivers/gpu/drm/drm_of.c       | 13 +++++-
>  drivers/gpu/drm/tegra/drm.h    |  2 +
>  drivers/gpu/drm/tegra/output.c | 21 +++++++--
>  drivers/gpu/drm/tegra/rgb.c    | 85 +++++++++++++++++++++-------------
>  drivers/of/property.c          | 32 +++++++++----
>  include/linux/of_graph.h       |  7 +++
>  6 files changed, 114 insertions(+), 46 deletions(-)
> 

Hello Thierry,

Do you you have any objections to this series?
