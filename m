Return-Path: <SRS0=aedO=3O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8425C2D0DB
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jan 2020 10:45:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D61122522
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jan 2020 10:45:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729945AbgAYKpn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Jan 2020 05:45:43 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:44247 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729473AbgAYKnG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jan 2020 05:43:06 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1ivIu6-00006Z-VW; Sat, 25 Jan 2020 11:43:03 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id B81BA1C1A85;
        Sat, 25 Jan 2020 11:42:50 +0100 (CET)
Date:   Sat, 25 Jan 2020 10:42:50 -0000
From:   "tip-bot2 for Madhuparna Bhowmik" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] doc: Convert arrayRCU.txt to arrayRCU.rst
Cc:     Madhuparna Bhowmik <madhuparnabhowmik04@gmail.com>,
        Phong Tran <tranmanphong@gmail.com>,
        Amol Grover <frextrite@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <157994897055.396.1213883219008520117.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     9ffdd7982417e2e227e295c4dea9cec652a71983
Gitweb:        https://git.kernel.org/tip/9ffdd7982417e2e227e295c4dea9cec652a71983
Author:        Madhuparna Bhowmik <madhuparnabhowmik04@gmail.com>
AuthorDate:    Tue, 29 Oct 2019 01:54:17 +05:30
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Tue, 10 Dec 2019 18:51:19 -08:00

doc: Convert arrayRCU.txt to arrayRCU.rst

This patch converts arrayRCU from .txt to .rst format, and also adds
it to the index.rst file.

Signed-off-by: Madhuparna Bhowmik <madhuparnabhowmik04@gmail.com>
[ paulmck: Trimmed trailing whitespace. ]
Tested-by: Phong Tran <tranmanphong@gmail.com>
Tested-by: Amol Grover <frextrite@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 Documentation/RCU/arrayRCU.rst | 165 ++++++++++++++++++++++++++++++++-
 Documentation/RCU/arrayRCU.txt | 153 +------------------------------
 Documentation/RCU/index.rst    |   1 +-
 3 files changed, 166 insertions(+), 153 deletions(-)
 create mode 100644 Documentation/RCU/arrayRCU.rst
 delete mode 100644 Documentation/RCU/arrayRCU.txt

