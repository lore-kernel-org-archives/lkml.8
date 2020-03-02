Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 182F5C3F2DC
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 08:17:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C52CF246B6
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 08:17:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583137022;
	bh=qb0QCd39Wo7QeZK9RU8cjFB2UYuizkJIFiPvTDnQ8f4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=rJCpiZIj6voMq5M8dSEsUOm0rLrYp3Ww50nUAzOgA7xEnz3HxR59X0ljlhuHRCqds
	 ZLirmXIaGji8vOZ+hSidVQdEg433qid2WXxRBzE6q4uPZCR0vzRFzVcBiMuusjI39r
	 g6bzM7iTn1PoFgU9yyWuzFsJc7xTA03YsVEHqqbc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727084AbgCBIRA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 03:17:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:57202 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727347AbgCBIQY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 03:16:24 -0500
Received: from mail.kernel.org (ip5f5ad4e9.dynamic.kabel-deutschland.de [95.90.212.233])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 99D08246F2;
        Mon,  2 Mar 2020 08:16:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583136979;
        bh=qb0QCd39Wo7QeZK9RU8cjFB2UYuizkJIFiPvTDnQ8f4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yODMVuHvE67S8WIzqFepZZ+zYRG4uX8ZbZOehIWAqxQc0OcZO3AyARgngmkSBGZuW
         piSx5Dfm/hYwqaS8iGKIUywg+LcAjrXcRsOvZ45Ls7OAimo+qnFnVJUkOcP2uaUDpN
         5Rxo2wru/eCcaRJYecErvkT91w5EwpwgB45xTzFg=
Received: from mchehab by mail.kernel.org with local (Exim 4.92.3)
        (envelope-from <mchehab@kernel.org>)
        id 1j8gFN-0003yt-PA; Mon, 02 Mar 2020 09:16:17 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH 29/42] docs: scsi: convert scsi_fc_transport.txt to ReST
Date:   Mon,  2 Mar 2020 09:16:02 +0100
Message-Id: <f75bd9b6512f223847cc4ece8bd7e8e72e434b21.1583136624.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <cover.1583136624.git.mchehab+huawei@kernel.org>
References: <cover.1583136624.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/scsi/index.rst                  |   1 +
 ...fc_transport.txt => scsi_fc_transport.rst} | 236 +++++++++++-------
 2 files changed, 151 insertions(+), 86 deletions(-)
 rename Documentation/scsi/{scsi_fc_transport.txt => scsi_fc_transport.rst} (74%)

diff --git a/Documentation/scsi/index.rst b/Documentation/scsi/index.rst
index 8da7c27f73b7..471982ef461d 100644
--- a/Documentation/scsi/index.rst
+++ b/Documentation/scsi/index.rst
@@ -33,5 +33,6 @@ Linux SCSI Subsystem
    qlogicfas
    scsi-changer
    scsi_eh
+   scsi_fc_transport
 
    scsi_transport_srp/figures
diff --git a/Documentation/scsi/scsi_fc_transport.txt b/Documentation/scsi/scsi_fc_transport.rst
similarity index 74%
rename from Documentation/scsi/scsi_fc_transport.txt
rename to Documentation/scsi/scsi_fc_transport.rst
index f79282fc48d7..176c1862cb9b 100644
--- a/Documentation/scsi/scsi_fc_transport.txt
+++ b/Documentation/scsi/scsi_fc_transport.rst
@@ -1,8 +1,13 @@
-                             SCSI FC Tansport
-                 =============================================
+.. SPDX-License-Identifier: GPL-2.0
+
+================
+SCSI FC Tansport
+================
 
 Date:  11/18/2008
-Kernel Revisions for features:
+
+Kernel Revisions for features::
+
   rports : <<TBS>>
   vports : 2.6.22
   bsg support : 2.6.30 (?TBD?)
@@ -12,25 +17,27 @@ Introduction
 ============
 This file documents the features and components of the SCSI FC Transport.
 It also provides documents the API between the transport and FC LLDDs.
-The FC transport can be found at:
+
+The FC transport can be found at::
+
   drivers/scsi/scsi_transport_fc.c
   include/scsi/scsi_transport_fc.h
   include/scsi/scsi_netlink_fc.h
   include/scsi/scsi_bsg_fc.h
 
-This file is found at Documentation/scsi/scsi_fc_transport.txt
+This file is found at Documentation/scsi/scsi_fc_transport.rst
 
 
 FC Remote Ports (rports)
-========================================================================
+========================
 << To Be Supplied >>
 
 
 FC Virtual Ports (vports)
-========================================================================
+=========================
 
