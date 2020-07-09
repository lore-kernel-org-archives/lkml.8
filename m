Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19957C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 10:28:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E8FA22077D
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 10:28:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G6lBTXeE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726845AbgGIK2U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 06:28:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726343AbgGIK2T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 06:28:19 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B3F3C061A0B
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jul 2020 03:28:19 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id q17so660343pls.9
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jul 2020 03:28:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/EG20tIDTCzthljxyo6PXMk7xchJ/qej5fX9u4QlLck=;
        b=G6lBTXeEsW0BuY74pDHN8y7Ayste3O8zUBSu0nnml6z3xQ983c9tA50CErUd+du9og
         etCNwE0/0cvBpKHJDn3m7rk+v6B+iWd6T77wQMrrF3zR8FNyszRts0JrslfuaO5gkK5G
         h6zwbpVs5nU4AWmiorsligyXderCM/P38vVpwqNsEo9nE8pY7oBd619daVCpUyg+0LMD
         uP4uLOQehV6yFNzSoRcPhg3H/uuM5ag8l4QqLIqz8yl+uc2oWZRAPPlhsLJnYOIvpNnB
         NX1MZllPPVfO7Dxy3LKs2UdLAm9MDD0Y7k/EeKtW4y+EgE8vTNJrI6mt94fBdgckSM8y
         CN7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/EG20tIDTCzthljxyo6PXMk7xchJ/qej5fX9u4QlLck=;
        b=fc0s7JN1AEXnnqlObBko+/N7cc8CsHw/g8obWkx1uZkwLBkZxh7GhVSf34X+mQ4zqW
         jlMCWKVpGFMorsXTh4Qd1njcR9GztsPU6pVPjsRdu8rR8325QhFnsaL5Xe15SnCaIi6Z
         MKOqtPERB6oHXEhWeOmWhGKIxEWvhkSBkacBjv9OFm+QFG08sgBBwk0YQMtEIP4WE1iU
         TJ3BRYCo89r6Ti7w4H/6WEHlUqLow2ZFSbGYiNPpRsdq0V8LGMRFPB01SCVH40LlKs6R
         DjTb+dn4QO95Pj5E3IgkKD0PNWpg/PLKDDgL+QoZvUIgiPlfjRTlmfxkr+iB3Kz+rV8w
         Sadg==
X-Gm-Message-State: AOAM531fZZfae84Bi7qqMS0fXT3e7/3l4rYA1DMqwXQAjCXljO81v2dz
        BuRTs+OCBXDMsbXMfsg0ExQ=
X-Google-Smtp-Source: ABdhPJzFWN306ECkrJvpYKRvNdI3aQoGs7do/QU+1Bp0IkooHRGYTL8OHkcuaRaQknD1fk/l+xILuA==
X-Received: by 2002:a17:90a:158f:: with SMTP id m15mr14001014pja.93.1594290498767;
        Thu, 09 Jul 2020 03:28:18 -0700 (PDT)
Received: from cvds-vagarw7.iind.intel.com ([192.55.54.40])
        by smtp.googlemail.com with ESMTPSA id y8sm2125163pju.49.2020.07.09.03.28.11
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Jul 2020 03:28:18 -0700 (PDT)
From:   Vaibhav Agarwal <vaibhav.sr@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alex Elder <elder@kernel.org>, Johan Hovold <johan@kernel.org>,
        Mark Greer <mgreer@animalcreek.com>
Cc:     greybus-dev@lists.linaro.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Vaibhav Agarwal <vaibhav.sr@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH v4 5/7] staging: greybus: audio: Add helper APIs for dynamic audio modules
Date:   Thu,  9 Jul 2020 15:57:21 +0530
Message-Id: <35e1baaae10a3f2162e71be4c2f75a701584f0e6.1594290158.git.vaibhav.sr@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1594290158.git.vaibhav.sr@gmail.com>
References: <cover.1594290158.git.vaibhav.sr@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greybus Codec driver allows modules to be dynamically added and removed,
which further requires updating the DAPM configurations as well.

