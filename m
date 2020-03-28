Return-Path: <SRS0=NZ+o=5N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92BF9C2D0EF
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 07:47:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 511B3206CC
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 07:47:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="PRoz1823"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726899AbgC1HrA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Mar 2020 03:47:00 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:41711 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726463AbgC1Hq7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Mar 2020 03:46:59 -0400
Received: by mail-pl1-f193.google.com with SMTP id d24so574464pll.8
        for <linux-kernel@vger.kernel.org>; Sat, 28 Mar 2020 00:46:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/0yIJm4VigGIBzJcmlJZgilkaD/1M80KU8ghmsbNvmQ=;
        b=PRoz1823xcDabkyRmMJELnYjxlhBx1S2BufXvfLNMn66WcUsEH73DAAzl1FJU2CBDu
         7z05se4WuUF6333k4sBs6X1wvgb3c/HJct5inuEl0Nqux0mgWJSvPlXzBY+lVC787Xr1
         dGZuLaIxclRM3X3hqDwLjVfXWoCyrXY0+UXfY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/0yIJm4VigGIBzJcmlJZgilkaD/1M80KU8ghmsbNvmQ=;
        b=qwcctaTkQnCLLs37HSWs7hp/52vNJC37ftx9qmpcRwW20Xyb8l27oW7XQliGxQVDFT
         B85/NzzdMuux08XtHNgNbTn0gh8qaDY9C+R1GhCsSPdi02xxDnJRYvTbX803c8dCYvmm
         Wcx92qp8m2KTruo9xceVnWvjmtkyWZGhIx4RdKXvRk7/zrAR7ZplOyuH40mK6ct1cXJB
         0aXnjC0KTuAVwVicenbhlwe+KK6vJf03xIWvhaNGZxdrbtjsbrTy2FBojMkBZdM49Roe
         UQgKukYtBzXgmmOUYZdo0wIo4olNzhvOj7yPKbKxTg33ybTnP+xamL8uyqziAhMT6356
         2IgQ==
X-Gm-Message-State: ANhLgQ1d5hahao/axOMTyg0rLSUuq6McYCCi42tnJeLGrFiVromhFky7
        x7xy1ckgknYcWF9UKXuBL80hgA==
X-Google-Smtp-Source: ADFU+vuEqEgJSMWfY2GR/a62CiaPCpQ3wdGtB2W4NKlQhUj81mNyI+d7lDz+mMhnijBq4/dXBUACNQ==
X-Received: by 2002:a17:90a:ad87:: with SMTP id s7mr3640371pjq.52.1585381616687;
        Sat, 28 Mar 2020 00:46:56 -0700 (PDT)
Received: from mcchou0.mtv.corp.google.com ([2620:15c:202:201:b46:ac84:1014:9555])
        by smtp.gmail.com with ESMTPSA id r59sm5273063pjb.45.2020.03.28.00.46.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 28 Mar 2020 00:46:55 -0700 (PDT)
From:   Miao-chen Chou <mcchou@chromium.org>
To:     Bluetooth Kernel Mailing List <linux-bluetooth@vger.kernel.org>
Cc:     Alain Michaud <alainm@chromium.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Miao-chen Chou <mcchou@chromium.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH v4 2/2] Bluetooth: btusb: Read the supported features of Microsoft vendor extension
Date:   Sat, 28 Mar 2020 00:46:32 -0700
Message-Id: <20200328004507.v4.2.Ic59b637deef8e646f6599a80c9a2aa554f919e55@changeid>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200328074632.21907-1-mcchou@chromium.org>
References: <20200328074632.21907-1-mcchou@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This defines opcode and packet structures of Microsoft vendor extension.
For now, we add only the HCI_VS_MSFT_Read_Supported_Features command. See
https://docs.microsoft.com/en-us/windows-hardware/drivers/bluetooth/
microsoft-defined-bluetooth-hci-commands-and-events#microsoft-defined-
bluetooth-hci-events for more details.
Upon initialization of a hci_dev, we issue a
HCI_VS_MSFT_Read_Supported_Features command to read the supported features
of Microsoft vendor extension if the opcode of Microsoft vendor extension
is valid. See https://docs.microsoft.com/en-us/windows-hardware/drivers/
bluetooth/microsoft-defined-bluetooth-hci-commands-and-events#
hci_vs_msft_read_supported_features for more details.
This was verified on a device with Intel ThunderPeak BT controller where
the Microsoft vendor extension features are 0x000000000000003f.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>

Signed-off-by: Miao-chen Chou <mcchou@chromium.org>
---

