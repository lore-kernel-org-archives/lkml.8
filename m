Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F125C3F2D5
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 08:17:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6797246CE
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 08:17:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583137047;
	bh=Wu8f99FLtwAansaYCxSiJNnIkhPh1PzyJM8dnRZ3aIo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ECapZHDfK7dNo8qe3Okb0PFqa16XcZ1FsakVVp20FlhJR9oKVxQBIFCqvOIOz45rZ
	 Fng6DsRPCnHJUkjZs2Z5um9XUu5qH2WSSvG+Q7EM56Pb0eyjvusTi3Z2puTV01nIZe
	 BIi8nkXvvYKMzyepJ6VAzhJ9BAsJiJxKsuse/xP8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727647AbgCBIRZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 03:17:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:57070 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727349AbgCBIQY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 03:16:24 -0500
Received: from mail.kernel.org (ip5f5ad4e9.dynamic.kabel-deutschland.de [95.90.212.233])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8A22D246EC;
        Mon,  2 Mar 2020 08:16:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583136979;
        bh=Wu8f99FLtwAansaYCxSiJNnIkhPh1PzyJM8dnRZ3aIo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QJbAzJ+AeistVYVX7NAegYn5SL/eXOl0Re0i2c1iDKCQ48UcJMVOi4UfffaYuBMAH
         QbferFvK2OBKy6e8rFCgQlS8OxCLyBj7PAdUB6yNLI3Z1djVgb9bKSEMoMPZ9TPRon
         /FrJ18pQ0CEjKWvrz0W7rtWQx+faBP/zNfJR3sT4=
Received: from mchehab by mail.kernel.org with local (Exim 4.92.3)
        (envelope-from <mchehab@kernel.org>)
        id 1j8gFN-0003yp-OL; Mon, 02 Mar 2020 09:16:17 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH 28/42] docs: scsi: convert scsi_eh.txt to ReST
Date:   Mon,  2 Mar 2020 09:16:01 +0100
Message-Id: <300314197f2e6a3258200711e825aa04c9e8ceaf.1583136624.git.mchehab+huawei@kernel.org>
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
 Documentation/driver-api/libata.rst           |   2 +-
 Documentation/scsi/index.rst                  |   1 +
 .../scsi/{scsi_eh.txt => scsi_eh.rst}         | 215 ++++++++++--------
 3 files changed, 128 insertions(+), 90 deletions(-)
 rename Documentation/scsi/{scsi_eh.txt => scsi_eh.rst} (73%)

diff --git a/Documentation/driver-api/libata.rst b/Documentation/driver-api/libata.rst
index 207f0d24de69..e2f87b82b074 100644
--- a/Documentation/driver-api/libata.rst
+++ b/Documentation/driver-api/libata.rst
@@ -401,7 +401,7 @@ Error handling
 ==============
 
 This chapter describes how errors are handled under libata. Readers are
-advised to read SCSI EH (Documentation/scsi/scsi_eh.txt) and ATA
+advised to read SCSI EH (Documentation/scsi/scsi_eh.rst) and ATA
 exceptions doc first.
 
 Origins of commands
diff --git a/Documentation/scsi/index.rst b/Documentation/scsi/index.rst
index 635a3b3c5e90..8da7c27f73b7 100644
--- a/Documentation/scsi/index.rst
+++ b/Documentation/scsi/index.rst
@@ -32,5 +32,6 @@ Linux SCSI Subsystem
    ppa
    qlogicfas
    scsi-changer
+   scsi_eh
 
    scsi_transport_srp/figures
diff --git a/Documentation/scsi/scsi_eh.txt b/Documentation/scsi/scsi_eh.rst
similarity index 73%
rename from Documentation/scsi/scsi_eh.txt
rename to Documentation/scsi/scsi_eh.rst
index 1b7436932a2b..341f22f35056 100644
--- a/Documentation/scsi/scsi_eh.txt
+++ b/Documentation/scsi/scsi_eh.rst
@@ -1,35 +1,39 @@
+.. SPDX-License-Identifier: GPL-2.0
 
+=======
 SCSI EH
-======================================
+=======
 
- This document describes SCSI midlayer error handling infrastructure.
+This document describes SCSI midlayer error handling infrastructure.
 Please refer to Documentation/scsi/scsi_mid_low_api.txt for more
 information regarding SCSI midlayer.
 
-TABLE OF CONTENTS
+.. TABLE OF CONTENTS
 
