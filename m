Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75A78C2BA1B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 15:48:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BCA62075E
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 15:48:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586360888;
	bh=7hTV2dJgIFRro7f3UUMXrrc2L76PI7X8rrq/aKCVMQg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=h2pcWTCk/MoIrF3f9sCNkHvOWulzS0haj9uj5XCxurJ7J1BXDrBkOsXfLClxG2uew
	 1mhZSMyDiE+l8RY5XsUR/MAg7Ra7K9tC5GHPqfzQFlAW5/LjFtkbcTU1p8AcgMr8nV
	 xhvGJ3WnNv64T6qFOkhDQqWm2cLF5OEzfugfkmwQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730003AbgDHPsG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 11:48:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:49388 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729667AbgDHPqd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 11:46:33 -0400
Received: from mail.kernel.org (ip5f5ad4d8.dynamic.kabel-deutschland.de [95.90.212.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 82C4D21841;
        Wed,  8 Apr 2020 15:46:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586360791;
        bh=7hTV2dJgIFRro7f3UUMXrrc2L76PI7X8rrq/aKCVMQg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xTBlpP4BfPpgOfUQOpoaRRR1e3mDrDzHIjZWBFvMEJSQ+l1c4GfBIdzaMiFPwKKmC
         gWBw0ll54tMTmUa+GBrB/uljaruycz2DuZHDKD5jpBB9PQHoH2Cj+iVJCZywSzktmq
         AkoZUBtK6GVs4zBla/p5qlTH2Dbgyurq68e5Q3ZY=
Received: from mchehab by mail.kernel.org with local (Exim 4.92.3)
        (envelope-from <mchehab@kernel.org>)
        id 1jMCuL-000cBc-NO; Wed, 08 Apr 2020 17:46:29 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH 17/35] docs: watch_queue.rst: supress some Sphinx warnings
Date:   Wed,  8 Apr 2020 17:46:09 +0200
Message-Id: <5ab5d36c72b25c427452b35ef589acae41516319.1586359676.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <cover.1586359676.git.mchehab+huawei@kernel.org>
References: <cover.1586359676.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sphinx doesn't like multi-line literal blocks with ``foobar``:

    Documentation/watch_queue.rst:109: WARNING: Inline literal start-string without end-string.
    Documentation/watch_queue.rst:109: WARNING: Inline emphasis start-string without end-string.
    Documentation/watch_queue.rst:109: WARNING: Inline emphasis start-string without end-string.
    Documentation/watch_queue.rst:109: WARNING: Inline emphasis start-string without end-string.
    Documentation/watch_queue.rst:186: WARNING: Inline literal start-string without end-string.
    Documentation/watch_queue.rst:186: WARNING: Inline emphasis start-string without end-string.
    Documentation/watch_queue.rst:185: WARNING: Inline emphasis start-string without end-string.

So, let's use the "::" markup instead.

While we could do the fix only at the affected lines, let's
do the same change along the entire file, in order to preserve
the same look and feel at the entire doc.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/watch_queue.rst | 34 +++++++++++++++++++++++++---------
 1 file changed, 25 insertions(+), 9 deletions(-)

diff --git a/Documentation/watch_queue.rst b/Documentation/watch_queue.rst
index d8f70282d247..f1ffe9cdf81f 100644
--- a/Documentation/watch_queue.rst
+++ b/Documentation/watch_queue.rst
@@ -105,15 +105,19 @@ watch that specific key).
 
 To manage a watch list, the following functions are provided:
 
-  * ``void init_watch_list(struct watch_list *wlist,
-			   void (*release_watch)(struct watch *wlist));``
+  * ::
+
+      void init_watch_list(struct watch_list *wlist,
+			   void (*release_watch)(struct watch *wlist));
 
     Initialise a watch list.  If ``release_watch`` is not NULL, then this
     indicates a function that should be called when the watch_list object is
     destroyed to discard any references the watch list holds on the watched
     object.
 
-  * ``void remove_watch_list(struct watch_list *wlist);``
+  * ::
+
+      void remove_watch_list(struct watch_list *wlist);
 
     This removes all of the watches subscribed to a watch_list and frees them
     and then destroys the watch_list object itself.
@@ -127,14 +131,18 @@ records will be written into.  The workings of this are hidden entirely inside
 of the watch_queue device driver, but it is necessary to gain a reference to it
 to set a watch.  These can be managed with:
 
-  * ``struct watch_queue *get_watch_queue(int fd);``
+  * ::
+
+      struct watch_queue *get_watch_queue(int fd);``
 
     Since watch queues are indicated to the kernel by the fd of the pipe that
     implements the buffer, userspace must hand that fd through a system call.
     This can be used to look up an opaque pointer to the watch queue from the
     system call.
 
-  * ``void put_watch_queue(struct watch_queue *wqueue);``
+  * ::
+
+      void put_watch_queue(struct watch_queue *wqueue);
 
     This discards the reference obtained from ``get_watch_queue()``.
 
@@ -170,18 +178,24 @@ different ID are ignored.
 
 The following functions are provided to manage watches:
 
-  * ``void init_watch(struct watch *watch, struct watch_queue *wqueue);``
+  * ::
+
+      void init_watch(struct watch *watch, struct watch_queue *wqueue);
 
     Initialise a watch object, setting its pointer to the watch queue, using
     appropriate barriering to avoid lockdep complaints.
 
-  * ``int add_watch_to_object(struct watch *watch, struct watch_list *wlist);``
+  * ::
+
+      int add_watch_to_object(struct watch *watch, struct watch_list *wlist);
 
     Subscribe a watch to a watch list (notification source).  The
     driver-settable fields in the watch struct must have been set before this
     is called.
 
-  * ``int remove_watch_from_object(struct watch_list *wlist,
+  * ::
+
+      int remove_watch_from_object(struct watch_list *wlist,
 				   struct watch_queue *wqueue,
 				   u64 id, false);``
 
@@ -190,7 +204,9 @@ The following functions are provided to manage watches:
     (``WATCH_META_REMOVAL_NOTIFICATION``) is sent to the watch queue to
     indicate that the watch got removed.
 
-  * ``int remove_watch_from_object(struct watch_list *wlist, NULL, 0, true);``
+  * ::
+
+      int remove_watch_from_object(struct watch_list *wlist, NULL, 0, true);
 
     Remove all the watches from a watch list.  It is expected that this will be
     called preparatory to destruction and that the watch list will be
-- 
2.25.2

