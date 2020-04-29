Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B3AEC83007
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 19:34:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1C399206D6
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 19:34:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=narfindustries.com header.i=@narfindustries.com header.b="gL05+r8l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727815AbgD2TeJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 15:34:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727774AbgD2TeE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 15:34:04 -0400
Received: from mail-ua1-x942.google.com (mail-ua1-x942.google.com [IPv6:2607:f8b0:4864:20::942])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0A91C035493
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 12:34:03 -0700 (PDT)
Received: by mail-ua1-x942.google.com with SMTP id i5so1452915uaq.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 12:34:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=narfindustries.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=byoUl3WWDZv0UcSfpTGX7lJO0zcZe0ssHJvgqM1+GGY=;
        b=gL05+r8lh2NhbG6Mib2C+MwCxJ2rTiWbsfneYbWjcOzVx8wo5GTh4t/fToB9LTCu/+
         HGoIl58GZgH7iI8H3qU0lt9RCjOLx/9T1w62M2ReYZcbyVayC4JfzOwHD9y3fLMhGgNE
         GWucsvrmWhkz5849E3RyJ0dU7Cv6dcVJp2Osbs1GU7BMa/oXrEdSo0lhcxfqbsLZZdr3
         zVCt0E/siqeySWaP3u0enAZWw/XosKBBRj7SrORJDIGD7xNR+bgO7XJSUXvUGGq/KBhv
         /sAikxn1HkEzFLxb9SSnk5VVdSdI41LQpwMRykbB+67t+S+xLtxvvHq6oYUtWrdXF0dY
         9wOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=byoUl3WWDZv0UcSfpTGX7lJO0zcZe0ssHJvgqM1+GGY=;
        b=cUr/+aar4Go22EMVJC1awIwqlenhFzFZyY2/OOPzLU/t1CGsbZddzoH2KROijNA81g
         1fO162PWE9M7qaJKrgpRYTJJSYqxUhRCi4G6yhEY99HMTc7dp9cGsw1Eq/sG2hM4A2OY
         8ouVuNEv36hESDowzwqXpn9QZZFDAY9nI/Ck58fbVfcP4xLN/FD676+hHHraLau3hHI3
         HeHBkPSE0bddNY2MV2hKAIeNDBp9uKYNK126vfhe4KZIz4/+d1ExCQZHmuLPTBVbp76t
         nyzNULrukzDfxy+OGaQTDYgNk7MYeyxfRQolSjc54xmTkDqvkm4CBB+yHfzqnXOPGORe
         CsMA==
X-Gm-Message-State: AGi0PuYvssjLf221ET9FL2R3+Of0oKSB2q462/mFM1+S/jBONe9CVXBv
        OE+xL3TE1VKOCD8RV02eOZdJbG3Ccb9kug==
X-Google-Smtp-Source: APiQypJIhL0g26QRYag7RFEQuE0DWQ/Q7MybojYuNBnGe0kvqij5pXnSKsJEY9MJGOgMpB08+6OIlw==
X-Received: by 2002:a9f:26e2:: with SMTP id 89mr24145592uay.104.1588188842430;
        Wed, 29 Apr 2020 12:34:02 -0700 (PDT)
Received: from localhost.localdomain ([24.171.221.68])
        by smtp.gmail.com with ESMTPSA id k26sm76764uag.10.2020.04.29.12.34.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2020 12:34:02 -0700 (PDT)
From:   Javier Malave <javier.malave@narfindustries.com>
To:     bx@narfindustries.com
Cc:     Javier Malave <javier.malave@narfindustries.com>,
        linux-kernel@vger.kernel.org, ah@narfindustries.com
Subject: [RFC 7/9] Virtual Memory Address Server for Distributed Thread Execution
Date:   Wed, 29 Apr 2020 15:32:54 -0400
Message-Id: <10fb2ec5acf90c3fe583b76343e5740ef84d367e.1588127445.git.javier.malave@narfindustries.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1588127445.git.javier.malave@narfindustries.com>
References: <0>
 <cover.1588127445.git.javier.malave@narfindustries.com>
In-Reply-To: <cover.1588127445.git.javier.malave@narfindustries.com>
References: <cover.1588127445.git.javier.malave@narfindustries.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Popcorn Linux implements software-based distributed
shared memory by extending Linux's virtual memory subsystem,
and enables processes on different machines to observe a
common and coherent virtual address space. Coherency of virtual
memory pages of different hosts is ensured using a
reader-replicate/writer-invalidate, page-level consistency protocol.

