Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1726EC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 16:26:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0026420722
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 16:26:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387758AbgF3Q0R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 12:26:17 -0400
Received: from foss.arm.com ([217.140.110.172]:41240 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387434AbgF3Q0P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 12:26:15 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D828330E;
        Tue, 30 Jun 2020 09:26:14 -0700 (PDT)
Received: from e120937-lin.home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 28A1C3F68F;
        Tue, 30 Jun 2020 09:26:14 -0700 (PDT)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, cristian.marussi@arm.com
Subject: [PATCH] firmware: arm_scmi: fix notifications macros argument reuse
Date:   Tue, 30 Jun 2020 17:25:47 +0100
Message-Id: <20200630162547.40824-1-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Checkpatch --strict reports some possible side-effects related to argument
reuse in some SCMI Notification Core macros: these are indeed false flags
in the context of actual macros invocations.

Nevertheless cleanup fixing all the warnings.

No functional change.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
 drivers/firmware/arm_scmi/notify.c | 48 ++++++++++++++++++++----------
 1 file changed, 32 insertions(+), 16 deletions(-)

diff --git a/drivers/firmware/arm_scmi/notify.c b/drivers/firmware/arm_scmi/notify.c
index b5b449f70605..bf8b3430c801 100644
--- a/drivers/firmware/arm_scmi/notify.c
+++ b/drivers/firmware/arm_scmi/notify.c
@@ -122,10 +122,13 @@
  */
 #define KEY_FIND(__ht, __obj, __k)				\
 ({								\
-	hash_for_each_possible((__ht), (__obj), hash, (__k))	\
-		if (likely((__obj)->key == (__k)))		\
+	typeof(__k) k_ = __k;					\
+	typeof(__obj) obj_;					\
+								\
+	hash_for_each_possible((__ht), obj_, hash, k_)		\
+		if (likely(obj_->key == k_))			\
 			break;					\
-	__obj;							\
+	__obj = obj_;						\
 })
 
 #define KEY_XTRACT_PROTO_ID(key)	FIELD_GET(PROTO_ID_MASK, (key))
@@ -140,19 +143,22 @@
  */
 #define SCMI_GET_PROTO(__ni, __pid)					\
 ({									\
+	typeof(__ni) ni_ = __ni;					\
 	struct scmi_registered_events_desc *__pd = NULL;		\
 									\
-	if ((__ni))							\
-		__pd = READ_ONCE((__ni)->registered_protocols[(__pid)]);\
+	if (ni_)							\
+		__pd = READ_ONCE(ni_->registered_protocols[(__pid)]);	\
 	__pd;								\
 })
 
 #define SCMI_GET_REVT_FROM_PD(__pd, __eid)				\
 ({									\
+	typeof(__pd) pd_ = __pd;					\
+	typeof(__eid) eid_ = __eid;					\
 	struct scmi_registered_event *__revt = NULL;			\
 									\
-	if ((__pd) && (__eid) < (__pd)->num_events)			\
-		__revt = READ_ONCE((__pd)->registered_events[(__eid)]);	\
+	if (pd_ && eid_ < pd_->num_events)				\
+		__revt = READ_ONCE(pd_->registered_events[eid_]);	\
 	__revt;								\
 })
 
@@ -167,15 +173,25 @@
 })
 
 /* A couple of utility macros to limit cruft when calling protocols' helpers */
-#define REVT_NOTIFY_ENABLE(revt, eid, sid)				       \
-	((revt)->proto->ops->set_notify_enabled((revt)->proto->ni->handle,     \
-						(eid), (sid), true))
-#define REVT_NOTIFY_DISABLE(revt, eid, sid)				       \
-	((revt)->proto->ops->set_notify_enabled((revt)->proto->ni->handle,     \
-						(eid), (sid), false))
-#define REVT_FILL_REPORT(revt, ...)					       \
-	((revt)->proto->ops->fill_custom_report((revt)->proto->ni->handle,     \
-						__VA_ARGS__))
+#define REVT_NOTIFY_SET_STATUS(revt, eid, sid, state)		\
+({								\
+	typeof(revt) r = revt;					\
+	r->proto->ops->set_notify_enabled(r->proto->ni->handle,	\
+					(eid), (sid), (state));	\
+})
+
+#define REVT_NOTIFY_ENABLE(revt, eid, sid)			\
+	REVT_NOTIFY_SET_STATUS((revt), (eid), (sid), true)
+
+#define REVT_NOTIFY_DISABLE(revt, eid, sid)			\
+	REVT_NOTIFY_SET_STATUS((revt), (eid), (sid), false)
+
+#define REVT_FILL_REPORT(revt, ...)				\
+({								\
+	typeof(revt) r = revt;					\
+	r->proto->ops->fill_custom_report(r->proto->ni->handle,	\
+					  __VA_ARGS__);		\
+})
 
 #define SCMI_PENDING_HASH_SZ		4
 #define SCMI_REGISTERED_HASH_SZ		6
-- 
2.17.1

