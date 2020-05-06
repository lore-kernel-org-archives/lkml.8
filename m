Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3936EC28CBC
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 06:18:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1406F2073A
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 06:18:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727976AbgEFGSH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 02:18:07 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:3854 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725873AbgEFGSG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 02:18:06 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id D019A51FD00B3074541E;
        Wed,  6 May 2020 14:18:04 +0800 (CST)
Received: from huawei.com (10.175.124.28) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.487.0; Wed, 6 May 2020
 14:17:54 +0800
From:   Jason Yan <yanaijie@huawei.com>
To:     <perex@perex.cz>, <tiwai@suse.com>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>
CC:     Jason Yan <yanaijie@huawei.com>
Subject: [PATCH] ALSA: hda: Return true,false for return type bool
Date:   Wed, 6 May 2020 14:17:16 +0800
Message-ID: <20200506061716.19209-1-yanaijie@huawei.com>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.124.28]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following coccicheck warning:

include/sound/hdaudio.h:210:73-74: WARNING: return of 0/1 in function
'snd_hdac_is_in_pm' with return type bool
include/sound/hdaudio.h:211:76-77: WARNING: return of 0/1 in function
'snd_hdac_is_power_on' with return type bool

Signed-off-by: Jason Yan <yanaijie@huawei.com>
---
 include/sound/hdaudio.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/sound/hdaudio.h b/include/sound/hdaudio.h
index d365297b3698..10945963d727 100644
--- a/include/sound/hdaudio.h
+++ b/include/sound/hdaudio.h
@@ -207,8 +207,8 @@ static inline int snd_hdac_power_down_pm(struct hdac_device *codec) { return 0;
 static inline int snd_hdac_keep_power_up(struct hdac_device *codec) { return 0; }
 static inline void snd_hdac_enter_pm(struct hdac_device *codec) {}
 static inline void snd_hdac_leave_pm(struct hdac_device *codec) {}
-static inline bool snd_hdac_is_in_pm(struct hdac_device *codec) { return 0; }
-static inline bool snd_hdac_is_power_on(struct hdac_device *codec) { return 1; }
+static inline bool snd_hdac_is_in_pm(struct hdac_device *codec) { return false; }
+static inline bool snd_hdac_is_power_on(struct hdac_device *codec) { return true; }
 #endif
 
 /*
-- 
2.21.1