Changes in v4:
- Move MSFT's do_open() and do_close() from net/bluetooth/hci_core.c to
net/bluetooth/msft.c.
- Other than msft opcode, define struct msft_data to host the rest of
information of Microsoft extension and leave a void* pointing to a
msft_data in struct hci_dev.

Changes in v3:
- Introduce msft_vnd_ext_do_open() and msft_vnd_ext_do_close().

Changes in v2:
- Issue a HCI_VS_MSFT_Read_Supported_Features command with
__hci_cmd_sync() instead of constructing a request.

 include/net/bluetooth/hci_core.h |   1 +
 net/bluetooth/hci_core.c         |   5 ++
 net/bluetooth/hci_event.c        |   5 ++
 net/bluetooth/msft.c             | 126 +++++++++++++++++++++++++++++++
 net/bluetooth/msft.h             |  10 +++
 5 files changed, 147 insertions(+)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 239cae2d9998..59ddcd3a52cc 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -486,6 +486,7 @@ struct hci_dev {
 
 #if IS_ENABLED(CONFIG_BT_MSFTEXT)
 	__u16			msft_opcode;
+	void			*msft_data;
 #endif
 
 	int (*open)(struct hci_dev *hdev);
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index dbd2ad3a26ed..c38707de767a 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -44,6 +44,7 @@
 #include "hci_debugfs.h"
 #include "smp.h"
 #include "leds.h"
+#include "msft.h"
 
 static void hci_rx_work(struct work_struct *work);
 static void hci_cmd_work(struct work_struct *work);
@@ -1563,6 +1564,8 @@ static int hci_dev_do_open(struct hci_dev *hdev)
 	    hci_dev_test_flag(hdev, HCI_VENDOR_DIAG) && hdev->set_diag)
 		ret = hdev->set_diag(hdev, true);
 
+	msft_do_open(hdev);
+
 	clear_bit(HCI_INIT, &hdev->flags);
 
 	if (!ret) {
@@ -1758,6 +1761,8 @@ int hci_dev_do_close(struct hci_dev *hdev)
 
 	hci_sock_dev_event(hdev, HCI_DEV_DOWN);
 
+	msft_do_close(hdev);
+
 	if (hdev->flush)
 		hdev->flush(hdev);
 
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 20408d386268..42b5871151a6 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -35,6 +35,7 @@
 #include "a2mp.h"
 #include "amp.h"
 #include "smp.h"
+#include "msft.h"
 
 #define ZERO_KEY "\x00\x00\x00\x00\x00\x00\x00\x00" \
 		 "\x00\x00\x00\x00\x00\x00\x00\x00"
@@ -6144,6 +6145,10 @@ void hci_event_packet(struct hci_dev *hdev, struct sk_buff *skb)
 		hci_num_comp_blocks_evt(hdev, skb);
 		break;
 
+	case HCI_EV_VENDOR:
+		msft_vendor_evt(hdev, skb);
+		break;
+
 	default:
 		BT_DBG("%s event 0x%2.2x", hdev->name, event);
 		break;
diff --git a/net/bluetooth/msft.c b/net/bluetooth/msft.c
index 7609932c48ca..f76e4c79556e 100644
--- a/net/bluetooth/msft.c
+++ b/net/bluetooth/msft.c
@@ -6,6 +6,24 @@
 
 #include "msft.h"
 
+#define MSFT_OP_READ_SUPPORTED_FEATURES		0x00
+struct msft_cp_read_supported_features {
+	__u8   sub_opcode;
+} __packed;
+struct msft_rp_read_supported_features {
+	__u8   status;
+	__u8   sub_opcode;
+	__le64 features;
+	__u8   evt_prefix_len;
+	__u8   evt_prefix[0];
+} __packed;
+
+struct msft_data {
+	__u64 features;
+	__u8  evt_prefix_len;
+	__u8  *evt_prefix;
+};
+
 void msft_set_opcode(struct hci_dev *hdev, __u16 opcode)
 {
 	hdev->msft_opcode = opcode;
@@ -14,3 +32,111 @@ void msft_set_opcode(struct hci_dev *hdev, __u16 opcode)
 		    hdev->msft_opcode);
 }
 EXPORT_SYMBOL(msft_set_opcode);