With current snd_soc architecture, dynamic audio modules is not yet
supported. This patch provides helper APIs to update DAPM configurations
in response to modules which are dynamically added or removed. The
source is primarily based on snd_dapm.c

Signed-off-by: Vaibhav Agarwal <vaibhav.sr@gmail.com>
Reviewed-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/staging/greybus/Makefile       |   2 +-
 drivers/staging/greybus/audio_codec.c  |  12 +-
 drivers/staging/greybus/audio_helper.c | 197 +++++++++++++++++++++++++
 drivers/staging/greybus/audio_helper.h |  17 +++
 4 files changed, 223 insertions(+), 5 deletions(-)
 create mode 100644 drivers/staging/greybus/audio_helper.c
 create mode 100644 drivers/staging/greybus/audio_helper.h

diff --git a/drivers/staging/greybus/Makefile b/drivers/staging/greybus/Makefile
index 627e44f2a983..3b4b6cabff19 100644
--- a/drivers/staging/greybus/Makefile
+++ b/drivers/staging/greybus/Makefile
@@ -28,7 +28,7 @@ obj-$(CONFIG_GREYBUS_VIBRATOR)	+= gb-vibrator.o
 
 # Greybus Audio is a bunch of modules
 gb-audio-module-y	:= audio_module.o audio_topology.o
-gb-audio-codec-y	:= audio_codec.o
+gb-audio-codec-y	:= audio_codec.o audio_helper.o
 gb-audio-gb-y		:= audio_gb.o
 gb-audio-apbridgea-y	:= audio_apbridgea.o
 gb-audio-manager-y	:= audio_manager.o audio_manager_module.o
diff --git a/drivers/staging/greybus/audio_codec.c b/drivers/staging/greybus/audio_codec.c
index 0ecdba27086b..74538f8c5fa4 100644
--- a/drivers/staging/greybus/audio_codec.c
+++ b/drivers/staging/greybus/audio_codec.c
@@ -14,6 +14,7 @@
 #include "audio_codec.h"
 #include "audio_apbridgea.h"
 #include "audio_manager.h"
+#include "audio_helper.h"
 
 static struct gbaudio_codec_info *gbcodec;
 
