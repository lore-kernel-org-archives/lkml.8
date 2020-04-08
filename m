Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C656C2D0EA
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 06:05:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D55E320692
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 06:05:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mz1/1VoS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726559AbgDHGFn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 02:05:43 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:43047 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726492AbgDHGFm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 02:05:42 -0400
Received: by mail-qk1-f196.google.com with SMTP id 13so2037108qko.10
        for <linux-kernel@vger.kernel.org>; Tue, 07 Apr 2020 23:05:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=i3YYftYCfrhJjBZZ31eyPIp2ch2qqn2ebn4+Xy1T8GM=;
        b=mz1/1VoSkSn8lIOzYyt+hoarBQ1UWUZd5QYpTPClZskcGof5rbMLfBlcO0b6FeThy8
         GivJZVp7anhPLhtV99KRCAA2/1kPkMjhIIj23PLzre2mRfXiczXolpQsPmtIUMgLGSUv
         72pYMDVrzBTXcE2VpUaKV1VY9AKeus3Q3x8j4regBUXTeZq8Z0IxDyFiZtWlQdPBOB3m
         Cvb8Kq9ADE4bX3LQCfvrT4qkbalweYD0Mp5geM39vmknMkAlPnGPWqnWNAitM1zB0JQN
         MAzolMAp3LlMUuEIlHMXS0kWg2IJBwwGgd1G3tlOdN5Z/XiXHlyi/COV0cHnZBYSi4jO
         M1bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=i3YYftYCfrhJjBZZ31eyPIp2ch2qqn2ebn4+Xy1T8GM=;
        b=Uf5Dk9x9hzjVYOT5sA82GUp/gxX082satQXtDc8yeXJ1cpTKjAFAnNlNVxQd8Mo1tV
         n7bIQJOnvJgeMlSJkgO8/AvT/9uZYL2ziAkdCwZTeTSFQGUH9/T+EsJGdXs1ep+DFgze
         MU85XLHO1R0rIBBRW2ISoVrHVUT1pShIGP1cwJvfqka8dpJ5JQX6p6xAzKDhRmlVy0mn
         J/CmWjZnj+6AEw5v3c3w4jQb50XIs5QvwDeCRVvt7erh0axoIlR5mhZlt3+P0pZBbVJY
         MFQWecWBuSy7V5SFNPn+hBF5eYdKjN2nOTIx9Y5RyJU5M7eshxlHTjJWH0pR5vAKmX/v
         3B1A==
X-Gm-Message-State: AGi0PuarHlT8snrq98wyXkwHZZkT3VRSmfZUt6ZMr67HZKTrGLoIr/c2
        4891ynQmtaNSDvOfpNdxhT0=
X-Google-Smtp-Source: APiQypL97PJUfEmdYSkziP+A+Mrzd39ffS+akOz263Ejgd1uwHqIfFVDlMZwNT0XGGInVIQPwZHKdg==
X-Received: by 2002:a37:67c8:: with SMTP id b191mr5720639qkc.166.1586325941141;
        Tue, 07 Apr 2020 23:05:41 -0700 (PDT)
Received: from arch.localdomain (189-69-221-86.dial-up.telesp.net.br. [189.69.221.86])
        by smtp.gmail.com with ESMTPSA id w30sm19664170qtw.21.2020.04.07.23.05.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2020 23:05:40 -0700 (PDT)
From:   Gabriela Bittencourt <gabrielabittencourt00@gmail.com>
To:     rodrigosiqueiramelo@gmail.com, hamohammed.sa@gmail.com,
        daniel@ffwll.ch, airlied@linux.ie, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, manasi.d.navare@intel.com
Cc:     Gabriela Bittencourt <gabrielabittencourt00@gmail.com>
Subject: [PATCH 0/2] drm/vkms: Add Virtual hardware module option
Date:   Wed,  8 Apr 2020 03:05:01 -0300
Message-Id: <20200408060503.47709-1-gabrielabittencourt00@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm trying to implement the virtual hardware (virtual_hw) module option on
VKMS module.

The virtual hardware module option is implemented as an option to skip the
timing and vblank subtests. The main idea of virtual_hw is shorten the time
used on each period of operation. For this, the timer for counting the
period is eliminated and the KMS configurations are implemented along with
the standard atomic operations.

During the 'atomic_enable' and 'atomic_disable' the vblank is initialized
only if the virtual_hw is disabled (and therefore, the vblank is enabled).
A kick of crc/vblank is decoupled from vblank_simulate. Case the vblank
is disabled (that is, the vblank_simulate will never execute) a
vkms_composer_work routine is added to the end of the atomic_flush.

The IGT tests used to check the patch were the kms-flip, which kept the
same results, with and without my alterations, with the exceptions of the
tests that required vblank. The warning message and the related tests are
presented below:

Test requirement not met in function run_test_on_crtc_set, file ../tests/kms_flip.c:1285:
Test requirement: vblank
There is no VBlank
Last errno: 95, Operation not supported
 - wf_vblank-ts-check
 - blocking-wf_vblank
 - absolute-wf_vblank
 - blocking-absolute-wf_vblank
 - busy-flip
 - plain-flip-ts-check
 - plain-flip-fb-recreate
 - flip-vs-expired-vblank
 - flip-vs-absolute-wf_vblank
 - basic-flip-vs-wf_vblank
 - flip-vs-blocking-wf-vblank
 - dpms-vs-vblank-race
 - modeset-vs-vblank-race
 - wf_vblank-ts-check-interruptible
 - absolute-wf_vblank-interruptible
 - blocking-absolute-wf_vblank-interruptible
 - plain-flip-ts-check-interruptible
 - plain-flip-fb-recreate-interruptible
 - flip-vs-expired-vblank-interruptible
 - flip-vs-absolute-wf_vblank-interruptible
 - flip-vs-wf_vblank-interruptible
 - dpms-vs-vblank-race-interruptible
 - modeset-vs-vblank-race-interruptible

Any suggestions are very welcome :)

Gabriela Bittencourt (2):
  drm/vkms: Rework vkms_vblank_simulate
  drm/vkms: Add 'virtual_hw' module option

 drivers/gpu/drm/vkms/vkms_crtc.c | 42 +++++++++++++++++++++++++++-----
 drivers/gpu/drm/vkms/vkms_drv.c  | 13 ++++++++--
 drivers/gpu/drm/vkms/vkms_drv.h  |  2 ++
 3 files changed, 49 insertions(+), 8 deletions(-)

-- 
2.25.1

