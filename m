Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DCB9C43461
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 10:18:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 258BE207EA
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 10:18:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessm-com.20150623.gappssmtp.com header.i=@endlessm-com.20150623.gappssmtp.com header.b="Le2zSKka"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729950AbgIDKSA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 06:18:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729584AbgIDKRu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 06:17:50 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F37FC061244
        for <linux-kernel@vger.kernel.org>; Fri,  4 Sep 2020 03:17:50 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id c10so5371545otm.13
        for <linux-kernel@vger.kernel.org>; Fri, 04 Sep 2020 03:17:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=lPxZaTNtW5YIeyR3xGRRL/xoA1G8FPiEJM8B82fslQU=;
        b=Le2zSKkazZ1gO39eGYsVx4cem55qd/DC6Q2blFPKTBoy+7nOudrnvnkzDCECzwXeT2
         3sWv7LSDa51geVMtEujv6z6cfikZCLGNCMOhlNw+e+BADnCYCsvFG/epFABwLkq7gu5M
         E4AduSqpE2wPwQlvZLNdbJL6vnzIovrTzUMYAm/QdlfErhvvZUIm1Z0MPiiF8mFPh6Rf
         hvLUweTbmvvsxYkzQISGX9j5KRehBC9NYmyDBLv7/mZ2xoRyEMxUxHEWrcvb2Fu/QknF
         wWbHZ2tt+z6ucf/sG8PXoX/ewHJty2MDYnjESaQKFcKGFdgZiRhKT7QEuygCAcLMgCKa
         m8oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=lPxZaTNtW5YIeyR3xGRRL/xoA1G8FPiEJM8B82fslQU=;
        b=GPP2YEHtflfgp1aHwnT/5sFeWZWE69z1XYYp/NunUl38moOg5bf+qH6v5im8tDlEAQ
         oeZvawFwE/zuiu5lRwhzVMt5XN1Hq+oCzLgAya/Tc85264O8+qDBG4AAgMPYKJxxvRuO
         Ah261oI6saeYb0kjUkP9XMZNTX1qVF+gGz5+BHQZwT/CDGeG83q7vbLCKkH/V7IxQG48
         9v1m69CJMXI7jrf9wlu6AIZayFxUTsjfZBwdpcIE4XVmGe/jCTvm0C0O7KNqlMVTSEED
         nWPWpze/KkZoYZrbo488dAa0A2Kqsiwg7iDXchFv/4QgciK7dAnayMqjaUGqYQLLNQi0
         fSMw==
X-Gm-Message-State: AOAM530LG03xYun+MtidcWu32pDEvgo5rU8kreLF5VeVLxLE1xeYujh8
        XOs5zqbOBDP7L6L75ghMYZDPU77aGwRK12S+Vm6VeA==
X-Google-Smtp-Source: ABdhPJweP2lCtEYjkHQWlo8QD4Vq+0WurSxnsElGAWHdmPXCihLvVJ8RSL9d2TT9bD+gTRC7lnVmzXCKaHLVS1Y6hf8=
X-Received: by 2002:a05:6830:1e22:: with SMTP id t2mr240631otr.100.1599214668457;
 Fri, 04 Sep 2020 03:17:48 -0700 (PDT)
MIME-Version: 1.0
From:   Jian-Hong Pan <jian-hong@endlessm.com>
Date:   Fri, 4 Sep 2020 18:16:16 +0800
Message-ID: <CAPpJ_efY2=qmaAtuYVfWhZNBhzTAtAxm9CS5jb_sTpca97jkpA@mail.gmail.com>
Subject: Re: [PATCH v5 00/80] drm/vc4: Support BCM2711 Display Pipeline
To:     maxime@cerno.tech
Cc:     bcm-kernel-feedback-list@broadcom.com,
        dave.stevenson@raspberrypi.com, devicetree@vger.kernel.org,
        dri-devel@lists.freedesktop.org, eric@anholt.net,
        kdasu.kdev@gmail.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        nsaenzjulienne@suse.de, p.zabel@pengutronix.de,
        phil@raspberrypi.com, robh+dt@kernel.org, sboyd@kernel.org,
        tim.gover@raspberrypi.com,
        Linux Upstreaming Team <linux@endlessm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Maxime,

