Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 246C8C433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 16:32:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF9A2206DB
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 16:32:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pEBwEHKE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732035AbgIHQcp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 12:32:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731961AbgIHQ1c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 12:27:32 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D432C061573
        for <linux-kernel@vger.kernel.org>; Tue,  8 Sep 2020 09:27:18 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id g10so15343526otq.9
        for <linux-kernel@vger.kernel.org>; Tue, 08 Sep 2020 09:27:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=qe8786Kv2/Cdda8ENAC5J9OvVx6/GLW0ZvDTGCUEWHI=;
        b=pEBwEHKEb1Dk4iDE+bs0N/QmZmfmRHAdNjZfAPX4VRrtoLeqOs0RvZiP3PyjyhGTyR
         7314mZnv/TVtui8z8++jmRdhor2lXGLxeiyDlFvN52zTnMO4zevmY2agOGtGDjhJRe9n
         2GVBGNe42bsAb3MLIRBr1nS7CgafY02zu/kzxWNZFIGhyzvePv5Lh1hkSSz6pkuNALvK
         nmDT5DrQ+MFgy0hqKBAdlvg5eChxI61+3JKMJvrEHHRPAQus7XNObK8IsKB+rhuGI49C
         rmXQSScHmMbvAQuES7ldtKynOvtJzb/pf2YPUWMIDgdE6eg9xRq5jSsrbraprvmo+4rl
         QlVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=qe8786Kv2/Cdda8ENAC5J9OvVx6/GLW0ZvDTGCUEWHI=;
        b=IkJyBHShwad6VpKQsGq8uPegM2t68kLF4Qzg6pNbq2EXVUgGUE8qsNSNIPKRMaEpaL
         qm8i7YCm0niH+C3bhgsdGjoSsaZsXHKTlel/tMNpFCdFzTZV3QzDAnHnC++OZjZWMmY0
         8NX15dOUc+u4TIR3oveW0XkMqPo5TNwB/ZUzuZmpma8uH+o9Uc+TgMn/ouor8PLmadtx
         hqHJemhHP9civCiez65C09Op7Nj3+zi2Q3ieUTqhYtgFzEi7SR6fvCfj6l0lKxfj5SGd
         JEF1e8j9Jpm/8HhXSfFZLwskqyFFz4N8dmyCWn/JVToPOJLFjJzGQRzRX5+e5Wem6SDK
         iM4A==
X-Gm-Message-State: AOAM532+XLcLxiBZ45tuvUVXCjnjnWn80I/PVcRj5U3/17N1zeRjOY0q
        fU2JZWICisxt+VIxWPhnyp9f860OxiUJ3V3q4CAXH22n0SR8Rg==
X-Google-Smtp-Source: ABdhPJwF/dno6+Gp7uQwcYtb25LqX/clnTegre5FuzZSMtCcMNYZYLn4O1EQY/jnjgJOWLOT5h/Ux9vDuj/4wGpzMl4=
X-Received: by 2002:a9d:345:: with SMTP id 63mr18625809otv.370.1599582436249;
 Tue, 08 Sep 2020 09:27:16 -0700 (PDT)
MIME-Version: 1.0
From:   Mikael Pettersson <mikpelinux@gmail.com>
Date:   Tue, 8 Sep 2020 18:27:05 +0200
Message-ID: <CAM43=SOCs699z9E1EK3EG8BCJFw_9veWa7xWOEokvwj01NVS6Q@mail.gmail.com>
Subject: [REGRESSION][BISECTED] 5.9-rc4 disables console on radeon
To:     Linux Kernel list <linux-kernel@vger.kernel.org>,
        amd-gfx@lists.freedesktop.org,
        Kai-Heng Feng <kai.heng.feng@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Starting with linux-5.9-rc4, the Dell monitor on my desktop PC goes
black during boot
when the kernel activates the framebuffer console, except for this
error message shown
in the center of the screen:

"Dell U2412M
 The current input timing is not supported by the monitor display. Please
 change your input timing to 1920x1200@60Hz or any other monitor
 listed timing as per the monitor specifications.
 <DVI symbol>"

The monitor remains black until I reboot.

All kernels up to and including 5.9-rc3 were Ok.  A git bisect identified

# first bad commit: [fc8c70526bd30733ea8667adb8b8ffebea30a8ed]
drm/radeon: Prefer lower feedback dividers

as the culprit, and reverting that from -rc4 makes the console work again.

Adding a bit of debugging code to that function shows:

avivo_get_fb_ref_div: fb_div_new 136 fb_div_old 137
avivo_get_fb_ref_div: fb_div_new 142 fb_div_old 143
avivo_get_fb_ref_div: fb_div_new 136 fb_div_old 137
avivo_get_fb_ref_div: fb_div_new 119 fb_div_old 120
avivo_get_fb_ref_div: fb_div_new 136 fb_div_old 137

during boot, where "new" is what the commit above changed the code to compute,
and "old" is the value computed by the working code from rc3.

The graphics card is a Radeon HD6450 silent model:
01:00.0 VGA compatible controller: Advanced Micro Devices, Inc.
[AMD/ATI] Caicos [Radeon HD 6450/7450/8450 / R5 230 OEM] (prog-if 00
[VGA controller])