@@ -865,7 +866,7 @@ int gbaudio_register_module(struct gbaudio_module_info *module)
 
 	/* card already instantiated, create widgets here only */
 	if (comp->card->instantiated) {
-		snd_soc_dapm_link_component_dai_widgets(comp->card,
+		gbaudio_dapm_link_component_dai_widgets(comp->card,
 							&comp->dapm);
 #ifdef CONFIG_SND_JACK
 		/*
@@ -999,13 +1000,16 @@ void gbaudio_unregister_module(struct gbaudio_module_info *module)
 	if (module->controls) {
 		dev_dbg(comp->dev, "Removing %d controls\n",
 			module->num_controls);
-		snd_soc_remove_codec_controls(comp, module->controls,
-					      module->num_controls);
+		/* release control semaphore */
+		up_write(&card->controls_rwsem);
+		gbaudio_remove_component_controls(comp, module->controls,
+						  module->num_controls);
+		down_write(&card->controls_rwsem);
 	}
 	if (module->dapm_widgets) {
 		dev_dbg(comp->dev, "Removing %d widgets\n",
 			module->num_dapm_widgets);
-		snd_soc_dapm_free_controls(&comp->dapm, module->dapm_widgets,
+		gbaudio_dapm_free_controls(&comp->dapm, module->dapm_widgets,
 					   module->num_dapm_widgets);
 	}
 
diff --git a/drivers/staging/greybus/audio_helper.c b/drivers/staging/greybus/audio_helper.c
new file mode 100644
index 000000000000..faaa39708118
--- /dev/null
+++ b/drivers/staging/greybus/audio_helper.c
@@ -0,0 +1,197 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Greybus Audio Sound SoC helper APIs
+ */
+
+#include <linux/debugfs.h>
+#include <sound/core.h>
+#include <sound/soc.h>
+#include <sound/soc-dapm.h>
+
+#define gbaudio_dapm_for_each_direction(dir) \
+	for ((dir) = SND_SOC_DAPM_DIR_IN; (dir) <= SND_SOC_DAPM_DIR_OUT; \
+		(dir)++)
+
+static void gbaudio_dapm_link_dai_widget(struct snd_soc_dapm_widget *dai_w,
+					 struct snd_soc_card *card)
+{
+	struct snd_soc_dapm_widget *w;
+	struct snd_soc_dapm_widget *src, *sink;
+	struct snd_soc_dai *dai = dai_w->priv;
+
+	/* ...find all widgets with the same stream and link them */
+	list_for_each_entry(w, &card->widgets, list) {
+		if (w->dapm != dai_w->dapm)
+			continue;
+
+		switch (w->id) {
+		case snd_soc_dapm_dai_in:
+		case snd_soc_dapm_dai_out:
+			continue;
+		default:
+			break;
+		}
+
+		if (!w->sname || !strstr(w->sname, dai_w->sname))
+			continue;
+
+		/*
+		 * check if widget is already linked,
+		 * if (w->linked)
+		 *	return;
+		 */
+
+		if (dai_w->id == snd_soc_dapm_dai_in) {
+			src = dai_w;
+			sink = w;
+		} else {
+			src = w;
+			sink = dai_w;
+		}
+		dev_dbg(dai->dev, "%s -> %s\n", src->name, sink->name);
+		/* Add the DAPM path and set widget's linked status
+		 * snd_soc_dapm_add_path(w->dapm, src, sink, NULL, NULL);
+		 * w->linked = 1;
+		 */
+	}
+}
+
+int gbaudio_dapm_link_component_dai_widgets(struct snd_soc_card *card,
+					    struct snd_soc_dapm_context *dapm)
+{
+	struct snd_soc_dapm_widget *dai_w;
+
+	/* For each DAI widget... */
+	list_for_each_entry(dai_w, &card->widgets, list) {
+		if (dai_w->dapm != dapm)
+			continue;
+		switch (dai_w->id) {
+		case snd_soc_dapm_dai_in:
+		case snd_soc_dapm_dai_out:
+			break;
+		default:
+			continue;
+		}
+		gbaudio_dapm_link_dai_widget(dai_w, card);
+	}
+
+	return 0;
+}
+
+static void gbaudio_dapm_free_path(struct snd_soc_dapm_path *path)
+{
+	list_del(&path->list_node[SND_SOC_DAPM_DIR_IN]);
+	list_del(&path->list_node[SND_SOC_DAPM_DIR_OUT]);
+	list_del(&path->list_kcontrol);
+	list_del(&path->list);
+	kfree(path);
+}
+
+static void gbaudio_dapm_free_widget(struct snd_soc_dapm_widget *w)
+{
+	struct snd_soc_dapm_path *p, *next_p;
+	enum snd_soc_dapm_direction dir;
+
+	list_del(&w->list);
+	/*
+	 * remove source and sink paths associated to this widget.
+	 * While removing the path, remove reference to it from both
+	 * source and sink widgets so that path is removed only once.
+	 */
+	gbaudio_dapm_for_each_direction(dir) {
+		snd_soc_dapm_widget_for_each_path_safe(w, dir, p, next_p)
+			gbaudio_dapm_free_path(p);
+	}
+
+	kfree(w->kcontrols);
+	kfree_const(w->name);
+	kfree_const(w->sname);
+	kfree(w);
+}
+
+int gbaudio_dapm_free_controls(struct snd_soc_dapm_context *dapm,
+			       const struct snd_soc_dapm_widget *widget,
+			       int num)
+{
+	int i;
+	struct snd_soc_dapm_widget *w, *next_w;
+#ifdef CONFIG_DEBUG_FS
+	struct dentry *parent = dapm->debugfs_dapm;
+	struct dentry *debugfs_w = NULL;
+#endif
+
+	mutex_lock(&dapm->card->dapm_mutex);
+	for (i = 0; i < num; i++) {
+		/* below logic can be optimized to identify widget pointer */
+		list_for_each_entry_safe(w, next_w, &dapm->card->widgets,
+					 list) {
+			if (w->dapm != dapm)
+				continue;
+			if (!strcmp(w->name, widget->name))
+				break;
+			w = NULL;
+		}
+		if (!w) {
+			dev_err(dapm->dev, "%s: widget not found\n",
+				widget->name);
+			return -EINVAL;
+		}
+		widget++;
+#ifdef CONFIG_DEBUG_FS
+		if (!parent)
+			debugfs_w = debugfs_lookup(w->name, parent);
+		debugfs_remove(debugfs_w);
+		debugfs_w = NULL;
+#endif
+		gbaudio_dapm_free_widget(w);
+	}
+	mutex_unlock(&dapm->card->dapm_mutex);
+	return 0;
+}
+
+static int gbaudio_remove_controls(struct snd_card *card, struct device *dev,
+				   const struct snd_kcontrol_new *controls,
+				   int num_controls, const char *prefix)
+{
+	int i, err;
+
+	for (i = 0; i < num_controls; i++) {
+		const struct snd_kcontrol_new *control = &controls[i];
+		struct snd_ctl_elem_id id;
+		struct snd_kcontrol *kctl;
+
+		if (prefix)
+			snprintf(id.name, sizeof(id.name), "%s %s", prefix,
+				 control->name);
+		else
+			strlcpy(id.name, control->name, sizeof(id.name));
+		id.numid = 0;
+		id.iface = control->iface;
+		id.device = control->device;
+		id.subdevice = control->subdevice;
+		id.index = control->index;
+		kctl = snd_ctl_find_id(card, &id);
+		if (!kctl) {
+			dev_err(dev, "%d: Failed to find %s\n", err,
+				control->name);
+			continue;
+		}
+		err = snd_ctl_remove(card, kctl);
+		if (err < 0) {
+			dev_err(dev, "%d: Failed to remove %s\n", err,
+				control->name);
+			continue;
+		}
+	}
+	return 0;
+}
+
+int gbaudio_remove_component_controls(struct snd_soc_component *component,
+				      const struct snd_kcontrol_new *controls,
+				      unsigned int num_controls)
+{
+	struct snd_card *card = component->card->snd_card;
+
+	return gbaudio_remove_controls(card, component->dev, controls,
+				       num_controls, component->name_prefix);
+}
diff --git a/drivers/staging/greybus/audio_helper.h b/drivers/staging/greybus/audio_helper.h
new file mode 100644
index 000000000000..5cf1c6d7d3ea
--- /dev/null
+++ b/drivers/staging/greybus/audio_helper.h
@@ -0,0 +1,17 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Greybus Audio Sound SoC helper APIs
+ */
+
+#ifndef __LINUX_GBAUDIO_HELPER_H
+#define __LINUX_GBAUDIO_HELPER_H
+
+int gbaudio_dapm_link_component_dai_widgets(struct snd_soc_card *card,
+					    struct snd_soc_dapm_context *dapm);
+int gbaudio_dapm_free_controls(struct snd_soc_dapm_context *dapm,
+			       const struct snd_soc_dapm_widget *widget,
+			       int num);
+int gbaudio_remove_component_controls(struct snd_soc_component *component,
+				      const struct snd_kcontrol_new *controls,
+				      unsigned int num_controls);
+#endif
-- 
2.27.0

