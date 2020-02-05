Return-Path: <SRS0=fqu/=3Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 153E9C35247
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 15:55:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1E99217BA
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 15:55:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KcUUVv3V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727678AbgBEPzd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Feb 2020 10:55:33 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:40575 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726661AbgBEPzb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 10:55:31 -0500
Received: by mail-pj1-f66.google.com with SMTP id 12so1163714pjb.5
        for <linux-kernel@vger.kernel.org>; Wed, 05 Feb 2020 07:55:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=RZ6Ct4Oj3K0GAue+qavlZN4QrXIm9tOhLLMRLW/Kj14=;
        b=KcUUVv3VGnVKCMO60mdN3/wQH2++CFCggPRHk3bUcA7COjLXlv7RM0dfBEupMhL22t
         tV+aXl5f0j1QuIEBzDTZPFOiaJ37NU9uUxQu6GyONEYV27NinN06BCYXdeEXVq6aWb1i
         MHp52c2e4eiX4EiEzOz65wfehVks0y0r0Mx2hRoAWYj+TDwoYEMC90klQXPQPsh80R1G
         Hf+A7VGV8mcShRmvFREPT+KAzIyaC8YhAqIGYnTj3uIFBJ5g89qcSTHGCXhpGAbqWyGE
         YT/TcAXAVnL/PCbwfGvE6gtzfT607JO3k29Htswkof1QpM2I0L+eQUbGVBsG52P+G0me
         ehSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:in-reply-to:references;
        bh=RZ6Ct4Oj3K0GAue+qavlZN4QrXIm9tOhLLMRLW/Kj14=;
        b=Hk61Qyt9kcibnPh/+vSBVf4D/j/tMmpMY+Ib5k02SLTcOZX/3kyOpgnJZs7PO52LcM
         AqaKGx3ZcrKSfHIIIGu6kqATfFcxMr9d+itc1pluEDiPYmP7CIajVPr4d61J7RI0PBkx
         eXpHh6swxDvUkH7tYa54I+Lal087b3m5ftaWy9+JaqB44nM5YtzKqki9nFLpiwxKuyxJ
         VK9We8dMZXOOMKL8kcWB1hBWhGOIJHFc1+4RlpStlRd5IgpX2pH42iWwh/cHqgfYOPvU
         x9MXiHT8HrW/kKSOMycY+gwhOPNsa66oAw4tzUERFuVEUIlONODfWEJowMZxvLDGut9M
         m0Ag==
X-Gm-Message-State: APjAAAWbXyGZUw6g/J/wM3jXAAN2SLVT8h8wBx7oneK2Oe5lnBeMZwGX
        7JQTFLG4IyeBJmNlX6JudIY=
X-Google-Smtp-Source: APXvYqzLQ4Y25RJhzUQVA9vcQ96lpanTthGUCJKFc0c/+B6lbpC7vu5R2UFKxtKxLy8rvO4lUhx3Zw==
X-Received: by 2002:a17:90a:950b:: with SMTP id t11mr6216301pjo.79.1580918130305;
        Wed, 05 Feb 2020 07:55:30 -0800 (PST)
Received: from emb-wallaby.amd.com ([165.204.156.251])
        by smtp.gmail.com with ESMTPSA id z10sm195678pgz.88.2020.02.05.07.55.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2020 07:55:29 -0800 (PST)
From:   Arindam Nath <arindam.nath@amd.com>
To:     Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        Jon Mason <jdmason@kudzu.us>,
        Dave Jiang <dave.jiang@intel.com>,
        Allen Hubbe <allenbh@gmail.com>,
        Jiasen Lin <linjiasen@hygon.cn>,
        Sanjay R Mehta <sanju.mehta@amd.com>
Cc:     linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org,
        Arindam Nath <arindam.nath@amd.com>
Subject: [PATCH 14/15] NTB: send DB event when driver is loaded or un-loaded
Date:   Wed,  5 Feb 2020 21:24:31 +0530
Message-Id: <e2f6de21a4faf6a44e18dd5f6429b6150913f324.1580914232.git.arindam.nath@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1580914232.git.arindam.nath@amd.com>
References: <cover.1580914232.git.arindam.nath@amd.com>
In-Reply-To: <cover.1580914232.git.arindam.nath@amd.com>
References: <cover.1580914232.git.arindam.nath@amd.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the driver on the local side is loaded, it sets
SIDE_READY bit in SIDE_INFO register. Likewise, when
it is un-loaded, it clears the bit.

Also just after being loaded, the driver polls for
peer SIDE_READY bit to be set. Since that bit is set
when the peer side driver has loaded, the polling on
local side breaks as soon as this condition is met.

But the situation is different when the driver is
un-loaded. Since the polling has already been stopped
as mentioned before, if the peer side driver gets
un-loaded, the driver on the local side is not notified
implicitly.

So, we improvise using existing doorbell mechanism.
We reserve the highest order bit of the DB register to
send a notification to peer when the driver on local
side is un-loaded. This also means that now we are one
short of 16 DB events and that is taken care of in the
valid DB mask.