+
+static struct msft_data *read_supported_features(struct hci_dev *hdev)
+{
+	struct msft_data *msft;
+	struct msft_cp_read_supported_features cp;
+	struct msft_rp_read_supported_features *rp;
+	struct sk_buff *skb;
+
+	cp.sub_opcode = MSFT_OP_READ_SUPPORTED_FEATURES;
+
+	skb = __hci_cmd_sync(hdev, hdev->msft_opcode, sizeof(cp), &cp,
+			     HCI_CMD_TIMEOUT);
+	if (IS_ERR(skb)) {
+		bt_dev_err(hdev, "Failed to read MSFT supported features (%ld)",
+			   PTR_ERR(skb));
+		return NULL;
+	}
+
+	if (skb->len < sizeof(*rp)) {
+		bt_dev_err(hdev, "MSFT supported features length mismatch");
+		goto failed;
+	}
+
+	rp = (struct msft_rp_read_supported_features *)skb->data;
+
+	if (rp->sub_opcode != MSFT_OP_READ_SUPPORTED_FEATURES)
+		goto failed;
+
+	msft = kzalloc(sizeof(*msft), GFP_KERNEL);
+	if (!msft)
+		goto failed;
+
+	if (rp->evt_prefix_len > 0) {
+		msft->evt_prefix = kmemdup(rp->evt_prefix, rp->evt_prefix_len,
+					   GFP_KERNEL);
+		if (!msft->evt_prefix)
+			goto failed;
+	}
+
+	msft->evt_prefix_len = rp->evt_prefix_len;
+	msft->features = __le64_to_cpu(rp->features);
+	kfree_skb(skb);
+
+	bt_dev_info(hdev, "MSFT supported features %llx", msft->features);
+	return msft;
+
+failed:
+	kfree_skb(skb);
+	return NULL;
+}
+
+void msft_do_open(struct hci_dev *hdev)
+{
+	if (hdev->msft_opcode == HCI_OP_NOP)
+		return;
+
+	bt_dev_dbg(hdev, "Initialize MSFT extension");
+	hdev->msft_data = read_supported_features(hdev);
+}
+
+void msft_do_close(struct hci_dev *hdev)
+{
+	struct msft_data *msft = hdev->msft_data;
+
+	if (!msft)
+		return;
+
+	bt_dev_dbg(hdev, "Cleanup of MSFT extension");
+
+	hdev->msft_data = NULL;
+
+	kfree(msft->evt_prefix);
+	kfree(msft);
+}
+
+int msft_vendor_evt(struct hci_dev *hdev, struct sk_buff *skb)
+{
+	struct msft_data *msft = hdev->msft_data;
+	u8 event;
+
+	if (!msft)
+		return -ENOSYS;
+
+	/* When the extension has defined an event prefix, check that it
+	 * matches, and otherwise just return.
+	 */
+	if (msft->evt_prefix_len > 0) {
+		if (skb->len < msft->evt_prefix_len)
+			return -ENOSYS;
+
+		if (memcmp(skb->data, msft->evt_prefix, msft->evt_prefix_len))
+			return -ENOSYS;
+
+		skb_pull(skb, msft->evt_prefix_len);
+	}
+
+	/* Every event starts at least with an event code and the rest of
+	 * the data is variable and depends on the event code. Returns true
+	 */
+	if (skb->len < 1)
+		return -EBADMSG;
+
+	event = *skb->data;
+	skb_pull(skb, 1);
+
+	bt_dev_dbg(hdev, "MSFT vendor event %u", event);
+	return 0;
+}
diff --git a/net/bluetooth/msft.h b/net/bluetooth/msft.h
index 7218ea759dde..6a7d0ac6c66c 100644
--- a/net/bluetooth/msft.h
+++ b/net/bluetooth/msft.h
@@ -4,15 +4,25 @@
 #ifndef __MSFT_H
 #define __MSFT_H
 
+#include <linux/errno.h>
 #include <net/bluetooth/hci_core.h>
 
 #if IS_ENABLED(CONFIG_BT_MSFTEXT)
 
 void msft_set_opcode(struct hci_dev *hdev, __u16 opcode);
+void msft_do_open(struct hci_dev *hdev);
+void msft_do_close(struct hci_dev *hdev);
+int msft_vendor_evt(struct hci_dev *hdev, struct sk_buff *skb);
 
 #else
 
 static inline void msft_set_opcode(struct hci_dev *hdev, __u16 opcode) {}
+static inline void msft_do_open(struct hci_dev *hdev) {}
+static inline void msft_do_close(struct hci_dev *hdev) {}
+static inline int msft_vendor_evt(struct hci_dev *hdev, struct sk_buff *skb)
+{
+	return -ENOSYS;
+}
 
 #endif
 
-- 
2.24.1

