Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5325C3F2D1
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 08:17:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78D772468E
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 08:17:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583137069;
	bh=NWSpKgMqGn7uoBQa4zj8oIZXn9Fl+xsJhW43vwu7Zq0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=q5s1KQFHCnpDsNipMlgt/acA9ciBvgHcTwI+2v1X3/8GygusguBOITH2hlwP7v9GB
	 iDXGXA3tMVy/nY1dhn7ZlB68TC67RQffpen3pc65IyePnf7xlxOe1bkvrAruzbya+Q
	 INF7vNXdE2qc3clUgtM6PJk+voG5PFB0d0VucZJI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727715AbgCBIRs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 03:17:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:57148 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727213AbgCBIQW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 03:16:22 -0500
Received: from mail.kernel.org (ip5f5ad4e9.dynamic.kabel-deutschland.de [95.90.212.233])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4DF6B246D8;
        Mon,  2 Mar 2020 08:16:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583136979;
        bh=NWSpKgMqGn7uoBQa4zj8oIZXn9Fl+xsJhW43vwu7Zq0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AnBydHehmbluiDcq7uj1QQBkZlWHyuk87DH1lJFkqo1Nb6256drehAP3DwcMdMMp2
         SRYI9pwTqZTZtmgBDtldRvVBmApPSw8rnLuRzF6WswegCfMwftpVDyGUVjY3d3IgEy
         phsw5/oc+CYuEEexBhYme3HqIYk93/GY+2diveLQ=
Received: from mchehab by mail.kernel.org with local (Exim 4.92.3)
        (envelope-from <mchehab@kernel.org>)
        id 1j8gFN-0003y4-Go; Mon, 02 Mar 2020 09:16:17 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH 19/42] docs: scsi: convert libsas.txt to ReST
Date:   Mon,  2 Mar 2020 09:15:52 +0100
Message-Id: <9022cb5551487f774cab16a828fe06b0b6b3add3.1583136624.git.mchehab+huawei@kernel.org>
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
 Documentation/scsi/{libsas.txt => libsas.rst} | 364 +++++++++++-------
 2 files changed, 218 insertions(+), 147 deletions(-)
 rename Documentation/scsi/{libsas.txt => libsas.rst} (57%)

diff --git a/Documentation/scsi/index.rst b/Documentation/scsi/index.rst
index b13df9c1810a..e6850c0a1378 100644
--- a/Documentation/scsi/index.rst
+++ b/Documentation/scsi/index.rst
@@ -23,5 +23,6 @@ Linux SCSI Subsystem
    g_NCR5380
    hpsa
    hptiop
+   libsas
 
    scsi_transport_srp/figures
diff --git a/Documentation/scsi/libsas.txt b/Documentation/scsi/libsas.rst
similarity index 57%
rename from Documentation/scsi/libsas.txt
rename to Documentation/scsi/libsas.rst
index 8cac6492aade..7216b5d25800 100644
--- a/Documentation/scsi/libsas.txt
+++ b/Documentation/scsi/libsas.rst
@@ -1,5 +1,8 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=========
 SAS Layer
----------
+=========
 
 The SAS Layer is a management infrastructure which manages
 SAS LLDDs.  It sits between SCSI Core and SAS LLDDs.  The
@@ -37,16 +40,21 @@ It will then return.  Then you enable your phys to actually
 start OOB (at which point your driver will start calling the
 notify_* event callbacks).
 
-Structure descriptions:
+Structure descriptions
+======================
+
+``struct sas_phy``
+------------------
 
-struct sas_phy --------------------
 Normally this is statically embedded to your driver's
-phy structure:
-	struct my_phy {
-	       blah;
-	       struct sas_phy sas_phy;
-	       bleh;
-	};
+phy structure::
+
+    struct my_phy {
+	    blah;
+	    struct sas_phy sas_phy;
+	    bleh;
+    };
+
 And then all the phys are an array of my_phy in your HA
 struct (shown below).
 
@@ -63,94 +71,122 @@ There is a scheme where the LLDD can RW certain fields,
 and the SAS layer can only read such ones, and vice versa.
 The idea is to avoid unnecessary locking.
 