-Overview:
--------------------------------
+Overview
+--------
 
   New FC standards have defined mechanisms which allows for a single physical
   port to appear on as multiple communication ports. Using the N_Port Id
@@ -61,12 +68,14 @@ Overview:
   Thus, whether a FC port is based on a physical port or on a virtual port,
   each will appear as a unique scsi_host with its own target and lun space.
 
-  Note: At this time, the transport is written to create only NPIV-based
+  .. Note::
+    At this time, the transport is written to create only NPIV-based
     vports. However, consideration was given to VF-based vports and it
     should be a minor change to add support if needed.  The remaining
     discussion will concentrate on NPIV.
 
-  Note: World Wide Name assignment (and uniqueness guarantees) are left
+  .. Note::
+    World Wide Name assignment (and uniqueness guarantees) are left
     up to an administrative entity controlling the vport. For example,
     if vports are to be associated with virtual machines, a XEN mgmt
     utility would be responsible for creating wwpn/wwnn's for the vport,
@@ -91,18 +100,29 @@ Device Trees and Vport Objects:
   port's scsi_host.
 
   Here's what to expect in the device tree :
-   The typical Physical Port's Scsi_Host:
+
+   The typical Physical Port's Scsi_Host::
+
      /sys/devices/.../host17/
-   and it has the typical descendant tree:
+
+   and it has the typical descendant tree::
+
      /sys/devices/.../host17/rport-17:0-0/target17:0:0/17:0:0:0:
-   and then the vport is created on the Physical Port:
+
+   and then the vport is created on the Physical Port::
+
      /sys/devices/.../host17/vport-17:0-0
-   and the vport's Scsi_Host is then created:
+
+   and the vport's Scsi_Host is then created::
+
      /sys/devices/.../host17/vport-17:0-0/host18
-   and then the rest of the tree progresses, such as:
+
+   and then the rest of the tree progresses, such as::
+
      /sys/devices/.../host17/vport-17:0-0/host18/rport-18:0-0/target18:0:0/18:0:0:0:
 
-  Here's what to expect in the sysfs tree :
+  Here's what to expect in the sysfs tree::
+
    scsi_hosts:
      /sys/class/scsi_host/host17                physical port's scsi_host
      /sys/class/scsi_host/host18                vport's scsi_host
@@ -116,8 +136,8 @@ Device Trees and Vport Objects:
      /sys/class/fc_remote_ports/rport-18:0-0    rport on the vport
 
 
-Vport Attributes:
--------------------------------
+Vport Attributes
+----------------
 
   The new fc_vport class object has the following attributes
 
@@ -184,16 +204,18 @@ Vport Attributes:
         (e.g. 0x, x, etc).
 
 
-Vport States:
--------------------------------
+Vport States
+------------
 
   Vport instantiation consists of two parts:
+
     - Creation with the kernel and LLDD. This means all transport and
       driver data structures are built up, and device objects created.
       This is equivalent to a driver "attach" on an adapter, which is
       independent of the adapter's link state.
     - Instantiation of the vport on the FC link via ELS traffic, etc.
       This is equivalent to a "link up" and successful link initialization.
+
   Further information can be found in the interfaces section below for
   Vport Creation.
 
@@ -227,6 +249,7 @@ Vport States:
     FC_VPORT_NO_FABRIC_SUPP     - No Fabric Support
       The vport is not operational. One of the following conditions were
       encountered:
+
        - The FC topology is not Point-to-Point
        - The FC port is not connected to an F_Port
        - The F_Port has indicated that NPIV is not supported.
@@ -251,32 +274,53 @@ Vport States:
 
   The following state table indicates the different state transitions:
 
