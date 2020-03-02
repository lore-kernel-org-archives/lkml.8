Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2839FC3F2D7
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 22:40:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0515720848
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 22:40:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726928AbgCBWkK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 17:40:10 -0500
Received: from ms.lwn.net ([45.79.88.28]:59674 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726783AbgCBWkJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 17:40:09 -0500
Received: from meer.lwn.net (localhost [127.0.0.1])
        by ms.lwn.net (Postfix) with ESMTPA id B77912E4;
        Mon,  2 Mar 2020 22:40:08 +0000 (UTC)
From:   Jonathan Corbet <corbet@lwn.net>
To:     linux-kernel@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-doc@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH 1/3] docs: Organize core-api/index.rst
Date:   Mon,  2 Mar 2020 15:39:55 -0700
Message-Id: <20200302223957.905473-2-corbet@lwn.net>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200302223957.905473-1-corbet@lwn.net>
References: <20200302223957.905473-1-corbet@lwn.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The core-api manual has become a big, disorganized mess.  Try to bring a
small amount of order to it by organizing the documents into
subcategories.

Signed-off-by: Jonathan Corbet <corbet@lwn.net>
---
 Documentation/core-api/index.rst | 95 ++++++++++++++++++++++++--------
 1 file changed, 73 insertions(+), 22 deletions(-)

diff --git a/Documentation/core-api/index.rst b/Documentation/core-api/index.rst
index d02b26917931..b39dae276b57 100644
--- a/Documentation/core-api/index.rst
+++ b/Documentation/core-api/index.rst
@@ -8,42 +8,81 @@ This is the beginning of a manual for core kernel APIs.  The conversion
 Core utilities
 ==============
 
+This section has general and "core core" documentation.  The first is a
+massive grab-bag of kerneldoc info left over from the docbook days; it
+should really be broken up someday when somebody finds the energy to do
+it.
+
 .. toctree::
    :maxdepth: 1
 
    kernel-api
+   workqueue
+   printk-formats
+   symbol-namespaces
+
+Data structures and low-level utilities
+=======================================
+
+Library functionality that is used throughout the kernel.
+
+.. toctree::
+   :maxdepth: 1
+
    kobject
    assoc_array
+   xarray
+   idr
+   circular-buffers
+   generic-radix-tree
+   packing
+   timekeeping
+   errseq
+
+Concurrency primitives
+======================
+
+How Linux keeps everything from happening at the same time.  See
+:doc:`/locking/index` for more related documentation.
+
+.. toctree::
+   :maxdepth: 1
+
    atomic_ops
-   cachetlb
    refcount-vs-atomic
-   cpu_hotplug
-   idr
    local_ops
-   workqueue
+   padata
+   ../RCU/index
+
+Low-level hardware management
+=============================
+
+Cache management, managing CPU hotplug, etc.
+
+.. toctree::
+   :maxdepth: 1
+
+   cachetlb
+   cpu_hotplug
+   memory-hotplug
    genericirq
-   xarray
-   librs
-   genalloc
-   errseq
-   packing
-   printk-formats
-   circular-buffers
-   generic-radix-tree
+   protection-keys
+
+Memory management
+=================
+
+How to allocate and use memory in the kernel.  Note that there is a lot
+more memory-management documentation in :doc:`/vm/index`.
+
+.. toctree::
+   :maxdepth: 1
+
    memory-allocation
    mm-api
+   genalloc
    pin_user_pages
-   gfp_mask-from-fs-io
-   timekeeping
    boot-time-mm
-   memory-hotplug
-   protection-keys
-   ../RCU/index
-   gcc-plugins
-   symbol-namespaces
-   padata
-   ioctl
-
+   gfp_mask-from-fs-io
 
 Interfaces for kernel debugging
 ===============================
@@ -54,6 +93,18 @@ Interfaces for kernel debugging
    debug-objects
    tracepoint
 
+Everything else
+===============
+
+Documents that don't fit elsewhere or which have yet to be categorized.
+
+.. toctree::
+   :maxdepth: 1
+
+   librs
+   gcc-plugins
+   ioctl
+
 .. only:: subproject and html
 
    Indices
-- 
2.24.1

