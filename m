Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE2BCC433E6
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 00:48:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9FFBB206CD
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 00:48:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dionne-riel-com.20150623.gappssmtp.com header.i=@dionne-riel-com.20150623.gappssmtp.com header.b="1xmu95Op"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726797AbgHaAsF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Aug 2020 20:48:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726388AbgHaAsB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Aug 2020 20:48:01 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A83FCC061573
        for <linux-kernel@vger.kernel.org>; Sun, 30 Aug 2020 17:48:00 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id p185so4745187qkb.11
        for <linux-kernel@vger.kernel.org>; Sun, 30 Aug 2020 17:48:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dionne-riel-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:mime-version
         :content-transfer-encoding;
        bh=Ooy/Ds01zwtdWxtvqST7QaBXnPjhUyEPG89CnF8y7sk=;
        b=1xmu95Opr4FkH3j1bt5qQmg/xRMGvKvX/6+n06ZSpVZiGpi08Id462k/IBTiNGBW+W
         vc0GOjVJ7mjtM+pcgrBAgPU9g3MUkr3IDK1RE+zazEIRCdODPRBilcTFkcSkdnn+nQLu
         IJonNitrw4Ktn2EFbjeEoS1jp7VfRZFlvmJaEe2HjMHqNx4fuif1MiVd/yK76NDssYQZ
         W16wEe4n+cVFipOH4TWD598xkDxGuMlcExX5/QAJhJcoXr+K16O2b4WetzHEDV+SumGo
         nDnmHQIsECug7izJtt8u9GsYNOJKxbEwba7Unx/2v7NnneJTQowFIh8//EbYWyUR5ajv
         JvDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-transfer-encoding;
        bh=Ooy/Ds01zwtdWxtvqST7QaBXnPjhUyEPG89CnF8y7sk=;
        b=SCmprJXVzE5sM2mLcLhbqLVj2L7rNqt8gmWAKu9zsDM34HwoCPuvL8s2nqBI8Cj0Qb
         6F3tneLnBYBRUl+yH3UBa0lu53waFPIcv2+9bfHnT2lLhwQKXOsvXp2AHys/lEuqctzM
         QjzqlhmzIhl3dmWpfKJ+pI6R5/N6aZlVMkj/T8hNo+4z76ZWvl2fwWmSBDZZlPRjaLGL
         4LvpJY6FeOxniJdOnu1ZUy6kjJ6OsjilC0A/7ui+6tvWh/4VSks8wq6hAkjX2rwuoyI1
         IQKFjN0eDqXQ7z41g4YBHsUhuPfTUITVYdjFVs6cm5H7hR9BgyXbO8miAjYaUd3z6QxO
         d7sg==
X-Gm-Message-State: AOAM530vhmdCWl62PQ0UtoFOrnF7mDqQCOs+kUbE6JUKlWNwTXCpbkbL
        12ZvlxOnhQHE6tMLMyoTPG0xrrqBx45b8rANf3c=
X-Google-Smtp-Source: ABdhPJzTmMUpbFhAM7CfMqDcEsaBir+F5cMQqZ4Ghh9KJgAcb5T7yo+9dYddAsrQyQWeBhmA3r9V6A==
X-Received: by 2002:a05:620a:ed3:: with SMTP id x19mr8136108qkm.89.1598834879435;
        Sun, 30 Aug 2020 17:47:59 -0700 (PDT)
Received: from DUFFMAN (135-23-195-85.cpe.pppoe.ca. [135.23.195.85])
        by smtp.gmail.com with ESMTPSA id g45sm8727004qtb.60.2020.08.30.17.47.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Aug 2020 17:47:59 -0700 (PDT)
Date:   Sun, 30 Aug 2020 20:47:56 -0400
From:   Samuel Dionne-Riel <samuel@dionne-riel.com>
To:     linux-kernel@vger.kernel.org
Cc:     dri-devel@lists.freedesktop.org, Lin Huang <hl@rock-chips.com>,
        linux-rockchip@lists.infradead.org,
        Heiko Stuebner <heiko@sntech.de>
Subject: innolux p097pfg dpms off/on fails (on gru-scarlet)
Message-ID: <20200830204756.1f9dba11@DUFFMAN>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have an Asus Chromebook Tablet CT100PA, which I will refer to as
"dumo" from this point on, which is a specific variant of gru-scarlet.
As far as I am aware, all gru-scarlet are the same, except for the
display, and in turn the different scarlets with the innolux panel
are the same.

I do not have the hardware to verify the kingdisplay variant's
behaviour, though I don't really expect it to fail the same way, but it
is still a possibility that there is a root cause that could cause a
similar failure.