-    State              Event                            New State
-    --------------------------------------------------------------------
-     n/a                Initialization                  Unknown
-    Unknown:            Link Down                       Linkdown
-                        Link Up & Loop                  No Fabric Support
-                        Link Up & no Fabric             No Fabric Support
-                        Link Up & FLOGI response        No Fabric Support
-                          indicates no NPIV support
-                        Link Up & FDISC being sent      Initializing
-                        Disable request                 Disable
-    Linkdown:           Link Up                         Unknown
-    Initializing:       FDISC ACC                       Active
-                        FDISC LS_RJT w/ no resources    No Fabric Resources
-                        FDISC LS_RJT w/ invalid         Fabric Rejected WWN
-                          pname or invalid nport_id
-                        FDISC LS_RJT failed for         Vport Failed
-                          other reasons
-                        Link Down                       Linkdown
-                        Disable request                 Disable
-    Disable:            Enable request                  Unknown
-    Active:             LOGO received from fabric       Fabric Logout
-                        Link Down                       Linkdown
-                        Disable request                 Disable
-    Fabric Logout:      Link still up                   Unknown
+   +------------------+--------------------------------+---------------------+
+   | State            | Event                          | New State           |
+   +==================+================================+=====================+
+   | n/a              | Initialization                 | Unknown             |
+   +------------------+--------------------------------+---------------------+
+   | Unknown:         | Link Down                      | Linkdown            |
+   |                  +--------------------------------+---------------------+
+   |                  | Link Up & Loop                 | No Fabric Support   |
+   |                  +--------------------------------+---------------------+
+   |                  | Link Up & no Fabric            | No Fabric Support   |
+   |                  +--------------------------------+---------------------+
+   |                  | Link Up & FLOGI response       | No Fabric Support   |
+   |                  | indicates no NPIV support      |                     |
+   |                  +--------------------------------+---------------------+
+   |                  | Link Up & FDISC being sent     | Initializing        |
+   |                  +--------------------------------+---------------------+
+   |                  | Disable request                | Disable             |
+   +------------------+--------------------------------+---------------------+
+   | Linkdown:        | Link Up                        | Unknown             |
+   +------------------+--------------------------------+---------------------+
+   | Initializing:    | FDISC ACC                      | Active              |
+   |                  +--------------------------------+---------------------+
+   |                  | FDISC LS_RJT w/ no resources   | No Fabric Resources |
+   |                  +--------------------------------+---------------------+
+   |                  | FDISC LS_RJT w/ invalid        | Fabric Rejected WWN |
+   |		      | pname or invalid nport_id      |                     |
+   |                  +--------------------------------+---------------------+
+   |                  | FDISC LS_RJT failed for        | Vport Failed        |
+   |                  | other reasons                  |                     |
+   |                  +--------------------------------+---------------------+
+   |                  | Link Down                      | Linkdown            |
+   |                  +--------------------------------+---------------------+
+   |                  | Disable request                | Disable             |
+   +------------------+--------------------------------+---------------------+
+   | Disable:         | Enable request                 | Unknown             |
+   +------------------+--------------------------------+---------------------+
+   | Active:          | LOGO received from fabric      | Fabric Logout       |
+   |                  +--------------------------------+---------------------+
+   |                  | Link Down                      | Linkdown            |
+   |                  +--------------------------------+---------------------+
+   |                  | Disable request                | Disable             |
+   +------------------+--------------------------------+---------------------+
+   | Fabric Logout:   | Link still up                  | Unknown             |
+   +------------------+--------------------------------+---------------------+
+
+The following 4 error states all have the same transitions::
 
-         The following 4 error states all have the same transitions:
     No Fabric Support:
     No Fabric Resources:
     Fabric Rejected WWN:
@@ -285,8 +329,8 @@ Vport States:
                         Link goes down                  Linkdown
 
 
-Transport <-> LLDD Interfaces :
--------------------------------
+Transport <-> LLDD Interfaces
+-----------------------------
 
 Vport support by LLDD:
 
@@ -300,14 +344,17 @@ Vport support by LLDD:
 
 Vport Creation:
 
-  The LLDD vport_create() syntax is:
+  The LLDD vport_create() syntax is::
 
       int vport_create(struct fc_vport *vport, bool disable)
 
-    where:
-      vport:    Is the newly allocated vport object
-      disable:  If "true", the vport is to be created in a disabled stated.
+  where:
+
+      =======   ===========================================================
+      vport     Is the newly allocated vport object
+      disable   If "true", the vport is to be created in a disabled stated.
                 If "false", the vport is to be enabled upon creation.
+      =======   ===========================================================
 
   When a request is made to create a new vport (via sgio/netlink, or the
   vport_create fc_host attribute), the transport will validate that the LLDD
@@ -317,6 +364,7 @@ Vport Creation:
   LLDD's vport_create() function with the newly allocated vport object.
 
   As mentioned above, vport creation is divided into two parts:
+
     - Creation with the kernel and LLDD. This means all transport and
       driver data structures are built up, and device objects created.
       This is equivalent to a driver "attach" on an adapter, which is
@@ -329,6 +377,7 @@ Vport Creation:
   infrastructure exists to support NPIV, and complete the first part of
   vport creation (data structure build up) before returning.  We do not
   hinge vport_create() on the link-side operation mainly because:
+
     - The link may be down. It is not a failure if it is. It simply
       means the vport is in an inoperable state until the link comes up.
       This is consistent with the link bouncing post vport creation.
@@ -337,11 +386,15 @@ Vport Creation:
       FC adapter. The vport_create is synonymous with driver attachment
       to the adapter, which is independent of link state.
 
-    Note: special error codes have been defined to delineate infrastructure
+  .. Note::
+
+      special error codes have been defined to delineate infrastructure
       failure cases for quicker resolution.
 
   The expected behavior for the LLDD's vport_create() function is:
