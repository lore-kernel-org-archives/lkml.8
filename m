Return-Path: <SRS0=7DLR=6Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.6 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11B9EC3A5A9
	for <linux-kernel@archiver.kernel.org>; Sat,  2 May 2020 07:17:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD998208DB
	for <linux-kernel@archiver.kernel.org>; Sat,  2 May 2020 07:17:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726787AbgEBHRc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 May 2020 03:17:32 -0400
Received: from bmailout3.hostsharing.net ([176.9.242.62]:45865 "EHLO
        bmailout3.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726486AbgEBHRb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 May 2020 03:17:31 -0400
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by bmailout3.hostsharing.net (Postfix) with ESMTPS id 4BDD71003CE02;
        Sat,  2 May 2020 09:17:29 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id B7EEC3F76B2; Sat,  2 May 2020 09:17:28 +0200 (CEST)
Date:   Sat, 2 May 2020 09:17:28 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>,
        Alex Deucher <alexdeucher@gmail.com>,
        "Zhou, David(ChunMing)" <David1.Zhou@amd.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        Takashi Iwai <tiwai@suse.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Koenig, Christian" <Christian.Koenig@amd.com>
Subject: Re: [PATCH 0/1] Fiji GPU audio register timeout when in BACO state
Message-ID: <20200502071728.fn2fcqvt6aies3zu@wunner.de>
References: <PSXP216MB043822350CDE9E7EEA37730880AD0@PSXP216MB0438.KORP216.PROD.OUTLOOK.COM>
 <CADnq5_MCQ7xHY=yhNtRW=ze0LRPzxuu-Mm7pD4kFa5R52UrGSw@mail.gmail.com>
 <s5h1ro6jn0v.wl-tiwai@suse.de>
 <CADnq5_Mjb_FnNOzjUfJZ7GSDzi-+Cfc1ZTuqm7UWCWVvY6DU_w@mail.gmail.com>
 <s5hwo5xj98v.wl-tiwai@suse.de>
 <PSXP216MB0438FE3E1CA577805BEC23C880AA0@PSXP216MB0438.KORP216.PROD.OUTLOOK.COM>
 <s5hh7x0kiwb.wl-tiwai@suse.de>
 <PSXP216MB04381A30909F66867E6B6BCC80AA0@PSXP216MB0438.KORP216.PROD.OUTLOOK.COM>
 <s5h1ro4kgog.wl-tiwai@suse.de>
 <s5h7dxuizep.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <s5h7dxuizep.wl-tiwai@suse.de>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 02, 2020 at 09:11:58AM +0200, Takashi Iwai wrote:
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -673,6 +673,12 @@ static int amdgpu_dm_audio_component_bind(struct device *kdev,
>  	struct amdgpu_device *adev = dev->dev_private;
>  	struct drm_audio_component *acomp = data;
>  
> +	if (!device_link_add(hda_kdev, kdev, DL_FLAG_STATELESS |
> +			     DL_FLAG_PM_RUNTIME)) {
> +		DRM_ERROR("DM: cannot add device link to audio device\n");
> +		return -ENOMEM;
> +	}
> +

Doesn't this duplicate drivers/pci/quirks.c:quirk_gpu_hda() ?
