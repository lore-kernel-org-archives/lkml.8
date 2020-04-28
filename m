Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E319DC83007
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 07:02:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C30B1206A5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 07:02:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="akJy1tba"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726478AbgD1HCQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 03:02:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725867AbgD1HCQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 03:02:16 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCE16C03C1AC
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 00:02:14 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id f8so7987995plt.2
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 00:02:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4/nXkttFFpuCRApbDJrQtkcOv5tbYmzw7WwX94JHLec=;
        b=akJy1tba1VpIzlH/CXLZlgwmODN/R788RBn+EBkFiZNxPR9HnUenKsz8T7JZ3hBiQs
         6JxexXdGrkQivjC7Y9LpCP3JuG7fTFRrji8IJor7BprWzLpoplEjU1ufuwh+f1Z/rflv
         cj8ycSNF6ebqJt7mCKn11SKuViZxnhv1YL6SmKkoG2wggjoB5z3g+EIDR/kjNGSiM52i
         wmBl6bGfJ9pCt2vdzS74YeyDnawUMQokZMZEpok+2zU4ZBPPHHawFEkcVdqtHwS8SLLm
         B+0MFC85J0M48ov68PK4QQ0OOIGNv4Zmy9W4+VSV9tgm9A953mb3aQFl+AkIP5omVDyd
         GGjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4/nXkttFFpuCRApbDJrQtkcOv5tbYmzw7WwX94JHLec=;
        b=MDRpNEdprcX+i70RVBYM3rxvG99UoA1PMMedxEkfANtTrNebkhU/AdAQKtUpH5Hntl
         rg3vkvliOBR2Nr/0AShOzoHuMezGPw1vUu3rfy7SrpddzUBn8fQmz2naBo4AXXiv0IGV
         EQ9qGnd+a8/dD7zvKpnisjCHDP8E6pH0IHieC+IV3N1b35D7hPjgZ41pGFBqSzod9VB6
         rPKu0K/dO4NT/KrsP+eXd69LBT9hIYIN6YsMauASc0nHExU5OSyrlbgyHsEoAw5+sCpN
         1sc70nxsP4gfkbnWHmG1dH7gUnaIeH3oEg7tAUnxT78G1x4PCVAjS/L57CpLxhB95deY
         KpPA==
X-Gm-Message-State: AGi0PuZE0UZdv3SLbW6a9ZALa2Rc0NAZnrvD/zzaXGbZkIrGpn8ukiGJ
        0AbksXxucfhAPnDdjKpBXV8aPA==
X-Google-Smtp-Source: APiQypKJLT+5WEewrpsIGozji9eAxX0I24yBU7u0wC3+voEg1WXhmgIc5VBQVKbIDRa6YQ/bPe8YjA==
X-Received: by 2002:a17:90a:7105:: with SMTP id h5mr3221811pjk.3.1588057334032;
        Tue, 28 Apr 2020 00:02:14 -0700 (PDT)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id h193sm14310501pfe.30.2020.04.28.00.02.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2020 00:02:12 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     "David S. Miller" <davem@davemloft.net>,
        Chuhong Yuan <hslester96@gmail.com>,
        Peter Fink <pfink@christ-es.de>
Cc:     linux-usb@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: [PATCH] net: usb: ax88179_178a: Implement ethtool_ops set_eeprom
Date:   Tue, 28 Apr 2020 00:01:39 -0700
Message-Id: <20200428070139.3465511-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The vendor driver does upon failing to read a valid MAC address from
EEPROM write the netdev's address back to EEPROM and invoking a EEPROM
reload operation. Based on this we can implement the ethtool_ops
set_eeprom and provide the means to populate the EEPROM from within
Linux.

It's worth noting that ax88179_get_eeprom() will return some default
data unless the content of the EEPROM is deemed "complete", so until the
EEPROM is fully populated (e.g. by running ethtool -e | ethtool -E)
data written with ax88179_set_eeprom() will appear not to stick.

The implementation is based on asix_set_eeprom(), from asix_common.c

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 drivers/net/usb/ax88179_178a.c | 77 ++++++++++++++++++++++++++++++++++
 1 file changed, 77 insertions(+)

