Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82C16C3F2D7
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 17:01:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 584E52465D
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 17:01:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h7tWtMak"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730122AbgCDRBh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 12:01:37 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:23495 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729750AbgCDQ7P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 11:59:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583341154;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UkuSi18F920kGdVfDKBjKhJnrlqzG64xslOlb7+rPeo=;
        b=h7tWtMak+ucy2cRaFruod10j7aX9gTWOFOPp7C5pD2QJidN7qRZs+Rb0ie7wdJH0+K3uyE
        MAlJlL9s4OV8aXR0qXqeCHKKJ6F6+D9Hu+g/bdaP4CuVOwcAlp9fyeEdYAJSjzl+4VhzZB
        melGOFU70XN2jJvf4EGL5Pu0eLZ/UdQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-273-oxthAFKsP8SvGNgN7WHShA-1; Wed, 04 Mar 2020 11:59:13 -0500
X-MC-Unique: oxthAFKsP8SvGNgN7WHShA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E8F11DB63;
        Wed,  4 Mar 2020 16:59:11 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.18.25.35])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B638C7388E;
        Wed,  4 Mar 2020 16:59:11 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 53AD42257D9; Wed,  4 Mar 2020 11:59:03 -0500 (EST)
From:   Vivek Goyal <vgoyal@redhat.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvdimm@lists.01.org, virtio-fs@redhat.com, miklos@szeredi.hu
Cc:     vgoyal@redhat.com, stefanha@redhat.com, dgilbert@redhat.com,
        mst@redhat.com
Subject: [PATCH 07/20] fuse: Get rid of no_mount_options
Date:   Wed,  4 Mar 2020 11:58:32 -0500
Message-Id: <20200304165845.3081-8-vgoyal@redhat.com>
In-Reply-To: <20200304165845.3081-1-vgoyal@redhat.com>
References: <20200304165845.3081-1-vgoyal@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This option was introduced so that for virtio_fs we don't show any mounts
options fuse_show_options(). Because we don't offer any of these options
to be controlled by mounter.

Very soon we are planning to introduce option "dax" which mounter should
be able to specify. And no_mount_options does not work anymore. What
we need is a per mount option specific flag so that fileystem can
specify which options to show.

Add few such flags to control the behavior in more fine grained manner
and get rid of no_mount_options.

Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
---
 fs/fuse/fuse_i.h    | 14 ++++++++++----
 fs/fuse/inode.c     | 22 ++++++++++++++--------
 fs/fuse/virtio_fs.c |  1 -
 3 files changed, 24 insertions(+), 13 deletions(-)

diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index aa75e2305b75..2cebdf6dcfd8 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -468,18 +468,21 @@ struct fuse_fs_context {
 	int fd;
 	unsigned int rootmode;
 	kuid_t user_id;
+	bool user_id_show;
 	kgid_t group_id;
+	bool group_id_show;
 	bool is_bdev:1;
 	bool fd_present:1;
 	bool rootmode_present:1;
 	bool user_id_present:1;
 	bool group_id_present:1;
 	bool default_permissions:1;
+	bool default_permissions_show:1;
 	bool allow_other:1;
+	bool allow_other_show:1;
 	bool destroy:1;
 	bool no_control:1;
 	bool no_force_umount:1;
-	bool no_mount_options:1;
 	unsigned int max_read;
 	unsigned int blksize;
 	const char *subtype;
@@ -509,9 +512,11 @@ struct fuse_conn {
=20
 	/** The user id for this mount */
 	kuid_t user_id;
+	bool user_id_show:1;
=20
 	/** The group id for this mount */
 	kgid_t group_id;
+	bool group_id_show:1;
=20
 	/** The pid namespace for this mount */
 	struct pid_namespace *pid_ns;
@@ -695,10 +700,14 @@ struct fuse_conn {
=20
 	/** Check permissions based on the file mode or not? */
 	unsigned default_permissions:1;
+	bool default_permissions_show:1;
=20
 	/** Allow other than the mounter user to access the filesystem ? */
 	unsigned allow_other:1;
=20
+	/** Show allow_other in mount options */
+	bool allow_other_show:1;
+
 	/** Does the filesystem support copy_file_range? */
 	unsigned no_copy_file_range:1;
=20
@@ -714,9 +723,6 @@ struct fuse_conn {
 	/** Do not allow MNT_FORCE umount */
 	unsigned int no_force_umount:1;
=20
-	/* Do not show mount options */
-	unsigned int no_mount_options:1;
-
 	/** The number of requests waiting for completion */
 	atomic_t num_waiting;
=20
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 95d712d44ca1..f160a3d47b63 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -515,10 +515,12 @@ static int fuse_parse_param(struct fs_context *fc, =
struct fs_parameter *param)
=20
 	case OPT_DEFAULT_PERMISSIONS:
 		ctx->default_permissions =3D true;
+		ctx->default_permissions_show =3D true;
 		break;
=20
 	case OPT_ALLOW_OTHER:
 		ctx->allow_other =3D true;
+		ctx->allow_other_show =3D true;
 		break;
=20
 	case OPT_MAX_READ:
@@ -553,14 +555,15 @@ static int fuse_show_options(struct seq_file *m, st=
ruct dentry *root)
 	struct super_block *sb =3D root->d_sb;
 	struct fuse_conn *fc =3D get_fuse_conn_super(sb);
=20
-	if (fc->no_mount_options)
-		return 0;
-
-	seq_printf(m, ",user_id=3D%u", from_kuid_munged(fc->user_ns, fc->user_i=
d));
-	seq_printf(m, ",group_id=3D%u", from_kgid_munged(fc->user_ns, fc->group=
_id));
-	if (fc->default_permissions)
+	if (fc->user_id_show)
+		seq_printf(m, ",user_id=3D%u",
+			   from_kuid_munged(fc->user_ns, fc->user_id));
+	if (fc->group_id_show)
+		seq_printf(m, ",group_id=3D%u",
+			   from_kgid_munged(fc->user_ns, fc->group_id));
+	if (fc->default_permissions && fc->default_permissions_show)
 		seq_puts(m, ",default_permissions");
-	if (fc->allow_other)
+	if (fc->allow_other && fc->allow_other_show)
 		seq_puts(m, ",allow_other");
 	if (fc->max_read !=3D ~0)
 		seq_printf(m, ",max_read=3D%u", fc->max_read);
@@ -1171,14 +1174,17 @@ int fuse_fill_super_common(struct super_block *sb=
, struct fuse_fs_context *ctx)
 	sb->s_flags |=3D SB_POSIXACL;
=20
 	fc->default_permissions =3D ctx->default_permissions;
+	fc->default_permissions_show =3D ctx->default_permissions_show;
 	fc->allow_other =3D ctx->allow_other;
+	fc->allow_other_show =3D ctx->allow_other_show;
 	fc->user_id =3D ctx->user_id;
+	fc->user_id_show =3D ctx->user_id_show;
 	fc->group_id =3D ctx->group_id;
+	fc->group_id_show =3D ctx->group_id_show;
 	fc->max_read =3D max_t(unsigned, 4096, ctx->max_read);
 	fc->destroy =3D ctx->destroy;
 	fc->no_control =3D ctx->no_control;
 	fc->no_force_umount =3D ctx->no_force_umount;
-	fc->no_mount_options =3D ctx->no_mount_options;
=20
 	err =3D -ENOMEM;
 	root =3D fuse_get_root_inode(sb, ctx->rootmode);
diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
index a16cc9195087..3f786a15b0d9 100644
--- a/fs/fuse/virtio_fs.c
+++ b/fs/fuse/virtio_fs.c
@@ -1060,7 +1060,6 @@ static int virtio_fs_fill_super(struct super_block =
*sb)
 		.destroy =3D true,
 		.no_control =3D true,
 		.no_force_umount =3D true,
-		.no_mount_options =3D true,
 	};
=20
 	mutex_lock(&virtio_fs_mutex);
--=20
2.20.1