The display will apparently suspend (right wording?) fine with DPMS,
but will not resume (wording?) fine. This has been an issue since the
introduction of the driver and the introduction of the device (scarlet)
to the kernel, and is still on 5.9-rc2.

Doing the following:

  $ xset dpms force off # standby, or suspend
  $ xset dpms force on

Pretty much instantly the following messages are logged:

[   53.731851] dw-mipi-dsi-rockchip ff960000.mipi: failed to write command FIFO
[   53.739815] panel-innolux-p079zca ff960000.mipi.0: failed to write command 0

Then 120 seconds later, this pair of WARN:

[  173.754168] ------------[ cut here ]------------
[  173.759343] pclk_mipi_dsi1 already disabled
[  173.764076] WARNING: CPU: 2 PID: 5182 at drivers/clk/clk.c:952 clk_core_disable+0x2c/0x94
[  173.773216] Modules linked in:
[  173.776639] CPU: 2 PID: 5182 Comm: X Not tainted 5.9.0-rc2 #1-mobile-nixos
[  173.784323] Hardware name: Google Scarlet (DT)
[  173.789292] pstate: 40000085 (nZcv daIf -PAN -UAO BTYPE=--)
[  173.795522] pc : clk_core_disable+0x2c/0x94
[  173.800199] lr : clk_core_disable+0x2c/0x94
[  173.804871] sp : ffff800011d3ba20
[  173.808573] x29: ffff800011d3ba20 x28: 0000000000000028
[  173.814514] x27: ffff0000c32bdf00 x26: 0000000000000038
[  173.820455] x25: ffff800010d2e2eb x24: ffff0000edece000
[  173.826395] x23: ffff0000f0bea680 x22: 0000000000000001
[  173.832326] x21: ffff0000ef82e0e0 x20: ffff0000f0986500
[  173.838266] x19: ffff0000f0986500 x18: 0000000000000000
[  173.844198] x17: 0000000000000000 x16: 0000000000000000
[  173.850137] x15: 000000000000000a x14: 00000000000b962f
[  173.856077] x13: ffff800091d3b76f x12: 0000000000000006
[  173.862008] x11: ffffffffffffffff x10: 0000000000000030
[  173.867939] x9 : ffff800011d3b77d x8 : 0000000000000000
[  173.873869] x7 : 0000000000000008 x6 : ffff80001118811e
[  173.879809] x5 : ffff0000f5589e48 x4 : 0000000000000000
[  173.885741] x3 : 0000000000000027 x2 : 0000000000000027
[  173.891680] x1 : ffff0000e5c3ee40 x0 : 000000000000001f
[  173.897612] Call trace:
[  173.900349]  clk_core_disable+0x2c/0x94
[  173.904637]  clk_core_disable_lock+0x20/0x34
[  173.909413]  clk_disable+0x1c/0x28
[  173.913220]  dw_mipi_dsi_bridge_post_disable+0x80/0x120
[  173.919065]  drm_atomic_bridge_chain_post_disable+0x74/0x98
[  173.925297]  drm_atomic_helper_commit_modeset_disables+0x3d8/0x3dc
[  173.932208]  drm_atomic_helper_commit_tail_rpm+0x20/0xa0
[  173.938138]  commit_tail+0x74/0xf8
[  173.941941]  drm_atomic_helper_commit+0x104/0x108
[  173.947203]  drm_atomic_commit+0x48/0x54
[  173.951590]  drm_atomic_connector_commit_dpms+0xa0/0x100
[  173.957531]  drm_mode_obj_set_property_ioctl+0xd4/0x2c8
[  173.963378]  drm_connector_property_set_ioctl+0x20/0x28
[  173.969220]  drm_ioctl_kernel+0xa0/0xdc
[  173.973507]  drm_ioctl+0x2c4/0x2ec
[  173.977312]  vfs_ioctl+0x24/0x40
[  173.980921]  __arm64_sys_ioctl+0x74/0xa4
[  173.985299]  el0_svc_common.constprop.0+0xe0/0x160
[  173.990655]  do_el0_svc+0x44/0x70
[  173.994362]  el0_sync_handler+0xc8/0x184
[  173.998747]  el0_sync+0x140/0x180
[  174.002450] ---[ end trace 6c6d0de3ca79ec7d ]---
[  174.007763] ------------[ cut here ]------------
[  174.012925] pclk_mipi_dsi0 already disabled
[  174.017633] WARNING: CPU: 5 PID: 5182 at drivers/clk/clk.c:952 clk_core_disable+0x2c/0x94
[  174.026770] Modules linked in:
[  174.030184] CPU: 5 PID: 5182 Comm: X Tainted: G        W         5.9.0-rc2 #1-mobile-nixos
[  174.039419] Hardware name: Google Scarlet (DT)
[  174.044382] pstate: 40000085 (nZcv daIf -PAN -UAO BTYPE=--)
[  174.050608] pc : clk_core_disable+0x2c/0x94
[  174.055278] lr : clk_core_disable+0x2c/0x94
[  174.059948] sp : ffff800011d3ba20
[  174.063646] x29: ffff800011d3ba20 x28: 0000000000000028
[  174.069582] x27: ffff0000c32bdf00 x26: 0000000000000038
[  174.075517] x25: ffff800010d2e2eb x24: ffff0000edece000
[  174.081451] x23: ffff0000f0bea680 x22: 0000000000000001
[  174.087385] x21: ffff0000ef82e0e0 x20: ffff0000f0986400
[  174.093319] x19: ffff0000f0986400 x18: 0000000000000000
[  174.099254] x17: 0000000000000000 x16: 0000000000000000
[  174.105187] x15: 000000000000000a x14: 000000000000327d
[  174.111121] x13: ffff800091d3b76f x12: 0000000000000006
[  174.117055] x11: ffffffffffffffff x10: 0000000000000030
[  174.122989] x9 : ffff800011d3b77d x8 : 0000000000000000
[  174.128923] x7 : 0000000000000008 x6 : ffff80001118811e
[  174.134856] x5 : ffff0000f55cbe48 x4 : 0000000000000000
[  174.140789] x3 : 0000000000000027 x2 : 0000000000000027
[  174.146723] x1 : ffff0000e5c3ee40 x0 : 000000000000001f
[  174.152657] Call trace:
[  174.155388]  clk_core_disable+0x2c/0x94
[  174.159670]  clk_core_disable_lock+0x20/0x34
[  174.164439]  clk_disable+0x1c/0x28
[  174.168239]  dw_mipi_dsi_bridge_post_disable+0xc4/0x120
[  174.174077]  drm_atomic_bridge_chain_post_disable+0x74/0x98
[  174.180303]  drm_atomic_helper_commit_modeset_disables+0x3d8/0x3dc
[  174.187208]  drm_atomic_helper_commit_tail_rpm+0x20/0xa0
[  174.193140]  commit_tail+0x74/0xf8
[  174.196938]  drm_atomic_helper_commit+0x104/0x108
[  174.202191]  drm_atomic_commit+0x48/0x54
[  174.206571]  drm_atomic_connector_commit_dpms+0xa0/0x100
[  174.212505]  drm_mode_obj_set_property_ioctl+0xd4/0x2c8
[  174.218343]  drm_connector_property_set_ioctl+0x20/0x28
[  174.224179]  drm_ioctl_kernel+0xa0/0xdc
[  174.228461]  drm_ioctl+0x2c4/0x2ec
[  174.232258]  vfs_ioctl+0x24/0x40
[  174.235860]  __arm64_sys_ioctl+0x74/0xa4
[  174.240240]  el0_svc_common.constprop.0+0xe0/0x160
[  174.245592]  do_el0_svc+0x44/0x70
[  174.249294]  el0_sync_handler+0xc8/0x184
[  174.253672]  el0_sync+0x140/0x180
[  174.257372] ---[ end trace 6c6d0de3ca79ec7e ]---