-[1] How SCSI commands travel through the midlayer and to EH
-    [1-1] struct scsi_cmnd
-    [1-2] How do scmd's get completed?
-	[1-2-1] Completing a scmd w/ scsi_done
-	[1-2-2] Completing a scmd w/ timeout
-    [1-3] How EH takes over
-[2] How SCSI EH works
-    [2-1] EH through fine-grained callbacks
-	[2-1-1] Overview
-	[2-1-2] Flow of scmds through EH
-	[2-1-3] Flow of control
-    [2-2] EH through transportt->eh_strategy_handler()
-	[2-2-1] Pre transportt->eh_strategy_handler() SCSI midlayer conditions
-	[2-2-2] Post transportt->eh_strategy_handler() SCSI midlayer conditions
-	[2-2-3] Things to consider
+   [1] How SCSI commands travel through the midlayer and to EH
+       [1-1] struct scsi_cmnd
+       [1-2] How do scmd's get completed?
+   	[1-2-1] Completing a scmd w/ scsi_done
+   	[1-2-2] Completing a scmd w/ timeout
+       [1-3] How EH takes over
+   [2] How SCSI EH works
+       [2-1] EH through fine-grained callbacks
+   	[2-1-1] Overview
+   	[2-1-2] Flow of scmds through EH
+   	[2-1-3] Flow of control
+       [2-2] EH through transportt->eh_strategy_handler()
+   	[2-2-1] Pre transportt->eh_strategy_handler() SCSI midlayer conditions
+   	[2-2-2] Post transportt->eh_strategy_handler() SCSI midlayer conditions
+   	[2-2-3] Things to consider
 
 
-[1] How SCSI commands travel through the midlayer and to EH
+1. How SCSI commands travel through the midlayer and to EH
+==========================================================
 
-[1-1] struct scsi_cmnd
+1.1 struct scsi_cmnd
+--------------------
 
- Each SCSI command is represented with struct scsi_cmnd (== scmd).  A
+Each SCSI command is represented with struct scsi_cmnd (== scmd).  A
 scmd has two list_head's to link itself into lists.  The two are
 scmd->list and scmd->eh_entry.  The former is used for free list or
 per-device allocated scmd list and not of much interest to this EH
@@ -38,25 +42,28 @@ otherwise stated scmds are always linked using scmd->eh_entry in this
 discussion.
 
 
-[1-2] How do scmd's get completed?
+1.2 How do scmd's get completed?
+--------------------------------
 
- Once LLDD gets hold of a scmd, either the LLDD will complete the
+Once LLDD gets hold of a scmd, either the LLDD will complete the
 command by calling scsi_done callback passed from midlayer when
 invoking hostt->queuecommand() or the block layer will time it out.
 
 
-[1-2-1] Completing a scmd w/ scsi_done
+1.2.1 Completing a scmd w/ scsi_done
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
 
- For all non-EH commands, scsi_done() is the completion callback.  It
+For all non-EH commands, scsi_done() is the completion callback.  It
 just calls blk_complete_request() to delete the block layer timer and
 raise SCSI_SOFTIRQ
 
- SCSI_SOFTIRQ handler scsi_softirq calls scsi_decide_disposition() to
+SCSI_SOFTIRQ handler scsi_softirq calls scsi_decide_disposition() to
 determine what to do with the command.  scsi_decide_disposition()
 looks at the scmd->result value and sense data to determine what to do
 with the command.
 
  - SUCCESS
+
 	scsi_finish_command() is invoked for the command.  The
 	function does some maintenance chores and then calls
 	scsi_io_completion() to finish the I/O.
@@ -66,17 +73,21 @@ with the command.
 	of the data in case of an error.
 
  - NEEDS_RETRY
+
  - ADD_TO_MLQUEUE
+
 	scmd is requeued to blk queue.
 
  - otherwise
+
 	scsi_eh_scmd_add(scmd) is invoked for the command.  See
 	[1-3] for details of this function.
 
 
-[1-2-2] Completing a scmd w/ timeout
+1.2.2 Completing a scmd w/ timeout
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
 
- The timeout handler is scsi_times_out().  When a timeout occurs, this
+The timeout handler is scsi_times_out().  When a timeout occurs, this
 function
 
  1. invokes optional hostt->eh_timed_out() callback.  Return value can
@@ -101,18 +112,21 @@ function
  3. scsi_eh_scmd_add(scmd, SCSI_EH_CANCEL_CMD) is invoked for the
     command.  See [1-4] for more information.
 
-[1-3] Asynchronous command aborts
+1.3 Asynchronous command aborts
+-------------------------------
 
  After a timeout occurs a command abort is scheduled from
  scsi_abort_command(). If the abort is successful the command
  will either be retried (if the number of retries is not exhausted)
  or terminated with DID_TIME_OUT.
