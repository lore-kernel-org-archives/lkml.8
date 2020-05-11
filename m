Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 591C9C54E4A
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 13:54:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2DD70206D6
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 13:54:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RZRlmTNj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730493AbgEKNyy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 09:54:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730296AbgEKNx4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 09:53:56 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAB79C061A0C;
        Mon, 11 May 2020 06:53:54 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id g12so19351003wmh.3;
        Mon, 11 May 2020 06:53:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=5N3ENsJZJg9Tw3PfN0/AL9v74uEGkOjDfNKmyoBqZfE=;
        b=RZRlmTNjtUWxH2s0w8/3OQs9b4LmHtDTxX3kny9XXJwHVRV7VJTi9v51ecle1hkV4A
         LUNV80vzSyAu35MYi4MH9z/kK6d/waQJUACp+QKeMq5mXAz5BVMLjAKZUYi4yh+22wou
         noL96BfxCZe0CCgjpnThTLxbtuZWHi9aD9dLoOCHxLV3mprpHekZ35WyT4r5BoUd6fs7
         +BEaN2HTUygUQNTq/3Lh22zzgBLDdqRWASD9yEfqFUnbxuxJogwtqk1me1K5JgeUeXz9
         97QJx5oRTBf7RjvKwevM/tpu5yTsjg3vNOCvnRlZMZhi+NsXDjZMQnB+Ye+h+eoLUsTn
         BR3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=5N3ENsJZJg9Tw3PfN0/AL9v74uEGkOjDfNKmyoBqZfE=;
        b=Sgvo1Q9OBNoPRZ7U8rJOnunCT9FJZ7ejFKqhuhzW/p5QbTsh0wVtfbcC+1JI6v2jbY
         HpzVJyZ/8AtEkFjIvFnHi9GUmETePcXvYAka/E5m8uuAStf/JwtCVocOuad5p4hK6wIO
         Gll1/JtpfLla8HPxHcO/6/hjnSWvgN3/oCyK9xXjuhiS2F2rkQc399NoDyCQ6I45C5L3
         EhcABEH0EJp7c4Xlh3sW51Df7rPVQ483cnukMTKSLdcc8uTLJlz69vV/4+DfhdaEvDr4
         +wF0UrMo5qhhMx4sRQh64Av8/Yqs3q+8svJbGzjq7WqETosTK4oS5QgLQa9fGEW8hni1
         ESyQ==
X-Gm-Message-State: AGi0Pub+KteCzC/grN0XHjM7dU0EXHAHq6w7WcImS3fS00MDcZ5dfQXO
        rUPbLNHQu+8wm1tttP+e2i0=
X-Google-Smtp-Source: APiQypJIWSS0RrPJchpZ4nG7qqMcoaR+hx84nHM5Jjh7skEIWDgAFxurl3YSD4kwP9ZQ+94O/K4Srw==
X-Received: by 2002:a1c:7e82:: with SMTP id z124mr24141030wmc.53.1589205233425;
        Mon, 11 May 2020 06:53:53 -0700 (PDT)
Received: from localhost.localdomain ([86.121.118.29])
        by smtp.gmail.com with ESMTPSA id 2sm17596413wre.25.2020.05.11.06.53.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2020 06:53:52 -0700 (PDT)
From:   Vladimir Oltean <olteanv@gmail.com>
To:     andrew@lunn.ch, f.fainelli@gmail.com, vivien.didelot@gmail.com
Cc:     davem@davemloft.net, kuba@kernel.org, jiri@mellanox.com,
        idosch@idosch.org, rmk+kernel@armlinux.org.uk,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 net-next 07/15] net: dsa: sja1105: exit sja1105_vlan_filtering when called multiple times
Date:   Mon, 11 May 2020 16:53:30 +0300
Message-Id: <20200511135338.20263-8-olteanv@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200511135338.20263-1-olteanv@gmail.com>
References: <20200511135338.20263-1-olteanv@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vladimir Oltean <vladimir.oltean@nxp.com>

VLAN filtering is a global property for sja1105, and that means that we
rely on the DSA core to not call us more than once.

But we need to introduce some per-port state for the tagger, namely the
xmit_tpid, and the best place to do that is where the xmit_tpid changes,
namely in sja1105_vlan_filtering. So at the moment, exit early from the
function to avoid unnecessarily resetting the switch for each port call.
Then we'll change the xmit_tpid prior to the early exit in the next
patch.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
Changes in v2:
None.

 drivers/net/dsa/sja1105/sja1105_main.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/dsa/sja1105/sja1105_main.c b/drivers/net/dsa/sja1105/sja1105_main.c
index d2755ab2853d..82b424a03658 100644
--- a/drivers/net/dsa/sja1105/sja1105_main.c
+++ b/drivers/net/dsa/sja1105/sja1105_main.c
@@ -2158,6 +2158,9 @@ static int sja1105_vlan_filtering(struct dsa_switch *ds, int port, bool enabled)
 	else
 		state = SJA1105_VLAN_FILTERING_FULL;
 
+	if (priv->vlan_state == state)
+		return 0;
+
 	priv->vlan_state = state;
 
 	table = &priv->static_config.tables[BLK_IDX_GENERAL_PARAMS];
-- 
2.17.1