Any further interaction with trying to "resume" or "suspend" the
display ends up with similar messages that I'd characterize as
the clock states being "confused".

 * Enabling unprepared pclk_mipi_dsi[01]
 * pclk_mipi_dsi[01] already disabled

Note that before being stuck in a confused state, using the /sys/ nodes
as follow seem to not cause issues:

  $ echo 1 | sudo tee /sys/class/graphics/fb0/blank
  $ echo 0 | sudo tee /sys/class/graphics/fb0/blank

Though once set in a confused state, it fails to recover with anything
I throw at it.

Not sure that it matters, but during all the operations the backlight
operates as expected, it seems only the MIPI subsystem is not working
as expected.

For context, here's some bits of knowledge from an IRC conversation on
the #chromium-os channel on Freenode.

> <mmind00> samueldr amstan: the issue is probably with how
> the dsi bridge handles powerons ... which in turn is a hack around
> how DRM handles display bringup
>
> <mmind00> samueldr amstan: bigger explanation from an
> internal commit I carry around: http://paste.debian.net/1161814/
>
> <mmind00> at least that is the dsi issue I ran into with
> our product using the dw-dsi ... even if dw-dsi is still pre-bridge,
> the issue might be similar - see non-atomic access not always calling
> mode_set

If there's any more information that can be helpful for figuring out
the issue, I'm open to trying them.

Additionally, I'm okay with being given tips or resources about how to
fix the problem. This is out of my realm of expertise, and I'm
definitely confused by the new terminology and lack of background
knowledge.

Thanks,

-- 
Samuel Dionne-Riel
