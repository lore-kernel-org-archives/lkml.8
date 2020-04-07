Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36C8CC2BA2B
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 14:26:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05F762078C
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 14:26:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="odzYHM4P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728998AbgDGO0x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 10:26:53 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39386 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728776AbgDGO0w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 10:26:52 -0400
Received: by mail-wr1-f66.google.com with SMTP id p10so4124780wrt.6
        for <linux-kernel@vger.kernel.org>; Tue, 07 Apr 2020 07:26:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1IYm3UJMYvZGcA5HDx6pN/EcT0r+laztRqnVn0lIv8o=;
        b=odzYHM4PQyxjrTdP94HEuH+cVYijwmO4USncHr3KBM+149SLADXX0l5w+eH1QjXMDq
         2usIGRMpJkO4vtnJ4/xbDW7w9VGBfZSXHIMf+m9RIhJd8Eug4LLMT91gtx+pR3VpkVaY
         FCnmm67cuXEQi7XFfyZk/0CAUZcxbYOjKvDEAn5S3NZh7+tkn0nMwHL7FUDRyHDS8Mnl
         wDrCoVW4ZFFVT3Wv3qCwDj3uKoioUOKK8Jlc0eipMjyND96mVue0x/Xp4atmpNrGbS0i
         YHnr0sYMJiqWInH+XZkl7sIovRIss8th70kqT/l6N5rJIzsGPX9yny/xqHWwTzGe2fW6
         sbhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1IYm3UJMYvZGcA5HDx6pN/EcT0r+laztRqnVn0lIv8o=;
        b=NifTES1ZLSfKlLbFYaaVkIjYzX+17qCEm2NaJFGbD+8bF6u2BVLy2QJhQW+I/lxJK5
         +XziDHIh2IHqBsemSMrAmK+XMaDP3LfBLbHKZk2aWhVrcPZVrhujWSKp/VO3ZJ7w5S0B
         kGJU172HQCq2m3SYsaveWPsF0e4AQsweTmy1TZ+DEfQgGg3D8FitXdGMUSdlbsxEGj3S
         vYy9IWVDkN2Bf4c2qpBExWvfLyBeZzuV6kmRRrnNyEnjpn+7ve/c2oSzcYwk0oMRj3KV
         Zs+o2bDBgvSgYaYDTroYQsak2A8sH/eY/nNaCUFoAbwtVD5heKgq+BilTqWeUXTu1Jic
         TguA==
X-Gm-Message-State: AGi0PuaGvjPcGWRrr9BJu1kyLpge4qelIUvqakihInng8Lri2Leytqbd
        SabCGllu0ny8IfvUvPQaNnA=
X-Google-Smtp-Source: APiQypIajbhXDWtqrq1B2DdOwT8dbEEV5/v0+zYrndyRedN8LxgiIIX/wjQGUqh2yW1LFwrGLMRFNQ==
X-Received: by 2002:a5d:5686:: with SMTP id f6mr3019640wrv.91.1586269610755;
        Tue, 07 Apr 2020 07:26:50 -0700 (PDT)
Received: from Saturn.fritz.box ([81.221.228.86])
        by smtp.gmail.com with ESMTPSA id f20sm2544119wmc.35.2020.04.07.07.26.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2020 07:26:49 -0700 (PDT)
Message-ID: <1586269609.25385.3.camel@gmail.com>
Subject: Re: [PATCH 0/4] defconfig: fix changed configs and refresh
From:   Max Krummenacher <max.oss.09@gmail.com>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Max Krummenacher <max.krummenacher@toradex.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Will Deacon <will@kernel.org>, Vidya Sagar <vidyas@nvidia.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Olof Johansson <olof@lixom.net>,
        Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Anson Huang <Anson.Huang@nxp.com>,
        Li Yang <leoyang.li@nxp.com>, Shawn Guo <shawnguo@kernel.org>
Date:   Tue, 07 Apr 2020 16:26:49 +0200
In-Reply-To: <20200407141624.GG4751@pendragon.ideasonboard.com>
References: <20200407103537.4138-1-max.krummenacher@toradex.com>
         <CAMuHMdWrekHiADkMmgO5nDxFNYjLud7FD=7ArMZNQire_+7TQg@mail.gmail.com>
         <20200407141624.GG4751@pendragon.ideasonboard.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Laurent, Geert,

Am Dienstag, den 07.04.2020, 17:16 +0300 schrieb Laurent Pinchart:
> Hi Geert,
> 
> On Tue, Apr 07, 2020 at 03:16:14PM +0200, Geert Uytterhoeven wrote:
> > On Tue, Apr 7, 2020 at 12:36 PM Max Krummenacher <max.oss.09@gmail.com> wrote:
> > > Three configs have been renamed and/or changed behaviour.
> > > Clean that by using the new config name.
> > > Then refresh the defconfig with make defconfig savedefconfig.
> > > 
> > > The refreshed defconfig does result in a not changed .config.
> > > 
> > > Applies on linux-next/master tag: next-20200407
> > > 
> > > Max Krummenacher (4):
> > >   arm64: defconfig: DRM_DUMB_VGA_DAC: follow changed config symbol name
> > >   arm64: defconfig: PCIE_TEGRA194: follow changed config symbol name
> > >   arm64: defconfig: ARCH_R8A7795: follow changed config symbol name
> > >   arm64: defconfig: refresh
> > 
> > Probably CONFIG_DRM_DISPLAY_CONNECTOR should also be enabled for HDMI,
> > VGA, and composite display connectors on various boards since commit
> > 0c275c30176b2e78 ("drm/bridge: Add bridge driver for display
> > connectors"), but it's not clear to me when exactly this became a
> > requirement, as before there was no code that looked for e.g.
> > vga-connector.
> > Laurent?
> 
> It's not required yet for R-Car DU, but I'm working on changing that :-)
> If we can enable CONFIG_DRM_DISPLAY_CONNECTOR in defconfig as part of
> this series, it would be useful for me.
> 
I will add CONFIG_DRM_DISPLAY_CONNECTOR in a V2 to  "arm64: defconfig: DRM_DUMB_VGA_DAC:
follow changed config symbol name" with a comment in the commit comment that this is
recommended to go  with the DRM_DUMB_VGA_DAC.

Regards
Max
