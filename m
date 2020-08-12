Return-Path: <SRS0=ZArZ=BW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FA7BC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 00:09:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D6902076C
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 00:09:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="D8glpmb5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726503AbgHLAJF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 20:09:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726422AbgHLAJE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 20:09:04 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9085DC061787
        for <linux-kernel@vger.kernel.org>; Tue, 11 Aug 2020 17:09:04 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id f4so487968plo.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Aug 2020 17:09:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=ZpqanX1uekkaNMZ08yYFYDvc0CW2tgz+aClfGg1TO1g=;
        b=D8glpmb5WqJz7ppDPauIiHX6IcmeWzaqOufV1M73cok0q632O2khgu2afnO+tDpuKI
         YnRmw4Q3IxOKQNkRoy99lB8vIL3ciQj7ygU8jmEsiper0TzL4eHrK+a/ywAmhGPgUdf1
         aAoMU5nbhCCgf9hAPNk8dNTQKf6bbnUf4UNEJJVxAK8KrK1Cs16pbwhnkIfTipfExPXZ
         UYiB2prYhq6Tz6X9h5QnkRjpCxDGIyHzMzCk4GyRppltjHedFla51yaa3Dg9Rzo66zCP
         y67nw+WrWxTExSFmHgtGu/uE7jnDIwuRKqJRcpWoLLIGLccEmssdKzQTToPMgII8usiz
         lHag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=ZpqanX1uekkaNMZ08yYFYDvc0CW2tgz+aClfGg1TO1g=;
        b=G4uj3nTMJEjnDlm9jHtyZ7V+tarznOJHESHxvfBqjcAe+PfK9q4OEX2HxdE7YjKKUz
         ooFzjZsm3PzdKUvZN26oK2XPNtoRjZFHqdBVKtVxuAqt//SKCxfuNX8xX/MOaMPy8SQf
         aKGfqx5pfd3HKPbttEHETrF1XS6oEzN6MKJqOBYYzHa4OofHhjjW+KRXqxOxHZRecP/k
         1RpdvCDLKZnOP1l03tzowaCHiM1jc/SV56YNCS1lvYCihKmpLGGJhx85innKaczM/Sw5
         qdKoZHQVBoP1cAMHHOhGV9gQqdMKSmPF1mgkms2yPKXuqHfoUpHGgdNTu0Zsmrs+6Ack
         BsaQ==
X-Gm-Message-State: AOAM531WhxNIlMjs5mOozMRvWheATtFnbRzNj6t1l1Qn2zaNA3igapWK
        qlV02tdgSbWDWc3kxnUod9+lEU2pVwc=
X-Google-Smtp-Source: ABdhPJyAoAFNgGqRiTvKp/WURNjiv5ZkyaVdAQV0Gtf9rEJk3MICDNXW1ef5laLWh37ybsijrLOThls1zbg=
X-Received: by 2002:a17:90a:f014:: with SMTP id bt20mr365422pjb.0.1597190943694;
 Tue, 11 Aug 2020 17:09:03 -0700 (PDT)
Date:   Tue, 11 Aug 2020 17:08:59 -0700
Message-Id: <20200812000859.542332-1-badhri@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.236.gb10cc79966-goog
Subject: [PATCH v1] tcpm: During PR_SWAP, source caps should be sent only
 after tSwapSourceStart
From:   Badhri Jagan Sridharan <badhri@google.com>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Badhri Jagan Sridharan <badhri@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From the spec:
"6.6.8.1 SwapSourceStartTimer
The SwapSourceStartTimer Shall be used by the new Source, after a Power
Role Swap or Fast Role Swap, to ensure that it does not send
Source_Capabilities Message before the new Sink is ready to receive the
Source_Capabilities Message. The new Source Shall Not send the
Source_Capabilities Message earlier than tSwapSourceStart after the
last bit of the EOP of GoodCRC Message sent in response to the PS_RDY
Message sent by the new Source indicating that its power supply is
ready."

This fixes TD.PD.CP.E3, TD.PD.CP.E4, TD.PD.CP.E5 failures

Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>
---
 drivers/usb/typec/tcpm/tcpm.c | 2 +-
 include/linux/usb/pd.h        | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
index 3ef37202ee37..d38347bd3335 100644
--- a/drivers/usb/typec/tcpm/tcpm.c
+++ b/drivers/usb/typec/tcpm/tcpm.c
@@ -3555,7 +3555,7 @@ static void run_state_machine(struct tcpm_port *port)
 		 */
 		tcpm_set_pwr_role(port, TYPEC_SOURCE);
 		tcpm_pd_send_control(port, PD_CTRL_PS_RDY);
-		tcpm_set_state(port, SRC_STARTUP, 0);
+		tcpm_set_state(port, SRC_STARTUP, PD_T_SWAP_SRC_START);
 		break;
 
 	case VCONN_SWAP_ACCEPT:
diff --git a/include/linux/usb/pd.h b/include/linux/usb/pd.h
index b6c233e79bd4..ea842ae862d4 100644
--- a/include/linux/usb/pd.h
+++ b/include/linux/usb/pd.h
@@ -473,6 +473,7 @@ static inline unsigned int rdo_max_power(u32 rdo)
 #define PD_T_ERROR_RECOVERY	100	/* minimum 25 is insufficient */
 #define PD_T_SRCSWAPSTDBY      625     /* Maximum of 650ms */
 #define PD_T_NEWSRC            250     /* Maximum of 275ms */
+#define PD_T_SWAP_SRC_START	20
 
 #define PD_T_DRP_TRY		100	/* 75 - 150 ms */
 #define PD_T_DRP_TRYWAIT	600	/* 400 - 800 ms */
-- 
2.28.0.236.gb10cc79966-goog