diff --git a/drivers/net/usb/ax88179_178a.c b/drivers/net/usb/ax88179_178a.c
index 93044cf1417a..b05bb11a02cb 100644
--- a/drivers/net/usb/ax88179_178a.c
+++ b/drivers/net/usb/ax88179_178a.c
@@ -31,6 +31,7 @@
 #define AX_ACCESS_PHY				0x02
 #define AX_ACCESS_EEPROM			0x04
 #define AX_ACCESS_EFUS				0x05
+#define AX_RELOAD_EEPROM_EFUSE			0x06
 #define AX_PAUSE_WATERLVL_HIGH			0x54
 #define AX_PAUSE_WATERLVL_LOW			0x55
 
@@ -611,6 +612,81 @@ ax88179_get_eeprom(struct net_device *net, struct ethtool_eeprom *eeprom,
 	return 0;
 }
 
+static int
+ax88179_set_eeprom(struct net_device *net, struct ethtool_eeprom *eeprom,
+		   u8 *data)
+{
+	struct usbnet *dev = netdev_priv(net);
+	u16 *eeprom_buff;
+	int first_word;
+	int last_word;
+	int ret;
+	int i;
+
+	netdev_dbg(net, "write EEPROM len %d, offset %d, magic 0x%x\n",
+		   eeprom->len, eeprom->offset, eeprom->magic);
+
+	if (eeprom->len == 0)
+		return -EINVAL;
+
+	if (eeprom->magic != AX88179_EEPROM_MAGIC)
+		return -EINVAL;
+
+	first_word = eeprom->offset >> 1;
+	last_word = (eeprom->offset + eeprom->len - 1) >> 1;
+
+	eeprom_buff = kmalloc_array(last_word - first_word + 1, sizeof(u16),
+				    GFP_KERNEL);
+	if (!eeprom_buff)
+		return -ENOMEM;
+
+	/* align data to 16 bit boundaries, read the missing data from
+	   the EEPROM */
+	if (eeprom->offset & 1) {
+		ret = ax88179_read_cmd(dev, AX_ACCESS_EEPROM, first_word, 1, 2,
+				       &eeprom_buff[0]);
+		if (ret < 0) {
+			netdev_err(net, "Failed to read EEPROM at offset 0x%02x.\n", first_word);
+			goto free;
+		}
+	}
+
+	if ((eeprom->offset + eeprom->len) & 1) {
+		ret = ax88179_read_cmd(dev, AX_ACCESS_EEPROM, last_word, 1, 2,
+				       &eeprom_buff[last_word - first_word]);
+		if (ret < 0) {
+			netdev_err(net, "Failed to read EEPROM at offset 0x%02x.\n", last_word);
+			goto free;
+		}
+	}
+
+	memcpy((u8 *)eeprom_buff + (eeprom->offset & 1), data, eeprom->len);
+
+	for (i = first_word; i <= last_word; i++) {
+		netdev_dbg(net, "write to EEPROM at offset 0x%02x, data 0x%04x\n",
+			   i, eeprom_buff[i - first_word]);
+		ret = ax88179_write_cmd(dev, AX_ACCESS_EEPROM, i, 1, 2,
+					&eeprom_buff[i - first_word]);
+		if (ret < 0) {
+			netdev_err(net, "Failed to write EEPROM at offset 0x%02x.\n", i);
+			goto free;
+		}
+		msleep(20);
+	}
+
+	/* reload EEPROM data */
+	ret = ax88179_write_cmd(dev, AX_RELOAD_EEPROM_EFUSE, 0x0000, 0, 0, NULL);
+	if (ret < 0) {
+		netdev_err(net, "Failed to reload EEPROM data\n");
+		goto free;
+	}
+
+	ret = 0;
+free:
+	kfree(eeprom_buff);
+	return ret;
+}
+
 static int ax88179_get_link_ksettings(struct net_device *net,
 				      struct ethtool_link_ksettings *cmd)
 {
@@ -822,6 +898,7 @@ static const struct ethtool_ops ax88179_ethtool_ops = {
 	.set_wol		= ax88179_set_wol,
 	.get_eeprom_len		= ax88179_get_eeprom_len,
 	.get_eeprom		= ax88179_get_eeprom,
+	.set_eeprom		= ax88179_set_eeprom,
 	.get_eee		= ax88179_get_eee,
 	.set_eee		= ax88179_set_eee,
 	.nway_reset		= usbnet_nway_reset,
-- 
2.24.0

