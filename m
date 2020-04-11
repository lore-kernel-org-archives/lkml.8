Return-Path: <SRS0=xbEg=53=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EF13C2BA2B
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 09:54:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CF6A2078E
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 09:54:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726178AbgDKJyB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Apr 2020 05:54:01 -0400
Received: from m17618.mail.qiye.163.com ([59.111.176.18]:64526 "EHLO
        m17618.mail.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725966AbgDKJyA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Apr 2020 05:54:00 -0400
Received: from ubuntu.localdomain (unknown [58.251.74.227])
        by m17618.mail.qiye.163.com (Hmail) with ESMTPA id A59014E141C;
        Sat, 11 Apr 2020 17:53:47 +0800 (CST)
From:   Wang Wenhu <wenhu.wang@vivo.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
Cc:     Wang Wenhu <wenhu.wang@vivo.com>
Subject: [PATCH 3/3] driver: rpmon: add rpmon_qmi driver
Date:   Sat, 11 Apr 2020 02:53:01 -0700
Message-Id: <20200411095301.18780-4-wenhu.wang@vivo.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200411095301.18780-1-wenhu.wang@vivo.com>
References: <20200411095301.18780-1-wenhu.wang@vivo.com>
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZSFVISUhCQkJDQ0pMT09IQ1lXWShZQU
        hPN1dZLVlBSVdZCQ4XHghZQVk1NCk2OjckKS43PlkG
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PFE6PSo4VjgzAhQXATgvIgE1
        Ky0wCT9VSlVKTkNNTkJDQ0lMQkJOVTMWGhIXVQweFRMOVQwaFRw7DRINFFUYFBZFWVdZEgtZQVlO
        Q1VJTkpVTE9VSUlMWVdZCAFZQUpPSEJJNwY+
X-HM-Tid: 0a7168a8d7019376kuwsa59014e141c
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RPMON_QMI is used by RPMON to communicate with remote processors
with QMI APIs if enabled. RPMON_QMI itself is designed as a modular
framework that would introduce different kinds of message sets
which may be updated for versions.

RPMON_QMI creates a device of rpmon_device type for each remote
processor endpoint. All the endpoint devices shares an unique set
of QMI suite.

Signed-off-by: Wang Wenhu <wenhu.wang@vivo.com>
---
 drivers/rpmon/Kconfig     |  15 ++
 drivers/rpmon/Makefile    |   1 +
 drivers/rpmon/rpmon_qmi.c | 434 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 450 insertions(+)
 create mode 100644 drivers/rpmon/rpmon_qmi.c

diff --git a/drivers/rpmon/Kconfig b/drivers/rpmon/Kconfig
index 4118d4fab433..e44d587db0d2 100644
--- a/drivers/rpmon/Kconfig
+++ b/drivers/rpmon/Kconfig
@@ -23,6 +23,21 @@ config RPMON
 	  Currently RPMON_QMI is available which uses QMI infrastructures
 	  on Qualcomm SoC Platforms.
 
+config RPMON_QMI
+	tristate "RPMON QMI Driver Engine"
+	select RPMON_QMI_MSG_V1
+	depends on RPMON
+	depends on QCOM_QMI_HELPERS
+	help
+	  RPMON_QMI is used by RPMON to communicate with remote processors
+	  with QMI APIs if enabled. RPMON_QMI itself is designed as a modular
+	  framework that would introduce different kinds of message sets
+	  which may be updated for versions.
+
+	  RPMON_QMI creates a device of rpmon_device type for each remote
+	  processor endpoint. All the endpoint devices shares an unique set
+	  of QMI suite.
+
 config RPMON_QMI_MSG_V1
 	tristate "RPMON QMI Message Version 1.0"
 	depends on RPMON
diff --git a/drivers/rpmon/Makefile b/drivers/rpmon/Makefile
index 25f468a73a20..76d9525339d9 100644
--- a/drivers/rpmon/Makefile
+++ b/drivers/rpmon/Makefile
@@ -1,2 +1,3 @@
 obj-$(CONFIG_RPMON) += rpmon.o
+obj-$(CONFIG_RPMON_QMI) += rpmon_qmi.o
 obj-$(CONFIG_RPMON_QMI_MSG_V1)	+= rpmon_qmi_msg_v1.o
diff --git a/drivers/rpmon/rpmon_qmi.c b/drivers/rpmon/rpmon_qmi.c
new file mode 100644
index 000000000000..ae49510cbb83
--- /dev/null
+++ b/drivers/rpmon/rpmon_qmi.c
@@ -0,0 +1,434 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2020 Vivo Communication Technology Co. Ltd.
+ * Copyright (C) 2020 Wang Wenhu <wenhu.wang@vivo.com>
+ * All rights reserved.
+ *
+ * RPMON: An implementation of remote processor monitor freamwork
+ * for platforms that multi-processors exists. RPMON is implemented
+ * with chardev and sysfs class as interfaces to communicate with
+ * the user level. It supports different communication interfaces
+ * added modularly with remote processors. Currently QMI implementation
+ * is available.
+ *
+ * RPMON could be used to detect the stabilities of remote processors,
+ * collect any kinds of information you are interested with, take
+ * actions like connection status check, and so on. Enhancements can
+ * be made upon current implementation.
+ */
+
+#include <linux/module.h>
+#include <linux/rpmon.h>
+#include <linux/soc/qcom/qmi.h>
+#include <linux/of_platform.h>
+#include "rpmon_qmi.h"
+
+#define DRIVER_NAME "rpmon_qmi_drv"
+
+/*
+ * Remote processor registered.
+ */
+#define RP_REGISTERED		0x0001
+
+/*
+ * work struct for message processing.
+ */
+struct recv_work {
+	struct work_struct work;
+	struct sockaddr_qrtr sq;
+	void *msg;
+};
+
+/*
+ * Delayed work to take a reset action when a failure is detected.
+ */
+struct exec_cb_work {
+	struct delayed_work		dwk;
+	struct rpmon_qmi_device *rdev;
+	u32			checks;
+};
+
+struct rpmon_qmi_exec_fn {
+	int (*exec_call)(struct rpmon_qmi_device *rdev);
+};
+
+struct rpmon_qmi_cb_fn {
+	void (*callback)(struct work_struct *work);
+	u32 msg_len;
+};
+
+static DEFINE_MUTEX(rdev_list_lock);
+static LIST_HEAD(rdev_list);
+static struct rpmon_qmi *rpqmi;
+static struct workqueue_struct *rpqmi_wq;
+
+static void rpmon_qmi_register_req_cb(struct work_struct *work)
+{
+	struct rpmon_register_req *req;
+	struct rpmon_qmi_device *rdev;
+	struct recv_work *rwk = container_of(work, struct recv_work, work);
+
+	req = (struct rpmon_register_req *)rwk->msg;
+
+	mutex_lock(&rdev_list_lock);
+	list_for_each_entry(rdev, &rdev_list, list) {
+		if (strncmp(rdev->info->name, req->name, RP_NAME_LEN))
+			continue;
+
+		rdev->flag |= RP_REGISTERED;
+		memcpy(&rdev->addr, &rwk->sq, sizeof(rwk->sq));
+		if (req->timeout_valid)
+			rdev->timeout = req->timeout;
+		else
+			rdev->timeout = 5000;
+		rpmon_event_notify(rdev->info, RPMON_EVENT_REGISTER);
+		break;
+	}
+	mutex_unlock(&rdev_list_lock);
+
+	kfree(rwk->msg);
+	kfree(rwk);
+}
+
+void rpmon_qmi_conn_check_resp_cb(struct work_struct *work)
+{
+	struct rpmon_conn_check_resp *cc_resp;
+	struct rpmon_qmi_device *rdev;
+	struct sockaddr_qrtr *addr;
+	struct recv_work *rwk =
+			container_of(work, struct recv_work, work);
+
+	cc_resp = (struct rpmon_conn_check_resp *)rwk->msg;
+	mutex_lock(&rdev_list_lock);
+	list_for_each_entry(rdev, &rdev_list, list) {
+		addr = &rdev->addr;
+		if (addr->sq_node != rwk->sq.sq_node ||
+		    addr->sq_port != rwk->sq.sq_port)
+			continue;
+
+		if (!cc_resp->result.error)
+			atomic_inc(&rdev->reports);
+		break;
+	}
+	mutex_unlock(&rdev_list_lock);
+
+	kfree(rwk->msg);
+	kfree(rwk);
+}
+
+/**
+ * rpmon_qmi_exec_cb_worker - callback worker for execution
+ * @work: work to been done
+ *
+ * Called as worker handler by the signle worker thread of rpmon_wq.
+ * The worker is scheduled after timeout ms duration since the execution.
+ */
+static void rpmon_qmi_exec_cb_worker(struct work_struct *work)
+{
+	struct delayed_work *dwk = to_delayed_work(work);
+	struct exec_cb_work *ewk =
+			container_of(dwk, struct exec_cb_work, dwk);
+	struct rpmon_qmi_device *rdev = ewk->rdev;
+
+	mutex_lock(&rdev_list_lock);
+	if (ewk->checks <= atomic_read(&rdev->reports)) {
+		pr_debug("%s health check success", rdev->info->name);
+		goto out;
+	}
+
+	pr_err("subsystem %s failed to respond in time", rdev->info->name);
+
+	rpmon_event_notify(rdev->info, RPMON_EVENT_CHKCONN_FAIL);
+
+out:
+	mutex_unlock(&rdev_list_lock);
+	kfree(ewk);
+}
+
+static struct rpmon_qmi_cb_fn rpmon_qmi_event_callbacks[] = {
+	{
+		.callback = rpmon_qmi_register_req_cb,
+		.msg_len = sizeof(struct rpmon_register_req),
+	},
+	{
+		.callback = rpmon_qmi_conn_check_resp_cb,
+		.msg_len = sizeof(struct rpmon_conn_check_resp),
+	},
+};
+
+/**
+ * rpmon_qmi_conn_check - send indication, initiate and queue callback work
+ * @rdev: device interface of specific remote processor to be checked
+ */
+static int rpmon_qmi_conn_check(struct rpmon_qmi_device *rdev)
+{
+	struct exec_cb_work *ewk;
+
+	mutex_lock(&rdev_list_lock);
+	if (!(rdev->flag & RP_REGISTERED)) {
+		pr_err("%s has not registered", rdev->info->name);
+		return -ENOANO;
+	}
+
+	if (!__ratelimit(&rdev->ratelimit)) {
+		pr_err("%s rate-limited", rdev->info->name);
+		return 0;
+	}
+	mutex_unlock(&rdev_list_lock);
+
+	rdev->rqmi->sendmsg(rdev, NULL, 0);
+
+	ewk = kzalloc(sizeof(*ewk), GFP_KERNEL);
+	if (!ewk)
+		return -ENOANO;
+
+	ewk->rdev = rdev;
+	ewk->checks = atomic_inc_return(&rdev->checks);
+	INIT_DELAYED_WORK(&ewk->dwk, rpmon_qmi_exec_cb_worker);
+	queue_delayed_work(rpqmi_wq,
+			   &ewk->dwk, msecs_to_jiffies(rdev->timeout));
+
+	return 0;
+}
+
+static struct rpmon_qmi_exec_fn rpmon_qmi_exec_calls[] = {
+	{.exec_call = rpmon_qmi_conn_check},
+};
+
+static int rpmon_qmi_monitor(struct rpmon_info *info, u32 event)
+{
+	struct rpmon_qmi_device *rdev = (struct rpmon_qmi_device *)info->priv;
+	int i;
+
+	for (i = 0; i < RPMON_EXEC_MAX; i++) {
+		if (event & RPMON_ACTION(i)) {
+			if (i >= (sizeof(rpmon_qmi_exec_calls) /
+				  sizeof(struct rpmon_qmi_exec_fn)))
+				return -ENOTSUPP;
+
+			if (rpmon_qmi_exec_calls[i].exec_call)
+				return rpmon_qmi_exec_calls[i].exec_call(rdev);
+			else
+				return -ENOTSUPP;
+		}
+	}
+
+	return -EINVAL;
+}
+
+static int rpmon_qmi_drv_probe(struct platform_device *pdev)
+{
+	struct rpmon_info *info = pdev->dev.platform_data;
+	struct rpmon_qmi_device *rdev;
+	struct device_node *node = pdev->dev.of_node;
+	const char *name;
+	int ret = -ENODEV;
+
+	if (node) {
+		/* Allocate info for one device */
+		info = devm_kzalloc(&pdev->dev, sizeof(*info), GFP_KERNEL);
+		if (!info) {
+			ret = -ENOMEM;
+			goto out;
+		}
+
+		if (!of_property_read_string(node, "linux,subsys", &name))
+			info->name = devm_kstrdup(&pdev->dev, name, GFP_KERNEL);
+		else
+			info->name = devm_kasprintf(&pdev->dev, GFP_KERNEL,
+						       "%pOFn", node);
+		info->version = "devicetree";
+	}
+
+	if (!info || !info->name || !info->version) {
+		dev_dbg(&pdev->dev, "%s: err_info\n", __func__);
+		return ret;
+	}
+
+	/* Allocate device for qmi specific reference */
+	rdev = devm_kzalloc(&pdev->dev, sizeof(*rdev), GFP_KERNEL);
+	if (!rdev) {
+		ret = -ENOMEM;
+		goto err_info_free;
+	}
+
+	rdev->rqmi = rpqmi;
+	rdev->info = info;
+	info->priv = rdev;
+	info->monitor = rpmon_qmi_monitor;
+	platform_set_drvdata(pdev, rdev);
+
+	ret = rpmon_register_device(&pdev->dev, info);
+	if (ret) {
+		dev_err(&pdev->dev, "unable to register rpmon_qmi_device\n");
+		goto err_rdev_free;
+	}
+
+	mutex_lock(&rdev_list_lock);
+	list_add_tail(&rdev->list, &rdev_list);
+	mutex_unlock(&rdev_list_lock);
+
+	return ret;
+
+err_rdev_free:
+	devm_kfree(&pdev->dev, rdev);
+err_info_free:
+	devm_kfree(&pdev->dev, info);
+out:
+	return ret;
+}
+
+static int rpmon_qmi_drv_remove(struct platform_device *pdev)
+{
+	struct rpmon_qmi_device *rdev = platform_get_drvdata(pdev);
+
+	rpmon_unregister_device(rdev->info);
+
+	return 0;
+}
+static void rpmon_qmi_msg_callback(enum rpmon_qmi_msg_type type,
+			struct sockaddr_qrtr *sq,
+			const void *msg)
+{
+	struct recv_work *rwk;
+
+	if (type >= (sizeof(rpmon_qmi_event_callbacks) /
+		     sizeof(struct rpmon_qmi_cb_fn))) {
+		pr_err("Error none supported message type.\n");
+		return;
+	}
+
+	if (rpmon_qmi_event_callbacks[type].callback) {
+		rwk = kzalloc(sizeof(*rwk), GFP_KERNEL);
+		if (!rwk) {
+			pr_err("Error to alloc recv_work");
+			return;
+		}
+
+		INIT_WORK(&rwk->work, rpmon_qmi_event_callbacks[type].callback);
+		memcpy(&rwk->sq, sq, sizeof(*sq));
+
+		rwk->msg = kzalloc(rpmon_qmi_event_callbacks[type].msg_len,
+				   GFP_KERNEL);
+		if (!rwk->msg) {
+			pr_err("Error to alloc message of recv_work");
+			kfree(rwk);
+			return;
+		}
+
+		memcpy(rwk->msg, msg, rpmon_qmi_event_callbacks[type].msg_len);
+		queue_work(rpqmi_wq, &rwk->work);
+	}
+}
+
+static const struct of_device_id rpmon_of_qmi_match[] = {
+	{ .compatible = "rpmon-qmi" },
+	{ /* Sentinel */ },
+};
+
+static struct platform_driver rpmon_qmi_drv = {
+	.probe = rpmon_qmi_drv_probe,
+	.remove = rpmon_qmi_drv_remove,
+	.driver = {
+		.name = DRIVER_NAME,
+		.owner = THIS_MODULE,
+		.of_match_table = of_match_ptr(rpmon_of_qmi_match),
+	},
+};
+
+static int __init rpmon_qmi_drv_init(void)
+{
+	int ret;
+
+	rpqmi_wq = create_singlethread_workqueue("rpmon_qmi_wq");
+	if (!rpqmi_wq) {
+		pr_err("Error creating workqueue\n");
+		ret = -EFAULT;
+		goto out;
+	}
+
+	rpqmi = kzalloc(sizeof(*rpqmi), GFP_KERNEL);
+	if (!rpqmi) {
+		ret = -ENOMEM;
+		goto err_wq_free;
+	}
+
+	ret = rpmon_qmi_handle_init(rpqmi, rpmon_qmi_msg_callback);
+	if (ret)
+		goto err_rpqmi_free;
+
+	ret = qmi_handle_init(&rpqmi->qmi,
+			      RPQMI_BUF_SIZE, NULL, rpqmi->handlers);
+	if (ret < 0) {
+		pr_err("Error init qmi handle, %d", ret);
+		goto err_rpqmi_free;
+	}
+
+	ret = qmi_add_server(&rpqmi->qmi,
+			     rpqmi->svc->service,
+			     rpqmi->svc->version,
+			     rpqmi->svc->instance);
+	if (ret < 0) {
+		pr_err("Error add qmi server, %d", ret);
+		goto err_rpqmi_free;
+	}
+	mutex_init(&rdev_list_lock);
+
+	return platform_driver_register(&rpmon_qmi_drv);
+
+err_rpqmi_free:
+	kfree(rpqmi);
+err_wq_free:
+	destroy_workqueue(rpqmi_wq);
+out:
+	return ret;
+}
+late_initcall_sync(rpmon_qmi_drv_init);
+
+static void rpmon_qmi_del_server(void)
+{
+	struct qrtr_ctrl_pkt pkt;
+	struct sockaddr_qrtr sq;
+	struct msghdr msg = { };
+	struct kvec iv = { &pkt, sizeof(pkt) };
+	struct qmi_service *svc = rpqmi->svc;
+	struct qmi_handle *qmi = &rpqmi->qmi;
+	int ret;
+
+	memset(&pkt, 0, sizeof(pkt));
+	pkt.cmd = cpu_to_le32(QRTR_TYPE_DEL_SERVER);
+	pkt.server.service = cpu_to_le32(svc->service);
+	pkt.server.instance = cpu_to_le32(svc->version | svc->instance << 8);
+	pkt.server.node = cpu_to_le32(qmi->sq.sq_node);
+	pkt.server.port = cpu_to_le32(qmi->sq.sq_port);
+
+	sq.sq_family = qmi->sq.sq_family;
+	sq.sq_node = qmi->sq.sq_node;
+	sq.sq_port = QRTR_PORT_CTRL;
+
+	msg.msg_name = &sq;
+	msg.msg_namelen = sizeof(sq);
+
+	mutex_lock(&qmi->sock_lock);
+	if (qmi->sock) {
+		ret = kernel_sendmsg(qmi->sock, &msg, &iv, 1, sizeof(pkt));
+		if (ret < 0)
+			pr_err("send service delete message failed: %d\n", ret);
+	}
+	mutex_unlock(&qmi->sock_lock);
+}
+
+static void __exit rpmon_qmi_drv_exit(void)
+{
+	rpmon_qmi_del_server();
+
+	qmi_handle_release(&rpqmi->qmi);
+
+	platform_driver_unregister(&rpmon_qmi_drv);
+}
+module_exit(rpmon_qmi_drv_exit);
+
+MODULE_AUTHOR("Wang Wenhu");
+MODULE_DESCRIPTION("Subsystem Monitor via QMI platform driver");
+MODULE_ALIAS("platform:" DRIVER_NAME);
+MODULE_LICENSE("GPL v2");
-- 
2.17.1

