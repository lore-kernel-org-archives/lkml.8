Return-Path: <SRS0=MDzn=5V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE5F0C2BA15
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Apr 2020 20:13:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9313720672
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Apr 2020 20:13:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20150623.gappssmtp.com header.i=@daynix-com.20150623.gappssmtp.com header.b="jJyCDymm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727677AbgDEUNY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Apr 2020 16:13:24 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:40110 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726887AbgDEUNY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Apr 2020 16:13:24 -0400
Received: by mail-lf1-f66.google.com with SMTP id j17so10087028lfe.7
        for <linux-kernel@vger.kernel.org>; Sun, 05 Apr 2020 13:13:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZecswmQzcKyJcaA1KVr1PgDOFuDkBa9m5xQm0CMlRfg=;
        b=jJyCDymm6a4Y4wyhQ19mQrdIHDOuRafStVA1S1Ig6u2VsstNNG+WN5ithcMu/UoDhe
         CJm6CNrO5du/C461KF08IoNM6ixV+wdPZH8150mM/yVeqUBK51IxAnWz7mKOY839n8aW
         d7cHEB5htx7FQ8+DMQOGIPAUPdAP2iIaT8fdrFL0ztPZz0GCoILB7X3WnENer2eAJskQ
         eeo1VWbmuMKB2MUvYRbouX1S5SlVWKrKQ6M6xDtskZYZDXj9EBjSi5jMaCUjXzgkBOze
         jU3zjVkxzmHp8gl2mo4gFFASzkAJPg2bF21TLTOydSfR8DchzsZcVw7KD93PqUSsu39Y
         78tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZecswmQzcKyJcaA1KVr1PgDOFuDkBa9m5xQm0CMlRfg=;
        b=lvqpQLsD7CeJ+4XW4UGqdo+ZpknT/mJumbMrDmk3MvU8NS5dPBL6wMXTMWdwCBP10u
         V0XSEL0qwhcXQ3hM23Ir6Yu47K4dI6CNxDgGMuSx6b8BDcCKQuwDFieryaLKn+SHtEXi
         um0bO21fp/et0xHD2gn01epfEdiWqGMvg+hIuXB4Qwmov7MIBb0MfQ2u0uPeWHjFltgg
         m7jTx82Qk7jOAi2y454WslQ0SUVpz213QWI3rTaiInfLzDdOr/ECNr0A36LKZVUOc5on
         IvowRbz17UNhVC1keKXM/mcOFw5yZSm+fen/YIRuqA7N+43kIvOL2BIQLPCYBh0XYDin
         4lcw==
X-Gm-Message-State: AGi0Pub1QZ1xZTv6StS/I+4pIjoweybnYw1WiGIxO4nY6uzgUx9SFxe9
        44DkW6URIryYqYaItDv/mhzzTsmo5UnTdQ==
X-Google-Smtp-Source: APiQypIEsOpmUVRbUVIGQF9PTFmAXeRwenTbMDANUZ4VQGITx+F9m6bijBqeMQEHZ9PikkiF90Ex9A==
X-Received: by 2002:ac2:4143:: with SMTP id c3mr4585061lfi.131.1586117602906;
        Sun, 05 Apr 2020 13:13:22 -0700 (PDT)
Received: from navi.cosmonova.net.ua ([95.67.24.131])
        by smtp.gmail.com with ESMTPSA id m1sm5450815lfl.69.2020.04.05.13.13.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Apr 2020 13:13:22 -0700 (PDT)
From:   andrew@daynix.com
To:     virtualization@lists.linux-foundation.org
Cc:     gregkh@linuxfoundation.org, jslaby@suse.com,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Fix: buffer overflow during hvc_alloc().
Date:   Sun,  5 Apr 2020 23:40:24 +0300
Message-Id: <20200405204024.1007843-1-andrew@daynix.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrew Melnychenko <andrew@daynix.com>

If there is a lot(more then 16) of virtio-console devices
or virtio_console module is reloaded
- buffers 'vtermnos' and 'cons_ops' are overflowed.
In older kernels it overruns spinlock which leads to kernel freezing:
https://bugzilla.redhat.com/show_bug.cgi?id=1786239

Signed-off-by: Andrew Melnychenko <andrew@daynix.com>
---
 drivers/tty/hvc/hvc_console.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/drivers/tty/hvc/hvc_console.c b/drivers/tty/hvc/hvc_console.c
index 27284a2dcd2b..436cc51c92c3 100644
--- a/drivers/tty/hvc/hvc_console.c
+++ b/drivers/tty/hvc/hvc_console.c
@@ -302,10 +302,6 @@ int hvc_instantiate(uint32_t vtermno, int index, const struct hv_ops *ops)
 	vtermnos[index] = vtermno;
 	cons_ops[index] = ops;
 
-	/* reserve all indices up to and including this index */
-	if (last_hvc < index)
-		last_hvc = index;
-
 	/* check if we need to re-register the kernel console */
 	hvc_check_console(index);
 
@@ -960,13 +956,22 @@ struct hvc_struct *hvc_alloc(uint32_t vtermno, int data,
 		    cons_ops[i] == hp->ops)
 			break;
 
-	/* no matching slot, just use a counter */
-	if (i >= MAX_NR_HVC_CONSOLES)
-		i = ++last_hvc;
+	if (i >= MAX_NR_HVC_CONSOLES) {
+
+		/* find 'empty' slot for console */
+		for (i = 0; i < MAX_NR_HVC_CONSOLES && vtermnos[i] != -1; i++) {
+		}
+
+		/* no matching slot, just use a counter */
+		if (i == MAX_NR_HVC_CONSOLES)
+			i = ++last_hvc + MAX_NR_HVC_CONSOLES;
+	}
 
 	hp->index = i;
-	cons_ops[i] = ops;
-	vtermnos[i] = vtermno;
+	if (i < MAX_NR_HVC_CONSOLES) {
+		cons_ops[i] = ops;
+		vtermnos[i] = vtermno;
+	}
 
 	list_add_tail(&(hp->next), &hvc_structs);
 	mutex_unlock(&hvc_structs_mutex);
-- 
2.24.1

