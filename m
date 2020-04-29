Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A14BEC83004
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 19:34:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D47D2082E
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 19:34:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=narfindustries.com header.i=@narfindustries.com header.b="N6LFgR8d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727842AbgD2TeS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 15:34:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727824AbgD2TeN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 15:34:13 -0400
Received: from mail-vs1-xe42.google.com (mail-vs1-xe42.google.com [IPv6:2607:f8b0:4864:20::e42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC5D3C03C1AE
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 12:34:12 -0700 (PDT)
Received: by mail-vs1-xe42.google.com with SMTP id g184so2200091vsc.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 12:34:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=narfindustries.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=p9PrLrx0+PcUYGnxN/eSizpZhG/bx9CsUYj3IDgBEk8=;
        b=N6LFgR8d5S5AMds85NUHbvamKg3LkUyJI/OVaUMPMTUsN9Z9gqkzC56gPOLjXodXC0
         lDtcbkyl5GUl6lRgZIcMWx0HY48nKRXks1O6JHFZkgTx+pNTkWskRFxaWo/jZAp1qr5V
         nZtZtr5nURp9dS+X8aFXYS3X+7knUi1AcDe+CVuMKZJ/mXFgh8AuePR3vDKPdbZSfodI
         TT+asAAg7YM7DkhhgISKAousADFAgBXk/tTv4KxmSETATAl02oNxC8uya3yOqfERh30I
         bOrmpN6DZmGqFto1pzlyzw4UNxbp73xJFuZHvEX8DL8qvB9ZbyCQH6k3Dc1VdTa4tJPM
         B41g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=p9PrLrx0+PcUYGnxN/eSizpZhG/bx9CsUYj3IDgBEk8=;
        b=QWzGvIvu1BAYWsR00enba8YFxmdJ9TxhsiLcSprFY+jnX+7vh4/l5cGCG0xq2PR+gE
         V9xPdN1GeXwDec0LRoQEGlYPK/vCaF9cati7hqnzVX8WU/6+4OYcIN9ouPYAfTauAXfn
         ub4A2HTTyMbVMDQxzi8JphTgOW9Ac2RXrf1rRH5l9TV0Ny4zs1xu5fz/LbNWKrAOuX/o
         4/a1jE6DL9P06Ia6rfJ0paQOlTcjZN19USMfwBthTqJsDBdL6eYn6E/uEIOfvn7IpFMt
         /6D9alz+fJYHyiphSK0jmF4MnAyTdkW36bSfeIeGs+uVmU+6VT8z7PMtKrxWx5fjmfh+
         FmDQ==
X-Gm-Message-State: AGi0PuZZ9A/4dRJj3heUqGE5Xyo9bXfi/5qR6EJ06IUxq2nAy7Ag1/zz
        F7dPZ7TJzabSsffxckZAKpAMug==
X-Google-Smtp-Source: APiQypI09d8jJJ7MXfPPydMi1pAL/sUuWjuveZ+VtznLIehRxQfXFx2b1F0ICzHFkDxqmQnCvW2yBA==
X-Received: by 2002:a05:6102:1c3:: with SMTP id s3mr47238vsq.56.1588188851423;
        Wed, 29 Apr 2020 12:34:11 -0700 (PDT)
Received: from localhost.localdomain ([24.171.221.68])
        by smtp.gmail.com with ESMTPSA id k26sm76764uag.10.2020.04.29.12.34.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2020 12:34:11 -0700 (PDT)
From:   Javier Malave <javier.malave@narfindustries.com>
To:     bx@narfindustries.com
Cc:     Javier Malave <javier.malave@narfindustries.com>,
        linux-kernel@vger.kernel.org, ah@narfindustries.com
Subject: [RFC 9/9] Add Popcorn Message Layer and socket support
Date:   Wed, 29 Apr 2020 15:32:56 -0400
Message-Id: <f7a7a7c09a2632072c6480938a7d9170f85c14fe.1588127445.git.javier.malave@narfindustries.com>
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

This patch adds the Popcorn Message layer. It allows for Popcorn 
functionality over a TCP/IP network. The network is created when the 
module is inserted on all nodes, using a list of IP addresses located in 
/etc/popcorn/nodes. Each node ID is defined by the order of these IP 
addresses. 

All Popcorn work is handled via work queues. Popcorn uses two work queues: 
popcorn_ordered_wq and popcorn_wq. Each Popcorn server module (vma server, 
page server, process server) registers handlers with the Popcorn kernel 
message module. These handlers are in charge of posting work to the work
queues.

The message socket receive handler delegates the Popcorn kernel message 
module to call upon the proper work queue handlers. Moreover, the Popcorn 
kernel message module is responsible for posting and processing Popcorn 
messages. It forwards requests and responses for the different Popcorn
server modules invoking the appropriate handlers for each message type.  
---
 drivers/msg_layer/Kconfig  |  28 ++
 drivers/msg_layer/Makefile |   2 +
 drivers/msg_layer/common.h |  63 ++++
 drivers/msg_layer/socket.c | 710 +++++++++++++++++++++++++++++++++++++
 include/popcorn/pcn_kmsg.h | 205 +++++++++++
 kernel/popcorn/pcn_kmsg.c  | 231 ++++++++++++
 6 files changed, 1239 insertions(+)
 create mode 100644 drivers/msg_layer/Kconfig
 create mode 100644 drivers/msg_layer/Makefile
 create mode 100644 drivers/msg_layer/common.h
 create mode 100644 drivers/msg_layer/socket.c
 create mode 100644 include/popcorn/pcn_kmsg.h
 create mode 100644 kernel/popcorn/pcn_kmsg.c

diff --git a/drivers/msg_layer/Kconfig b/drivers/msg_layer/Kconfig
new file mode 100644
index 000000000..f5baf6d6e
--- /dev/null
+++ b/drivers/msg_layer/Kconfig
@@ -0,0 +1,28 @@
+if POPCORN
+
+config POPCORN_KMSG
+	bool "Inter-kernel messaging layer"
+	default y
+	help
+	  Enable support for various inter-kernel message passing
+	  implementations
+
+if POPCORN_KMSG
+
+# Socket over Ethernet
+config POPCORN_KMSG_SOCKET
+	tristate "Over TCP/IP (DANGEROUS)"
+	depends on INET && m
+	default m
+	help
+	  Send Popcorn messages through TCP/IP sockets
+
+# Debuging
+config POPCORN_DEBUG_MSG_LAYER
+	bool "Print debug messages"
+	depends on POPCORN_DEBUG
+	default n
+
+endif # POPCORN_KMSG
+
+endif # POPCORN
diff --git a/drivers/msg_layer/Makefile b/drivers/msg_layer/Makefile
new file mode 100644
index 000000000..5c8ffbefd
--- /dev/null
+++ b/drivers/msg_layer/Makefile
@@ -0,0 +1,2 @@
+obj-$(CONFIG_POPCORN_KMSG_SOCKET) := msg_socket.o
+msg_socket-y := socket.o ring_buffer.o
diff --git a/drivers/msg_layer/common.h b/drivers/msg_layer/common.h
new file mode 100644
index 000000000..352f8d9f3
--- /dev/null
+++ b/drivers/msg_layer/common.h
@@ -0,0 +1,63 @@
+// SPDX-License-Identifier: GPL-2.0, 3-clause BSD
+
+#ifndef _MSG_LAYER_COMMON_H_
+#define _MSG_LAYER_COMMON_H_
+
+#include <popcorn/pcn_kmsg.h>
+#include <popcorn/bundle.h>
+#include <popcorn/debug.h>
+
+#include <linux/inet.h>
+#include <linux/inetdevice.h>
+#include <linux/netdevice.h>
+
+#define MAX_NUM_NODES	32
+
+static uint32_t ip_table[MAX_NUM_NODES] = { 0 };
+static uint32_t max_nodes = MAX_NUM_NODES;
+
+static uint32_t __init __get_host_ip(void)
+{
+	struct net_device *d;
+	for_each_netdev(&init_net, d) {
+		struct in_ifaddr *ifaddr;
+
+		for (ifaddr = d->ip_ptr->ifa_list; ifaddr; ifaddr = ifaddr->ifa_next) {
+			int i;
+			uint32_t addr = ifaddr->ifa_local;
+			for (i = 0; i < max_nodes; i++) {
+				if (addr == ip_table[i]) {
+					return addr;
+				}
+			}
+		}
+	}
+	return -1;
+}
+
+bool __init identify_myself(void)
+{
+	int i;
+	uint32_t my_ip;
+
+	PCNPRINTK("Loading node configuration...");
+
+	my_ip = __get_host_ip();
+
+	for (i = 0; i < max_nodes; i++) {
+		char *me = " ";
+		if (my_ip == ip_table[i]) {
+			my_nid = i;
+			me = "*";
+		}
+		PCNPRINTK("%s %d: %pI4\n", me, i, ip_table + i);
+	}
+
+	if (my_nid < 0) {
+		PCNPRINTK_ERR("My IP is not listed in the node configuration\n");
+		return false;
+	}
+
+	return true;
+}
+#endif
diff --git a/drivers/msg_layer/socket.c b/drivers/msg_layer/socket.c
new file mode 100644
index 000000000..80a172c6f
--- /dev/null
+++ b/drivers/msg_layer/socket.c
@@ -0,0 +1,710 @@
+// SPDX-License-Identifier: GPL-2.0, 3-clause BSD
+/*
+ * /drivers/msg_layer/socket.c
+ *
+ * Messaging transport layer over TCP/IP
+ *
+ *  author, Javier Malave, Rebecca Shapiro, Andrew Hughes,
+ *  Narf Industries 2020 (modifications for upstream RFC)
+ *  author, Ho-Ren (Jack) Chuang <horenc@vt.edu>
+ *  author, Sang-Hoon Kim <sanghoon@vt.edu>
+ */
+#include <linux/kthread.h>
+#include <popcorn/stat.h>
+#include <linux/module.h>
+#include <linux/inet.h>
+#include <linux/string.h>
+#include <linux/fs.h>
+#include "ring_buffer.h"
+#include "common.h"
+
+#define PORT 30467
+#define MAX_SEND_DEPTH	1024
+
+#define CONFIG_FILE_LEN	256
+#define CONFIG_FILE_PATH	"/etc/popcorn/nodes"
+#define CONFIG_FILE_CHUNK_SIZE	512
+
+enum {
+	SEND_FLAG_POSTED = 0,
+};
+
+struct q_item {
+	struct pcn_kmsg_message *msg;
+	unsigned long flags;
+	struct completion *done;
+};
+
+/* Per-node handle for socket */
+struct sock_handle {
+	int nid;
+
+	/* Ring buffer for queueing outbound messages */
+	struct q_item *msg_q;
+	unsigned long q_head;
+	unsigned long q_tail;
+	spinlock_t q_lock;
+	struct semaphore q_empty;
+	struct semaphore q_full;
+
+	struct socket *sock;
+	struct task_struct *send_handler;
+	struct task_struct *recv_handler;
+};
+static struct sock_handle sock_handles[MAX_NUM_NODES] = {};
+
+static struct socket *sock_listen = NULL;
+static struct ring_buffer send_buffer = {};
+
+static char config_file_path[CONFIG_FILE_LEN];
+
+/*
+ * Handle inbound messages
+ */
+static int ksock_recv(struct socket *sock, char *buf, size_t len)
+{
+	struct msghdr msg = {
+		.msg_flags = 0,
+		.msg_control = NULL,
+		.msg_controllen = 0,
+		.msg_name = NULL,
+		.msg_namelen = 0,
+	};
+	struct kvec iov = {
+		.iov_base = buf,
+		.iov_len = len,
+	};
+
+	return kernel_recvmsg(sock, &msg, &iov, 1, len, MSG_WAITALL);
+}
+
+static int recv_handler(void* arg0)
+{
+	struct sock_handle *sh = arg0;
+	MSGPRINTK("RECV handler for %d is ready\n", sh->nid);
+
+	while (!kthread_should_stop()) {
+		int len;
+		int ret;
+		size_t offset;
+		struct pcn_kmsg_hdr header;
+		char *data;
+
+		/* compose header */
+		offset = 0;
+		len = sizeof(header);
+		while (len > 0) {
+			ret = ksock_recv(sh->sock, (char *)(&header) + offset, len);
+			if (ret == -1 || kthread_should_stop() ) {
+				return 0;
+			}
+			offset += ret;
+			len -= ret;
+		}
+		if (ret < 0)
+			break;
+
+#ifdef CONFIG_POPCORN_CHECK_SANITY
+		BUG_ON(header.type < 0 || header.type >= PCN_KMSG_TYPE_MAX);
+		BUG_ON(header.size < 0 || header.size >  PCN_KMSG_MAX_SIZE);
+#endif
+
+		/* compose body */
+		data = kmalloc(header.size, GFP_KERNEL);
+		BUG_ON(!data && "Unable to alloc a message");
+
+		memcpy(data, &header, sizeof(header));
+
+		offset = sizeof(header);
+		len = header.size - offset;
+
+		while (len > 0) {
+			ret = ksock_recv(sh->sock, data + offset, len);
+			if (ret == -1 || kthread_should_stop() ) {
+				return 0;
+			}
+			offset += ret;
+			len -= ret;
+		}
+		if (ret < 0)
+			break;
+
+		/* Call pcn_kmsg upper layer */
+		pcn_kmsg_process((struct pcn_kmsg_message *)data);
+	}
+	return 0;
+}
+
+
+/*
+ * Handle outbound messages
+ */
+static int ksock_send(struct socket *sock, char *buf, size_t len)
+{
+	struct msghdr msg = {
+		.msg_flags = 0,
+		.msg_control = NULL,
+		.msg_controllen = 0,
+		.msg_name = NULL,
+		.msg_namelen = 0,
+	};
+	struct kvec iov = {
+		.iov_base = buf,
+		.iov_len = len,
+	};
+
+	return kernel_sendmsg(sock, &msg, &iov, 1, len);
+}
+
+static int enq_send(int dest_nid, struct pcn_kmsg_message *msg,
+		    unsigned long flags, struct completion *done)
+{
+	int ret;
+	unsigned long at;
+	struct sock_handle *sh = sock_handles + dest_nid;
+	struct q_item *qi;
+
+	if (!sh)
+		return -1;
+
+	do {
+		ret = down_interruptible(&sh->q_full);
+
+		/* Return if sleep is interrupted by a signal */
+		if (ret == -EINTR)
+			return -1;
+	} while (ret);
+
+	spin_lock(&sh->q_lock);
+	at = sh->q_tail;
+	qi = sh->msg_q + at;
+	sh->q_tail = (at + 1) & (MAX_SEND_DEPTH - 1);
+
+	qi->msg = msg;
+	qi->flags = flags;
+	qi->done = done;
+	spin_unlock(&sh->q_lock);
+	up(&sh->q_empty);
+
+	return at;
+}
+
+void sock_kmsg_put(struct pcn_kmsg_message *msg);
+
+static int deq_send(struct sock_handle *sh)
+{
+	int ret;
+	char *p;
+	unsigned long from;
+	size_t remaining;
+	struct pcn_kmsg_message *msg;
+	struct q_item *qi;
+	unsigned long flags;
+	struct completion *done;
+
+	do {
+		ret = down_interruptible(&sh->q_empty);
+
+		/* Return if sleep is interrupted by a signal */
+		if (ret == -EINTR || kthread_should_stop() )
+			return 0;
+	} while (ret);
+
+	spin_lock(&sh->q_lock);
+	from = sh->q_head;
+	qi = sh->msg_q + from;
+	sh->q_head = (from + 1) & (MAX_SEND_DEPTH - 1);
+
+	msg = qi->msg;
+	flags = qi->flags;
+	done = qi->done;
+	spin_unlock(&sh->q_lock);
+	up(&sh->q_full);
+
+	p = (char *)msg;
+	remaining = msg->header.size;
+
+	while (remaining > 0) {
+		int sent = ksock_send(sh->sock, p, remaining);
+		if (sent < 0) {
+			io_schedule();
+			continue;
+		}
+		p += sent;
+		remaining -= sent;
+	}
+	if (test_bit(SEND_FLAG_POSTED, &flags)) {
+		sock_kmsg_put(msg);
+	}
+	if (done) complete(done);
+
+	return 0;
+}
+
+static int send_handler(void* arg0)
+{
+	struct sock_handle *sh = arg0;
+	MSGPRINTK("SEND handler for %d is ready\n", sh->nid);
+
+	while (!kthread_should_stop()) {
+		deq_send(sh);
+	}
+	kfree(sh->msg_q);
+	return 0;
+}
+
+
+#define WORKAROUND_POOL
+/* Manage send buffer */
+struct pcn_kmsg_message *sock_kmsg_get(size_t size)
+{
+	struct pcn_kmsg_message *msg;
+	might_sleep();
+
+#ifdef WORKAROUND_POOL
+	msg = kmalloc(size, GFP_KERNEL);
+#else
+	while (!(msg = ring_buffer_get(&send_buffer, size))) {
+		WARN_ON_ONCE("ring buffer is full\n");
+		schedule();
+	}
+#endif
+	return msg;
+}
+
+void sock_kmsg_put(struct pcn_kmsg_message *msg)
+{
+#ifdef WORKAROUND_POOL
+	kfree(msg);
+#else
+	ring_buffer_put(&send_buffer, msg);
+#endif
+}
+
+
+/* This is the interface for message layer */
+int sock_kmsg_send(int dest_nid, struct pcn_kmsg_message *msg, size_t size)
+{
+	int ret;
+
+	DECLARE_COMPLETION_ONSTACK(done);
+	ret = enq_send(dest_nid, msg, 0, &done);
+
+	if (ret != -1) {
+		if (!try_wait_for_completion(&done)) {
+			int ret = wait_for_completion_io_timeout(&done, 60 * HZ);
+			if (!ret)
+				return -EAGAIN;
+		}
+	}
+	return 0;
+}
+
+int sock_kmsg_post(int dest_nid, struct pcn_kmsg_message *msg, size_t size)
+{
+	enq_send(dest_nid, msg, 1 << SEND_FLAG_POSTED, NULL);
+	return 0;
+}
+
+void sock_kmsg_done(struct pcn_kmsg_message *msg)
+{
+	kfree(msg);
+}
+
+void sock_kmsg_stat(struct seq_file *seq, void *v)
+{
+	if (seq) {
+		seq_printf(seq, POPCORN_STAT_FMT,
+				(unsigned long long)ring_buffer_usage(&send_buffer),
+				0ULL,
+				"socket");
+	}
+}
+
+struct pcn_kmsg_transport transport_socket = {
+	.name = "socket",
+	.features = 0,
+
+	.get = sock_kmsg_get,
+	.put = sock_kmsg_put,
+	.stat = sock_kmsg_stat,
+
+	.send = sock_kmsg_send,
+	.post = sock_kmsg_post,
+	.done = sock_kmsg_done,
+};
+
+
+static struct task_struct * __init __start_handler(const int nid, const char *type,
+						   int (*handler)(void *data))
+{
+	char name[40];
+	struct task_struct *tsk;
+
+	sprintf(name, "pcn_%s_%d", type, nid);
+	tsk = kthread_run(handler, sock_handles + nid, name);
+	if (IS_ERR(tsk)) {
+		MSGPRINTK(KERN_ERR "Cannot create %s handler, %ld\n", name, PTR_ERR(tsk));
+		return tsk;
+	}
+
+	return tsk;
+}
+
+static int __init __start_handlers(const int nid)
+{
+	struct task_struct *tsk_send, *tsk_recv;
+	tsk_send = __start_handler(nid, "send", send_handler);
+	if (IS_ERR(tsk_send)) {
+		return PTR_ERR(tsk_send);
+	}
+
+	tsk_recv = __start_handler(nid, "recv", recv_handler);
+	if (IS_ERR(tsk_recv)) {
+		kthread_stop(tsk_send);
+		return PTR_ERR(tsk_recv);
+	}
+	sock_handles[nid].send_handler = tsk_send;
+	sock_handles[nid].recv_handler = tsk_recv;
+	return 0;
+}
+
+static int __init __connect_to_server(int nid)
+{
+	int ret;
+	struct sockaddr_in addr;
+	struct socket *sock;
+
+	ret = sock_create(PF_INET, SOCK_STREAM, IPPROTO_TCP, &sock);
+	if (ret < 0) {
+		MSGPRINTK("Failed to create socket, %d\n", ret);
+		return ret;
+	}
+
+	addr.sin_family = AF_INET;
+	addr.sin_port = htons(PORT);
+	addr.sin_addr.s_addr = ip_table[nid];
+
+	MSGPRINTK("Connecting to %d at %pI4\n", nid, ip_table + nid);
+	do {
+		ret = kernel_connect(sock, (struct sockaddr *)&addr, sizeof(addr), 0);
+		if (ret < 0) {
+			MSGPRINTK("Failed to connect the socket %d. Attempt again!!\n", ret);
+			msleep(1000);
+		}
+	} while (ret < 0);
+
+	sock_handles[nid].sock = sock;
+	ret = __start_handlers(nid);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static int __init __accept_client(int *nid)
+{
+	int i;
+	int ret;
+	int retry = 0;
+	bool found = false;
+	struct socket *sock;
+	struct sockaddr_in addr;
+
+	do {
+		ret = sock_create(PF_INET, SOCK_STREAM, IPPROTO_TCP, &sock);
+		if (ret < 0) {
+			MSGPRINTK("Failed to create socket, %d\n", ret);
+			return ret;
+		}
+
+		ret = kernel_accept(sock_listen, &sock, 0);
+		if (ret < 0) {
+			MSGPRINTK("Failed to accept, %d\n", ret);
+			goto out;
+		}
+
+		ret = kernel_getpeername(sock, (struct sockaddr *)&addr);
+		if (ret < 0) {
+			goto out_release;
+		}
+
+		/* Identify incoming peer nid */
+		for (i = 0; i < max_nodes; i++) {
+			if (addr.sin_addr.s_addr == ip_table[i]) {
+				*nid = i;
+				found = true;
+			}
+		}
+		if (!found) {
+			sock_release(sock);
+			continue;
+		}
+	} while (retry++ < 10 && !found);
+
+	if (!found)
+		return -EAGAIN;
+	sock_handles[*nid].sock = sock;
+
+	ret = __start_handlers(*nid);
+	if (ret)
+		goto out_release;
+
+	return 0;
+
+out_release:
+	sock_release(sock);
+out:
+	return ret;
+}
+
+static int __init __listen_to_connection(void)
+{
+	int ret;
+	struct sockaddr_in addr;
+
+	ret = sock_create(PF_INET, SOCK_STREAM, IPPROTO_TCP, &sock_listen);
+	if (ret < 0) {
+		printk(KERN_ERR "Failed to create socket, %d", ret);
+		return ret;
+	}
+
+	addr.sin_family = AF_INET;
+	addr.sin_addr.s_addr = INADDR_ANY;
+	addr.sin_port = htons(PORT);
+
+	ret = kernel_bind(sock_listen, (struct sockaddr *)&addr, sizeof(addr));
+	if (ret < 0) {
+		printk(KERN_ERR "Failed to bind socket, %d\n", ret);
+		goto out_release;
+	}
+
+	ret = kernel_listen(sock_listen, max_nodes);
+	if (ret < 0) {
+		printk(KERN_ERR "Failed to listen to connections, %d\n", ret);
+		goto out_release;
+	}
+
+	MSGPRINTK("Ready to accept incoming connections\n");
+	return 0;
+
+out_release:
+	sock_release(sock_listen);
+	sock_listen = NULL;
+	return ret;
+}
+
+static bool load_config_file(char *file)
+{
+	struct file *fp;
+	int bytes_read, ret;
+	int num_nodes = 0;
+	bool retval = true;
+	char ip_addr[CONFIG_FILE_CHUNK_SIZE];
+	u8 i4_addr[4];
+	loff_t offset = 0;
+	const char *end;
+
+	/* If no path was passed in, use hard coded default */
+	if (file[0] == '\0') {
+		strlcpy(file, CONFIG_FILE_PATH, CONFIG_FILE_LEN);
+	}
+
+	fp = filp_open(file, O_RDONLY, 0);
+	if (IS_ERR(fp)) {
+		MSGPRINTK("Cannot open config file %ld\n", PTR_ERR(fp));
+		return false;
+	}
+
+	while (num_nodes < (max_nodes - 1)) {
+		bytes_read = kernel_read(fp, ip_addr, CONFIG_FILE_CHUNK_SIZE, &offset);
+		if (bytes_read > 0) {
+			int str_off, str_len, j;
+
+			/* Replace \n, \r with \0 */
+			for (j = 0; j < CONFIG_FILE_CHUNK_SIZE; j++) {
+				if (ip_addr[j] == '\n' || ip_addr[j] == '\r') {
+					ip_addr[j] = '\0';
+				}
+			}
+
+			str_off = 0;
+			str_len = strlen(ip_addr);
+			while (str_off < bytes_read) {
+				str_len = strlen(ip_addr + str_off);
+
+				/* Make sure IP address is a valid IPv4 address */
+				if(str_len > 0){
+					ret = in4_pton(ip_addr + str_off, -1, i4_addr, -1, &end);
+					if (!ret) {
+						MSGPRINTK("invalid IP address in config file\n");
+						retval = false;
+						goto done;
+					}
+
+					ip_table[num_nodes++] = *((uint32_t *) i4_addr);
+				}
+
+				str_off += str_len + 1;
+			}
+		} else {
+			break;
+		}
+	}
+
+	/* Update max_nodes with number of nodes read in from config file */
+	max_nodes = num_nodes;
+
+done:
+	filp_close(fp, NULL);
+	return retval;
+}
+
+static void __init bail_early(void)
+{
+        int i;
+        if (sock_listen) sock_release(sock_listen);
+        for (i = 0; i < max_nodes; i++) {
+                struct sock_handle *sh = sock_handles + i;
+                if (sh->send_handler) {
+                        wake_up_process(sh->send_handler);
+                } else {
+                        if (sh->msg_q) kfree(sh->msg_q);
+                }
+                if (sh->recv_handler) {
+                        wake_up_process(sh->recv_handler);
+                }
+                if (sh->sock) {
+                        sock_release(sh->sock);
+                }
+        }
+        ring_buffer_destroy(&send_buffer);
+
+        MSGPRINTK("Successfully unloaded module!\n");
+
+}
+
+static void __exit exit_kmsg_sock(void)
+{
+	int i;
+	if (sock_listen) sock_release(sock_listen);
+	for (i = 0; i < max_nodes; i++) {
+		struct sock_handle *sh = sock_handles + i;
+		if (sh->send_handler) {
+			wake_up_process(sh->send_handler);
+		} else {
+			if (sh->msg_q) kfree(sh->msg_q);
+		}
+		if (sh->recv_handler) {
+			wake_up_process(sh->recv_handler);
+		}
+		if (sh->sock) {
+			sock_release(sh->sock);
+		}
+	}
+	ring_buffer_destroy(&send_buffer);
+
+	MSGPRINTK("Successfully unloaded module!\n");
+}
+
+static int __init init_kmsg_sock(void)
+{
+	int i, ret;
+
+	MSGPRINTK("Loading Popcorn messaging layer over TCP/IP...\n");
+
+	/* Load node configuration */
+	if (!load_config_file(config_file_path))
+		return -EINVAL;
+
+	if (!identify_myself())
+		return -EINVAL;
+
+	pcn_kmsg_set_transport(&transport_socket);
+
+	for (i = 0; i < max_nodes; i++) {
+		struct sock_handle *sh = sock_handles + i;
+
+		sh->msg_q = kmalloc(sizeof(*sh->msg_q) * MAX_SEND_DEPTH, GFP_KERNEL);
+		if (!sh->msg_q) {
+			ret = -ENOMEM;
+			goto out_exit;
+		}
+
+		sh->nid = i;
+		sh->q_head = 0;
+		sh->q_tail = 0;
+		spin_lock_init(&sh->q_lock);
+
+		sema_init(&sh->q_empty, 0);
+		sema_init(&sh->q_full, MAX_SEND_DEPTH);
+	}
+
+	if ((ret = ring_buffer_init(&send_buffer, "sock_send")))
+		goto out_exit;
+
+	if ((ret = __listen_to_connection()))
+		return ret;
+
+	/* Wait for a while so that nodes are ready to listen to connections */
+	msleep(100);
+
+	/* Initilaize the sock.
+	 *
+	 *  Each node has a connection table like tihs:
+	 * --------------------------------------------------------------------
+	 * | connect | connect | (many)... | my_nid(one) | accept | (many)... |
+	 * --------------------------------------------------------------------
+	 * my_nid:  no need to talk to itself
+	 * connect: connecting to existing nodes
+	 * accept:  waiting for the connection requests from later nodes
+	 */
+	for (i = 0; i < my_nid; i++) {
+		if ((ret = __connect_to_server(i)))
+			goto out_exit;
+		set_popcorn_node_online(i, true);
+	}
+
+	set_popcorn_node_online(my_nid, true);
+
+	for (i = my_nid + 1; i < max_nodes; i++) {
+		int nid = 0;
+		if ((ret = __accept_client(&nid)))
+			goto out_exit;
+		set_popcorn_node_online(nid, true);
+	}
+
+	broadcast_my_node_info(i);
+
+	PCNPRINTK("Ready on TCP/IP\n");
+	return 0;
+
+out_exit:
+	bail_early();
+	return ret;
+}
+
+static int max_nodes_set(const char *val, const struct kernel_param *kp)
+{
+	int n = 0, ret;
+
+	ret = kstrtoint(val, 10, &n);
+	if (ret != 0 || n < 1 || n > MAX_NUM_NODES)
+		return -EINVAL;
+
+	return param_set_int(val, kp);
+}
+
+static const struct kernel_param_ops param_ops = {
+	.set	= max_nodes_set,
+};
+
+module_param_cb(simpcb, &param_ops, &max_nodes, 0664);
+MODULE_PARM_DESC(max_nodes, "Maximum number of nodes supported");
+
+module_param_string(config_file, config_file_path, CONFIG_FILE_LEN, 0400);
+MODULE_PARM_DESC(config_file, "Configuration file path");
+
+module_init(init_kmsg_sock);
+module_exit(exit_kmsg_sock);
+MODULE_LICENSE("GPL");
diff --git a/include/popcorn/pcn_kmsg.h b/include/popcorn/pcn_kmsg.h
new file mode 100644
index 000000000..87dcac702
--- /dev/null
+++ b/include/popcorn/pcn_kmsg.h
@@ -0,0 +1,205 @@
+// SPDX-License-Identifier: GPL-2.0, 3-clause BSD
+#ifndef __POPCORN_PCN_KMSG_H__
+#define __POPCORN_PCN_KMSG_H__
+
+#include <linux/types.h>
+#include <linux/seq_file.h>
+
+/* Enumerate message types */
+enum pcn_kmsg_type {
+	/* Thread migration */
+	PCN_KMSG_TYPE_NODE_INFO,
+	PCN_KMSG_TYPE_STAT_START,
+	PCN_KMSG_TYPE_TASK_MIGRATE,
+	PCN_KMSG_TYPE_TASK_MIGRATE_BACK,
+	PCN_KMSG_TYPE_TASK_PAIRING,
+	PCN_KMSG_TYPE_TASK_EXIT_ORIGIN,
+	PCN_KMSG_TYPE_TASK_EXIT_REMOTE,
+
+	/* VMA synchronization */
+	PCN_KMSG_TYPE_VMA_INFO_REQUEST,
+	PCN_KMSG_TYPE_VMA_INFO_RESPONSE,
+	PCN_KMSG_TYPE_VMA_OP_REQUEST,
+	PCN_KMSG_TYPE_VMA_OP_RESPONSE,
+
+	/* Page consistency protocol */
+	PCN_KMSG_TYPE_REMOTE_PAGE_REQUEST,
+	PCN_KMSG_TYPE_REMOTE_PAGE_RESPONSE,
+	PCN_KMSG_TYPE_REMOTE_PAGE_RESPONSE_SHORT,
+	PCN_KMSG_TYPE_PAGE_INVALIDATE_REQUEST,
+	PCN_KMSG_TYPE_PAGE_INVALIDATE_RESPONSE,
+	PCN_KMSG_TYPE_REMOTE_PAGE_FLUSH,	/* XXX page flush is not working now */
+	PCN_KMSG_TYPE_REMOTE_PAGE_RELEASE,
+	PCN_KMSG_TYPE_REMOTE_PAGE_FLUSH_ACK,
+
+	/* Distributed futex */
+	PCN_KMSG_TYPE_FUTEX_REQUEST,
+	PCN_KMSG_TYPE_FUTEX_RESPONSE,
+	PCN_KMSG_TYPE_STAT_END,
+
+	/* Performance experiments */
+	PCN_KMSG_TYPE_TEST_REQUEST,
+	PCN_KMSG_TYPE_TEST_RESPONSE,
+	PCN_KMSG_TYPE_TEST_RDMA_REQUEST,
+	PCN_KMSG_TYPE_TEST_RDMA_RESPONSE,
+
+	/* Provide the single system image */
+	PCN_KMSG_TYPE_REMOTE_PROC_CPUINFO_REQUEST,
+	PCN_KMSG_TYPE_REMOTE_PROC_CPUINFO_RESPONSE,
+	PCN_KMSG_TYPE_REMOTE_PROC_MEMINFO_REQUEST,
+	PCN_KMSG_TYPE_REMOTE_PROC_MEMINFO_RESPONSE,
+	PCN_KMSG_TYPE_REMOTE_PROC_PS_REQUEST,
+	PCN_KMSG_TYPE_REMOTE_PROC_PS_RESPONSE,
+
+	/* Schedule server */
+	PCN_KMSG_TYPE_SCHED_PERIODIC,		/* XXX sched requires help!! */
+
+	PCN_KMSG_TYPE_MAX
+};
+
+/* Enumerate message priority. XXX Priority is not supported yet. */
+enum pcn_kmsg_prio {
+	PCN_KMSG_PRIO_LOW,
+	PCN_KMSG_PRIO_NORMAL,
+	PCN_KMSG_PRIO_HIGH,
+};
+
+/* Message header */
+struct pcn_kmsg_hdr {
+	int from_nid		:6;
+	enum pcn_kmsg_prio prio	:2;
+	enum pcn_kmsg_type type	:8;
+	size_t size;
+} __attribute__((packed));
+
+#define PCN_KMSG_FROM_NID(x) \
+	(((struct pcn_kmsg_message *)x)->header.from_nid)
+#define PCN_KMSG_SIZE(x) (sizeof(struct pcn_kmsg_hdr) + x)
+
+#define PCN_KMSG_MAX_SIZE (64UL << 10)
+#define PCN_KMSG_MAX_PAYLOAD_SIZE \
+	(PCN_KMSG_MAX_SIZE - sizeof(struct pcn_kmsg_hdr))
+
+#define DEFINE_PCN_KMSG(type, fields)		\
+	typedef struct {			\
+		struct pcn_kmsg_hdr header;	\
+		fields;				\
+	} __attribute__((packed)) type
+
+struct pcn_kmsg_message {
+	struct pcn_kmsg_hdr header;
+	unsigned char payload[PCN_KMSG_MAX_PAYLOAD_SIZE];
+} __attribute__((packed));
+
+void pcn_kmsg_dump(struct pcn_kmsg_message *msg);
+
+
+/* SETUP */
+
+/* Function pointer to callback functions */
+typedef int (*pcn_kmsg_cbftn)(struct pcn_kmsg_message *);
+
+/* Register a callback function to handle the message type */
+int pcn_kmsg_register_callback(enum pcn_kmsg_type type,
+			       pcn_kmsg_cbftn callback);
+
+/* Unregister a callback function for the message type */
+int pcn_kmsg_unregister_callback(enum pcn_kmsg_type type);
+
+
+/* MESSAGING */
+
+/*
+ * Send @msg whose size is @msg_size to the node @dest_nid.
+ * @msg is sent synchronously; it is safe to deallocate @msg after the return.
+ */
+int pcn_kmsg_send(enum pcn_kmsg_type type, int dest_nid, void *msg,
+		  size_t msg_size);
+
+/*
+ * Post @msg whose size is @msg_size to be sent to the node @dest_nid.
+ * The message should be allocated through pcn_kmsg_get(), and the message
+ * is reclaimed automatically once it is sent.
+ */
+int pcn_kmsg_post(enum pcn_kmsg_type type, int dest_nid, void *msg,
+		  size_t msg_size);
+
+/*
+ * Get message buffer for posting. Note pcn_kmsg_put() is for returning
+ * unused buffer without posting it; posted message is reclaimed automatically.
+ */
+void *pcn_kmsg_get(size_t size);
+void pcn_kmsg_put(void *msg);
+
+/*
+ * Process the received messag @msg. Each message layer should start processing
+ * the request by calling this function
+ */
+void pcn_kmsg_process(struct pcn_kmsg_message *msg);
+
+/*
+ * Return received message @msg after handling to recyle it. @msg becomes
+ * unavailable after the call. Make sure return received messages otherwise
+ * the message layer will panick.
+ */
+void pcn_kmsg_done(void *msg);
+
+/*
+ * Print out transport-specific statistics into @buffer
+ */
+void pcn_kmsg_stat(struct seq_file *seq, void *v);
+
+struct pcn_kmsg_rdma_handle {
+	u32 rkey;
+	void *addr;
+	dma_addr_t dma_addr;
+	void *private;
+};
+
+/*
+ * Pin @buffer for RDMA and get @rdma_addr and @rdma_key.
+ */
+struct pcn_kmsg_rdma_handle *pcn_kmsg_pin_rdma_buffer(void *buffer,
+						      size_t size);
+
+void pcn_kmsg_unpin_rdma_buffer(struct pcn_kmsg_rdma_handle *handle);
+
+int pcn_kmsg_rdma_write(int dest_nid, dma_addr_t rdma_addr, void *addr,
+			size_t size, u32 rdma_key);
+
+int pcn_kmsg_rdma_read(int from_nid, void *addr, dma_addr_t rdma_addr,
+		       size_t size, u32 rdma_key);
+
+/* TRANSPORT DESCRIPTOR */
+enum {
+	PCN_KMSG_FEATURE_RDMA = 1,
+};
+
+/*
+ * Check the features that the transport layer provides. Return true iff all
+ * features are supported.
+ */
+bool pcn_kmsg_has_features(unsigned int features);
+
+struct pcn_kmsg_transport {
+	char *name;
+	unsigned long features;
+
+	struct pcn_kmsg_message *(*get)(size_t);
+	void (*put)(struct pcn_kmsg_message *);
+
+	int (*send)(int, struct pcn_kmsg_message *, size_t);
+	int (*post)(int, struct pcn_kmsg_message *, size_t);
+	void (*done)(struct pcn_kmsg_message *);
+
+	void (*stat)(struct seq_file *, void *);
+
+	struct pcn_kmsg_rdma_handle *(*pin_rdma_buffer)(void *, size_t);
+	void (*unpin_rdma_buffer)(struct pcn_kmsg_rdma_handle *);
+	int (*rdma_write)(int, dma_addr_t, void *, size_t, u32);
+	int (*rdma_read)(int, void *, dma_addr_t, size_t, u32);
+};
+
+void pcn_kmsg_set_transport(struct pcn_kmsg_transport *tr);
+
+#endif /* __POPCORN_PCN_KMSG_H__ */
diff --git a/kernel/popcorn/pcn_kmsg.c b/kernel/popcorn/pcn_kmsg.c
new file mode 100644
index 000000000..882c82e25
--- /dev/null
+++ b/kernel/popcorn/pcn_kmsg.c
@@ -0,0 +1,231 @@
+// SPDX-License-Identifier: GPL-2.0, BSD
+/*
+ * /kernel/popcorn/pcn_kmsg.c - Kernel Module for Popcorn Messaging Layer over Socket
+ *
+ * author, Javier Malave, Rebecca Shapiro, Andrew Hughes,
+ * Narf Industries 2020 (modifications for upstream RFC)
+ *
+ * (Copyright):
+ * author, Sang-Hoon Kim, SSRG, Virginia Tech, 2017-2018
+ * author Ben Shelton, SSRG, Virginia Tech, 2013
+ */
+
+#include <linux/kernel.h>
+#include <linux/delay.h>
+#include <linux/errno.h>
+#include <linux/vmalloc.h>
+#include <linux/slab.h>
+#include <linux/err.h>
+
+#include <popcorn/pcn_kmsg.h>
+#include <popcorn/debug.h>
+#include <popcorn/stat.h>
+#include <popcorn/bundle.h>
+
+static pcn_kmsg_cbftn pcn_kmsg_cbftns[PCN_KMSG_TYPE_MAX] = { NULL };
+
+static struct pcn_kmsg_transport *transport = NULL;
+
+void pcn_kmsg_set_transport(struct pcn_kmsg_transport *tr)
+{
+	if (transport && tr) {
+		printk(KERN_ERR "Replace hot transport at your own risk.\n");
+	}
+	transport = tr;
+}
+EXPORT_SYMBOL(pcn_kmsg_set_transport);
+
+int pcn_kmsg_register_callback(enum pcn_kmsg_type type, pcn_kmsg_cbftn callback)
+{
+	BUG_ON(type < 0 || type >= PCN_KMSG_TYPE_MAX);
+
+	pcn_kmsg_cbftns[type] = callback;
+	return 0;
+}
+EXPORT_SYMBOL(pcn_kmsg_register_callback);
+
+int pcn_kmsg_unregister_callback(enum pcn_kmsg_type type)
+{
+	return pcn_kmsg_register_callback(type, (pcn_kmsg_cbftn)NULL);
+}
+EXPORT_SYMBOL(pcn_kmsg_unregister_callback);
+
+
+static atomic_t __nr_outstanding_requests[PCN_KMSG_TYPE_MAX] = { ATOMIC_INIT(0) };
+
+void pcn_kmsg_process(struct pcn_kmsg_message *msg)
+{
+	pcn_kmsg_cbftn ftn;
+
+	if(IS_ENABLED(CONFIG_POPCORN_CHECK_SANITY)) {
+		BUG_ON(msg->header.type < 0 || msg->header.type >= PCN_KMSG_TYPE_MAX);
+		BUG_ON(msg->header.size < 0 || msg->header.size > PCN_KMSG_MAX_SIZE);
+		if (atomic_inc_return(__nr_outstanding_requests + msg->header.type) > 64) {
+			if (WARN_ON_ONCE("leaking received messages, ")) {
+				printk("type %d\n", msg->header.type);
+			}
+		}
+	}
+	account_pcn_message_recv(msg);
+
+	ftn = pcn_kmsg_cbftns[msg->header.type];
+
+	if (ftn != NULL) {
+		ftn(msg);
+	} else {
+		printk(KERN_ERR"No callback registered for %d\n", msg->header.type);
+		pcn_kmsg_done(msg);
+	}
+}
+EXPORT_SYMBOL(pcn_kmsg_process);
+
+static inline int __build_and_check_msg(enum pcn_kmsg_type type, int to,
+					struct pcn_kmsg_message *msg, size_t size)
+{
+
+	if(IS_ENABLED(CONFIG_POPCORN_CHECK_SANITY)) {
+		BUG_ON(type < 0 || type >= PCN_KMSG_TYPE_MAX);
+		BUG_ON(size > PCN_KMSG_MAX_SIZE);
+		BUG_ON(to < 0 || to >= MAX_POPCORN_NODES);
+		BUG_ON(to == my_nid);
+	}
+
+	msg->header.type = type;
+	msg->header.prio = PCN_KMSG_PRIO_NORMAL;
+	msg->header.size = size;
+	msg->header.from_nid = my_nid;
+	return 0;
+}
+
+int pcn_kmsg_send(enum pcn_kmsg_type type, int to, void *msg, size_t size)
+{
+	int ret;
+	if ((ret = __build_and_check_msg(type, to, msg, size)))
+		return ret;
+
+	account_pcn_message_sent(msg);
+	return transport->send(to, msg, size);
+}
+EXPORT_SYMBOL(pcn_kmsg_send);
+
+int pcn_kmsg_post(enum pcn_kmsg_type type, int to, void *msg, size_t size)
+{
+	int ret;
+	if ((ret = __build_and_check_msg(type, to, msg, size)))
+		return ret;
+
+	account_pcn_message_sent(msg);
+	return transport->post(to, msg, size);
+}
+EXPORT_SYMBOL(pcn_kmsg_post);
+
+void *pcn_kmsg_get(size_t size)
+{
+	if (transport && transport->get)
+		return transport->get(size);
+	return kmalloc(size, GFP_KERNEL);
+}
+EXPORT_SYMBOL(pcn_kmsg_get);
+
+void pcn_kmsg_put(void *msg)
+{
+	if (transport && transport->put) {
+		transport->put(msg);
+	} else {
+		kfree(msg);
+	}
+}
+EXPORT_SYMBOL(pcn_kmsg_put);
+
+
+void pcn_kmsg_done(void *msg)
+{
+	if(IS_ENABLED(CONFIG_POPCORN_CHECK_SANITY)) {
+		struct pcn_kmsg_hdr *h = msg;;
+		if (atomic_dec_return(__nr_outstanding_requests + h->type) < 0) {
+			printk(KERN_ERR
+			"Over-release message type %d\n", h->type);
+		}
+	}
+	if (transport && transport->done) {
+		transport->done(msg);
+	} else {
+		kfree(msg);
+	}
+}
+EXPORT_SYMBOL(pcn_kmsg_done);
+
+void pcn_kmsg_stat(struct seq_file *seq, void *v)
+{
+	if (transport && transport->stat) {
+		transport->stat(seq, v);
+	}
+}
+EXPORT_SYMBOL(pcn_kmsg_stat);
+
+bool pcn_kmsg_has_features(unsigned int features)
+{
+	if (!transport)
+		return false;
+
+	return (transport->features & features) == features;
+}
+EXPORT_SYMBOL(pcn_kmsg_has_features);
+
+int pcn_kmsg_rdma_read(int from_nid, void *addr, dma_addr_t rdma_addr,
+		size_t size, u32 rdma_key)
+{
+	if(IS_ENABLED(CONFIG_POPCORN_CHECK_SANITY)) {
+		if (!transport || !transport->rdma_read)
+			return -EPERM;
+	}
+
+	account_pcn_rdma_read(size);
+	return transport->rdma_read(from_nid, addr, rdma_addr, size, rdma_key);
+}
+EXPORT_SYMBOL(pcn_kmsg_rdma_read);
+
+int pcn_kmsg_rdma_write(int dest_nid, dma_addr_t rdma_addr, void *addr,
+			size_t size, u32 rdma_key)
+{
+	if(IS_ENABLED(CONFIG_POPCORN_CHECK_SANITY)) {
+		if (!transport || !transport->rdma_write)
+			return -EPERM;
+	}
+
+	account_pcn_rdma_write(size);
+    return transport->rdma_write(dest_nid, rdma_addr, addr, size, rdma_key);
+}
+EXPORT_SYMBOL(pcn_kmsg_rdma_write);
+
+
+struct pcn_kmsg_rdma_handle *pcn_kmsg_pin_rdma_buffer(void *buffer, size_t size)
+{
+	if (transport && transport->pin_rdma_buffer) {
+		return transport->pin_rdma_buffer(buffer, size);
+	}
+	return ERR_PTR(-EINVAL);
+}
+EXPORT_SYMBOL(pcn_kmsg_pin_rdma_buffer);
+
+void pcn_kmsg_unpin_rdma_buffer(struct pcn_kmsg_rdma_handle *handle)
+{
+	if (transport && transport->unpin_rdma_buffer) {
+		transport->unpin_rdma_buffer(handle);
+	}
+}
+EXPORT_SYMBOL(pcn_kmsg_unpin_rdma_buffer);
+
+
+void pcn_kmsg_dump(struct pcn_kmsg_message *msg)
+{
+	struct pcn_kmsg_hdr *h = &msg->header;
+	printk("MSG %p: from=%d type=%d size=%lu\n",
+			msg, h->from_nid, h->type, h->size);
+}
+EXPORT_SYMBOL(pcn_kmsg_dump);
+
+int __init pcn_kmsg_init(void)
+{
+	return 0;
+}
-- 
2.17.1