+
  Otherwise scsi_eh_scmd_add() is invoked for the command.
  See [1-4] for more information.
 
-[1-4] How EH takes over
+1.4 How EH takes over
+---------------------
 
- scmds enter EH via scsi_eh_scmd_add(), which does the following.
+scmds enter EH via scsi_eh_scmd_add(), which does the following.
 
  1. Links scmd->eh_entry to shost->eh_cmd_q
 
@@ -122,19 +136,19 @@ function
 
  4. Wakes up SCSI EH thread if shost->host_busy == shost->host_failed
 
- As can be seen above, once any scmd is added to shost->eh_cmd_q,
+As can be seen above, once any scmd is added to shost->eh_cmd_q,
 SHOST_RECOVERY shost_state bit is turned on.  This prevents any new
 scmd to be issued from blk queue to the host; eventually, all scmds on
 the host either complete normally, fail and get added to eh_cmd_q, or
 time out and get added to shost->eh_cmd_q.
 
- If all scmds either complete or fail, the number of in-flight scmds
+If all scmds either complete or fail, the number of in-flight scmds
 becomes equal to the number of failed scmds - i.e. shost->host_busy ==
 shost->host_failed.  This wakes up SCSI EH thread.  So, once woken up,
 SCSI EH thread can expect that all in-flight commands have failed and
 are linked on shost->eh_cmd_q.
 
- Note that this does not mean lower layers are quiescent.  If a LLDD
+Note that this does not mean lower layers are quiescent.  If a LLDD
 completed a scmd with error status, the LLDD and lower layers are
 assumed to forget about the scmd at that point.  However, if a scmd
 has timed out, unless hostt->eh_timed_out() made lower layers forget
@@ -143,13 +157,14 @@ active as long as lower layers are concerned and completion could
 occur at any time.  Of course, all such completions are ignored as the
 timer has already expired.
 
- We'll talk about how SCSI EH takes actions to abort - make LLDD
+We'll talk about how SCSI EH takes actions to abort - make LLDD
 forget about - timed out scmds later.
 
 
-[2] How SCSI EH works
+2. How SCSI EH works
+====================
 
- LLDD's can implement SCSI EH actions in one of the following two
+LLDD's can implement SCSI EH actions in one of the following two
 ways.
 
  - Fine-grained EH callbacks
@@ -162,7 +177,7 @@ ways.
 	handling.  As such, it should do all chores the SCSI midlayer
 	performs during recovery.  This will be discussed in [2-2].
 
- Once recovery is complete, SCSI EH resumes normal operation by
+Once recovery is complete, SCSI EH resumes normal operation by
 calling scsi_restart_operations(), which
 
  1. Checks if door locking is needed and locks door.
@@ -177,34 +192,38 @@ calling scsi_restart_operations(), which
  4. Kicks queues in all devices on the host in the asses
 
 
-[2-1] EH through fine-grained callbacks
+2.1 EH through fine-grained callbacks
+-------------------------------------
 
-[2-1-1] Overview
+2.1.1 Overview
+^^^^^^^^^^^^^^
 
- If eh_strategy_handler() is not present, SCSI midlayer takes charge
+If eh_strategy_handler() is not present, SCSI midlayer takes charge
 of driving error handling.  EH's goals are two - make LLDD, host and
 device forget about timed out scmds and make them ready for new
 commands.  A scmd is said to be recovered if the scmd is forgotten by
 lower layers and lower layers are ready to process or fail the scmd
 again.
 
- To achieve these goals, EH performs recovery actions with increasing
+To achieve these goals, EH performs recovery actions with increasing
 severity.  Some actions are performed by issuing SCSI commands and
 others are performed by invoking one of the following fine-grained
 hostt EH callbacks.  Callbacks may be omitted and omitted ones are
 considered to fail always.
 
-int (* eh_abort_handler)(struct scsi_cmnd *);
-int (* eh_device_reset_handler)(struct scsi_cmnd *);
-int (* eh_bus_reset_handler)(struct scsi_cmnd *);
-int (* eh_host_reset_handler)(struct scsi_cmnd *);
+::
 
- Higher-severity actions are taken only when lower-severity actions
+    int (* eh_abort_handler)(struct scsi_cmnd *);
+    int (* eh_device_reset_handler)(struct scsi_cmnd *);
+    int (* eh_bus_reset_handler)(struct scsi_cmnd *);
+    int (* eh_host_reset_handler)(struct scsi_cmnd *);
+
+Higher-severity actions are taken only when lower-severity actions
 cannot recover some of failed scmds.  Also, note that failure of the
 highest-severity action means EH failure and results in offlining of
 all unrecovered devices.
 
