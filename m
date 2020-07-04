Return-Path: <SRS0=f/ZA=AP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF7EDC433DF
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jul 2020 20:56:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A1EC42145D
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jul 2020 20:56:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727878AbgGDU4l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Jul 2020 16:56:41 -0400
Received: from lilium.sigma-star.at ([109.75.188.150]:50074 "EHLO
        lilium.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726909AbgGDU4l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jul 2020 16:56:41 -0400
Received: from localhost (localhost [127.0.0.1])
        by lilium.sigma-star.at (Postfix) with ESMTP id 03F671819104B;
        Sat,  4 Jul 2020 22:56:39 +0200 (CEST)
Received: from lilium.sigma-star.at ([127.0.0.1])
        by localhost (lilium.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id X0Mx8iv6AOr7; Sat,  4 Jul 2020 22:56:38 +0200 (CEST)
Received: from lilium.sigma-star.at ([127.0.0.1])
        by localhost (lilium.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id VXH1s3sMiXyH; Sat,  4 Jul 2020 22:56:38 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     linux-kernel@vger.kernel.org
Cc:     tj@kernel.org, gregkh@linuxfoundation.org, ebiederm@xmission.com,
        dan.j.williams@intel.com, Richard Weinberger <richard@nod.at>
Subject: [PATCH] [RFC] kernfs: Allow vm_ops->close() if VMA is never split
Date:   Sat,  4 Jul 2020 22:56:19 +0200
Message-Id: <20200704205619.11172-1-richard@nod.at>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

10 years ago commit a6849fa1f7d7 ("sysfs: Fail bin file mmap if vma close=
 is implemented.")
removed support for vm_ops->close() for mmap on sysfs.
As far I understand the reason is that due to the wrapping in kernfs
every VMA split operation needs to be tracked to call vm_ops->close()
for all fragments. This is not feasible with reasonable effort.

Since commit 31383c6865a5 ("mm, hugetlbfs: introduce ->split() to vm_oper=
ations_struct")
we can get notified as soon a VMA is split, this can help to relax the re=
striction.
So I propose to allow having a custom close under the condition that a
VMA cannot get split.

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 fs/kernfs/file.c | 42 ++++++++++++++++++++++++++++++++++--------
 1 file changed, 34 insertions(+), 8 deletions(-)

diff --git a/fs/kernfs/file.c b/fs/kernfs/file.c
index 06b342d8462b..82b09e72acff 100644
--- a/fs/kernfs/file.c
+++ b/fs/kernfs/file.c
@@ -347,6 +347,38 @@ static void kernfs_vma_open(struct vm_area_struct *v=
ma)
 	kernfs_put_active(of->kn);
 }
=20
+static void kernfs_vma_close(struct vm_area_struct *vma)
+{
+	struct file *file =3D vma->vm_file;
+	struct kernfs_open_file *of =3D kernfs_of(file);
+
+	if (!of->vm_ops)
+		return;
+
+	if (!kernfs_get_active(of->kn))
+		return;
+
+	if (of->vm_ops->close)
+		of->vm_ops->close(vma);
+
+	kernfs_put_active(of->kn);
+}
+
+static int kernfs_vma_split(struct vm_area_struct *vma, unsigned long ad=
dr)
+{
+	struct file *file =3D vma->vm_file;
+	struct kernfs_open_file *of =3D kernfs_of(file);
+
+	/*
+	 * We cannot keep track of split operations,
+	 * so refuse splitting a VMA if someone uses close.
+	 */
+	if (of->vm_ops && of->vm_ops->close)
+		return -EINVAL;
+
+	return 0;
+}
+
 static vm_fault_t kernfs_vma_fault(struct vm_fault *vmf)
 {
 	struct file *file =3D vmf->vma->vm_file;
@@ -457,6 +489,8 @@ static struct mempolicy *kernfs_vma_get_policy(struct=
 vm_area_struct *vma,
=20
 static const struct vm_operations_struct kernfs_vm_ops =3D {
 	.open		=3D kernfs_vma_open,
+	.close		=3D kernfs_vma_close,
+	.split		=3D kernfs_vma_split,
 	.fault		=3D kernfs_vma_fault,
 	.page_mkwrite	=3D kernfs_vma_page_mkwrite,
 	.access		=3D kernfs_vma_access,
@@ -505,14 +539,6 @@ static int kernfs_fop_mmap(struct file *file, struct=
 vm_area_struct *vma)
 	if (of->mmapped && of->vm_ops !=3D vma->vm_ops)
 		goto out_put;
=20
-	/*
-	 * It is not possible to successfully wrap close.
-	 * So error if someone is trying to use close.
-	 */
-	rc =3D -EINVAL;
-	if (vma->vm_ops && vma->vm_ops->close)
-		goto out_put;
-
 	rc =3D 0;
 	of->mmapped =3D true;
 	of->vm_ops =3D vma->vm_ops;
--=20
2.26.2

