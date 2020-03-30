Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6189CC43331
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 18:45:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3344C20714
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 18:45:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lGnsXInS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727806AbgC3Spf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 14:45:35 -0400
Received: from mail-pf1-f181.google.com ([209.85.210.181]:34161 "EHLO
        mail-pf1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726385AbgC3Spe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 14:45:34 -0400
Received: by mail-pf1-f181.google.com with SMTP id 23so9050012pfj.1
        for <linux-kernel@vger.kernel.org>; Mon, 30 Mar 2020 11:45:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9wol+ovrMueDkx4O+ZEeXlUF+lPxlG2M/9hBMAq0rDQ=;
        b=lGnsXInSBhi87I3QI6h7raDe/x4KeVUALH840j659Z+daNe6ehRqhKNObsT3XqRPhU
         IVFjIOJraw2Zqj5f8mk1vZfJPESaRljbCjPHrHI54d3Dy5Gn2YmDgQIeU/xC6Gf1ro1k
         KU56WeJm8XFDW4ql8U4Xlhl9K5r+XIY1kVDQCLv6qWszf5Br27oQTYRXwpu1g/K0KcvN
         K5q/iwRgxpx+1XzGfa6qcGG2pDWeNrzJ32nsGVLhoMuRwSFLKUXlGZm4ESxLw4sf/hsc
         SoVhYcwJZ5YljDPwr/PW+7+cjHsLQqIOvkshbfwQubTQIBfKi1aU+Drs2SXAqm4vv8WT
         bMFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9wol+ovrMueDkx4O+ZEeXlUF+lPxlG2M/9hBMAq0rDQ=;
        b=FzGY0mzolFArenfqInjTujaNmBRARxwIplEypvK1mFkoV4Uve26+5NKZ4NXlYwa5wb
         vbP6eS59VzEz8o1VNDLkx5fga6UEVV+NU2a0SSk9lYXVEkypsa2vB3cS4YCWChdMcyxN
         326RV2Iy2rFHaEE+/3vTEby08ynEbmnTQ8c1eEx0f46ZycaD6dEzT8mIb89l8FVE8uxs
         vC3E9LEVBV9ma1Ecl8Fiwr9NbQ3ENxySxlb+Q+DnL4YMz877NsFJiaxDtA5/lo2pKJt/
         4P19I8RxVsl7RI7GxdnoGA0nnDg5pXJKoDwAd4JLuP19RcM9GBNMDuSQ+tE4SeoDnDDL
         wjFA==
X-Gm-Message-State: ANhLgQ2fqVzs8AhuNdZRI4vMTszflF2saYvpfrB89EkUcHvOEE9gVbIt
        j+RI2Gu+vHuz49LbssCjDdM=
X-Google-Smtp-Source: ADFU+vunmqPw2uT4eqPeeR1QoIac+sHhFAoghR7V0FCU1nrZrah2LDXbaq3rdhqY0m1rnQCVSk8JJw==
X-Received: by 2002:a62:1ace:: with SMTP id a197mr13951840pfa.105.1585593933473;
        Mon, 30 Mar 2020 11:45:33 -0700 (PDT)
Received: from OptiPlexFedora.fios-router.home ([47.144.161.84])
        by smtp.gmail.com with ESMTPSA id 13sm3347202pfn.131.2020.03.30.11.45.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2020 11:45:33 -0700 (PDT)
From:   "John B. Wyatt IV" <jbwyatt4@gmail.com>
To:     outreachy-kernel@googlegroups.com,
        Julia Lawall <julia.lawall@inria.fr>,
        Stefano Brivio <sbrivio@redhat.com>,
        Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Quentin Deslandes <quentin.deslandes@itdev.co.uk>,
        Colin Ian King <colin.king@canonical.com>,
        Malcolm Priestley <tvboxspy@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Cc:     "John B. Wyatt IV" <jbwyatt4@gmail.com>
Subject: [PATCH v5] staging: vt6656: add error code handling to unused variable
Date:   Mon, 30 Mar 2020 11:45:17 -0700
Message-Id: <20200330184517.33074-1-jbwyatt4@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add error code handling to unused 'ret' variable that was never used.
Return an error code from functions called within vnt_radio_power_on.

Issue reported by coccinelle (coccicheck).

Suggested-by: Quentin Deslandes <quentin.deslandes@itdev.co.uk>
Suggested-by: Stefano Brivio <sbrivio@redhat.com>
Reviewed-by: Quentin Deslandes <quentin.deslandes@itdev.co.uk>
Signed-off-by: John B. Wyatt IV <jbwyatt4@gmail.com>
---
v5: Remove Suggested-by: Julia Lawall above seperator line.
    Remove break; statement in switch block.
    break; removal checked by both gcc compile and checkpatch.
    Suggested by Stefano Brivio <sbrivio@redhat.com>

v4: Move Suggested-by: Julia Lawall above seperator line.
    Add Reviewed-by tag as requested by Quentin Deslandes.

v3: Forgot to add v2 code changes to commit.

v2: Replace goto statements with return.
    Remove last if check because it was unneeded.
    Suggested-by: Julia Lawall <julia.lawall@inria.fr>

 drivers/staging/vt6656/card.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/vt6656/card.c b/drivers/staging/vt6656/card.c
index dc3ab10eb630..27fc53accdfd 100644
--- a/drivers/staging/vt6656/card.c
+++ b/drivers/staging/vt6656/card.c
@@ -723,9 +723,13 @@ int vnt_radio_power_on(struct vnt_private *priv)
 {
 	int ret = 0;
 
-	vnt_exit_deep_sleep(priv);
+	ret = vnt_exit_deep_sleep(priv);
+	if (ret)
+		return ret;
 
-	vnt_mac_reg_bits_on(priv, MAC_REG_HOSTCR, HOSTCR_RXON);
+	ret = vnt_mac_reg_bits_on(priv, MAC_REG_HOSTCR, HOSTCR_RXON);
+	if (ret)
+		return ret;
 
 	switch (priv->rf_type) {
 	case RF_AL2230:
@@ -734,14 +738,15 @@ int vnt_radio_power_on(struct vnt_private *priv)
 	case RF_VT3226:
 	case RF_VT3226D0:
 	case RF_VT3342A0:
-		vnt_mac_reg_bits_on(priv, MAC_REG_SOFTPWRCTL,
-				    (SOFTPWRCTL_SWPE2 | SOFTPWRCTL_SWPE3));
+		ret = vnt_mac_reg_bits_on(priv, MAC_REG_SOFTPWRCTL,
+					  (SOFTPWRCTL_SWPE2 | 
+					  SOFTPWRCTL_SWPE3));
 		break;
 	}
+	if (ret)
+		return ret;
 
-	vnt_mac_reg_bits_off(priv, MAC_REG_GPIOCTL1, GPIO3_INTMD);
-
-	return ret;
+	return vnt_mac_reg_bits_off(priv, MAC_REG_GPIOCTL1, GPIO3_INTMD);
 }
 
 void vnt_set_bss_mode(struct vnt_private *priv)
-- 
2.25.1

