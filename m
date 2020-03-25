Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A27DC2D0EA
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 19:43:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 282E820740
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 19:43:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="GINL0q+2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727675AbgCYTn6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 15:43:58 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:60598 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727376AbgCYTn4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 15:43:56 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02PJdAHT063141;
        Wed, 25 Mar 2020 19:43:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=0vH1KFZk1/4SVyE8Qk92sb7MjPD7nD4dOwBS6h2i5Ww=;
 b=GINL0q+274nAm3f93ervD4JaEUNE1EchEh6DCejGP5WHeWCqmMlw5YptLx1dxL8JLuy/
 S47FZao/wNriO1uVlihVktb1XE57bvQlF3yPn5kqETNAn+RWKMXNjtxPTj2QqX8ZcfoS
 EzQsOsFvipm8mTzs2yk8sVJHTPM9zGhZm+O9gpIPW0yeY3mPw6hDeIX0S3nRV5L8gE3u
 Kh3xnhZ+UOGFMHdiclteE4lOoQmpUmLQ8UAmjd4APTbJtR3OpjBYbIvadisblj4udilR
 ROui00e3t542uIDxa53Bdm0XJ/vXPiX/TWZbBotS2+mGlvyepB+WsAVBUVZRoPbyMcEJ 8Q== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 2ywavmbs8k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 25 Mar 2020 19:43:38 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02PJgh5G188832;
        Wed, 25 Mar 2020 19:43:37 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 2yxw4s3php-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 25 Mar 2020 19:43:37 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 02PJhakK024902;
        Wed, 25 Mar 2020 19:43:36 GMT
Received: from pneuma.us.oracle.com (/10.39.203.246)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 25 Mar 2020 12:43:35 -0700
From:   Ross Philipson <ross.philipson@oracle.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-doc@vger.kernel.org
Cc:     ross.philipson@oracle.com, dpsmith@apertussolutions.com,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        trenchboot-devel@googlegroups.com
Subject: [RFC PATCH 10/12] x86: Secure Launch adding event log securityfs
Date:   Wed, 25 Mar 2020 15:43:15 -0400
Message-Id: <20200325194317.526492-11-ross.philipson@oracle.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200325194317.526492-1-ross.philipson@oracle.com>
References: <20200325194317.526492-1-ross.philipson@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9571 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 spamscore=0 mlxlogscore=999 adultscore=0 phishscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003250157
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9571 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0
 priorityscore=1501 mlxscore=0 bulkscore=0 clxscore=1015 impostorscore=0
 phishscore=0 suspectscore=0 mlxlogscore=999 spamscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2003250156
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Daniel P. Smith" <dpsmith@apertussolutions.com>

The late init functionality registers securityfs nodes to allow fetching
of and writing events to the late launch TPM log.

Signed-off-by: Daniel P. Smith <dpsmith@apertussolutions.com>
---
 arch/x86/kernel/slaunch.c | 184 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 184 insertions(+)

diff --git a/arch/x86/kernel/slaunch.c b/arch/x86/kernel/slaunch.c
index 083fa72bd9f9..fea15b0e36b7 100644
--- a/arch/x86/kernel/slaunch.c
+++ b/arch/x86/kernel/slaunch.c
@@ -449,3 +449,187 @@ void __init slaunch_setup(void)
 	    vendor[3] == INTEL_CPUID_MFGID_EDX)
 		slaunch_setup_intel();
 }