-enabled -- must be set (0/1)
-id -- must be set [0,MAX_PHYS)
-class, proto, type, role, oob_mode, linkrate -- must be set
-oob_mode --  you set this when OOB has finished and then notify
-the SAS Layer.
-
-sas_addr -- this normally points to an array holding the sas
-address of the phy, possibly somewhere in your my_phy
-struct.
-
-attached_sas_addr -- set this when you (LLDD) receive an
-IDENTIFY frame or a FIS frame, _before_ notifying the SAS
-layer.  The idea is that sometimes the LLDD may want to fake
-or provide a different SAS address on that phy/port and this
-allows it to do this.  At best you should copy the sas
-address from the IDENTIFY frame or maybe generate a SAS
-address for SATA directly attached devices.  The Discover
-process may later change this.
-
-frame_rcvd -- this is where you copy the IDENTIFY/FIS frame
-when you get it; you lock, copy, set frame_rcvd_size and
-unlock the lock, and then call the event.  It is a pointer
-since there's no way to know your hw frame size _exactly_,
-so you define the actual array in your phy struct and let
-this pointer point to it.  You copy the frame from your
-DMAable memory to that area holding the lock.
-
-sas_prim -- this is where primitives go when they're
-received.  See sas.h. Grab the lock, set the primitive,
-release the lock, notify.
-
-port -- this points to the sas_port if the phy belongs
-to a port -- the LLDD only reads this. It points to the
-sas_port this phy is part of.  Set by the SAS Layer.
-
-ha -- may be set; the SAS layer sets it anyway.
-
-lldd_phy -- you should set this to point to your phy so you
-can find your way around faster when the SAS layer calls one
-of your callbacks and passes you a phy.  If the sas_phy is
-embedded you can also use container_of -- whatever you
-prefer.
-
-
-struct sas_port --------------------
+enabled
+    - must be set (0/1)
+
+id
+    - must be set [0,MAX_PHYS)]
+
+class, proto, type, role, oob_mode, linkrate
+    - must be set
+
+oob_mode
+    - you set this when OOB has finished and then notify
+      the SAS Layer.
+
+sas_addr
+    - this normally points to an array holding the sas
+      address of the phy, possibly somewhere in your my_phy
+      struct.
+
+attached_sas_addr
+    - set this when you (LLDD) receive an
+      IDENTIFY frame or a FIS frame, _before_ notifying the SAS
+      layer.  The idea is that sometimes the LLDD may want to fake
+      or provide a different SAS address on that phy/port and this
+      allows it to do this.  At best you should copy the sas
+      address from the IDENTIFY frame or maybe generate a SAS
+      address for SATA directly attached devices.  The Discover
+      process may later change this.
+
+frame_rcvd
+    - this is where you copy the IDENTIFY/FIS frame
+      when you get it; you lock, copy, set frame_rcvd_size and
+      unlock the lock, and then call the event.  It is a pointer
+      since there's no way to know your hw frame size _exactly_,
+      so you define the actual array in your phy struct and let
+      this pointer point to it.  You copy the frame from your
+      DMAable memory to that area holding the lock.
+
+sas_prim
+    - this is where primitives go when they're
+      received.  See sas.h. Grab the lock, set the primitive,
+      release the lock, notify.
+
+port
+    - this points to the sas_port if the phy belongs
+      to a port -- the LLDD only reads this. It points to the
+      sas_port this phy is part of.  Set by the SAS Layer.
+
+ha
+    - may be set; the SAS layer sets it anyway.
+
+lldd_phy
+    - you should set this to point to your phy so you
+      can find your way around faster when the SAS layer calls one
+      of your callbacks and passes you a phy.  If the sas_phy is
+      embedded you can also use container_of -- whatever you
+      prefer.
+
+
+``struct sas_port``
+-------------------
+
 The LLDD doesn't set any fields of this struct -- it only
 reads them.  They should be self explanatory.
 
 phy_mask is 32 bit, this should be enough for now, as I
 haven't heard of a HA having more than 8 phys.
 
-lldd_port -- I haven't found use for that -- maybe other
-LLDD who wish to have internal port representation can make
-use of this.
+lldd_port
+    - I haven't found use for that -- maybe other
+      LLDD who wish to have internal port representation can make
+      use of this.
 
+``struct sas_ha_struct``
+------------------------
 
-struct sas_ha_struct --------------------
 It normally is statically declared in your own LLDD
-structure describing your adapter:
-struct my_sas_ha {
-       blah;
-       struct sas_ha_struct sas_ha;
-       struct my_phy phys[MAX_PHYS];
-       struct sas_port sas_ports[MAX_PHYS]; /* (1) */
-       bleh;
-};
+structure describing your adapter::
 
