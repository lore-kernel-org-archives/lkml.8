Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12A4EC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 07:38:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E2A29206A5
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 07:38:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessm-com.20150623.gappssmtp.com header.i=@endlessm-com.20150623.gappssmtp.com header.b="Psl2Lo/7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726867AbgGJHil (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 03:38:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725966AbgGJHil (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 03:38:41 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5B1CC08C5DC
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 00:38:40 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id o22so2247059pjw.2
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 00:38:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8ZjrFAw+j0ptFQYf6vjS3GyECZiwHud7B+29TqXkRYs=;
        b=Psl2Lo/7z/XmiV3clRJoB9dUmnRObvmiQueEkHMWf8CGDLu2jCWH5TdtWDZ4uU9tFf
         CS51zjH3cI6A6p3C7m18a3cM8PWF2m3nOlwntUbe3haHTJOhg0Zx41c8ihgOI+/QcLh7
         OsrH5WepfANDEbo91D00EQTK29UpzKlJbPQqdQoKsBkUOUyQoL4swP+ntNEHoMzhve3o
         3j+JmCMvWg2n5YlGba0+hwSrEYwaXh/CtH7cNz4lvSSVldVyoTM5KTJI6qbGSY/V61Xc
         8FwewkX8pY/mDHHSyzxwapUzKZ2hVW8RJ4+HlfMExj5Boj8H2qj7RT3SvNMHX4Djt5Mq
         xQ7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8ZjrFAw+j0ptFQYf6vjS3GyECZiwHud7B+29TqXkRYs=;
        b=U60VtgFGsG6Lqp2UGugSJgOWd+apRzULOTmPzfrMaNsguIbf3d/9U0dd3mrD9UCL+D
         vMGQEWTUVe/pQ8OQofC+tcaSVDJznpMopTuKQroq5Xz15++5Ad8k9UMyJGg4vx+KN5zB
         v/gPVQeEsWq6D11jn3mxsCOqZk4ZsWuET2LV8hpf0TdiKP+EMNOLtBuLXdaz0m6Zz/p3
         VXAkJQKKxBBsvV6L5yoe2UgYzjrDZj2hRDIPTrB0BHjKKp3+If3Tbxp4P8p/0173wF/E
         JW/xD4zpdE33j1Yxo3G+ecsn476eUKgKLS8em6115d370iquVPb+Ny1hva+TH79htknU
         4Xpw==
X-Gm-Message-State: AOAM532tE1Y0fel1/69CXkVhlMGPyRDBhqo2qpI9EPsmnGWKVEppihDJ
        yKsUkyPkOzSe+jytNjI3xMxwtg==
X-Google-Smtp-Source: ABdhPJwlQjxPimcLQyqZkwsetm/TUyF3vIvWAZnR02TYlVm2S9C4hZm4s/4qXkuD2qBQJzR6lJWAKA==
X-Received: by 2002:a17:902:a416:: with SMTP id p22mr1452916plq.341.1594366720068;
        Fri, 10 Jul 2020 00:38:40 -0700 (PDT)
Received: from starnight.localdomain (123-204-46-122.static.seed.net.tw. [123.204.46.122])
        by smtp.googlemail.com with ESMTPSA id t126sm5245550pfd.214.2020.07.10.00.38.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2020 00:38:39 -0700 (PDT)
From:   Jian-Hong Pan <jian-hong@endlessm.com>
To:     maxime@cerno.tech
Cc:     bcm-kernel-feedback-list@broadcom.com,
        dave.stevenson@raspberrypi.com, devicetree@vger.kernel.org,
        dri-devel@lists.freedesktop.org, eric@anholt.net,
        kdasu.kdev@gmail.com, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org, mturquette@baylibre.com,
        nsaenzjulienne@suse.de, phil@raspberrypi.com, robh+dt@kernel.org,
        sboyd@kernel.org, tim.gover@raspberrypi.com, linux@endlessm.com
Subject: Re: [PATCH v4 00/78] drm/vc4: Support BCM2711 Display Pipeline
Date:   Fri, 10 Jul 2020 15:37:58 +0800
Message-Id: <20200710073758.75181-1-jian-hong@endlessm.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.7a1aa1784976093af26cb31fd283cf5b3ed568bb.1594230107.git-series.maxime@cerno.tech>
References: <cover.7a1aa1784976093af26cb31fd283cf5b3ed568bb.1594230107.git-series.maxime@cerno.tech>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Maxime,

Thanks for your version 4 patch again.
I took the patches and applied them upon next-20200708.

I make system cold reboot to multi-user target and the text console shows on the
screen. Then, I simply hot re-plug the HDMI cable on HDMI0 port, I not only lose
the text console on the screen (the display shows blank, backlight is off), but
also kernel does not probe modes for the HDMI connector again.

But HDMI1 does probe modes again for hot re-plugging. So, HDMI1 does not hit the
issue like HDMI0.

* System probes modes only once for HDMI0 port (HDMI-A-1), even hot re-plug HDMI
  cable to the same port:

[   15.611072] [drm:drm_helper_probe_single_connector_modes] [CONNECTOR:32:HDMI-A-1] probed modes :
[   15.611079] [drm:drm_mode_debug_printmodeline] Modeline "1920x1080": 60 148500 1920 2008 2052 2200 1080 1084 1089 1125 0x48 0x5
[   15.611085] [drm:drm_mode_debug_printmodeline] Modeline "1920x1080": 60 148500 1920 2008 2052 2200 1080 1084 1089 1125 0x40 0x5
...
[   15.611298] [drm:drm_mode_debug_printmodeline] Modeline "720x400": 70 28320 720 738 846 900 400 412 414 449 0x40 0x6
[   15.611303] [drm:drm_helper_probe_single_connector_modes] [CONNECTOR:38:HDMI-A-2]
[   15.612184] [drm:drm_helper_probe_single_connector_modes] [CONNECTOR:38:HDMI-A-2] disconnected
[   15.612191] [drm:drm_client_modeset_probe] connector 32 enabled? yes
[   15.612194] [drm:drm_client_modeset_probe] connector 38 enabled? no
[   15.612206] [drm:drm_client_modeset_probe] Not using firmware configuration
[   15.612213] [drm:drm_client_modeset_probe] looking for cmdline mode on connector 32
[   15.612218] [drm:drm_client_modeset_probe] looking for preferred mode on connector 32 0
[   15.612221] [drm:drm_client_modeset_probe] found mode 1920x1080
...
[  108.263384] [drm:output_poll_execute] [CONNECTOR:32:HDMI-A-1] status updated from disconnected to connected
[  108.264307] vc4-drm gpu: [drm:drm_fb_helper_hotplug_event.part.0] 
[  108.264312] [drm:drm_client_modeset_probe] 
[  108.264321] [drm:drm_helper_probe_single_connector_modes] [CONNECTOR:32:HDMI-A-1]
[  109.303379] [drm:drm_helper_probe_single_connector_modes] [CONNECTOR:38:HDMI-A-2]
[  109.304258] [drm:drm_helper_probe_single_connector_modes] [CONNECTOR:38:HDMI-A-2] disconnected
[  109.304266] [drm:drm_client_modeset_probe] No connectors reported connected with modes

* System probes modes again for HDMI1 port (HDMI-A-2), whenever hot re-plug the
  HDMI cable:

[  797.974649] [drm:drm_helper_probe_single_connector_modes] [CONNECTOR:38:HDMI-A-2] probed modes :
[  797.974656] [drm:drm_mode_debug_printmodeline] Modeline "1920x1080": 60 148500 1920 2008 2052 2200 1080 1084 1089 1125 0x48 0x5
[  797.974662] [drm:drm_mode_debug_printmodeline] Modeline "1920x1080": 60 148500 1920 2008 2052 2200 1080 1084 1089 1125 0x40 0x5
...
[  797.974874] [drm:drm_mode_debug_printmodeline] Modeline "720x400": 70 28320 720 738 846 900 400 412 414 449 0x40 0x6
[  797.974880] [drm:drm_client_modeset_probe] connector 32 enabled? no
[  797.974883] [drm:drm_client_modeset_probe] connector 38 enabled? yes
[  797.974895] [drm:drm_client_modeset_probe] Not using firmware configuration
[  797.974901] [drm:drm_client_modeset_probe] looking for cmdline mode on connector 38
[  797.974905] [drm:drm_client_modeset_probe] looking for preferred mode on connector 38 0
[  797.974908] [drm:drm_client_modeset_probe] found mode 1920x1080
...
[  852.242615] vc4-drm gpu: [drm:drm_client_dev_hotplug] fbdev: ret=0
[  873.718277] [drm:output_poll_execute] [CONNECTOR:38:HDMI-A-2] status updated from disconnected to connected
[  873.718332] vc4-drm gpu: [drm:drm_fb_helper_hotplug_event.part.0] 
[  873.718338] [drm:drm_client_modeset_probe]
...
[  874.264013] [drm:drm_helper_probe_single_connector_modes] [CONNECTOR:38:HDMI-A-2] probed modes :
[  874.264020] [drm:drm_mode_debug_printmodeline] Modeline "1920x1080": 60 148500 1920 2008 2052 2200 1080 1084 1089 1125 0x48 0x5
[  874.264026] [drm:drm_mode_debug_printmodeline] Modeline "1920x1080": 60 148500 1920 2008 2052 2200 1080 1084 1089 1125 0x40 0x5
...
[  874.264239] [drm:drm_mode_debug_printmodeline] Modeline "720x400": 70 28320 720 738 846 900 400 412 414 449 0x40 0x6
[  874.264244] [drm:drm_client_modeset_probe] connector 32 enabled? no
[  874.264247] [drm:drm_client_modeset_probe] connector 38 enabled? yes
[  874.264259] [drm:drm_client_modeset_probe] Not using firmware configuration
[  874.264264] [drm:drm_client_modeset_probe] looking for cmdline mode on connector 38
[  874.264268] [drm:drm_client_modeset_probe] looking for preferred mode on connector 38 0
[  874.264272] [drm:drm_client_modeset_probe] found mode 1920x1080

Here is the full dmesg: https://gist.github.com/starnight/5ffb86af552fedb9b6e5741d0540a878#file-dmesg-v4-log
