Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D20EC54FCC
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 16:55:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 41FC1206F4
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 16:55:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587488142;
	bh=85Hb/Vl2BC3BeHWKtYOntLnrUTWb3H2EexK36MH0Wa4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zWQ1KkqAtbewXzxZOdNL03GmowQFNv0CC85oSObjrCiQIpSXGWOXCm1S4vlz19oOW
	 HgA08xmQ6t+kSk8Da2ZPpavXqKRrodSR+Ah1mglHyREvMgZqmuc11ypTLsJjA3Qx80
	 6Z35Q0nvuJmrDRgWDKvn2WNOSj0eMC8yOM/C1bAI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729415AbgDUQzl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 12:55:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:57242 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729112AbgDUQys (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 12:54:48 -0400
Received: from mail.kernel.org (ip5f5ad4d8.dynamic.kabel-deutschland.de [95.90.212.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6DCF72098B;
        Tue, 21 Apr 2020 16:54:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587488084;
        bh=85Hb/Vl2BC3BeHWKtYOntLnrUTWb3H2EexK36MH0Wa4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=T5Jb2vZB5CISYLdTRVKgKGAPs7rex6qIpH731WmbhchZt/J3jNQRQHltHSjWnIJXx
         F+pFhPswhuR90sS+u8WzOMvz7g18iaOMwq0i0euWsv/5jBcIe4cXzgy9G8zxP05nw3
         m/AJXp6YvRlth/qpaD2kuThO1q5zQ9I2m5cY5Qjo=
Received: from mchehab by mail.kernel.org with local (Exim 4.92.3)
        (envelope-from <mchehab@kernel.org>)
        id 1jQwAU-00CmEv-NA; Tue, 21 Apr 2020 18:54:42 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH v2 20/29] docs: filesystems: convert seq_file.txt to ReST
Date:   Tue, 21 Apr 2020 18:54:31 +0200
Message-Id: <68bafc8d454f25de4a8736f97baf8aaf6659c43a.1587487612.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <cover.1587487612.git.mchehab+huawei@kernel.org>
References: <cover.1587487612.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

- Add a SPDX header;
- Add a document title;
- Adjust section titles;
- Some whitespace fixes and new line breaks;
- Mark literal blocks as such;
- Add it to filesystems/index.rst.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/filesystems/index.rst           |  1 +
 .../{seq_file.txt => seq_file.rst}            | 61 +++++++++++--------
 2 files changed, 38 insertions(+), 24 deletions(-)
 rename Documentation/filesystems/{seq_file.txt => seq_file.rst} (92%)

diff --git a/Documentation/filesystems/index.rst b/Documentation/filesystems/index.rst
index 6458891f74e4..3d35317b0c46 100644
--- a/Documentation/filesystems/index.rst
+++ b/Documentation/filesystems/index.rst
@@ -32,6 +32,7 @@ algorithms work.
    mandatory-locking
    mount_api
    quota
+   seq_file
 
    automount-support
 
diff --git a/Documentation/filesystems/seq_file.txt b/Documentation/filesystems/seq_file.rst
similarity index 92%
rename from Documentation/filesystems/seq_file.txt
rename to Documentation/filesystems/seq_file.rst
index d412b236a9d6..fab302046b13 100644
--- a/Documentation/filesystems/seq_file.txt
+++ b/Documentation/filesystems/seq_file.rst
@@ -1,6 +1,11 @@
-The seq_file interface
+.. SPDX-License-Identifier: GPL-2.0
+
+======================
+The seq_file Interface
+======================
 
 	Copyright 2003 Jonathan Corbet <corbet@lwn.net>
+
 	This file is originally from the LWN.net Driver Porting series at
 	http://lwn.net/Articles/driver-porting/
 
@@ -43,7 +48,7 @@ loadable module which creates a file called /proc/sequence. The file, when
 read, simply produces a set of increasing integer values, one per line. The
 sequence will continue until the user loses patience and finds something
 better to do. The file is seekable, in that one can do something like the
-following:
+following::
 
     dd if=/proc/sequence of=out1 count=1
     dd if=/proc/sequence skip=1 of=out2 count=1
@@ -55,16 +60,18 @@ wanting to see the full source for this module can find it at
 http://lwn.net/Articles/22359/).
 
 Deprecated create_proc_entry
+============================
 
 Note that the above article uses create_proc_entry which was removed in
-kernel 3.10. Current versions require the following update
+kernel 3.10. Current versions require the following update::
 
--	entry = create_proc_entry("sequence", 0, NULL);
--	if (entry)
--		entry->proc_fops = &ct_file_ops;
-+	entry = proc_create("sequence", 0, NULL, &ct_file_ops);
+    -	entry = create_proc_entry("sequence", 0, NULL);
+    -	if (entry)
+    -		entry->proc_fops = &ct_file_ops;
+    +	entry = proc_create("sequence", 0, NULL, &ct_file_ops);
 
 The iterator interface
+======================
 
 Modules implementing a virtual file with seq_file must implement an
 iterator object that allows stepping through the data of interest
@@ -99,7 +106,7 @@ position.  The pos passed to start() will always be either zero, or
 the most recent pos used in the previous session.
 
 For our simple sequence example,
-the start() function looks like:
+the start() function looks like::
 
 	static void *ct_seq_start(struct seq_file *s, loff_t *pos)
 	{
@@ -129,7 +136,7 @@ move the iterator forward to the next position in the sequence.  The
 example module can simply increment the position by one; more useful
 modules will do what is needed to step through some data structure. The
 next() function returns a new iterator, or NULL if the sequence is
-complete. Here's the example version:
+complete. Here's the example version::
 
 	static void *ct_seq_next(struct seq_file *s, void *v, loff_t *pos)
 	{
@@ -141,10 +148,10 @@ complete. Here's the example version:
 The stop() function closes a session; its job, of course, is to clean
 up. If dynamic memory is allocated for the iterator, stop() is the
 place to free it; if a lock was taken by start(), stop() must release
-that lock.  The value that *pos was set to by the last next() call
+that lock.  The value that ``*pos`` was set to by the last next() call
 before stop() is remembered, and used for the first start() call of
 the next session unless lseek() has been called on the file; in that
-case next start() will be asked to start at position zero.
+case next start() will be asked to start at position zero::
 
 	static void ct_seq_stop(struct seq_file *s, void *v)
 	{
@@ -152,7 +159,7 @@ case next start() will be asked to start at position zero.
 	}
 
 Finally, the show() function should format the object currently pointed to
-by the iterator for output.  The example module's show() function is:
+by the iterator for output.  The example module's show() function is::
 
 	static int ct_seq_show(struct seq_file *s, void *v)
 	{
@@ -169,7 +176,7 @@ generated output before returning SEQ_SKIP, that output will be dropped.
 
 We will look at seq_printf() in a moment. But first, the definition of the
 seq_file iterator is finished by creating a seq_operations structure with
-the four functions we have just defined:
+the four functions we have just defined::
 
 	static const struct seq_operations ct_seq_ops = {
 	        .start = ct_seq_start,
@@ -194,6 +201,7 @@ other locks while the iterator is active.
 
 
 Formatted output
+================
 
 The seq_file code manages positioning within the output created by the
 iterator and getting it into the user's buffer. But, for that to work, that
@@ -203,7 +211,7 @@ been defined which make this task easy.
 Most code will simply use seq_printf(), which works pretty much like
 printk(), but which requires the seq_file pointer as an argument.
 
-For straight character output, the following functions may be used:
+For straight character output, the following functions may be used::
 
 	seq_putc(struct seq_file *m, char c);
 	seq_puts(struct seq_file *m, const char *s);
@@ -213,7 +221,7 @@ The first two output a single character and a string, just like one would
 expect. seq_escape() is like seq_puts(), except that any character in s
 which is in the string esc will be represented in octal form in the output.
 
-There are also a pair of functions for printing filenames:
+There are also a pair of functions for printing filenames::
 
 	int seq_path(struct seq_file *m, const struct path *path,
 		     const char *esc);
@@ -226,8 +234,10 @@ the path relative to the current process's filesystem root.  If a different
 root is desired, it can be used with seq_path_root().  If it turns out that
 path cannot be reached from root, seq_path_root() returns SEQ_SKIP.
 
-A function producing complicated output may want to check
+A function producing complicated output may want to check::
+
 	bool seq_has_overflowed(struct seq_file *m);
+
 and avoid further seq_<output> calls if true is returned.
 
 A true return from seq_has_overflowed means that the seq_file buffer will
@@ -236,6 +246,7 @@ buffer and retry printing.
 
 
 Making it all work
+==================
 
 So far, we have a nice set of functions which can produce output within the
 seq_file system, but we have not yet turned them into a file that a user
@@ -244,7 +255,7 @@ creation of a set of file_operations which implement the operations on that
 file. The seq_file interface provides a set of canned operations which do
 most of the work. The virtual file author still must implement the open()
 method, however, to hook everything up. The open function is often a single
-line, as in the example module:
+line, as in the example module::
 
 	static int ct_open(struct inode *inode, struct file *file)
 	{
@@ -263,7 +274,7 @@ by the iterator functions.
 There is also a wrapper function to seq_open() called seq_open_private(). It
 kmallocs a zero filled block of memory and stores a pointer to it in the
 private field of the seq_file structure, returning 0 on success. The
-block size is specified in a third parameter to the function, e.g.:
+block size is specified in a third parameter to the function, e.g.::
 
 	static int ct_open(struct inode *inode, struct file *file)
 	{
@@ -273,7 +284,7 @@ block size is specified in a third parameter to the function, e.g.:
 
 There is also a variant function, __seq_open_private(), which is functionally
 identical except that, if successful, it returns the pointer to the allocated
-memory block, allowing further initialisation e.g.:
+memory block, allowing further initialisation e.g.::
 
 	static int ct_open(struct inode *inode, struct file *file)
 	{
@@ -295,7 +306,7 @@ frees the memory allocated in the corresponding open.
 
 The other operations of interest - read(), llseek(), and release() - are
 all implemented by the seq_file code itself. So a virtual file's
-file_operations structure will look like:
+file_operations structure will look like::
 
 	static const struct file_operations ct_file_ops = {
 	        .owner   = THIS_MODULE,
@@ -309,7 +320,7 @@ There is also a seq_release_private() which passes the contents of the
 seq_file private field to kfree() before releasing the structure.
 
 The final step is the creation of the /proc file itself. In the example
-code, that is done in the initialization code in the usual way:
+code, that is done in the initialization code in the usual way::
 
 	static int ct_init(void)
 	{
@@ -325,9 +336,10 @@ And that is pretty much it.
 
 
 seq_list
+========
 
 If your file will be iterating through a linked list, you may find these
-routines useful:
+routines useful::
 
 	struct list_head *seq_list_start(struct list_head *head,
 	       		 		 loff_t pos);
@@ -338,15 +350,16 @@ routines useful:
 
 These helpers will interpret pos as a position within the list and iterate
 accordingly.  Your start() and next() functions need only invoke the
-seq_list_* helpers with a pointer to the appropriate list_head structure.
+``seq_list_*`` helpers with a pointer to the appropriate list_head structure.
 
 
 The extra-simple version
+========================
 
 For extremely simple virtual files, there is an even easier interface.  A
 module can define only the show() function, which should create all the
 output that the virtual file will contain. The file's open() method then
-calls:
+calls::
 
 	int single_open(struct file *file,
 	                int (*show)(struct seq_file *m, void *p),
-- 
2.25.2