+
+/*
+ * Securityfs exposure
+ */
+struct memfile {
+	char *name;
+	void __iomem *addr;
+	size_t size;
+};
+
+static struct memfile sl_evtlog = {"eventlog", 0, 0};
+static void __iomem *txt_heap;
+static struct txt_heap_event_log_pointer2_1_element __iomem *evtlog20;
+
+static DEFINE_MUTEX(sl_evt_write_mutex);
+
+static ssize_t sl_evtlog_read(struct file *file, char __user *buf,
+			      size_t count, loff_t *pos)
+{
+	return simple_read_from_buffer(buf, count, pos,
+		sl_evtlog.addr, sl_evtlog.size);
+}
+
+static ssize_t sl_evtlog_write(struct file *file, const char __user *buf,
+				size_t datalen, loff_t *ppos)
+{
+	char *data;
+	ssize_t result;
+
+	/* No partial writes. */
+	result = -EINVAL;
+	if (*ppos != 0)
+		goto out;
+
+	data = memdup_user(buf, datalen);
+	if (IS_ERR(data)) {
+		result = PTR_ERR(data);
+		goto out;
+	}
+
+	mutex_lock(&sl_evt_write_mutex);
+	if (evtlog20)
+		result = tpm20_log_event(evtlog20, sl_evtlog.addr,
+					 datalen, data);
+	else
+		result = tpm12_log_event(sl_evtlog.addr, datalen, data);
+	mutex_unlock(&sl_evt_write_mutex);
+
+	kfree(data);
+out:
+	return result;
+}
+
+static const struct file_operations sl_evtlog_ops = {
+	.read = sl_evtlog_read,
+	.write = sl_evtlog_write,
+	.llseek	= default_llseek,
+};
+
+#define SL_DIR_ENTRY	1 /* directoy node must be last */
+#define SL_FS_ENTRIES	2
+
+static struct dentry *fs_entries[SL_FS_ENTRIES];
+
+static long slaunch_expose_securityfs(void)
+{
+	long ret = 0;
+	int entry = SL_DIR_ENTRY;
+
+	fs_entries[entry] = securityfs_create_dir("slaunch", NULL);
+	if (IS_ERR(fs_entries[entry])) {
+		pr_err("Error creating securityfs sl_evt_log directory\n");
+		ret = PTR_ERR(fs_entries[entry]);
+		goto err;
+	}
+
+	if (sl_evtlog.addr > 0) {
+		entry--;
+		fs_entries[entry] = securityfs_create_file(sl_evtlog.name,
+					   S_IRUSR | S_IRGRP,
+					   fs_entries[SL_DIR_ENTRY], NULL,
+					   &sl_evtlog_ops);
+		if (IS_ERR(fs_entries[entry])) {
+			pr_err("Error creating securityfs %s file\n",
+				sl_evtlog.name);
+			ret = PTR_ERR(fs_entries[entry]);
+			goto err_dir;
+		}
+	}
+
+	return 0;
+
+err_dir:
+	securityfs_remove(fs_entries[SL_DIR_ENTRY]);
+err:
+	return ret;
+}
+
+static void slaunch_teardown_securityfs(void)
+{
+	int i;
+
+	for (i = 0; i < SL_FS_ENTRIES; i++)
+		securityfs_remove(fs_entries[i]);
+
+	if (sl_flags & SL_FLAG_ARCH_TXT) {
+		if (txt_heap) {
+			memunmap(txt_heap);
+			txt_heap = NULL;
+		}
+	}
+
+	sl_evtlog.addr = 0;
+	sl_evtlog.size = 0;
+}
+
+static void slaunch_intel_evtlog(void)
+{
+	void __iomem *config;
+	struct txt_os_mle_data *params;
+	void *os_sinit_data;
+	u64 base, size;
+
+	config = ioremap(TXT_PUB_CONFIG_REGS_BASE, TXT_NR_CONFIG_PAGES *
+			 PAGE_SIZE);
+	if (!config) {
+		pr_err("Error failed to ioremap TXT reqs\n");
+		return;
+	}
+
+	memcpy_fromio(&base, config + TXT_CR_HEAP_BASE, sizeof(u64));
+	memcpy_fromio(&size, config + TXT_CR_HEAP_SIZE, sizeof(u64));
+	iounmap(config);
+
+	/* now map TXT heap */
+	txt_heap = memremap(base, size, MEMREMAP_WB);
+	if (!txt_heap) {
+		pr_err("Error failed to memremap TXT heap\n");
+		return;
+	}
+
+	params = (struct txt_os_mle_data *)txt_os_mle_data_start(txt_heap);
+
+	sl_evtlog.size = TXT_MAX_EVENT_LOG_SIZE;
+	sl_evtlog.addr = (void __iomem *)&params->event_log_buffer[0];
+
+	/* Determine if this is TPM 1.2 or 2.0 event log */
+	if (memcmp(sl_evtlog.addr + sizeof(struct tpm12_pcr_event),
+		    TPM20_EVTLOG_SIGNATURE, sizeof(TPM20_EVTLOG_SIGNATURE)))
+		return; /* looks like it is not 2.0 */
+
+	/* For TPM 2.0 logs, the extended heap element must be located */
+	os_sinit_data = txt_os_sinit_data_start(txt_heap);
+
+	evtlog20 = tpm20_find_log2_1_element(os_sinit_data);
+
+	/*
+	 * If this fails, things are in really bad shape. Any attempt to write
+	 * events to the log will fail.
+	 */
+	if (!evtlog20)
+		pr_err("Error failed to find TPM20 event log element\n");
+}
+
+static int __init slaunch_late_init(void)
+{
+	/* Check to see if Secure Launch happened */
+	if (!(sl_flags & (SL_FLAG_ACTIVE|SL_FLAG_ARCH_TXT)))
+		return 0;
+
+	/* Only Intel TXT is supported at this point */
+	slaunch_intel_evtlog();
+
+	return slaunch_expose_securityfs();
+}
+
+static void __exit slaunch_exit(void)
+{
+	slaunch_teardown_securityfs();
+}
+
+late_initcall(slaunch_late_init);
+
+__exitcall(slaunch_exit);
-- 
2.25.1