Thanks for version 5 patch series!

I applied it based on linux-next tag next-20200828 and build it with
the config [1] to test on RPi 4
However, It fails to get HDMI state machine clock and pixel bcb clock.
Then, vc4-drm probes failed. Full dmseg [2]:

[    2.552675] [drm:vc5_hdmi_init_resources] *ERROR* Failed to get
HDMI state machine clock
[    2.557974] raspberrypi-firmware soc:firmware: Attached to firmware
from 2020-06-01T13:23:40
[    2.567612] of_clk_hw_onecell_get: invalid index 14
[    2.567636] [drm:vc5_hdmi_init_resources] *ERROR* Failed to get
pixel bvb clock
[    2.567664] vc4-drm gpu: failed to bind fef00700.hdmi (ops vc4_hdmi_ops): -2
[    2.567731] vc4-drm gpu: master bind failed: -2
[    2.567755] vc4-drm: probe of gpu failed with error -2

I decompile bcm2711-rpi-4-b.dtb.  Both hdmi@7ef00700 and hdmi@7ef05700
show the clocks member.

hdmi@7ef00700 {
        compatible = "brcm,bcm2711-hdmi0";
        reg = <0x7ef00700 0x300 0x7ef00300 0x200 0x7ef00f00 0x80
0x7ef00f80 0x80 0x7ef01b00 0x200 0x7ef01f00 0x400 0x7ef00200 0x80
0x7ef04300 0x100 0x7ef20000 0x100>;
        reg-names = "hdmi\0dvp\0phy\0rm\0packet\0metadata\0csc\0cec\0hd";
        clock-names = "hdmi\0bvb\0audio\0cec";
        resets = <0x17 0x00>;
        ddc = <0x18>;
        dmas = <0x19 0x0a>;
        dma-names = "audio-rx";
        status = "okay";
        clocks = <0x10 0x0d 0x10 0x0e 0x17 0x00 0x1a>;
};

hdmi@7ef05700 {
        compatible = "brcm,bcm2711-hdmi1";
        reg = <0x7ef05700 0x300 0x7ef05300 0x200 0x7ef05f00 0x80
0x7ef05f80 0x80 0x7ef06b00 0x200 0x7ef06f00 0x400 0x7ef00280 0x80
0x7ef09300 0x100 0x7ef20000 0x100>;
        reg-names = "hdmi\0dvp\0phy\0rm\0packet\0metadata\0csc\0cec\0hd";
        ddc = <0x1b>;
        clock-names = "hdmi\0bvb\0audio\0cec";
        resets = <0x17 0x01>;
        dmas = <0x19 0x11>;
        dma-names = "audio-rx";
        status = "okay";
        clocks = <0x10 0x0d 0x10 0x0e 0x17 0x01 0x1a>;
};

Also re-check runtime device tree, they are the same values as mentioned above:

$ xxd /proc/device-tree/soc/hdmi@7ef00700/clocks
00000000: 0000 0010 0000 000d 0000 0010 0000 000e  ................
00000010: 0000 0017 0000 0000 0000 001a            ............
$ xxd /proc/device-tree/soc/hdmi@7ef05700/clocks
00000000: 0000 0010 0000 000d 0000 0010 0000 000e  ................
00000010: 0000 0017 0000 0001 0000 001a            ............

Do I miss something?

[1]: https://gist.github.com/starnight/649ea5a8384313f0354aca504f78ad70#file-config
[2]: https://gist.github.com/starnight/649ea5a8384313f0354aca504f78ad70#file-dmesg-log

Jian-Hong Pan
