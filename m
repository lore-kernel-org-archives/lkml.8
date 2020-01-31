Return-Path: <SRS0=flzY=3U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20EC3C33CB2
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 10:40:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F20BB206F0
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 10:40:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728436AbgAaKjG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jan 2020 05:39:06 -0500
Received: from mx2.suse.de ([195.135.220.15]:56998 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728336AbgAaKjG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jan 2020 05:39:06 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 886E3AFF6;
        Fri, 31 Jan 2020 10:39:04 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
Cc:     linux-rpi-kernel@lists.infradead.org,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org, devel@driverdev.osuosl.org
Subject: [PATCH v2 00/21] staging: vc04_services: suspend/resume cleanup
Date:   Fri, 31 Jan 2020 11:38:16 +0100
Message-Id: <20200131103836.14312-1-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While in the process of preparing vchiq to support the Raspberry Pi 4, I
stumbled upon a bunch of dead code in it. Which this series deletes.

Ultimately the idea is to clean up vchiq_bcm2835_arm.c up to a point
where it'll be easy to join it with vchiq_arm.c, which IIRC the TODO
file states, should be the sole responsible for platform code.

With this we'll be able to introduce RPi4's functionality in a cleaner
way.

Overall it's a 500 line clean up, I tried to keep the patches as small and
manageable as possible, but I'd be happy to squash them if you prefer it
that way.

This was tested on a RPi3-B using the camera and HDMI audio and
vchiq_test app.

---

Changes since v1:
 - Reordered patches so as to have all of the suspend/resume state
   deletion together
 - Fix bug found by kbuild test robot
 - move "staging: vc04_services: Get rid of vc_suspend_state in struct
   vchiq_arm_state" into "staging: vc04_services: Get rid of unused
   suspend/resume states"

Nicolas Saenz Julienne (21):
  staging: vc04_services: Remove unused variables in struct
    vchiq_arm_state
  staging: vc04_services: Get rid of resume_blocked in struct
    vchiq_arm_state
  staging: vc04_services: Get rid of resume_blocker completion in struct
    vchiq_arm_state
  staging: vc04_services: get rid of blocked_blocker completion in
    struct vchiq_arm_state
  staging: vc04_services: Delete blocked_count in struct vchiq_arm_state
  staging: vc04_services: get rid of vchiq_platform_use_suspend_timer()
  staging: vc04_services: Get rid of vchiq_platform_paused/resumed()
  staging: vc04_services: Get rid of vchiq_platform_suspend/resume()
  staging: vc04_services: Get rid of vchiq_platform_videocore_wanted()
  staging: vc04_services: Get rid of vchiq_platform_handle_timeout()
  staging: vc04_services: Get rid of vchiq_on_remote_use_active()
  staging: vc04_services: Get rid of vchiq_arm_vcsuspend()
  staging: vc04_services: Get rid of vchiq_check_resume()
  staging: vc04_services: Delete vc_suspend_complete completion
  staging: vc04_services: Get rid of unused suspend/resume states
  staging: vc04_services: Get of even more suspend/resume states
  staging: vc04_services: Get rid of the rest of suspend/resume state
    handling
  staging: vc04_services: Get rid of USE_TYPE_SERVICE_NO_RESUME
  staging: vc04_services: Delete vchiq_platform_check_suspend()
  staging: vc04_services: Get rid of vchiq_arm_vcresume()'s signature
  staging: vc04_services: vchiq_arm: Get rid of unused defines

 .../interface/vchiq_arm/vchiq_2835_arm.c      |  43 --
 .../interface/vchiq_arm/vchiq_arm.c           | 495 +-----------------
 .../interface/vchiq_arm/vchiq_arm.h           |  76 ---
 .../interface/vchiq_arm/vchiq_core.c          |  16 -
 .../interface/vchiq_arm/vchiq_core.h          |  15 -
 5 files changed, 9 insertions(+), 636 deletions(-)

-- 
2.25.0