+
     - Validate Infrastructure:
+
         - If the driver or adapter cannot support another vport, whether
             due to improper firmware, (a lie about) max_npiv, or a lack of
             some other resource - return VPCERR_UNSUPPORTED.
@@ -349,17 +402,21 @@ Vport Creation:
             the adapter and detects an overlap - return VPCERR_BAD_WWN.
         - If the driver detects the topology is loop, non-fabric, or the
             FLOGI did not support NPIV - return VPCERR_NO_FABRIC_SUPP.
+
     - Allocate data structures. If errors are encountered, such as out
         of memory conditions, return the respective negative Exxx error code.
     - If the role is FCP Initiator, the LLDD is to :
+
         - Call scsi_host_alloc() to allocate a scsi_host for the vport.
         - Call scsi_add_host(new_shost, &vport->dev) to start the scsi_host
           and bind it as a child of the vport device.
         - Initializes the fc_host attribute values.
+
     - Kick of further vport state transitions based on the disable flag and
         link state - and return success (zero).
 
   LLDD Implementers Notes:
+
   - It is suggested that there be a different fc_function_templates for
     the physical port and the virtual port.  The physical port's template
     would have the vport_create, vport_delete, and vport_disable functions,
@@ -373,14 +430,17 @@ Vport Creation:
 
 Vport Disable/Enable:
 
-  The LLDD vport_disable() syntax is:
+  The LLDD vport_disable() syntax is::
 
       int vport_disable(struct fc_vport *vport, bool disable)
 
-    where:
-      vport:    Is vport to be enabled or disabled
-      disable:  If "true", the vport is to be disabled.
+  where:
+
+      =======   =======================================
+      vport     Is vport to be enabled or disabled
+      disable   If "true", the vport is to be disabled.
                 If "false", the vport is to be enabled.
+      =======   =======================================
 
   When a request is made to change the disabled state on a vport, the
   transport will validate the request against the existing vport state.
@@ -401,11 +461,12 @@ Vport Disable/Enable:
 
 Vport Deletion:
 
-  The LLDD vport_delete() syntax is:
+  The LLDD vport_delete() syntax is::
 
       int vport_delete(struct fc_vport *vport)
 
-    where:
+  where:
+
       vport:    Is vport to delete
 
   When a request is made to delete a vport (via sgio/netlink, or via the
@@ -443,39 +504,42 @@ Transport supplied functions
 
 The following functions are supplied by the FC-transport for use by LLDs.
 
-   fc_vport_create - create a vport
-   fc_vport_terminate - detach and remove a vport
+   ==================   =========================
+   fc_vport_create      create a vport
+   fc_vport_terminate   detach and remove a vport
+   ==================   =========================
 
-Details:
+Details::
 
-/**
- * fc_vport_create - Admin App or LLDD requests creation of a vport
- * @shost:     scsi host the virtual port is connected to.
- * @ids:       The world wide names, FC4 port roles, etc for
- *              the virtual port.
- *
- * Notes:
- *     This routine assumes no locks are held on entry.
- */
-struct fc_vport *
-fc_vport_create(struct Scsi_Host *shost, struct fc_vport_identifiers *ids)
+    /**
+    * fc_vport_create - Admin App or LLDD requests creation of a vport
+    * @shost:     scsi host the virtual port is connected to.
+    * @ids:       The world wide names, FC4 port roles, etc for
+    *              the virtual port.
+    *
+    * Notes:
+    *     This routine assumes no locks are held on entry.
+    */
+    struct fc_vport *
+    fc_vport_create(struct Scsi_Host *shost, struct fc_vport_identifiers *ids)
 
-/**
- * fc_vport_terminate - Admin App or LLDD requests termination of a vport
- * @vport:      fc_vport to be terminated
- *
- * Calls the LLDD vport_delete() function, then deallocates and removes
- * the vport from the shost and object tree.
- *
- * Notes:
- *      This routine assumes no locks are held on entry.
- */
-int
-fc_vport_terminate(struct fc_vport *vport)
+    /**
+    * fc_vport_terminate - Admin App or LLDD requests termination of a vport
+    * @vport:      fc_vport to be terminated
+    *
+    * Calls the LLDD vport_delete() function, then deallocates and removes
+    * the vport from the shost and object tree.
+    *
+    * Notes:
+    *      This routine assumes no locks are held on entry.
+    */
+    int
+    fc_vport_terminate(struct fc_vport *vport)
 
 
 FC BSG support (CT & ELS passthru, and more)
-========================================================================
+============================================
+
 << To Be Supplied >>
 
 
-- 
2.21.1

