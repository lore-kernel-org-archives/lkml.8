Return-Path: <SRS0=vnT4=3J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2942C2D0DB
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 17:06:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F34121D7E
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 17:06:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729246AbgATRGT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jan 2020 12:06:19 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:38168 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726642AbgATRGT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 12:06:19 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: ezequiel)
        with ESMTPSA id 588B62912EE
From:   Ezequiel Garcia <ezequiel@collabora.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Sandy Huang <hjc@rock-chips.com>,
        =?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com, Ezequiel Garcia <ezequiel@collabora.com>
Subject: [PATCH 1/5] component: Add an API to cleanup before unbind
Date:   Mon, 20 Jan 2020 14:05:58 -0300
Message-Id: <20200120170602.3832-2-ezequiel@collabora.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200120170602.3832-1-ezequiel@collabora.com>
References: <20200120170602.3832-1-ezequiel@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some users of the component API have a special model
for the allocation and release of its resources:
resources are allocated by an API but then
released by other means.

This contrasts with the current component API
assumption: .unbind must undo everything that .bind did.

An example of this is the DRM framework, which expects
registered objects (connectors, planes, CRTCs, etc)
to be released by respective drm_xxx_funcs.destroy hooks.

The drm_xxx_funcs.destroy call is done either directly
by drm_mode_config_cleanup() or in a refcounted fashion,
depending on the type of object.

For example, a DRM CRTC object is registered by
drm_crtc_init_with_planes(), and then released by drm_crtc_cleanup(),
which is normally called from the drm_crtc_funcs.destroy hook.

Now, in this model, drm_mode_config_cleanup() should
always be called before component_unbind() to avoid
use-after-free situations (because each component
has a devres group).

However, component_bind_all() calls component_unbind
on binded components, if any component in the chain
fails to bind.

In order to allow this special case, and following Alan Kay:

  "simple things should be simple, complex things should be possible"

introduce an extension to component_bind_all, which takes an extra
cleanup callback, to be called when binding fails to perform
extra cleanup steps.

This new API allows the following simple pattern:

void unbind_cleanup(...)
{
        drm_mode_config_cleanup(drm_dev);
}

int foo_bind()
{
	component_bind_all_or_cleanup(dev, drm_dev, unbind_cleanup);
}

void foo_unbind()
{
        drm_mode_config_cleanup(drm_dev);
        component_unbind_all(dev, drm_dev);
}

Each DRM component then uses the respective .destroy
hooks to destroy DRM resources, and the .unbind
hooks to release non-DRM resources.

Arguably, this could be viewed as Very Ugly. However, it handles
this complex case, making it possible to fix the current
unbind crashes that some DRM drivers suffer from,
in a non-invasive way, keeping the DRM resource handling model.

Signed-off-by: Ezequiel Garcia <ezequiel@collabora.com>
---
 drivers/base/component.c  |  9 +++++++--
 include/linux/component.h | 10 +++++++++-
 2 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/drivers/base/component.c b/drivers/base/component.c
index 532a3a5d8f63..371cff9208cf 100644
--- a/drivers/base/component.c
+++ b/drivers/base/component.c
@@ -622,12 +622,14 @@ static int component_bind(struct component *component, struct master *master,
  * component_bind_all - bind all components of an aggregate driver
  * @master_dev: device with the aggregate driver
  * @data: opaque pointer, passed to all components
+ * @cleanup: optional cleanup callback.
  *
  * Binds all components of the aggregate @dev by passing @data to their
  * &component_ops.bind functions. Should be called from
  * &component_master_ops.bind.
  */
-int component_bind_all(struct device *master_dev, void *data)
+int component_bind_all_or_cleanup(struct device *master_dev,
+				  void *data, void (*cleanup)(void *data))
 {
 	struct master *master;
 	struct component *c;
@@ -650,6 +652,9 @@ int component_bind_all(struct device *master_dev, void *data)
 		}
 
 	if (ret != 0) {
+		if (cleanup)
+			cleanup(data);
+
 		for (; i > 0; i--)
 			if (!master->match->compare[i - 1].duplicate) {
 				c = master->match->compare[i - 1].component;
@@ -659,7 +664,7 @@ int component_bind_all(struct device *master_dev, void *data)
 
 	return ret;
 }
-EXPORT_SYMBOL_GPL(component_bind_all);
+EXPORT_SYMBOL_GPL(component_bind_all_or_cleanup);
 
 static int __component_add(struct device *dev, const struct component_ops *ops,
 	int subcomponent)
diff --git a/include/linux/component.h b/include/linux/component.h
index 16de18f473d7..1a5c7b772de3 100644
--- a/include/linux/component.h
+++ b/include/linux/component.h
@@ -38,7 +38,15 @@ int component_add_typed(struct device *dev, const struct component_ops *ops,
 	int subcomponent);
 void component_del(struct device *, const struct component_ops *);
 
-int component_bind_all(struct device *master, void *master_data);
+int component_bind_all_or_cleanup(struct device *master,
+				  void *master_data,
+				  void (*cleanup)(void *data));
+
+static inline int component_bind_all(struct device *master, void *master_data)
+{
+	return component_bind_all_or_cleanup(master, master_data, NULL);
+}
+
 void component_unbind_all(struct device *master, void *master_data);
 
 struct master;
-- 
2.25.0