diff --git a/Documentation/RCU/arrayRCU.rst b/Documentation/RCU/arrayRCU.rst
new file mode 100644
index 0000000..4051ea3
--- /dev/null
+++ b/Documentation/RCU/arrayRCU.rst
@@ -0,0 +1,165 @@
+.. _array_rcu_doc:
+
+Using RCU to Protect Read-Mostly Arrays
+=======================================
+
+Although RCU is more commonly used to protect linked lists, it can
+also be used to protect arrays.  Three situations are as follows:
+
+1.  :ref:`Hash Tables <hash_tables>`
+
+2.  :ref:`Static Arrays <static_arrays>`
+
+3.  :ref:`Resizable Arrays <resizable_arrays>`
+
+Each of these three situations involves an RCU-protected pointer to an
+array that is separately indexed.  It might be tempting to consider use
+of RCU to instead protect the index into an array, however, this use
+case is **not** supported.  The problem with RCU-protected indexes into
+arrays is that compilers can play way too many optimization games with
+integers, which means that the rules governing handling of these indexes
+are far more trouble than they are worth.  If RCU-protected indexes into
+arrays prove to be particularly valuable (which they have not thus far),
+explicit cooperation from the compiler will be required to permit them
+to be safely used.
+
+That aside, each of the three RCU-protected pointer situations are
+described in the following sections.
+
+.. _hash_tables:
+
+Situation 1: Hash Tables
+------------------------
+
+Hash tables are often implemented as an array, where each array entry
+has a linked-list hash chain.  Each hash chain can be protected by RCU
+as described in the listRCU.txt document.  This approach also applies
+to other array-of-list situations, such as radix trees.
+
+.. _static_arrays:
+
+Situation 2: Static Arrays
+--------------------------
+
+Static arrays, where the data (rather than a pointer to the data) is
+located in each array element, and where the array is never resized,
+have not been used with RCU.  Rik van Riel recommends using seqlock in
+this situation, which would also have minimal read-side overhead as long
+as updates are rare.
+
+Quick Quiz:
+		Why is it so important that updates be rare when using seqlock?
+
+:ref:`Answer to Quick Quiz <answer_quick_quiz_seqlock>`
+
+.. _resizable_arrays:
+
+Situation 3: Resizable Arrays
+------------------------------
+
+Use of RCU for resizable arrays is demonstrated by the grow_ary()
+function formerly used by the System V IPC code.  The array is used
+to map from semaphore, message-queue, and shared-memory IDs to the data
+structure that represents the corresponding IPC construct.  The grow_ary()
+function does not acquire any locks; instead its caller must hold the
+ids->sem semaphore.
+
+The grow_ary() function, shown below, does some limit checks, allocates a
+new ipc_id_ary, copies the old to the new portion of the new, initializes
+the remainder of the new, updates the ids->entries pointer to point to
+the new array, and invokes ipc_rcu_putref() to free up the old array.
+Note that rcu_assign_pointer() is used to update the ids->entries pointer,
+which includes any memory barriers required on whatever architecture
+you are running on::
+
+	static int grow_ary(struct ipc_ids* ids, int newsize)
+	{
+		struct ipc_id_ary* new;
+		struct ipc_id_ary* old;
+		int i;
+		int size = ids->entries->size;
+
+		if(newsize > IPCMNI)
+			newsize = IPCMNI;
+		if(newsize <= size)
+			return newsize;
+
+		new = ipc_rcu_alloc(sizeof(struct kern_ipc_perm *)*newsize +
+				    sizeof(struct ipc_id_ary));
+		if(new == NULL)
+			return size;
+		new->size = newsize;
+		memcpy(new->p, ids->entries->p,
+		       sizeof(struct kern_ipc_perm *)*size +
+		       sizeof(struct ipc_id_ary));
+		for(i=size;i<newsize;i++) {
+			new->p[i] = NULL;
+		}
+		old = ids->entries;
+
+		/*
+		 * Use rcu_assign_pointer() to make sure the memcpyed
+		 * contents of the new array are visible before the new
+		 * array becomes visible.
+		 */
+		rcu_assign_pointer(ids->entries, new);
+
+		ipc_rcu_putref(old);
+		return newsize;
+	}
+
+The ipc_rcu_putref() function decrements the array's reference count
+and then, if the reference count has dropped to zero, uses call_rcu()
+to free the array after a grace period has elapsed.
+
+The array is traversed by the ipc_lock() function.  This function
+indexes into the array under the protection of rcu_read_lock(),
+using rcu_dereference() to pick up the pointer to the array so
+that it may later safely be dereferenced -- memory barriers are
+required on the Alpha CPU.  Since the size of the array is stored
+with the array itself, there can be no array-size mismatches, so
+a simple check suffices.  The pointer to the structure corresponding
+to the desired IPC object is placed in "out", with NULL indicating
+a non-existent entry.  After acquiring "out->lock", the "out->deleted"
+flag indicates whether the IPC object is in the process of being
+deleted, and, if not, the pointer is returned::
+
+	struct kern_ipc_perm* ipc_lock(struct ipc_ids* ids, int id)
+	{
+		struct kern_ipc_perm* out;
+		int lid = id % SEQ_MULTIPLIER;
+		struct ipc_id_ary* entries;
+
+		rcu_read_lock();
+		entries = rcu_dereference(ids->entries);
+		if(lid >= entries->size) {
+			rcu_read_unlock();
+			return NULL;
+		}
+		out = entries->p[lid];
+		if(out == NULL) {
+			rcu_read_unlock();
+			return NULL;
+		}
+		spin_lock(&out->lock);
+
+		/* ipc_rmid() may have already freed the ID while ipc_lock
+		 * was spinning: here verify that the structure is still valid
+		 */
+		if (out->deleted) {
+			spin_unlock(&out->lock);
+			rcu_read_unlock();
+			return NULL;
+		}
+		return out;
+	}
+
+.. _answer_quick_quiz_seqlock:
+
+Answer to Quick Quiz:
+	Why is it so important that updates be rare when using seqlock?
+
+	The reason that it is important that updates be rare when
+	using seqlock is that frequent updates can livelock readers.
+	One way to avoid this problem is to assign a seqlock for
+	each array entry rather than to the entire array.
diff --git a/Documentation/RCU/arrayRCU.txt b/Documentation/RCU/arrayRCU.txt
deleted file mode 100644
index f05a9af..0000000
--- a/Documentation/RCU/arrayRCU.txt
+++ /dev/null
@@ -1,153 +0,0 @@
-Using RCU to Protect Read-Mostly Arrays
-
-
-Although RCU is more commonly used to protect linked lists, it can
-also be used to protect arrays.  Three situations are as follows:
-
-1.  Hash Tables
-
-2.  Static Arrays
-
-3.  Resizeable Arrays
-
-Each of these three situations involves an RCU-protected pointer to an
-array that is separately indexed.  It might be tempting to consider use
-of RCU to instead protect the index into an array, however, this use
-case is -not- supported.  The problem with RCU-protected indexes into
-arrays is that compilers can play way too many optimization games with
-integers, which means that the rules governing handling of these indexes
-are far more trouble than they are worth.  If RCU-protected indexes into
-arrays prove to be particularly valuable (which they have not thus far),
-explicit cooperation from the compiler will be required to permit them
-to be safely used.
-
-That aside, each of the three RCU-protected pointer situations are
-described in the following sections.
-
-
-Situation 1: Hash Tables
-
-Hash tables are often implemented as an array, where each array entry
-has a linked-list hash chain.  Each hash chain can be protected by RCU
-as described in the listRCU.txt document.  This approach also applies
-to other array-of-list situations, such as radix trees.
-
-
-Situation 2: Static Arrays
-
-Static arrays, where the data (rather than a pointer to the data) is
-located in each array element, and where the array is never resized,
-have not been used with RCU.  Rik van Riel recommends using seqlock in
-this situation, which would also have minimal read-side overhead as long
-as updates are rare.
-
-Quick Quiz:  Why is it so important that updates be rare when
-	     using seqlock?
-
-
-Situation 3: Resizeable Arrays
-
-Use of RCU for resizeable arrays is demonstrated by the grow_ary()
-function formerly used by the System V IPC code.  The array is used
-to map from semaphore, message-queue, and shared-memory IDs to the data
-structure that represents the corresponding IPC construct.  The grow_ary()
-function does not acquire any locks; instead its caller must hold the
-ids->sem semaphore.
-
-The grow_ary() function, shown below, does some limit checks, allocates a
-new ipc_id_ary, copies the old to the new portion of the new, initializes
-the remainder of the new, updates the ids->entries pointer to point to
-the new array, and invokes ipc_rcu_putref() to free up the old array.
-Note that rcu_assign_pointer() is used to update the ids->entries pointer,
-which includes any memory barriers required on whatever architecture
-you are running on.
-
-	static int grow_ary(struct ipc_ids* ids, int newsize)
-	{
-		struct ipc_id_ary* new;
-		struct ipc_id_ary* old;
-		int i;
-		int size = ids->entries->size;
-
-		if(newsize > IPCMNI)
-			newsize = IPCMNI;
-		if(newsize <= size)
-			return newsize;
-
-		new = ipc_rcu_alloc(sizeof(struct kern_ipc_perm *)*newsize +
-				    sizeof(struct ipc_id_ary));
-		if(new == NULL)
-			return size;
-		new->size = newsize;
-		memcpy(new->p, ids->entries->p,
-		       sizeof(struct kern_ipc_perm *)*size +
-		       sizeof(struct ipc_id_ary));
-		for(i=size;i<newsize;i++) {
-			new->p[i] = NULL;
-		}
-		old = ids->entries;
-
-		/*
-		 * Use rcu_assign_pointer() to make sure the memcpyed
-		 * contents of the new array are visible before the new
-		 * array becomes visible.
-		 */
-		rcu_assign_pointer(ids->entries, new);
-
-		ipc_rcu_putref(old);
-		return newsize;
-	}
-
-The ipc_rcu_putref() function decrements the array's reference count
-and then, if the reference count has dropped to zero, uses call_rcu()
-to free the array after a grace period has elapsed.
-
-The array is traversed by the ipc_lock() function.  This function
-indexes into the array under the protection of rcu_read_lock(),
-using rcu_dereference() to pick up the pointer to the array so
-that it may later safely be dereferenced -- memory barriers are
-required on the Alpha CPU.  Since the size of the array is stored
-with the array itself, there can be no array-size mismatches, so
-a simple check suffices.  The pointer to the structure corresponding
-to the desired IPC object is placed in "out", with NULL indicating
-a non-existent entry.  After acquiring "out->lock", the "out->deleted"
-flag indicates whether the IPC object is in the process of being
-deleted, and, if not, the pointer is returned.
-
-	struct kern_ipc_perm* ipc_lock(struct ipc_ids* ids, int id)
-	{
-		struct kern_ipc_perm* out;
-		int lid = id % SEQ_MULTIPLIER;
-		struct ipc_id_ary* entries;
-
-		rcu_read_lock();
-		entries = rcu_dereference(ids->entries);
-		if(lid >= entries->size) {
-			rcu_read_unlock();
-			return NULL;
-		}
-		out = entries->p[lid];
-		if(out == NULL) {
-			rcu_read_unlock();
-			return NULL;
-		}
-		spin_lock(&out->lock);
-
-		/* ipc_rmid() may have already freed the ID while ipc_lock
-		 * was spinning: here verify that the structure is still valid
-		 */
-		if (out->deleted) {
-			spin_unlock(&out->lock);
-			rcu_read_unlock();
-			return NULL;
-		}
-		return out;
-	}
-
-
-Answer to Quick Quiz:
-
-	The reason that it is important that updates be rare when
-	using seqlock is that frequent updates can livelock readers.
-	One way to avoid this problem is to assign a seqlock for
-	each array entry rather than to the entire array.
diff --git a/Documentation/RCU/index.rst b/Documentation/RCU/index.rst
index 5c99185..8d20d44 100644
--- a/Documentation/RCU/index.rst
+++ b/Documentation/RCU/index.rst
@@ -7,6 +7,7 @@ RCU concepts
 .. toctree::
    :maxdepth: 3
 
+   arrayRCU
    rcu
    listRCU
    UP