The VMA server's job is to implement the aforementioned protocol.
Currently this work is fully managed at the origin node.
Remote delegation of VMA operations is not supported except for
MUNMAP.
---
 include/popcorn/vma_server.h |  33 ++
 kernel/popcorn/vma_server.c  | 818 +++++++++++++++++++++++++++++++++++
 kernel/popcorn/vma_server.h  |  24 +
 3 files changed, 875 insertions(+)
 create mode 100644 include/popcorn/vma_server.h
 create mode 100644 kernel/popcorn/vma_server.c
 create mode 100644 kernel/popcorn/vma_server.h

diff --git a/include/popcorn/vma_server.h b/include/popcorn/vma_server.h
new file mode 100644
index 000000000..162f41368
--- /dev/null
+++ b/include/popcorn/vma_server.h
@@ -0,0 +1,33 @@
+// SPDX-License-Identifier: GPL-2.0, 3-clause BSD
+#ifndef INCLUDE_POPCORN_VMA_SERVER_H_
+#define INCLUDE_POPCORN_VMA_SERVER_H_
+
+
+/*
+ * VMA operation handlers for origin
+ */
+int vma_server_munmap_origin(unsigned long start, size_t len, int nid_except);
+
+
+/*
+ * Retrieve VMAs from origin
+ */
+int vma_server_fetch_vma(struct task_struct *tsk, unsigned long address);
+
+/*
+ * VMA operation handler for remote
+ */
+unsigned long vma_server_mmap_remote(struct file *file, unsigned long addr,
+				     unsigned long len, unsigned long prot,
+				     unsigned long flags, unsigned long pgoff);
+
+int vma_server_munmap_remote(unsigned long start, size_t len);
+int vma_server_brk_remote(unsigned long oldbrk, unsigned long brk);
+int vma_server_madvise_remote(unsigned long start, size_t len, int behavior);
+int vma_server_mprotect_remote(unsigned long start, size_t len,
+			       unsigned long prot);
+int vma_server_mremap_remote(unsigned long addr, unsigned long old_len,
+			     unsigned long new_len, unsigned long flags,
+			     unsigned long new_addr);
+
+#endif /* INCLUDE_POPCORN_VMA_SERVER_H_ */
diff --git a/kernel/popcorn/vma_server.c b/kernel/popcorn/vma_server.c
new file mode 100644
index 000000000..256267c0e
--- /dev/null
+++ b/kernel/popcorn/vma_server.c
@@ -0,0 +1,818 @@
+// SPDX-License-Identifier: GPL-2.0, BSD
+/*
+ * /kernel/popcorn/vma_server.c
+ *
+ * Popcorn Linux VMA handler implementation.
+ *
+ * VMA Server implements a reader-replicate/
+ * writer invalidate page-level coherency protocol.
+ *
+ * This work was an extension of David Katz MS Thesis,
+ * rewritten by Sang-Hoon to support multithread environment.
+ *
+ * author, Javier Malave, Rebecca Shapiro, Andrew Hughes,
+ * Narf Industries 2020 (modifications for upstream RFC)
+ * author Sang-Hoon Kim, SSRG Virginia Tech 2016-2017
+ * author Vincent Legout, Antonio Barbalace, SSRG Virginia Tech 2016
+ * author Ajith Saya, Sharath Bhat, SSRG Virginia Tech 2015
+ * author Marina Sadini, Antonio Barbalace, SSRG Virginia Tech 2014
+ * author Marina Sadini, SSRG Virginia Tech 2013
+ */
+
+#include <linux/slab.h>
+#include <linux/mm.h>
+#include <linux/kthread.h>
+
+#include <linux/mman.h>
+#include <linux/highmem.h>
+#include <linux/ptrace.h>
+#include <linux/sched/mm.h>
+#include <linux/elf.h>
+#include <linux/syscalls.h>
+#include <popcorn/bundle.h>
+
+#include "types.h"
+#include "util.h"
+#include "vma_server.h"
+#include "page_server.h"
+#include "wait_station.h"
+
+
+const char *vma_op_code_sz[] = {
+	"mmap", "munmap", "mprotect", "mremap", "madvise", "brk"
+};
+
+/*
+ *   This function performs a diff between all VMA's pcorand the current VMA
+ */
+static unsigned long map_difference(struct mm_struct *mm, struct file *file,
+				    unsigned long start, unsigned long end,
+				    unsigned long prot, unsigned long flags,
+				    unsigned long pgoff)
+{
+	unsigned long ret = start;
+	unsigned long error;
+	unsigned long populate = 0;
+	struct vm_area_struct *vma;
+
+	VSPRINTK("  [%d] map+ %lx %lx\n", current->pid, start, end);
+	for (vma = current->mm->mmap; start < end; vma = vma->vm_next) {
+
+		if (vma == NULL || end <= vma->vm_start) {
+			/*
+			 * We've reached the end of the list, or the VMA is fully
+			 * above the region of interest
+			 */
+			VSPRINTK("  [%d] map0 %lx -- %lx @ %lx, %lx\n", current->pid,
+					start, end, pgoff, prot);
+			error = do_mmap_pgoff(file, start, end - start,
+					      prot, flags, pgoff, &populate, NULL);
+			if (error != start) {
+				ret = VM_FAULT_SIGBUS;
+			}
+			break;
+		} else if (start >= vma->vm_start && end <= vma->vm_end) {
+			/*
+			 * VMA fully encompases the region of interest. nothing to do
+			 */
+			break;
+		} else if (start >= vma->vm_start
+				&& start < vma->vm_end && end > vma->vm_end) {
+			/*
+			 * VMA includes the start of the region of interest
+			 * but not the end. advance start (no mapping to do)
+			 */
+			pgoff += ((vma->vm_end - start) >> PAGE_SHIFT);
+			start = vma->vm_end;
+		} else if (start < vma->vm_start
+				&& vma->vm_start < end && end <= vma->vm_end) {
+			/*
+			 * VMA includes the end of the region of interest
+			 * but not the start
+			 */
+			VSPRINTK("  [%d] map1 %lx -- %lx @ %lx\n", current->pid,
+					start, vma->vm_start, pgoff);
+			error = do_mmap_pgoff(file, start, vma->vm_start - start,
+					      prot, flags, pgoff, &populate, NULL);
+			if (error != start) {
+				ret = VM_FAULT_SIGBUS;;
+			}
+			break;
+		} else if (start <= vma->vm_start && vma->vm_end <= end) {
+			/* VMA is fully within the region of interest */
+			VSPRINTK("  [%d] map2 %lx -- %lx @ %lx\n", current->pid,
+					start, vma->vm_start, pgoff);
+			error = do_mmap_pgoff(file, start, vma->vm_start - start,
+					      prot, flags, pgoff, &populate, NULL);
+			if (error != start) {
+				ret = VM_FAULT_SIGBUS;
+				break;
+			}
+
+			/*
+			 * Then advance to the end of this VMA
+			 */
+			pgoff += ((vma->vm_end - start) >> PAGE_SHIFT);
+			start = vma->vm_end;
+		}
+	}
+	WARN_ON(populate);
+	return ret;
+}
+
+/*
+ * VMA operation delegators at remotes
+ */
+static vma_op_request_t *__alloc_vma_op_request(enum vma_op_code opcode)
+{
+	vma_op_request_t *req = kmalloc(sizeof(*req), GFP_KERNEL);
+
+	if(!req)
+		return req;
+
+	req->origin_pid = current->origin_pid,
+	req->remote_pid = current->pid,
+	req->operation = opcode;
+
+	return req;
+}
+
+static int __delegate_vma_op(vma_op_request_t *req, vma_op_response_t **resp)
+{
+	vma_op_response_t *res;
+	struct wait_station *ws = get_wait_station(current);
+
+	req->remote_ws = ws->id;
+
+	pcn_kmsg_send(PCN_KMSG_TYPE_VMA_OP_REQUEST,
+			current->origin_nid, req, sizeof(*req));
+	res = wait_at_station(ws);
+	WARN_ON(res->operation != req->operation);
+
+	*resp = res;
+	return res->ret;
+}
+
+static int handle_vma_op_response(struct pcn_kmsg_message *msg)
+{
+	vma_op_response_t *res = (vma_op_response_t *)msg;
+	struct wait_station *ws = wait_station(res->remote_ws);
+
+	ws->private = res;
+	complete(&ws->pendings);
+
+	return 0;
+}
+
+unsigned long vma_server_mmap_remote(struct file *file,
+				     unsigned long addr, unsigned long len,
+				     unsigned long prot, unsigned long flags,
+				     unsigned long pgoff)
+{
+	unsigned long ret = 0;
+	vma_op_request_t *req;
+	vma_op_response_t *res;
+
+	if(!(req = __alloc_vma_op_request(VMA_OP_MMAP)))
+		return -ENOMEM;
+
+	req->addr = addr;
+	req->len = len;
+	req->prot = prot;
+	req->flags = flags;
+	req->pgoff = pgoff;
+	get_file_path(file, req->path, sizeof(req->path));
+
+	VSPRINTK("\n## VMA mmap [%d] %lx - %lx, %lx %lx\n", current->pid,
+			addr, addr + len, prot, flags);
+	if (req->path[0] != '\0') {
+		VSPRINTK("  [%d] %s\n", current->pid, req->path);
+	}
+
+	ret = __delegate_vma_op(req, &res);
+
+	VSPRINTK("  [%d] %ld %lx -- %lx\n", current->pid,
+			ret, res->addr, res->addr + res->len);
+
+	if (ret)
+		goto out_free;
+
+	while (!down_write_trylock(&current->mm->mmap_sem)) {
+		schedule();
+	}
+	ret = map_difference(current->mm, file, res->addr, res->addr + res->len,
+			prot, flags, pgoff);
+	up_write(&current->mm->mmap_sem);
+
+out_free:
+	kfree(req);
+	pcn_kmsg_done(res);
+
+	return ret;
+}
+
+int vma_server_munmap_remote(unsigned long start, size_t len)
+{
+	int ret;
+	vma_op_request_t *req;
+	vma_op_response_t *res;
+
+	VSPRINTK("\n## VMA munmap [%d] %lx %lx\n", current->pid, start, len);
+
+	ret = vm_munmap(start, len);
+	if (ret)
+		return ret;
+
+	if(!(req = __alloc_vma_op_request(VMA_OP_MUNMAP)))
+		return -ENOMEM;
+
+	req->addr = start;
+	req->len = len;
+
+	ret = __delegate_vma_op(req, &res);
+
+	VSPRINTK("  [%d] %d %lx -- %lx\n", current->pid,
+			ret, res->addr, res->addr + res->len);
+
+	kfree(req);
+	pcn_kmsg_done(res);
+
+	return ret;
+}
+
+int vma_server_brk_remote(unsigned long oldbrk, unsigned long brk)
+{
+	int ret;
+	vma_op_request_t *req;
+	vma_op_response_t *res;
+
+	if(!(req = __alloc_vma_op_request(VMA_OP_BRK)))
+		return -ENOMEM;
+
+	req->brk = brk;
+
+	VSPRINTK("\n## VMA brk-ed [%d] %lx --> %lx\n", current->pid, oldbrk, brk);
+
+	ret = __delegate_vma_op(req, &res);
+
+	VSPRINTK("  [%d] %d %lx\n", current->pid, ret, res->brk);
+
+	kfree(req);
+	pcn_kmsg_done(res);
+
+	return ret;
+}
+
+int vma_server_madvise_remote(unsigned long start, size_t len, int behavior)
+{
+	int ret;
+	vma_op_request_t *req;
+	vma_op_response_t *res;
+
+	if(!(req = __alloc_vma_op_request(VMA_OP_MADVISE)))
+		return -ENOMEM;
+
+	req->addr = start;
+	req->len = len;
+	req->behavior = behavior;
+
+	VSPRINTK("\n## VMA madvise-d [%d] %lx %lx %d\n", current->pid,
+			start, len, behavior);
+
+	ret = __delegate_vma_op(req, &res);
+
+	VSPRINTK("  [%d] %d %lx -- %lx %d\n", current->pid,
+			ret, res->addr, res->addr + res->len, behavior);
+
+	kfree(req);
+	pcn_kmsg_done(res);
+
+	return ret;
+}
+
+int vma_server_mprotect_remote(unsigned long start, size_t len,
+			       unsigned long prot)
+{
+	int ret;
+	vma_op_request_t *req;
+	vma_op_response_t *res;
+
+	if(!(req = __alloc_vma_op_request(VMA_OP_MPROTECT)))
+		return -ENOMEM;
+
+	req->start = start;
+	req->len = len;
+	req->prot = prot;
+
+	VSPRINTK("\nVMA mprotect [%d] %lx %lx %lx\n", current->pid,
+			start, len, prot);
+
+	ret = __delegate_vma_op(req, &res);
+
+	VSPRINTK("  [%d] %d %lx -- %lx %lx\n", current->pid,
+			ret, res->start, res->start + res->len, prot);
+
+	kfree(req);
+	pcn_kmsg_done(res);
+
+	return ret;
+}
+
+int vma_server_mremap_remote(unsigned long addr, unsigned long old_len,
+			     unsigned long new_len, unsigned long flags,
+			     unsigned long new_addr)
+{
+	WARN_ON_ONCE("Does not support remote mremap yet");
+	VSPRINTK("\nVMA mremap [%d] %lx %lx %lx %lx %lx\n", current->pid,
+			addr, old_len, new_len, flags, new_addr);
+	return -EINVAL;
+}
+
+
+/*
+ * VMA handlers for origin
+ */
+int vma_server_munmap_origin(unsigned long start, size_t len, int nid_except)
+{
+	int nid;
+	vma_op_request_t *req;
+	struct remote_context *rc = get_task_remote(current);
+
+	if(!(req = __alloc_vma_op_request(VMA_OP_MUNMAP)))
+		return -ENOMEM;
+
+	req->start = start;
+	req->len = len;
+
+	for (nid = 0; nid < MAX_POPCORN_NODES; nid++) {
+		struct wait_station *ws;
+		vma_op_response_t *res;
+
+		if (!get_popcorn_node_online(nid) || !rc->remote_tgids[nid])
+			continue;
+
+		if (nid == my_nid || nid == nid_except)
+			continue;
+
+		ws = get_wait_station(current);
+		req->remote_ws = ws->id;
+		req->origin_pid = rc->remote_tgids[nid];
+
+		VSPRINTK("  [%d] ->munmap [%d/%d] %lx+%lx\n", current->pid,
+				req->origin_pid, nid, start, len);
+		pcn_kmsg_send(PCN_KMSG_TYPE_VMA_OP_REQUEST, nid, req, sizeof(*req));
+		res = wait_at_station(ws);
+	}
+	kfree(req);
+	put_task_remote(current);
+
+	vm_munmap(start, len);
+	return 0;
+}
+
+/*
+ * VMA worker
+ *
+ * We do this because functions related to memory mapping operate
+ * on "current". Thus, we need mmap/munmap/madvise in our process
+ */
+static void __reply_vma_op(vma_op_request_t *req, long ret)
+{
+	vma_op_response_t *res = pcn_kmsg_get(sizeof(*res));
+
+	res->origin_pid = current->pid;
+	res->remote_pid = req->remote_pid;
+	res->remote_ws = req->remote_ws;
+
+	res->operation = req->operation;
+	res->ret = ret;
+	res->addr = req->addr;
+	res->len = req->len;
+
+	pcn_kmsg_post(PCN_KMSG_TYPE_VMA_OP_RESPONSE,
+			PCN_KMSG_FROM_NID(req), res, sizeof(*res));
+}
+
+/*
+ * Handle delegated VMA operations
+ * Currently, the remote worker only handles munmap VMA operations.
+ */
+static long __process_vma_op_at_remote(vma_op_request_t *req)
+{
+	long ret = -EPERM;
+
+	switch (req->operation) {
+	case VMA_OP_MUNMAP:
+		ret = vm_munmap(req->addr, req->len);
+		break;
+	case VMA_OP_MMAP:
+	case VMA_OP_MPROTECT:
+	case VMA_OP_MREMAP:
+	case VMA_OP_BRK:
+	case VMA_OP_MADVISE:
+		WARN_ON("Not implemented yet");
+		break;
+	default:
+		WARN_ON("unreachable");
+	}
+	return ret;
+}
+
+static long __process_vma_op_at_origin(vma_op_request_t *req)
+{
+	long ret = -EPERM;
+	int from_nid = PCN_KMSG_FROM_NID(req);
+
+	switch (req->operation) {
+	case VMA_OP_MMAP: {
+		unsigned long populate = 0;
+		unsigned long raddr;
+		struct file *f = NULL;
+		struct mm_struct *mm = get_task_mm(current);
+
+		if (req->path[0] != '\0')
+			f = filp_open(req->path, O_RDONLY | O_LARGEFILE, 0);
+
+		if (IS_ERR(f)) {
+			ret = PTR_ERR(f);
+			printk("  [%d] Cannot open %s %ld\n", current->pid, req->path, ret);
+			mmput(mm);
+			break;
+		}
+		down_write(&mm->mmap_sem);
+		raddr = do_mmap_pgoff(f, req->addr, req->len, req->prot,
+				      req->flags, req->pgoff, &populate, NULL);
+		up_write(&mm->mmap_sem);
+		if (populate)
+			mm_populate(raddr, populate);
+
+		ret = IS_ERR_VALUE(raddr) ? raddr : 0;
+		req->addr = raddr;
+		VSPRINTK("  [%d] %lx %lx -- %lx %lx %lx\n", current->pid,
+				ret, req->addr, req->addr + req->len, req->prot, req->flags);
+
+		if (f)
+			filp_close(f, NULL);
+		mmput(mm);
+		break;
+	}
+	case VMA_OP_BRK: {
+		unsigned long brk = req->brk;
+		req->brk = ksys_brk(req->brk);
+		ret = brk != req->brk;
+		break;
+	}
+	case VMA_OP_MUNMAP:
+		ret = vma_server_munmap_origin(req->addr, req->len, from_nid);
+		break;
+	case VMA_OP_MPROTECT:
+		ret = ksys_mprotect(req->addr, req->len, req->prot);
+		break;
+	case VMA_OP_MREMAP:
+		ret = ksys_mremap(req->addr, req->old_len, req->new_len,
+				  req->flags, req->new_addr);
+		break;
+	case VMA_OP_MADVISE:
+		if (req->behavior == MADV_RELEASE) {
+			ret = process_madvise_release_from_remote(
+					from_nid, req->start, req->start + req->len);
+		} else {
+			ret = ksys_madvise(req->start, req->len, req->behavior);
+		}
+		break;
+	default:
+		WARN_ON("unreachable");
+	}
+
+	return ret;
+}
+
+void process_vma_op_request(vma_op_request_t *req)
+{
+	long ret = 0;
+	VSPRINTK("\nVMA_OP_REQUEST [%d] %s %lx %lx\n", current->pid,
+			vma_op_code_sz[req->operation], req->addr, req->len);
+
+	if (current->at_remote) {
+		ret = __process_vma_op_at_remote(req);
+	} else {
+		ret = __process_vma_op_at_origin(req);
+	}
+
+	VSPRINTK("  [%d] ->%s %ld\n", current->pid,
+			vma_op_code_sz[req->operation], ret);
+
+	__reply_vma_op(req, ret);
+	pcn_kmsg_done(req);
+}
+
+/*
+ * Response for remote VMA request and handling the response
+ */
+struct vma_info {
+	struct list_head list;
+	unsigned long addr;
+	atomic_t pendings;
+	struct completion complete;
+	wait_queue_head_t pendings_wait;
+
+	volatile int ret;
+	volatile vma_info_response_t *response;
+};
+
+static struct vma_info *__lookup_pending_vma_request(struct remote_context *rc,
+						     unsigned long addr)
+{
+	struct vma_info *vi;
+
+	list_for_each_entry(vi, &rc->vmas, list) {
+		if (vi->addr == addr) return vi;
+	}
+	return NULL;
+}
+
+static int handle_vma_info_response(struct pcn_kmsg_message *msg)
+{
+	vma_info_response_t *res = (vma_info_response_t *)msg;
+	struct task_struct *tsk;
+	unsigned long flags;
+	struct vma_info *vi;
+	struct remote_context *rc;
+
+	tsk = __get_task_struct(res->remote_pid);
+	if (WARN_ON(!tsk)) {
+		goto out_free;
+	}
+	rc = get_task_remote(tsk);
+
+	spin_lock_irqsave(&rc->vmas_lock, flags);
+	vi = __lookup_pending_vma_request(rc, res->addr);
+	spin_unlock_irqrestore(&rc->vmas_lock, flags);
+	put_task_remote(tsk);
+	put_task_struct(tsk);
+
+	if (WARN_ON(!vi)) {
+		goto out_free;
+	}
+
+	vi->response = res;
+	complete(&vi->complete);
+	return 0;
+
+out_free:
+	pcn_kmsg_done(res);
+	return 0;
+}
+
+/*
+ * Handle VMA info requests at the origin.
+ * This is invoked through the remote work delegation.
+ */
+void process_vma_info_request(vma_info_request_t *req)
+{
+	vma_info_response_t *res = NULL;
+	struct mm_struct *mm;
+	struct vm_area_struct *vma;
+	unsigned long addr = req->addr;
+
+	might_sleep();
+
+	while (!res) {
+		res = kmalloc(sizeof(*res), GFP_KERNEL);
+	}
+	res->addr = addr;
+
+	mm = get_task_mm(current);
+	down_read(&mm->mmap_sem);
+
+	vma = find_vma(mm, addr);
+	if (unlikely(!vma)) {
+		printk("vma_info: vma does not exist at %lx\n", addr);
+		res->result = -ENOENT;
+		goto out_up;
+	}
+	if (likely(vma->vm_start <= addr)) {
+		goto good;
+	}
+	if (unlikely(!(vma->vm_flags & VM_GROWSDOWN))) {
+		printk("vma_info: vma does not really exist at %lx\n", addr);
+		res->result = -ENOENT;
+		goto out_up;
+	}
+
+good:
+	res->vm_start = vma->vm_start;
+	res->vm_end = vma->vm_end;
+	res->vm_flags = vma->vm_flags;
+	res->vm_pgoff = vma->vm_pgoff;
+
+	get_file_path(vma->vm_file, res->vm_file_path, sizeof(res->vm_file_path));
+	res->result = 0;
+
+out_up:
+	up_read(&mm->mmap_sem);
+	mmput(mm);
+
+	if (res->result == 0) {
+		VSPRINTK("\n## VMA_INFO [%d] %lx -- %lx %lx\n", current->pid,
+				res->vm_start, res->vm_end, res->vm_flags);
+		if (!vma_info_anon(res)) {
+			VSPRINTK("  [%d] %s + %lx\n", current->pid,
+					res->vm_file_path, res->vm_pgoff);
+		}
+	}
+
+	res->remote_pid = req->remote_pid;
+	pcn_kmsg_send(PCN_KMSG_TYPE_VMA_INFO_RESPONSE,
+			PCN_KMSG_FROM_NID(req), res, sizeof(*res));
+
+	pcn_kmsg_done(req);
+	kfree(res);
+	return;
+}
+
+
+static struct vma_info *__alloc_vma_info_request(struct task_struct *tsk,
+						 unsigned long addr,
+						 vma_info_request_t **preq)
+{
+	struct vma_info *vi = kmalloc(sizeof(*vi), GFP_KERNEL);
+	vma_info_request_t *req = kmalloc(sizeof(*req), GFP_KERNEL);
+
+	if(!vi || !req)
+		return vi;
+
+	INIT_LIST_HEAD(&vi->list);
+	vi->addr = addr;
+	vi->response = (volatile vma_info_response_t *)0xdeadbeaf;
+	atomic_set(&vi->pendings, 0);
+	init_completion(&vi->complete);
+	init_waitqueue_head(&vi->pendings_wait);
+
+	req->origin_pid = tsk->origin_pid;
+	req->remote_pid = tsk->pid;
+	req->addr = addr;
+
+	*preq = req;
+
+	return vi;
+}
+
+static int __update_vma(struct task_struct *tsk, vma_info_response_t *res)
+{
+	struct mm_struct *mm = tsk->mm;
+	struct vm_area_struct *vma;
+	unsigned long prot;
+	unsigned flags = MAP_FIXED;
+	struct file *f = NULL;
+	unsigned long err = 0;
+	int ret = 0;
+	unsigned long addr = res->addr;
+
+	if (res->result) {
+		down_read(&mm->mmap_sem);
+		return res->result;
+	}
+
+	while (!down_write_trylock(&mm->mmap_sem)) {
+		schedule();
+	}
+	vma = find_vma(mm, addr);
+	VSPRINTK("  [%d] %lx %lx\n", tsk->pid, vma ? vma->vm_start : 0, addr);
+
+	if (vma && vma->vm_start <= addr)
+		goto out;
+
+	if (vma_info_anon(res)) {
+		flags |= MAP_ANONYMOUS;
+	} else {
+		f = filp_open(res->vm_file_path, O_RDONLY | O_LARGEFILE, 0);
+		if (IS_ERR(f)) {
+			printk(KERN_ERR"%s: cannot find backing file %s\n",__func__,
+				res->vm_file_path);
+			ret = -EIO;
+			goto out;
+		}
+
+		VSPRINTK("  [%d] %s + %lx\n", tsk->pid,
+				res->vm_file_path, res->vm_pgoff);
+	}
+
+	prot  = ((res->vm_flags & VM_READ) ? PROT_READ : 0)
+			| ((res->vm_flags & VM_WRITE) ? PROT_WRITE : 0)
+			| ((res->vm_flags & VM_EXEC) ? PROT_EXEC : 0);
+
+	flags = flags
+			| ((res->vm_flags & VM_DENYWRITE) ? MAP_DENYWRITE : 0)
+			| ((res->vm_flags & VM_SHARED) ? MAP_SHARED : MAP_PRIVATE)
+			| ((res->vm_flags & VM_GROWSDOWN) ? MAP_GROWSDOWN : 0);
+
+	err = map_difference(mm, f, res->vm_start, res->vm_end,
+				prot, flags, res->vm_pgoff);
+
+	if (f) filp_close(f, NULL);
+
+out:
+	downgrade_write(&mm->mmap_sem);
+	return ret;
+}
+
+/*
+ * Fetch VMA information from the origin.
+ * mm->mmap_sem is down_read() at this point and should be downed upon return.
+ */
+int vma_server_fetch_vma(struct task_struct *tsk, unsigned long address)
+{
+	struct vma_info *vi = NULL;
+	unsigned long flags;
+	DEFINE_WAIT(wait);
+	int ret = 0;
+	unsigned long addr = address & PAGE_MASK;
+	vma_info_request_t *req = NULL;
+	struct remote_context *rc = get_task_remote(tsk);
+
+	might_sleep();
+
+	VSPRINTK("\n## VMAFAULT [%d] %lx %lx\n", current->pid,
+			address, instruction_pointer(current_pt_regs()));
+
+	spin_lock_irqsave(&rc->vmas_lock, flags);
+	vi = __lookup_pending_vma_request(rc, addr);
+	if (!vi) {
+		struct vma_info *v;
+		spin_unlock_irqrestore(&rc->vmas_lock, flags);
+
+		vi = __alloc_vma_info_request(tsk, addr, &req);
+
+		if(!vi || !req)
+			return -ENOMEM;
+
+		spin_lock_irqsave(&rc->vmas_lock, flags);
+		v = __lookup_pending_vma_request(rc, addr);
+		if (!v) {
+			list_add(&vi->list, &rc->vmas);
+		} else {
+			kfree(vi);
+			vi = v;
+			kfree(req);
+			req = NULL;
+		}
+	}
+	up_read(&tsk->mm->mmap_sem);
+
+	if (req) {
+		spin_unlock_irqrestore(&rc->vmas_lock, flags);
+
+		VSPRINTK("  [%d] %lx ->[%d/%d]\n", current->pid,
+				addr, tsk->origin_pid, tsk->origin_nid);
+		pcn_kmsg_send(PCN_KMSG_TYPE_VMA_INFO_REQUEST,
+				tsk->origin_nid, req, sizeof(*req));
+		wait_for_completion(&vi->complete);
+
+		ret = vi->ret =
+			__update_vma(tsk, (vma_info_response_t *)vi->response);
+
+		spin_lock_irqsave(&rc->vmas_lock, flags);
+		list_del(&vi->list);
+		spin_unlock_irqrestore(&rc->vmas_lock, flags);
+
+		pcn_kmsg_done((void *)vi->response);
+		wake_up_all(&vi->pendings_wait);
+
+		kfree(req);
+	} else {
+		VSPRINTK("  [%d] %lx already pended\n", current->pid, addr);
+		atomic_inc(&vi->pendings);
+		prepare_to_wait(&vi->pendings_wait, &wait, TASK_UNINTERRUPTIBLE);
+		spin_unlock_irqrestore(&rc->vmas_lock, flags);
+
+		io_schedule();
+		finish_wait(&vi->pendings_wait, &wait);
+
+		smp_rmb();
+		ret = vi->ret;
+		if (atomic_dec_and_test(&vi->pendings)) {
+			kfree(vi);
+		}
+		down_read(&tsk->mm->mmap_sem);
+	}
+
+	put_task_remote(tsk);
+	return ret;
+}
+
+DEFINE_KMSG_RW_HANDLER(vma_info_request, vma_info_request_t, origin_pid);
+DEFINE_KMSG_RW_HANDLER(vma_op_request, vma_op_request_t, origin_pid);
+
+int vma_server_init(void)
+{
+	REGISTER_KMSG_HANDLER(
+			PCN_KMSG_TYPE_VMA_INFO_REQUEST, vma_info_request);
+	REGISTER_KMSG_HANDLER(
+			PCN_KMSG_TYPE_VMA_INFO_RESPONSE, vma_info_response);
+
+	REGISTER_KMSG_HANDLER(PCN_KMSG_TYPE_VMA_OP_REQUEST, vma_op_request);
+	REGISTER_KMSG_HANDLER(PCN_KMSG_TYPE_VMA_OP_RESPONSE, vma_op_response);
+
+	return 0;
+}
diff --git a/kernel/popcorn/vma_server.h b/kernel/popcorn/vma_server.h
new file mode 100644
index 000000000..7ca760a85
--- /dev/null
+++ b/kernel/popcorn/vma_server.h
@@ -0,0 +1,24 @@
+// SPDX-License-Identifier: GPL-2.0, BSD
+#ifndef __INTERNAL_VMA_SERVER_H_
+#define __INTERNAL_VMA_SERVER_H_
+
+#include <popcorn/vma_server.h>
+
+enum vma_op_code {
+	VMA_OP_NOP = -1,
+	VMA_OP_MMAP,
+	VMA_OP_MUNMAP,
+	VMA_OP_MPROTECT,
+	VMA_OP_MREMAP,
+	VMA_OP_MADVISE,
+	VMA_OP_BRK,
+	VMA_OP_MAX,
+};
+
+struct remote_context;
+
+void process_vma_info_request(vma_info_request_t *req);
+
+void process_vma_op_request(vma_op_request_t *req);
+
+#endif /* __INTERNAL_VMA_SERVER_H_ */
-- 
2.17.1

