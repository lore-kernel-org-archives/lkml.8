Return-Path: <SRS0=VV4q=52=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40D68C2BB1D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 03:55:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A93F20936
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 03:55:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586490910;
	bh=TjFmNk6idyfIeYrGysZ/y2DkV1ouIOtNI5z9UXMVK0U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=z+EIPYBZ6agQO2Ku9d72BHqKNG5oBE3I5n+j2FFR2oLEJqLHA55CL8JYM5873wV8y
	 QiVes7+doey+BxR7M7/DDJUwKjTOBPVHN63vZTWd/2lH4iYBJLw/4ZACMFhjbHQphO
	 7acQsf+arfsUEKVt0KQK53XcyZWIrEyPygDfmwvE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729037AbgDJDzG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 23:55:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:34596 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727018AbgDJDuK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 23:50:10 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DC0A221655;
        Fri, 10 Apr 2020 03:50:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586490609;
        bh=TjFmNk6idyfIeYrGysZ/y2DkV1ouIOtNI5z9UXMVK0U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WizPvJQiMB0nfby//3jWCPrmgAeu51f0k99MZlbCd3pqm9FiaJa7iFjOZJfUw463f
         RN64+CZf92oU7BGCugHQmz0WJ/ZQnNyeD2qiJOlKy1711YrKDvTDWIQORctzDIlilW
         owP//5ndLwU1BDmOtKJHhsu5AgkISrDYTu9h9Rns=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     James Morse <james.morse@arm.com>,
        Liguang Zhang <zhangliguang@linux.alibaba.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Sasha Levin <sashal@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 4.19 03/32] firmware: arm_sdei: fix double-lock on hibernate with shared events
Date:   Thu,  9 Apr 2020 23:49:36 -0400
Message-Id: <20200410035005.9371-3-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200410035005.9371-1-sashal@kernel.org>
References: <20200410035005.9371-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: James Morse <james.morse@arm.com>

[ Upstream commit 6ded0b61cf638bf9f8efe60ab8ba23db60ea9763 ]

SDEI has private events that must be registered on each CPU. When
CPUs come and go they must re-register and re-enable their private
events. Each event has flags to indicate whether this should happen
to protect against an event being registered on a CPU coming online,
while all the others are unregistering the event.

These flags are protected by the sdei_list_lock spinlock, because
the cpuhp callbacks can't take the mutex.

Hibernate needs to unregister all events, but keep the in-memory
re-register and re-enable as they are. sdei_unregister_shared()
takes the spinlock to walk the list, then calls _sdei_event_unregister()
on each shared event. _sdei_event_unregister() tries to take the
same spinlock to update re-register and re-enable. This doesn't go
so well.

Push the re-register and re-enable updates out to their callers.
sdei_unregister_shared() doesn't want these values updated, so
doesn't need to do anything.

This also fixes shared events getting lost over hibernate as this
path made them look unregistered.

Fixes: da351827240e ("firmware: arm_sdei: Add support for CPU and system power states")
Reported-by: Liguang Zhang <zhangliguang@linux.alibaba.com>
Signed-off-by: James Morse <james.morse@arm.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/firmware/arm_sdei.c | 32 +++++++++++++++-----------------
 1 file changed, 15 insertions(+), 17 deletions(-)

diff --git a/drivers/firmware/arm_sdei.c b/drivers/firmware/arm_sdei.c
index c64c7da738297..05b528c7ed8fd 100644
--- a/drivers/firmware/arm_sdei.c
+++ b/drivers/firmware/arm_sdei.c
@@ -489,11 +489,6 @@ static int _sdei_event_unregister(struct sdei_event *event)
 {
 	lockdep_assert_held(&sdei_events_lock);
 
-	spin_lock(&sdei_list_lock);
-	event->reregister = false;
-	event->reenable = false;
-	spin_unlock(&sdei_list_lock);
-
 	if (event->type == SDEI_EVENT_TYPE_SHARED)
 		return sdei_api_event_unregister(event->event_num);
 
@@ -516,6 +511,11 @@ int sdei_event_unregister(u32 event_num)
 			break;
 		}
 
+		spin_lock(&sdei_list_lock);
+		event->reregister = false;
+		event->reenable = false;
+		spin_unlock(&sdei_list_lock);
+
 		err = _sdei_event_unregister(event);
 		if (err)
 			break;
@@ -583,26 +583,15 @@ static int _sdei_event_register(struct sdei_event *event)
 
 	lockdep_assert_held(&sdei_events_lock);
 
-	spin_lock(&sdei_list_lock);
-	event->reregister = true;
-	spin_unlock(&sdei_list_lock);
-
 	if (event->type == SDEI_EVENT_TYPE_SHARED)
 		return sdei_api_event_register(event->event_num,
 					       sdei_entry_point,
 					       event->registered,
 					       SDEI_EVENT_REGISTER_RM_ANY, 0);
 
-
 	err = sdei_do_cross_call(_local_event_register, event);
-	if (err) {
-		spin_lock(&sdei_list_lock);
-		event->reregister = false;
-		event->reenable = false;
-		spin_unlock(&sdei_list_lock);
-
+	if (err)
 		sdei_do_cross_call(_local_event_unregister, event);
-	}
 
 	return err;
 }
@@ -630,8 +619,17 @@ int sdei_event_register(u32 event_num, sdei_event_callback *cb, void *arg)
 			break;
 		}
 
+		spin_lock(&sdei_list_lock);
+		event->reregister = true;
+		spin_unlock(&sdei_list_lock);
+
 		err = _sdei_event_register(event);
 		if (err) {
+			spin_lock(&sdei_list_lock);
+			event->reregister = false;
+			event->reenable = false;
+			spin_unlock(&sdei_list_lock);
+
 			sdei_event_destroy(event);
 			pr_warn("Failed to register event %u: %d\n", event_num,
 				err);
-- 
2.20.1