-(1) If your LLDD doesn't have its own port representation.
+    struct my_sas_ha {
+	blah;
+	struct sas_ha_struct sas_ha;
+	struct my_phy phys[MAX_PHYS];
+	struct sas_port sas_ports[MAX_PHYS]; /* (1) */
+	bleh;
+    };
+
+    (1) If your LLDD doesn't have its own port representation.
 
 What needs to be initialized (sample function given below).
 
 pcidev
-sas_addr -- since the SAS layer doesn't want to mess with
+^^^^^^
+
+sas_addr
+       - since the SAS layer doesn't want to mess with
 	 memory allocation, etc, this points to statically
 	 allocated array somewhere (say in your host adapter
 	 structure) and holds the SAS address of the host
 	 adapter as given by you or the manufacturer, etc.
+
 sas_port
-sas_phy -- an array of pointers to structures. (see
+^^^^^^^^
+
+sas_phy
+      - an array of pointers to structures. (see
 	note above on sas_addr).
 	These must be set.  See more notes below.
-num_phys -- the number of phys present in the sas_phy array,
+
+num_phys
+       - the number of phys present in the sas_phy array,
 	 and the number of ports present in the sas_port
 	 array.  There can be a maximum num_phys ports (one per
 	 port) so we drop the num_ports, and only use
 	 num_phys.
 
-The event interface:
+The event interface::
 
 	/* LLDD calls these to notify the class of an event. */
 	void (*notify_ha_event)(struct sas_ha_struct *, enum ha_event);
@@ -161,7 +197,7 @@ When sas_register_ha() returns, those are set and can be
 called by the LLDD to notify the SAS layer of such events
 the SAS layer.
 
-The port notification:
+The port notification::
 
 	/* The class calls these to notify the LLDD of an event. */
 	void (*lldd_port_formed)(struct sas_phy *);
@@ -171,7 +207,7 @@ If the LLDD wants notification when a port has been formed
 or deformed it sets those to a function satisfying the type.
 
 A SAS LLDD should also implement at least one of the Task
-Management Functions (TMFs) described in SAM:
+Management Functions (TMFs) described in SAM::
 
 	/* Task Management Functions. Must be called from process context. */
 	int (*lldd_abort_task)(struct sas_task *);
@@ -184,7 +220,7 @@ Management Functions (TMFs) described in SAM:
 
 For more information please read SAM from T10.org.
 
-Port and Adapter management:
+Port and Adapter management::
 
 	/* Port and Adapter management */
 	int (*lldd_clear_nexus_port)(struct sas_port *);
@@ -192,75 +228,78 @@ Port and Adapter management:
 
 A SAS LLDD should implement at least one of those.
 
-Phy management:
+Phy management::
 
 	/* Phy management */
 	int (*lldd_control_phy)(struct sas_phy *, enum phy_func);
 
-lldd_ha -- set this to point to your HA struct. You can also
-use container_of if you embedded it as shown above.
+lldd_ha
+    - set this to point to your HA struct. You can also
+      use container_of if you embedded it as shown above.
 
 A sample initialization and registration function
 can look like this (called last thing from probe())
-*but* before you enable the phys to do OOB:
+*but* before you enable the phys to do OOB::
 
-static int register_sas_ha(struct my_sas_ha *my_ha)
-{
-	int i;
-	static struct sas_phy   *sas_phys[MAX_PHYS];
-	static struct sas_port  *sas_ports[MAX_PHYS];
+    static int register_sas_ha(struct my_sas_ha *my_ha)
+    {
+	    int i;
+	    static struct sas_phy   *sas_phys[MAX_PHYS];
+	    static struct sas_port  *sas_ports[MAX_PHYS];
 
-	my_ha->sas_ha.sas_addr = &my_ha->sas_addr[0];
+	    my_ha->sas_ha.sas_addr = &my_ha->sas_addr[0];
 
-	for (i = 0; i < MAX_PHYS; i++) {
-		sas_phys[i] = &my_ha->phys[i].sas_phy;
-		sas_ports[i] = &my_ha->sas_ports[i];
-	}
+	    for (i = 0; i < MAX_PHYS; i++) {
+		    sas_phys[i] = &my_ha->phys[i].sas_phy;
+		    sas_ports[i] = &my_ha->sas_ports[i];
+	    }
 
-	my_ha->sas_ha.sas_phy  = sas_phys;
-	my_ha->sas_ha.sas_port = sas_ports;
-	my_ha->sas_ha.num_phys = MAX_PHYS;
+	    my_ha->sas_ha.sas_phy  = sas_phys;
+	    my_ha->sas_ha.sas_port = sas_ports;
+	    my_ha->sas_ha.num_phys = MAX_PHYS;
 
-	my_ha->sas_ha.lldd_port_formed = my_port_formed;
+	    my_ha->sas_ha.lldd_port_formed = my_port_formed;
 
-	my_ha->sas_ha.lldd_dev_found = my_dev_found;
-	my_ha->sas_ha.lldd_dev_gone = my_dev_gone;
+	    my_ha->sas_ha.lldd_dev_found = my_dev_found;
+	    my_ha->sas_ha.lldd_dev_gone = my_dev_gone;
 
-	my_ha->sas_ha.lldd_execute_task = my_execute_task;
+	    my_ha->sas_ha.lldd_execute_task = my_execute_task;
 
-	my_ha->sas_ha.lldd_abort_task     = my_abort_task;
-	my_ha->sas_ha.lldd_abort_task_set = my_abort_task_set;
-	my_ha->sas_ha.lldd_clear_aca      = my_clear_aca;
-	my_ha->sas_ha.lldd_clear_task_set = my_clear_task_set;
-	my_ha->sas_ha.lldd_I_T_nexus_reset= NULL; (2)
-	my_ha->sas_ha.lldd_lu_reset       = my_lu_reset;
-	my_ha->sas_ha.lldd_query_task     = my_query_task;
+	    my_ha->sas_ha.lldd_abort_task     = my_abort_task;
+	    my_ha->sas_ha.lldd_abort_task_set = my_abort_task_set;
+	    my_ha->sas_ha.lldd_clear_aca      = my_clear_aca;
+	    my_ha->sas_ha.lldd_clear_task_set = my_clear_task_set;
+	    my_ha->sas_ha.lldd_I_T_nexus_reset= NULL; (2)
+	    my_ha->sas_ha.lldd_lu_reset       = my_lu_reset;
+	    my_ha->sas_ha.lldd_query_task     = my_query_task;
 
-	my_ha->sas_ha.lldd_clear_nexus_port = my_clear_nexus_port;
-	my_ha->sas_ha.lldd_clear_nexus_ha = my_clear_nexus_ha;
+	    my_ha->sas_ha.lldd_clear_nexus_port = my_clear_nexus_port;
+	    my_ha->sas_ha.lldd_clear_nexus_ha = my_clear_nexus_ha;
 
-	my_ha->sas_ha.lldd_control_phy = my_control_phy;
+	    my_ha->sas_ha.lldd_control_phy = my_control_phy;
 
-	return sas_register_ha(&my_ha->sas_ha);
-}
+	    return sas_register_ha(&my_ha->sas_ha);
+    }
 
 (2) SAS 1.1 does not define I_T Nexus Reset TMF.
 
 Events
-------
+======
 
-Events are _the only way_ a SAS LLDD notifies the SAS layer
+Events are **the only way** a SAS LLDD notifies the SAS layer
 of anything.  There is no other method or way a LLDD to tell
 the SAS layer of anything happening internally or in the SAS
 domain.
 
-Phy events:
+Phy events::
+
 	PHYE_LOSS_OF_SIGNAL, (C)
 	PHYE_OOB_DONE,
 	PHYE_OOB_ERROR,      (C)
 	PHYE_SPINUP_HOLD.
 
-Port events, passed on a _phy_:
+Port events, passed on a _phy_::
+
 	PORTE_BYTES_DMAED,      (M)
 	PORTE_BROADCAST_RCVD,   (E)
 	PORTE_LINK_RESET_ERR,   (C)
@@ -271,6 +310,7 @@ Host Adapter event:
 	HAE_RESET
 
 A SAS LLDD should be able to generate
+
 	- at least one event from group C (choice),
 	- events marked M (mandatory) are mandatory (only one),
 	- events marked E (expander) if it wants the SAS layer
@@ -279,26 +319,42 @@ A SAS LLDD should be able to generate
 
 Meaning:
 
-HAE_RESET -- when your HA got internal error and was reset.
-
-PORTE_BYTES_DMAED -- on receiving an IDENTIFY/FIS frame
-PORTE_BROADCAST_RCVD -- on receiving a primitive
-PORTE_LINK_RESET_ERR -- timer expired, loss of signal, loss
-of DWS, etc. (*)
-PORTE_TIMER_EVENT -- DWS reset timeout timer expired (*)
-PORTE_HARD_RESET -- Hard Reset primitive received.
-
-PHYE_LOSS_OF_SIGNAL -- the device is gone (*)
-PHYE_OOB_DONE -- OOB went fine and oob_mode is valid
-PHYE_OOB_ERROR -- Error while doing OOB, the device probably
-got disconnected. (*)
-PHYE_SPINUP_HOLD -- SATA is present, COMWAKE not sent.
-
-(*) should set/clear the appropriate fields in the phy,
-    or alternatively call the inlined sas_phy_disconnected()
-    which is just a helper, from their tasklet.
-
-The Execute Command SCSI RPC:
+HAE_RESET
+    - when your HA got internal error and was reset.
+
+PORTE_BYTES_DMAED
+    - on receiving an IDENTIFY/FIS frame
+
+PORTE_BROADCAST_RCVD
+    - on receiving a primitive
+
+PORTE_LINK_RESET_ERR
+    - timer expired, loss of signal, loss of DWS, etc. [1]_
+
+PORTE_TIMER_EVENT
+    - DWS reset timeout timer expired [1]_
+
+PORTE_HARD_RESET
+    - Hard Reset primitive received.
+
+PHYE_LOSS_OF_SIGNAL
+    - the device is gone [1]_
+
+PHYE_OOB_DONE
+    - OOB went fine and oob_mode is valid
+
+PHYE_OOB_ERROR
+    - Error while doing OOB, the device probably
+      got disconnected. [1]_
+
+PHYE_SPINUP_HOLD
+    - SATA is present, COMWAKE not sent.
+
+.. [1] should set/clear the appropriate fields in the phy,
+       or alternatively call the inlined sas_phy_disconnected()
+       which is just a helper, from their tasklet.
+
+The Execute Command SCSI RPC::
 
 	int (*lldd_execute_task)(struct sas_task *, gfp_t gfp_flags);
 
@@ -311,23 +367,28 @@ That is, when lldd_execute_task() is called, the command
 go out on the transport *immediately*.  There is *no*
 queuing of any sort and at any level in a SAS LLDD.
 
-Returns: -SAS_QUEUE_FULL, -ENOMEM, nothing was queued;
-	 0, the task(s) were queued.
-
-struct sas_task {
-	dev -- the device this task is destined to
-	task_proto -- _one_ of enum sas_proto
-	scatter -- pointer to scatter gather list array
-	num_scatter -- number of elements in scatter
-	total_xfer_len -- total number of bytes expected to be transferred
-	data_dir -- PCI_DMA_...
-	task_done -- callback when the task has finished execution
-};
-
-DISCOVERY
----------
+Returns:
+
+   * -SAS_QUEUE_FULL, -ENOMEM, nothing was queued;
+   * 0, the task(s) were queued.
+
+::
+
+    struct sas_task {
+	    dev -- the device this task is destined to
+	    task_proto -- _one_ of enum sas_proto
+	    scatter -- pointer to scatter gather list array
+	    num_scatter -- number of elements in scatter
+	    total_xfer_len -- total number of bytes expected to be transferred
+	    data_dir -- PCI_DMA_...
+	    task_done -- callback when the task has finished execution
+    };
+
+Discovery
+=========
 
 The sysfs tree has the following purposes:
+
     a) It shows you the physical layout of the SAS domain at
        the current time, i.e. how the domain looks in the
        physical world right now.
@@ -336,6 +397,7 @@ The sysfs tree has the following purposes:
 This is a link to the tree(1) program, very useful in
 viewing the SAS domain:
 ftp://mama.indstate.edu/linux/tree/
+
 I expect user space applications to actually create a
 graphical interface of this.
 
@@ -359,7 +421,7 @@ contents of the domain_device structure, but it never creates
 or destroys one.
 
 Expander management from User Space
------------------------------------
+===================================
 
 In each expander directory in sysfs, there is a file called
 "smp_portal".  It is a binary sysfs attribute file, which
@@ -371,15 +433,23 @@ Functionality is deceptively simple:
 
 1. Build the SMP frame you want to send. The format and layout
    is described in the SAS spec.  Leave the CRC field equal 0.
+
 open(2)
+
 2. Open the expander's SMP portal sysfs file in RW mode.
+
 write(2)
+
 3. Write the frame you built in 1.
+
 read(2)
+
 4. Read the amount of data you expect to receive for the frame you built.
    If you receive different amount of data you expected to receive,
    then there was some kind of error.
+
 close(2)
+
 All this process is shown in detail in the function do_smp_func()
 and its callers, in the file "expander_conf.c".
 
-- 
2.21.1

