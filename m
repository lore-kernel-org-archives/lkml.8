Return-Path: <SRS0=gmpU=CI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17963C433E6
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Aug 2020 15:29:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF70820738
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Aug 2020 15:29:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727799AbgH3P3V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Aug 2020 11:29:21 -0400
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:42779 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726771AbgH3P2C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Aug 2020 11:28:02 -0400
Received: from Internal Mail-Server by MTLPINE1 (envelope-from moshe@mellanox.com)
        with SMTP; 30 Aug 2020 18:27:57 +0300
Received: from dev-l-vrt-135.mtl.labs.mlnx (dev-l-vrt-135.mtl.labs.mlnx [10.234.135.1])
        by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id 07UFRvvG029680;
        Sun, 30 Aug 2020 18:27:57 +0300
Received: from dev-l-vrt-135.mtl.labs.mlnx (localhost [127.0.0.1])
        by dev-l-vrt-135.mtl.labs.mlnx (8.15.2/8.15.2/Debian-10) with ESMTP id 07UFRv05027857;
        Sun, 30 Aug 2020 18:27:57 +0300
Received: (from moshe@localhost)
        by dev-l-vrt-135.mtl.labs.mlnx (8.15.2/8.15.2/Submit) id 07UFRvd1027856;
        Sun, 30 Aug 2020 18:27:57 +0300
From:   Moshe Shemesh <moshe@mellanox.com>
To:     "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>
Cc:     Jiri Pirko <jiri@mellanox.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Moshe Shemesh <moshe@mellanox.com>
Subject: [PATCH net-next RFC v3 14/14] devlink: Add Documentation/networking/devlink/devlink-reload.rst
Date:   Sun, 30 Aug 2020 18:27:34 +0300
Message-Id: <1598801254-27764-15-git-send-email-moshe@mellanox.com>
X-Mailer: git-send-email 1.8.4.3
In-Reply-To: <1598801254-27764-1-git-send-email-moshe@mellanox.com>
References: <1598801254-27764-1-git-send-email-moshe@mellanox.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add devlink reload rst documentation file.
Update index file to include it.

Signed-off-by: Moshe Shemesh <moshe@mellanox.com>
---
v2 -> v3:
- Devlink reload returns the actions done
- Replace fw_live_patch action by fw_activate_no_reset
- Explain fw_activate meaning
v1 -> v2:
- Instead of reload levels driver,fw_reset,fw_live_patch have reload
  actions driver_reinit,fw_activate,fw_live_patch
---
 .../networking/devlink/devlink-reload.rst     | 68 +++++++++++++++++++
 Documentation/networking/devlink/index.rst    |  1 +
 2 files changed, 69 insertions(+)
 create mode 100644 Documentation/networking/devlink/devlink-reload.rst

diff --git a/Documentation/networking/devlink/devlink-reload.rst b/Documentation/networking/devlink/devlink-reload.rst
new file mode 100644
index 000000000000..44a18692bddd
--- /dev/null
+++ b/Documentation/networking/devlink/devlink-reload.rst
@@ -0,0 +1,68 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+==============
+Devlink Reload
+==============
+
+``devlink-reload`` provides mechanism to either reload driver entities,
+applying ``devlink-params`` and ``devlink-resources`` new values or firmware
+activation depends on reload action selected.
+
+Reload actions
+==============
+
+User may select a reload action.
+By default ``driver_reinit`` action is done.
+
+.. list-table:: Possible reload levels
+   :widths: 5 90
+
+   * - Name
+     - Description
+   * - ``driver-reinit``
+     - Devlink driver entities re-initialization, including applying
+       new values to devlink entities which are used during driver
+       load such as ``devlink-params`` in configuration mode
+       ``driverinit`` or ``devlink-resources``
+   * - ``fw_activate``
+     - Firmware activate. Activates new firmware if such image is stored and
+       pending activation. This action involves firmware reset, if no new image
+       pending this action will reload current firmware image.
+   * - ``fw_activate_no_reset``
+     - Activate new firmware image without firmware reset or reload.
+       This action is also known as live patch, applying firmware changes
+       without reset.
+
+Note that when required to do firmware activation some drivers may need
+to reload the driver. On the other hand some drivers may need to reset
+the firmware to reinitialize the driver entities. Therefore, the devlink
+reload command returns the actions which were actually done.
+However, in case fw_activate_no_reset action is selected, then no other
+reload action is allowed.
+
+Change namespace
+================
+
+All devlink instances are created in init_net and stay there for a
+lifetime. Allow user to be able to move devlink instances into
+namespaces during devlink reload operation. That ensures proper
+re-instantiation of driver objects, including netdevices.
+
+example usage
+-------------
+
+.. code:: shell
+
+    $ devlink dev reload help
+    $ devlink dev reload DEV [ netns { PID | NAME | ID } ] [ action { driver_reinit | fw_activate [no_reset] } ]
+
+    # Run reload command for devlink driver entities re-initialization:
+    $ devlink dev reload pci/0000:82:00.0 action driver_reinit
+    reload_actions_done:
+      driver_reinit
+
+    # Run reload command to activate firmware:
+    $ devlink dev reload pci/0000:82:00.0 action fw_activate
+    reload_actions_done:
+      driver_reinit fw_activate
+    # Note that the driver in this example reloads the driver while activating firmware
diff --git a/Documentation/networking/devlink/index.rst b/Documentation/networking/devlink/index.rst
index 7684ae5c4a4a..d82874760ae2 100644
--- a/Documentation/networking/devlink/index.rst
+++ b/Documentation/networking/devlink/index.rst
@@ -20,6 +20,7 @@ general.
    devlink-params
    devlink-region
    devlink-resource
+   devlink-reload
    devlink-trap
 
 Driver-specific documentation
-- 
2.17.1

