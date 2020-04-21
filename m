Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8905C54FC9
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 16:55:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8854B206F4
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 16:55:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587488124;
	bh=/px724oLbVhzjmXikP+qzAsBDN0UZBumjO87fRFni9M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=bXWP/LYF7k7NLZ6p4/xWTdi8eTo0is5lJN6iQ7YLwpZtXEod/MHuF9d3xbHgQQ0Lc
	 yO5ExDvHyrxJBA1hD/kfXum+xToIqXOFe03V5OXM5p0gnZM1SKyvRuR20/HOxtF8A0
	 ZesC/kAXVzxQil5FCEbfLCCFL6oucM1u5q8ggwkk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729343AbgDUQzX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 12:55:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:57336 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729155AbgDUQyt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 12:54:49 -0400
Received: from mail.kernel.org (ip5f5ad4d8.dynamic.kabel-deutschland.de [95.90.212.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 76CB121473;
        Tue, 21 Apr 2020 16:54:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587488084;
        bh=/px724oLbVhzjmXikP+qzAsBDN0UZBumjO87fRFni9M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TrQ5PDF3b0LEYMrmk1IZwid6NvpPEj0KyI3ny5T/EuwdXSldPB1wcX6JDJVNva72P
         Yhar9gS3XxGwfYe66w+OqBNNLO021c3gBCXXOgUqvmPfrb9Zhh8+RHUsqBdA7YlRZO
         WoKJlPs9PFZiGwB6xh80g/0a2xMQzKiyCiki66IY=
Received: from mchehab by mail.kernel.org with local (Exim 4.92.3)
        (envelope-from <mchehab@kernel.org>)
        id 1jQwAU-00CmEl-L3; Tue, 21 Apr 2020 18:54:42 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH v2 18/29] docs: filesystems: convert mount_api.txt to ReST
Date:   Tue, 21 Apr 2020 18:54:29 +0200
Message-Id: <5df8ac4199f4eb9829beb9455c423561685fdb9f.1587487612.git.mchehab+huawei@kernel.org>
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
- Adjust document and section titles;
- Some whitespace fixes and new line breaks;
- Mark literal blocks as such;
- Add table markups;
- Add lists markups;
- Add it to filesystems/index.rst.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/filesystems/index.rst           |   1 +
 .../{mount_api.txt => mount_api.rst}          | 329 ++++++++++++------
 include/linux/fs_context.h                    |   2 +-
 include/linux/lsm_hooks.h                     |   2 +-
 4 files changed, 218 insertions(+), 116 deletions(-)
 rename Documentation/filesystems/{mount_api.txt => mount_api.rst} (79%)

diff --git a/Documentation/filesystems/index.rst b/Documentation/filesystems/index.rst
index 02d52b536baf..abfc143434a2 100644
--- a/Documentation/filesystems/index.rst
+++ b/Documentation/filesystems/index.rst
@@ -30,6 +30,7 @@ algorithms work.
    files
    locks
    mandatory-locking
+   mount_api
 
    automount-support
 
diff --git a/Documentation/filesystems/mount_api.txt b/Documentation/filesystems/mount_api.rst
similarity index 79%
rename from Documentation/filesystems/mount_api.txt
rename to Documentation/filesystems/mount_api.rst
index 87c14bbb2b35..dea22d64f060 100644
--- a/Documentation/filesystems/mount_api.txt
+++ b/Documentation/filesystems/mount_api.rst
@@ -1,8 +1,10 @@
-			     ====================
-			     FILESYSTEM MOUNT API
-			     ====================
+.. SPDX-License-Identifier: GPL-2.0
 
-CONTENTS
+====================
+fILESYSTEM Mount API
+====================
+
+.. CONTENTS
 
  (1) Overview.
 
@@ -21,8 +23,7 @@ CONTENTS
  (8) Parameter helper functions.
 
 
-========
-OVERVIEW
+Overview
 ========
 
 The creation of new mounts is now to be done in a multistep process:
@@ -43,7 +44,7 @@ The creation of new mounts is now to be done in a multistep process:
 
  (7) Destroy the context.
 
-To support this, the file_system_type struct gains two new fields:
+To support this, the file_system_type struct gains two new fields::
 
 	int (*init_fs_context)(struct fs_context *fc);
 	const struct fs_parameter_description *parameters;
@@ -57,12 +58,11 @@ Note that security initialisation is done *after* the filesystem is called so
 that the namespaces may be adjusted first.
 
 
-======================
-THE FILESYSTEM CONTEXT
+The Filesystem context
 ======================
 
 The creation and reconfiguration of a superblock is governed by a filesystem
-context.  This is represented by the fs_context structure:
+context.  This is represented by the fs_context structure::
 
 	struct fs_context {
 		const struct fs_context_operations *ops;
@@ -86,78 +86,106 @@ context.  This is represented by the fs_context structure:
 
 The fs_context fields are as follows:
 
- (*) const struct fs_context_operations *ops
+   * ::
+
+       const struct fs_context_operations *ops
 
      These are operations that can be done on a filesystem context (see
      below).  This must be set by the ->init_fs_context() file_system_type
      operation.
 
- (*) struct file_system_type *fs_type
+   * ::
+
+       struct file_system_type *fs_type
 
      A pointer to the file_system_type of the filesystem that is being
      constructed or reconfigured.  This retains a reference on the type owner.
 
- (*) void *fs_private
+   * ::
+
+       void *fs_private
 
      A pointer to the file system's private data.  This is where the filesystem
      will need to store any options it parses.
 
- (*) struct dentry *root
+   * ::
+
+       struct dentry *root
 
      A pointer to the root of the mountable tree (and indirectly, the
      superblock thereof).  This is filled in by the ->get_tree() op.  If this
      is set, an active reference on root->d_sb must also be held.
 
- (*) struct user_namespace *user_ns
- (*) struct net *net_ns
+   * ::
+
+       struct user_namespace *user_ns
+       struct net *net_ns
 
      There are a subset of the namespaces in use by the invoking process.  They
      retain references on each namespace.  The subscribed namespaces may be
      replaced by the filesystem to reflect other sources, such as the parent
      mount superblock on an automount.
 
- (*) const struct cred *cred
+   * ::
+
+       const struct cred *cred
 
      The mounter's credentials.  This retains a reference on the credentials.
 
- (*) char *source
+   * ::
+
+       char *source
 
      This specifies the source.  It may be a block device (e.g. /dev/sda1) or
      something more exotic, such as the "host:/path" that NFS desires.
 
- (*) char *subtype
+   * ::
+
+       char *subtype
 
      This is a string to be added to the type displayed in /proc/mounts to
      qualify it (used by FUSE).  This is available for the filesystem to set if
      desired.
 
- (*) void *security
+   * ::
+
+       void *security
 
      A place for the LSMs to hang their security data for the superblock.  The
      relevant security operations are described below.
 
- (*) void *s_fs_info
+   * ::
+
+       void *s_fs_info
 
      The proposed s_fs_info for a new superblock, set in the superblock by
      sget_fc().  This can be used to distinguish superblocks.
 
- (*) unsigned int sb_flags
- (*) unsigned int sb_flags_mask
+   * ::
+
+       unsigned int sb_flags
+       unsigned int sb_flags_mask
 
      Which bits SB_* flags are to be set/cleared in super_block::s_flags.
 
- (*) unsigned int s_iflags
+   * ::
+
+       unsigned int s_iflags
 
      These will be bitwise-OR'd with s->s_iflags when a superblock is created.
 
- (*) enum fs_context_purpose
+   * ::
+
+       enum fs_context_purpose
 
      This indicates the purpose for which the context is intended.  The
      available values are:
 
-	FS_CONTEXT_FOR_MOUNT,		-- New superblock for explicit mount
-	FS_CONTEXT_FOR_SUBMOUNT		-- New automatic submount of extant mount
-	FS_CONTEXT_FOR_RECONFIGURE	-- Change an existing mount
+	==========================	======================================
+	FS_CONTEXT_FOR_MOUNT,		New superblock for explicit mount
+	FS_CONTEXT_FOR_SUBMOUNT		New automatic submount of extant mount
+	FS_CONTEXT_FOR_RECONFIGURE	Change an existing mount
+	==========================	======================================
 
 The mount context is created by calling vfs_new_fs_context() or
 vfs_dup_fs_context() and is destroyed with put_fs_context().  Note that the
@@ -176,11 +204,10 @@ mount context.  For instance, NFS might pin the appropriate protocol version
 module.
 
 
-=================================
-THE FILESYSTEM CONTEXT OPERATIONS
+The Filesystem Context Operations
 =================================
 
-The filesystem context points to a table of operations:
+The filesystem context points to a table of operations::
 
 	struct fs_context_operations {
 		void (*free)(struct fs_context *fc);
@@ -195,24 +222,32 @@ The filesystem context points to a table of operations:
 These operations are invoked by the various stages of the mount procedure to
 manage the filesystem context.  They are as follows:
 
- (*) void (*free)(struct fs_context *fc);
+   * ::
+
+	void (*free)(struct fs_context *fc);
 
      Called to clean up the filesystem-specific part of the filesystem context
      when the context is destroyed.  It should be aware that parts of the
      context may have been removed and NULL'd out by ->get_tree().
 
- (*) int (*dup)(struct fs_context *fc, struct fs_context *src_fc);
+   * ::
+
+	int (*dup)(struct fs_context *fc, struct fs_context *src_fc);
 
      Called when a filesystem context has been duplicated to duplicate the
      filesystem-private data.  An error may be returned to indicate failure to
      do this.
 
-     [!] Note that even if this fails, put_fs_context() will be called
+     .. Warning::
+
+         Note that even if this fails, put_fs_context() will be called
 	 immediately thereafter, so ->dup() *must* make the
 	 filesystem-private data safe for ->free().
 
- (*) int (*parse_param)(struct fs_context *fc,
-			struct struct fs_parameter *param);
+   * ::
+
+	int (*parse_param)(struct fs_context *fc,
+			   struct struct fs_parameter *param);
 
      Called when a parameter is being added to the filesystem context.  param
      points to the key name and maybe a value object.  VFS-specific options
@@ -224,7 +259,9 @@ manage the filesystem context.  They are as follows:
 
      If successful, 0 should be returned or a negative error code otherwise.
 
- (*) int (*parse_monolithic)(struct fs_context *fc, void *data);
+   * ::
+
+	int (*parse_monolithic)(struct fs_context *fc, void *data);
 
      Called when the mount(2) system call is invoked to pass the entire data
      page in one go.  If this is expected to be just a list of "key[=val]"
@@ -236,7 +273,9 @@ manage the filesystem context.  They are as follows:
      finds it's the standard key-val list then it may pass it off to
      generic_parse_monolithic().
 
- (*) int (*get_tree)(struct fs_context *fc);
+   * ::
+
+	int (*get_tree)(struct fs_context *fc);
 
      Called to get or create the mountable root and superblock, using the
      information stored in the filesystem context (reconfiguration goes via a
@@ -249,7 +288,9 @@ manage the filesystem context.  They are as follows:
      The phase on a userspace-driven context will be set to only allow this to
      be called once on any particular context.
 
- (*) int (*reconfigure)(struct fs_context *fc);
+   * ::
+
+	int (*reconfigure)(struct fs_context *fc);
 
      Called to effect reconfiguration of a superblock using information stored
      in the filesystem context.  It may detach any resources it desires from
@@ -259,19 +300,20 @@ manage the filesystem context.  They are as follows:
      On success it should return 0.  In the case of an error, it should return
      a negative error code.
 
-     [NOTE] reconfigure is intended as a replacement for remount_fs.
+     .. Note:: reconfigure is intended as a replacement for remount_fs.
 
 
-===========================
-FILESYSTEM CONTEXT SECURITY
+Filesystem context Security
 ===========================
 
 The filesystem context contains a security pointer that the LSMs can use for
 building up a security context for the superblock to be mounted.  There are a
 number of operations used by the new mount code for this purpose:
 
- (*) int security_fs_context_alloc(struct fs_context *fc,
-				   struct dentry *reference);
+   * ::
+
+	int security_fs_context_alloc(struct fs_context *fc,
+				      struct dentry *reference);
 
      Called to initialise fc->security (which is preset to NULL) and allocate
      any resources needed.  It should return 0 on success or a negative error
@@ -283,22 +325,28 @@ number of operations used by the new mount code for this purpose:
      non-NULL in the case of a submount (FS_CONTEXT_FOR_SUBMOUNT) in which case
      it indicates the automount point.
 
- (*) int security_fs_context_dup(struct fs_context *fc,
-				 struct fs_context *src_fc);
+   * ::
+
+	int security_fs_context_dup(struct fs_context *fc,
+				    struct fs_context *src_fc);
 
      Called to initialise fc->security (which is preset to NULL) and allocate
      any resources needed.  The original filesystem context is pointed to by
      src_fc and may be used for reference.  It should return 0 on success or a
      negative error code on failure.
 
- (*) void security_fs_context_free(struct fs_context *fc);
+   * ::
+
+	void security_fs_context_free(struct fs_context *fc);
 
      Called to clean up anything attached to fc->security.  Note that the
      contents may have been transferred to a superblock and the pointer cleared
      during get_tree.
 
- (*) int security_fs_context_parse_param(struct fs_context *fc,
-					 struct fs_parameter *param);
+   * ::
+
+	int security_fs_context_parse_param(struct fs_context *fc,
+					    struct fs_parameter *param);
 
      Called for each mount parameter, including the source.  The arguments are
      as for the ->parse_param() method.  It should return 0 to indicate that
@@ -310,7 +358,9 @@ number of operations used by the new mount code for this purpose:
      (provided the value pointer is NULL'd out).  If it is stolen, 1 must be
      returned to prevent it being passed to the filesystem.
 
- (*) int security_fs_context_validate(struct fs_context *fc);
+   * ::
+
+	int security_fs_context_validate(struct fs_context *fc);
 
      Called after all the options have been parsed to validate the collection
      as a whole and to do any necessary allocation so that
@@ -320,36 +370,43 @@ number of operations used by the new mount code for this purpose:
      In the case of reconfiguration, the target superblock will be accessible
      via fc->root.
 
- (*) int security_sb_get_tree(struct fs_context *fc);
+   * ::
+
+	int security_sb_get_tree(struct fs_context *fc);
 
      Called during the mount procedure to verify that the specified superblock
      is allowed to be mounted and to transfer the security data there.  It
      should return 0 or a negative error code.
 
- (*) void security_sb_reconfigure(struct fs_context *fc);
+   * ::
+
+	void security_sb_reconfigure(struct fs_context *fc);
 
      Called to apply any reconfiguration to an LSM's context.  It must not
      fail.  Error checking and resource allocation must be done in advance by
      the parameter parsing and validation hooks.
 
- (*) int security_sb_mountpoint(struct fs_context *fc, struct path *mountpoint,
-				unsigned int mnt_flags);
+   * ::
+
+	int security_sb_mountpoint(struct fs_context *fc,
+			           struct path *mountpoint,
+				   unsigned int mnt_flags);
 
      Called during the mount procedure to verify that the root dentry attached
      to the context is permitted to be attached to the specified mountpoint.
      It should return 0 on success or a negative error code on failure.
 
 
-==========================
-VFS FILESYSTEM CONTEXT API
+VFS Filesystem context API
 ==========================
 
 There are four operations for creating a filesystem context and one for
 destroying a context:
 
- (*) struct fs_context *fs_context_for_mount(
-		struct file_system_type *fs_type,
-		unsigned int sb_flags);
+   * ::
+
+       struct fs_context *fs_context_for_mount(struct file_system_type *fs_type,
+					       unsigned int sb_flags);
 
      Allocate a filesystem context for the purpose of setting up a new mount,
      whether that be with a new superblock or sharing an existing one.  This
@@ -359,7 +416,9 @@ destroying a context:
      fs_type specifies the filesystem type that will manage the context and
      sb_flags presets the superblock flags stored therein.
 
- (*) struct fs_context *fs_context_for_reconfigure(
+   * ::
+
+       struct fs_context *fs_context_for_reconfigure(
 		struct dentry *dentry,
 		unsigned int sb_flags,
 		unsigned int sb_flags_mask);
@@ -369,7 +428,9 @@ destroying a context:
      configured.  sb_flags and sb_flags_mask indicate which superblock flags
      need changing and to what.
 
- (*) struct fs_context *fs_context_for_submount(
+   * ::
+
+       struct fs_context *fs_context_for_submount(
 		struct file_system_type *fs_type,
 		struct dentry *reference);
 
@@ -382,7 +443,9 @@ destroying a context:
      Note that it's not a requirement that the reference dentry be of the same
      filesystem type as fs_type.
 
- (*) struct fs_context *vfs_dup_fs_context(struct fs_context *src_fc);
+   * ::
+
+        struct fs_context *vfs_dup_fs_context(struct fs_context *src_fc);
 
      Duplicate a filesystem context, copying any options noted and duplicating
      or additionally referencing any resources held therein.  This is available
@@ -392,14 +455,18 @@ destroying a context:
 
      The purpose in the new context is inherited from the old one.
 
- (*) void put_fs_context(struct fs_context *fc);
+   * ::
+
+       void put_fs_context(struct fs_context *fc);
 
      Destroy a filesystem context, releasing any resources it holds.  This
      calls the ->free() operation.  This is intended to be called by anyone who
      created a filesystem context.
 
-     [!] filesystem contexts are not refcounted, so this causes unconditional
-	 destruction.
+     .. Warning::
+
+        filesystem contexts are not refcounted, so this causes unconditional
+	destruction.
 
 In all the above operations, apart from the put op, the return is a mount
 context pointer or a negative error code.
@@ -407,8 +474,10 @@ context pointer or a negative error code.
 For the remaining operations, if an error occurs, a negative error code will be
 returned.
 
- (*) int vfs_parse_fs_param(struct fs_context *fc,
-			    struct fs_parameter *param);
+   * ::
+
+        int vfs_parse_fs_param(struct fs_context *fc,
+			       struct fs_parameter *param);
 
      Supply a single mount parameter to the filesystem context.  This include
      the specification of the source/device which is specified as the "source"
@@ -423,53 +492,64 @@ returned.
 
      The parameter value is typed and can be one of:
 
-	fs_value_is_flag,		Parameter not given a value.
-	fs_value_is_string,		Value is a string
-	fs_value_is_blob,		Value is a binary blob
-	fs_value_is_filename,		Value is a filename* + dirfd
-	fs_value_is_file,		Value is an open file (file*)
+	====================		=============================
+	fs_value_is_flag		Parameter not given a value
+	fs_value_is_string		Value is a string
+	fs_value_is_blob		Value is a binary blob
+	fs_value_is_filename		Value is a filename* + dirfd
+	fs_value_is_file		Value is an open file (file*)
+	====================		=============================
 
      If there is a value, that value is stored in a union in the struct in one
      of param->{string,blob,name,file}.  Note that the function may steal and
      clear the pointer, but then becomes responsible for disposing of the
      object.
 
- (*) int vfs_parse_fs_string(struct fs_context *fc, const char *key,
-			     const char *value, size_t v_size);
+   * ::
+
+       int vfs_parse_fs_string(struct fs_context *fc, const char *key,
+			       const char *value, size_t v_size);
 
      A wrapper around vfs_parse_fs_param() that copies the value string it is
      passed.
 
- (*) int generic_parse_monolithic(struct fs_context *fc, void *data);
+   * ::
+
+       int generic_parse_monolithic(struct fs_context *fc, void *data);
 
      Parse a sys_mount() data page, assuming the form to be a text list
      consisting of key[=val] options separated by commas.  Each item in the
      list is passed to vfs_mount_option().  This is the default when the
      ->parse_monolithic() method is NULL.
 
- (*) int vfs_get_tree(struct fs_context *fc);
+   * ::
+
+       int vfs_get_tree(struct fs_context *fc);
 
      Get or create the mountable root and superblock, using the parameters in
      the filesystem context to select/configure the superblock.  This invokes
      the ->get_tree() method.
 
- (*) struct vfsmount *vfs_create_mount(struct fs_context *fc);
+   * ::
+
+       struct vfsmount *vfs_create_mount(struct fs_context *fc);
 
      Create a mount given the parameters in the specified filesystem context.
      Note that this does not attach the mount to anything.
 
 
-===========================
-SUPERBLOCK CREATION HELPERS
+Superblock Creation Helpers
 ===========================
 
 A number of VFS helpers are available for use by filesystems for the creation
 or looking up of superblocks.
 
- (*) struct super_block *
-     sget_fc(struct fs_context *fc,
-	     int (*test)(struct super_block *sb, struct fs_context *fc),
-	     int (*set)(struct super_block *sb, struct fs_context *fc));
+   * ::
+
+       struct super_block *
+       sget_fc(struct fs_context *fc,
+	       int (*test)(struct super_block *sb, struct fs_context *fc),
+	       int (*set)(struct super_block *sb, struct fs_context *fc));
 
      This is the core routine.  If test is non-NULL, it searches for an
      existing superblock matching the criteria held in the fs_context, using
@@ -482,10 +562,12 @@ or looking up of superblocks.
 
 The following helpers all wrap sget_fc():
 
- (*) int vfs_get_super(struct fs_context *fc,
-		       enum vfs_get_super_keying keying,
-		       int (*fill_super)(struct super_block *sb,
-					 struct fs_context *fc))
+   * ::
+
+       int vfs_get_super(struct fs_context *fc,
+		         enum vfs_get_super_keying keying,
+		         int (*fill_super)(struct super_block *sb,
+					   struct fs_context *fc))
 
      This creates/looks up a deviceless superblock.  The keying indicates how
      many superblocks of this type may exist and in what manner they may be
@@ -515,14 +597,14 @@ PARAMETER DESCRIPTION
 =====================
 
 Parameters are described using structures defined in linux/fs_parser.h.
-There's a core description struct that links everything together:
+There's a core description struct that links everything together::
 
 	struct fs_parameter_description {
 		const struct fs_parameter_spec *specs;
 		const struct fs_parameter_enum *enums;
 	};
 
-For example:
+For example::
 
 	enum {
 		Opt_autocell,
@@ -539,10 +621,12 @@ For example:
 
 The members are as follows:
 
- (1) const struct fs_parameter_specification *specs;
+ (1) ::
+
+       const struct fs_parameter_specification *specs;
 
      Table of parameter specifications, terminated with a null entry, where the
-     entries are of type:
+     entries are of type::
 
 	struct fs_parameter_spec {
 		const char		*name;
@@ -558,6 +642,7 @@ The members are as follows:
 
      The 'type' field indicates the desired value type and must be one of:
 
+	=======================	=======================	=====================
 	TYPE NAME		EXPECTED VALUE		RESULT IN
 	=======================	=======================	=====================
 	fs_param_is_flag	No value		n/a
@@ -573,19 +658,23 @@ The members are as follows:
 	fs_param_is_blockdev	Blockdev path		* Needs lookup
 	fs_param_is_path	Path			* Needs lookup
 	fs_param_is_fd		File descriptor		result->int_32
+	=======================	=======================	=====================
 
      Note that if the value is of fs_param_is_bool type, fs_parse() will try
      to match any string value against "0", "1", "no", "yes", "false", "true".
 
      Each parameter can also be qualified with 'flags':
 
+	=======================	================================================
 	fs_param_v_optional	The value is optional
 	fs_param_neg_with_no	result->negated set if key is prefixed with "no"
 	fs_param_neg_with_empty	result->negated set if value is ""
 	fs_param_deprecated	The parameter is deprecated.
+	=======================	================================================
 
      These are wrapped with a number of convenience wrappers:
 
+	=======================	===============================================
 	MACRO			SPECIFIES
 	=======================	===============================================
 	fsparam_flag()		fs_param_is_flag
@@ -602,9 +691,10 @@ The members are as follows:
 	fsparam_bdev()		fs_param_is_blockdev
 	fsparam_path()		fs_param_is_path
 	fsparam_fd()		fs_param_is_fd
+	=======================	===============================================
 
      all of which take two arguments, name string and option number - for
-     example:
+     example::
 
 	static const struct fs_parameter_spec afs_param_specs[] = {
 		fsparam_flag	("autocell",	Opt_autocell),
@@ -618,10 +708,12 @@ The members are as follows:
      of arguments to specify the type and the flags for anything that doesn't
      match one of the above macros.
 
- (2) const struct fs_parameter_enum *enums;
+ (2) ::
+
+       const struct fs_parameter_enum *enums;
 
      Table of enum value names to integer mappings, terminated with a null
-     entry.  This is of type:
+     entry.  This is of type::
 
 	struct fs_parameter_enum {
 		u8		opt;
@@ -630,7 +722,7 @@ The members are as follows:
 	};
 
      Where the array is an unsorted list of { parameter ID, name }-keyed
-     elements that indicate the value to map to, e.g.:
+     elements that indicate the value to map to, e.g.::
 
 	static const struct fs_parameter_enum afs_param_enums[] = {
 		{ Opt_bar,   "x",      1},
@@ -648,18 +740,19 @@ CONFIG_VALIDATE_FS_PARSER=y) and will allow the description to be queried from
 userspace using the fsinfo() syscall.
 
 
-==========================
-PARAMETER HELPER FUNCTIONS
+Parameter Helper Functions
 ==========================
 
 A number of helper functions are provided to help a filesystem or an LSM
 process the parameters it is given.
 
- (*) int lookup_constant(const struct constant_table tbl[],
-			 const char *name, int not_found);
+   * ::
+
+       int lookup_constant(const struct constant_table tbl[],
+			   const char *name, int not_found);
 
      Look up a constant by name in a table of name -> integer mappings.  The
-     table is an array of elements of the following type:
+     table is an array of elements of the following type::
 
 	struct constant_table {
 		const char	*name;
@@ -669,9 +762,11 @@ process the parameters it is given.
      If a match is found, the corresponding value is returned.  If a match
      isn't found, the not_found value is returned instead.
 
- (*) bool validate_constant_table(const struct constant_table *tbl,
-				  size_t tbl_size,
-				  int low, int high, int special);
+   * ::
+
+       bool validate_constant_table(const struct constant_table *tbl,
+				    size_t tbl_size,
+				    int low, int high, int special);
 
      Validate a constant table.  Checks that all the elements are appropriately
      ordered, that there are no duplicates and that the values are between low
@@ -682,16 +777,20 @@ process the parameters it is given.
      If all is good, true is returned.  If the table is invalid, errors are
      logged to dmesg and false is returned.
 
- (*) bool fs_validate_description(const struct fs_parameter_description *desc);
+   * ::
+
+       bool fs_validate_description(const struct fs_parameter_description *desc);
 
      This performs some validation checks on a parameter description.  It
      returns true if the description is good and false if it is not.  It will
      log errors to dmesg if validation fails.
 
- (*) int fs_parse(struct fs_context *fc,
-		  const struct fs_parameter_description *desc,
-		  struct fs_parameter *param,
-		  struct fs_parse_result *result);
+   * ::
+
+        int fs_parse(struct fs_context *fc,
+		     const struct fs_parameter_description *desc,
+		     struct fs_parameter *param,
+		     struct fs_parse_result *result);
 
      This is the main interpreter of parameters.  It uses the parameter
      description to look up a parameter by key name and to convert that to an
@@ -711,14 +810,16 @@ process the parameters it is given.
      parameter is matched, but the value is erroneous, -EINVAL will be
      returned; otherwise the parameter's option number will be returned.
 
- (*) int fs_lookup_param(struct fs_context *fc,
-			 struct fs_parameter *value,
-			 bool want_bdev,
-			 struct path *_path);
+   * ::
+
+       int fs_lookup_param(struct fs_context *fc,
+			   struct fs_parameter *value,
+			   bool want_bdev,
+			   struct path *_path);
 
      This takes a parameter that carries a string or filename type and attempts
      to do a path lookup on it.  If the parameter expects a blockdev, a check
      is made that the inode actually represents one.
 
-     Returns 0 if successful and *_path will be set; returns a negative error
-     code if not.
+     Returns 0 if successful and ``*_path`` will be set; returns a negative
+     error code if not.
diff --git a/include/linux/fs_context.h b/include/linux/fs_context.h
index e6c3e4c61dad..5f24fcbfbfb4 100644
--- a/include/linux/fs_context.h
+++ b/include/linux/fs_context.h
@@ -85,7 +85,7 @@ struct p_log {
  * Superblock creation fills in ->root whereas reconfiguration begins with this
  * already set.
  *
- * See Documentation/filesystems/mount_api.txt
+ * See Documentation/filesystems/mount_api.rst
  */
 struct fs_context {
 	const struct fs_context_operations *ops;
diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 23bd89a3d369..c638e5de672f 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -77,7 +77,7 @@
  *	state.  This is called immediately after commit_creds().
  *
  * Security hooks for mount using fs_context.
- *	[See also Documentation/filesystems/mount_api.txt]
+ *	[See also Documentation/filesystems/mount_api.rst]
  *
  * @fs_context_dup:
  *	Allocate and attach a security structure to sc->security.  This pointer
-- 
2.25.2

