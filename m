Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B6FAC433E7
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 15:36:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 05D8820678
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 15:36:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kHDTXriP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728054AbgIBPf6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 11:35:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728312AbgIBPfr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 11:35:47 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CDEDC061244;
        Wed,  2 Sep 2020 08:35:45 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id k15so3033008pfc.12;
        Wed, 02 Sep 2020 08:35:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=HEqwK4t3Jbhbn9WZdb3oUG7FILqb8kl/CCgidI15uDY=;
        b=kHDTXriPodcCimTodp4iPeVr/AekjfXT50p2ukyjZp6e16RJa0u708YWek45zszv3C
         Fp/vea5VhkArLmNoriItDE91gvIqPHZqGRqPoqHdCstr8iMz+E4qo/0PmUCarHxcTZNk
         D3fUssP5yY2hYcM3XuyVinhVsdzjSf2puMyTiHDZFxyHRbDEveX0UqmxAA9xsBU/I0W9
         OTNVmSrDeEy26aw3cdSrEfzEsR8QuM4li2SKqNmzDgMqvBwdoN6n45bZlV8kADcH7Nai
         NVI4/vnFlm8Kwwl0g/Rl28VIKAF5XpuVcG70+0X5LKFhMqsakOHeOL6TUHBms+IqOKgh
         akTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=HEqwK4t3Jbhbn9WZdb3oUG7FILqb8kl/CCgidI15uDY=;
        b=LMRGay1Jo0UkPqbCq0Ekes8MZGMy1S9hsyFf9OaBCn9on3BTJd9LB3O676BW/Y8LlU
         Pt1iIOL4PqAexliK166L5DZZ/BhOfcku9jZBPZopsiHHwfqVSNhpG7NF3aIAxid2l0lx
         wVWDkKEVvTxXZIBwf/wht1FJQIAWEHdX36SB8nr6GR3zwcfcv5gP4FujF9F0/X6jCXVK
         RamFzXXX4Hloxm1d42vY9QYoWgz7sy3ZaX06bi8fz4OHUExBIHKKTCd/QOfbc8VR25eK
         lN+m7OJ6Er0jbwaU7Xl8oGaGdWpy1GPJ3V3lz2xYjZSg37CWdqpRoBVRJk+AQFU3+Dhi
         2OYQ==
X-Gm-Message-State: AOAM533Xlovo6igmRtMbwlBamcDQ3m7Bql+JTxxQm0l5G7o6oHBF4WVF
        ca27zG9GXhbdWAbujgDCz+Y=
X-Google-Smtp-Source: ABdhPJxHJXPfvXBk6OiHcYKsndf2R7W1LPm3hgGc5pDEcgNbal5oYmhxvi2HRzhZgeA3KaOaKDJWiw==
X-Received: by 2002:a63:f804:: with SMTP id n4mr2278378pgh.155.1599060944940;
        Wed, 02 Sep 2020 08:35:44 -0700 (PDT)
Received: from localhost.localdomain ([123.241.84.106])
        by smtp.gmail.com with ESMTPSA id m3sm4835402pjn.28.2020.09.02.08.35.41
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 02 Sep 2020 08:35:43 -0700 (PDT)
From:   cy_huang <u0084500@gmail.com>
To:     linux@roeck-us.net, heikki.krogerus@linux.intel.com
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, cy_huang@richtek.com
Subject: [PATCH] usb: typec: tcpm: Fix if vbus before cc, hard_reset_count not reset issue
Date:   Wed,  2 Sep 2020 23:35:33 +0800
Message-Id: <1599060933-8092-1-git-send-email-u0084500@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ChiYuan Huang <cy_huang@richtek.com>

Fix: If vbus event is before cc_event trigger, hard_reset_count
won't bt reset for some case.

Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
---
Below's the flow.

_tcpm_pd_vbus_off() -> run_state_machine to change state to SNK_UNATTACHED
call tcpm_snk_detach() -> tcpm_snk_detach() -> tcpm_detach()
tcpm_port_is_disconnected() will be called.
But port->attached is still true and port->cc1=open and port->cc2=open

It cause tcpm_port_is_disconnected return false, then hard_reset_count won't be reset.
After that, tcpm_reset_port() is called.
port->attached become false.

After that, cc now trigger cc_change event, the hard_reset_count will be kept.
Even tcpm_detach will be called, due to port->attached is false, tcpm_detach()
will directly return.

CC_EVENT will only trigger drp toggling again.
---
 drivers/usb/typec/tcpm/tcpm.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
index a48e3f90..5c73e1d 100644
--- a/drivers/usb/typec/tcpm/tcpm.c
+++ b/drivers/usb/typec/tcpm/tcpm.c
@@ -2797,8 +2797,7 @@ static void tcpm_detach(struct tcpm_port *port)
 		port->tcpc->set_bist_data(port->tcpc, false);
 	}
 
-	if (tcpm_port_is_disconnected(port))
-		port->hard_reset_count = 0;
+	port->hard_reset_count = 0;
 
 	tcpm_reset_port(port);
 }
-- 
2.7.4