- During recovery, the following rules are followed
+During recovery, the following rules are followed
 
  - Recovery actions are performed on failed scmds on the to do list,
    eh_work_q.  If a recovery action succeeds for a scmd, recovered
@@ -221,58 +240,72 @@ all unrecovered devices.
    timed-out scmds, SCSI EH ensures that LLDD forgets about a scmd
    before reusing it for EH commands.
 
- When a scmd is recovered, the scmd is moved from eh_work_q to EH
+When a scmd is recovered, the scmd is moved from eh_work_q to EH
 local eh_done_q using scsi_eh_finish_cmd().  After all scmds are
 recovered (eh_work_q is empty), scsi_eh_flush_done_q() is invoked to
 either retry or error-finish (notify upper layer of failure) recovered
 scmds.
 
- scmds are retried iff its sdev is still online (not offlined during
+scmds are retried iff its sdev is still online (not offlined during
 EH), REQ_FAILFAST is not set and ++scmd->retries is less than
 scmd->allowed.
 
 
-[2-1-2] Flow of scmds through EH
+2.1.2 Flow of scmds through EH
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
 
  1. Error completion / time out
-    ACTION: scsi_eh_scmd_add() is invoked for scmd
+
+    :ACTION: scsi_eh_scmd_add() is invoked for scmd
+
 	- add scmd to shost->eh_cmd_q
 	- set SHOST_RECOVERY
 	- shost->host_failed++
-    LOCKING: shost->host_lock
+
+    :LOCKING: shost->host_lock
 
  2. EH starts
-    ACTION: move all scmds to EH's local eh_work_q.  shost->eh_cmd_q
-	    is cleared.
-    LOCKING: shost->host_lock (not strictly necessary, just for
+
+    :ACTION: move all scmds to EH's local eh_work_q.  shost->eh_cmd_q
+	     is cleared.
+
+    :LOCKING: shost->host_lock (not strictly necessary, just for
              consistency)
 
  3. scmd recovered
-    ACTION: scsi_eh_finish_cmd() is invoked to EH-finish scmd
+
+    :ACTION: scsi_eh_finish_cmd() is invoked to EH-finish scmd
+
 	- scsi_setup_cmd_retry()
 	- move from local eh_work_q to local eh_done_q
-    LOCKING: none
-    CONCURRENCY: at most one thread per separate eh_work_q to
-		 keep queue manipulation lockless
+
+    :LOCKING: none
+
+    :CONCURRENCY: at most one thread per separate eh_work_q to
+		  keep queue manipulation lockless
 
  4. EH completes
-    ACTION: scsi_eh_flush_done_q() retries scmds or notifies upper
-	    layer of failure. May be called concurrently but must have
-	    a no more than one thread per separate eh_work_q to
-	    manipulate the queue locklessly
-	- scmd is removed from eh_done_q and scmd->eh_entry is cleared
-	- if retry is necessary, scmd is requeued using
-          scsi_queue_insert()
-	- otherwise, scsi_finish_command() is invoked for scmd
-	- zero shost->host_failed
-    LOCKING: queue or finish function performs appropriate locking
-
-
-[2-1-3] Flow of control
+
+    :ACTION: scsi_eh_flush_done_q() retries scmds or notifies upper
+	     layer of failure. May be called concurrently but must have
+	     a no more than one thread per separate eh_work_q to
+	     manipulate the queue locklessly
+
+	     - scmd is removed from eh_done_q and scmd->eh_entry is cleared
+	     - if retry is necessary, scmd is requeued using
+	       scsi_queue_insert()
+	     - otherwise, scsi_finish_command() is invoked for scmd
+	     - zero shost->host_failed
+
+    :LOCKING: queue or finish function performs appropriate locking
+
+
+2.1.3 Flow of control
+^^^^^^^^^^^^^^^^^^^^^^
 
  EH through fine-grained callbacks start from scsi_unjam_host().
 
-<<scsi_unjam_host>>
+``scsi_unjam_host``
 
     1. Lock shost->host_lock, splice_init shost->eh_cmd_q into local
        eh_work_q and unlock host_lock.  Note that shost->eh_cmd_q is
@@ -280,7 +313,7 @@ scmd->allowed.
 
     2. Invoke scsi_eh_get_sense.
 
-    <<scsi_eh_get_sense>>
+    ``scsi_eh_get_sense``
 
 	This action is taken for each error-completed
 	(!SCSI_EH_CANCEL_CMD) commands without valid sense data.  Most
@@ -315,7 +348,7 @@ scmd->allowed.
 
     3. If !list_empty(&eh_work_q), invoke scsi_eh_abort_cmds().
 
-    <<scsi_eh_abort_cmds>>
+    ``scsi_eh_abort_cmds``
 
 	This action is taken for each timed out command when
 	no_async_abort is enabled in the host template.
@@ -339,14 +372,14 @@ scmd->allowed.
 
     4. If !list_empty(&eh_work_q), invoke scsi_eh_ready_devs()
 
-    <<scsi_eh_ready_devs>>
+    ``scsi_eh_ready_devs``
 
 	This function takes four increasingly more severe measures to
 	make failed sdevs ready for new commands.
 
 	1. Invoke scsi_eh_stu()
 
-	<<scsi_eh_stu>>
+	``scsi_eh_stu``
 
 	    For each sdev which has failed scmds with valid sense data
 	    of which scsi_check_sense()'s verdict is FAILED,
@@ -369,7 +402,7 @@ scmd->allowed.
 
 	2. If !list_empty(&eh_work_q), invoke scsi_eh_bus_device_reset().
 
-	<<scsi_eh_bus_device_reset>>
+	``scsi_eh_bus_device_reset``
 
 	    This action is very similar to scsi_eh_stu() except that,
 	    instead of issuing STU, hostt->eh_device_reset_handler()
@@ -379,7 +412,7 @@ scmd->allowed.
 
 	3. If !list_empty(&eh_work_q), invoke scsi_eh_bus_reset()
 
-	<<scsi_eh_bus_reset>>
+	``scsi_eh_bus_reset``
 
 	    hostt->eh_bus_reset_handler() is invoked for each channel
 	    with failed scmds.  If bus reset succeeds, all failed
@@ -388,7 +421,7 @@ scmd->allowed.
 
 	4. If !list_empty(&eh_work_q), invoke scsi_eh_host_reset()
 
-	<<scsi_eh_host_reset>>
+	``scsi_eh_host_reset``
 
 	    This is the last resort.  hostt->eh_host_reset_handler()
 	    is invoked.  If host reset succeeds, all failed scmds on
@@ -396,14 +429,14 @@ scmd->allowed.
 
 	5. If !list_empty(&eh_work_q), invoke scsi_eh_offline_sdevs()
 
-	<<scsi_eh_offline_sdevs>>
+	``scsi_eh_offline_sdevs``
 
 	    Take all sdevs which still have unrecovered scmds offline
 	    and EH-finish the scmds.
 
     5. Invoke scsi_eh_flush_done_q().
 
-	<<scsi_eh_flush_done_q>>
+	``scsi_eh_flush_done_q``
 
 	    At this point all scmds are recovered (or given up) and
 	    put on eh_done_q by scsi_eh_finish_cmd().  This function
@@ -411,9 +444,10 @@ scmd->allowed.
 	    layer of failure of the scmds.
 
 
-[2-2] EH through transportt->eh_strategy_handler()
+2.2 EH through transportt->eh_strategy_handler()
+------------------------------------------------
 
- transportt->eh_strategy_handler() is invoked in the place of
+transportt->eh_strategy_handler() is invoked in the place of
 scsi_unjam_host() and it is responsible for whole recovery process.
 On completion, the handler should have made lower layers forget about
 all failed scmds and either ready for new commands or offline.  Also,
@@ -422,7 +456,8 @@ SCSI midlayer.  IOW, of the steps described in [2-1-2], all steps
 except for #1 must be implemented by eh_strategy_handler().
 
 
-[2-2-1] Pre transportt->eh_strategy_handler() SCSI midlayer conditions
+2.2.1 Pre transportt->eh_strategy_handler() SCSI midlayer conditions
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
 
  The following conditions are true on entry to the handler.
 
@@ -435,7 +470,8 @@ except for #1 must be implemented by eh_strategy_handler().
  - shost->host_failed == shost->host_busy
 
 
-[2-2-2] Post transportt->eh_strategy_handler() SCSI midlayer conditions
+2.2.2 Post transportt->eh_strategy_handler() SCSI midlayer conditions
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
 
  The following conditions must be true on exit from the handler.
 
@@ -453,7 +489,8 @@ except for #1 must be implemented by eh_strategy_handler().
    ->allowed to limit the number of retries.
 
 
-[2-2-3] Things to consider
+2.2.3 Things to consider
+^^^^^^^^^^^^^^^^^^^^^^^^
 
  - Know that timed out scmds are still active on lower layers.  Make
    lower layers forget about them before doing anything else with
@@ -469,7 +506,7 @@ except for #1 must be implemented by eh_strategy_handler().
    offline.
 
 
---
 Tejun Heo
 htejun@gmail.com
+
 11th September 2005
-- 
2.21.1