Signed-off-by: Arindam Nath <arindam.nath@amd.com>
---
 drivers/ntb/hw/amd/ntb_hw_amd.c | 57 +++++++++++++++++++++++++++++++--
 drivers/ntb/hw/amd/ntb_hw_amd.h |  1 +
 2 files changed, 56 insertions(+), 2 deletions(-)

diff --git a/drivers/ntb/hw/amd/ntb_hw_amd.c b/drivers/ntb/hw/amd/ntb_hw_amd.c
index 04be1482037b..c6cea0005553 100644
--- a/drivers/ntb/hw/amd/ntb_hw_amd.c
+++ b/drivers/ntb/hw/amd/ntb_hw_amd.c
@@ -647,6 +647,36 @@ static void amd_handle_event(struct amd_ntb_dev *ndev, int vec)
 	writel(status, mmio + AMD_INTSTAT_OFFSET);
 }
 
+static void amd_handle_db_event(struct amd_ntb_dev *ndev, int vec)
+{
+	struct device *dev = &ndev->ntb.pdev->dev;
+	u64 status;
+
+	status = amd_ntb_db_read(&ndev->ntb);
+
+	dev_dbg(dev, "status = 0x%llx and vec = %d\n", status, vec);
+
+	/*
+	 * Since we had reserved highest order bit of DB for signaling peer of
+	 * a special event, this is the only status bit we should be concerned
+	 * here now.
+	 */
+	if (status & BIT(ndev->db_last_bit)) {
+		ntb_db_clear(&ndev->ntb, BIT(ndev->db_last_bit));
+		/* send link down event notification */
+		ntb_link_event(&ndev->ntb);
+
+		/*
+		 * If we are here, that means the peer has signalled a special
+		 * event which notifies that the peer driver has been
+		 * un-loaded for some reason. Since there is a chance that the
+		 * peer will load its driver again sometime, we schedule link
+		 * polling routine.
+		 */
+		schedule_delayed_work(&ndev->hb_timer, AMD_LINK_HB_TIMEOUT);
+	}
+}
+
 static irqreturn_t ndev_interrupt(struct amd_ntb_dev *ndev, int vec)
 {
 	dev_dbg(&ndev->ntb.pdev->dev, "vec %d\n", vec);
@@ -654,8 +684,10 @@ static irqreturn_t ndev_interrupt(struct amd_ntb_dev *ndev, int vec)
 	if (vec > (AMD_DB_CNT - 1) || (ndev->msix_vec_count == 1))
 		amd_handle_event(ndev, vec);
 
-	if (vec < AMD_DB_CNT)
+	if (vec < AMD_DB_CNT) {
+		amd_handle_db_event(ndev, vec);
 		ntb_db_event(&ndev->ntb, vec);
+	}
 
 	return IRQ_HANDLED;
 }
@@ -1096,6 +1128,21 @@ static int amd_init_dev(struct amd_ntb_dev *ndev)
 		return rc;
 	}
 
+	ndev->db_valid_mask = BIT_ULL(ndev->db_count) - 1;
+	/*
+	 * We reserve the highest order bit of the DB register which will
+	 * be used to notify peer when the driver on this side is being
+	 * un-loaded.
+	 */
+	ndev->db_last_bit =
+			find_last_bit((unsigned long *)&ndev->db_valid_mask,
+				      hweight64(ndev->db_valid_mask));
+	writew((u16)~BIT(ndev->db_last_bit), mmio + AMD_DBMASK_OFFSET);
+	/*
+	 * Since now there is one less bit to account for, the DB count
+	 * and DB mask should be adjusted accordingly.
+	 */
+	ndev->db_count -= 1;
 	ndev->db_valid_mask = BIT_ULL(ndev->db_count) - 1;
 
 	/* Enable Link-Up and Link-Down event interrupts */
@@ -1235,9 +1282,15 @@ static void amd_ntb_pci_remove(struct pci_dev *pdev)
 {
 	struct amd_ntb_dev *ndev = pci_get_drvdata(pdev);
 
+	/*
+	 * Clear the READY bit in SIDEINFO register before sending DB event
+	 * to the peer. This will make sure that when the peer handles the
+	 * DB event, it correctly reads this bit as being 0.
+	 */
+	amd_deinit_side_info(ndev);
+	ntb_peer_db_set(&ndev->ntb, BIT_ULL(ndev->db_last_bit));
 	ntb_unregister_device(&ndev->ntb);
 	ndev_deinit_debugfs(ndev);
-	amd_deinit_side_info(ndev);
 	amd_deinit_dev(ndev);
 	amd_ntb_deinit_pci(ndev);
 	kfree(ndev);
diff --git a/drivers/ntb/hw/amd/ntb_hw_amd.h b/drivers/ntb/hw/amd/ntb_hw_amd.h
index 73959c0b9972..5f337b1572a0 100644
--- a/drivers/ntb/hw/amd/ntb_hw_amd.h
+++ b/drivers/ntb/hw/amd/ntb_hw_amd.h
@@ -193,6 +193,7 @@ struct amd_ntb_dev {
 
 	u64 db_valid_mask;
 	u64 db_mask;
+	u64 db_last_bit;
 	u32 int_mask;
 
 	struct msix_entry *msix;
-- 
2.17.1

