Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C98A3C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 06:30:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 96981217D8
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 06:30:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tejj1Erp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726472AbgGNGar (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 02:30:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725306AbgGNGar (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 02:30:47 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC5C9C061755;
        Mon, 13 Jul 2020 23:30:46 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id p20so20291316ejd.13;
        Mon, 13 Jul 2020 23:30:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=WDXrzFVh8dPZdUoaPn9Fet8aXFJz7P/2Be+BzrI1pyE=;
        b=tejj1ErpQNUFtDQMvGW9bNJg1jL6/aKDikj/iPRu5NslOsOp8I0oMU00udNnzmvkSl
         9qcb2UF9fOj7gxy9Bb9qGzhAI5oy8kaZxB7aml6Y9PXjgQ8npgdvlJ/2oUsj7f9yNvsh
         +46uOq5N/gkxy9DMtPqpec4S9ttrBprc+xllZHy2kys81rZcPF38FSpo0hS2m9eLQVou
         C3WsBKCit60KkpttjuFIW2wGybzq1TaOM/4nuuUfkAS8AqAkz35qGYAbv6OrzoP7xtUv
         uNrIgOoSsKCl+AIVpgHf114ORPpn8++e2u1B+5frd43DvhfG2kLppJQFIKjARSaWNYjT
         HSIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=WDXrzFVh8dPZdUoaPn9Fet8aXFJz7P/2Be+BzrI1pyE=;
        b=DPk7ab+CYe849ge4jQobl0UvayOx8armaOj2dgVVyV4HYd12jRzYtEz0pSPBLTH59y
         H0d5yA1gzBrnk5M97ojKhEzbWJxp/oNKxbFL8o5huVn5MT8LTr+sxKFSIYEOGsr9X2sf
         6+ke4HFPkoQ0dhlxuidNcfFtQCyDUB7HPJM3nrqr/o5Nuq9t8QMPXTrCfPYyQFUVRTqp
         CdGYw3nngJtTZr/W2yp0aKuJqo5/ydUXl28k9KnolB7MpizeNmKHnjNKziyg23qPqb+H
         eCAVAR5pBgKBeP2NND36E3a4Z8cdDSplJBbx5Jq4xg6eLWRCQoIsncq1byHUlPwN8PuG
         MqDg==
X-Gm-Message-State: AOAM533hLCfRv+PLzEJeyGuoLjaisjzXfg3HabPDBbygPsRZu3z+/MDb
        o9NN1J+A0v/z7wlnZK+pJF4=
X-Google-Smtp-Source: ABdhPJzAtUV4CLIhPpcRbq3dMdTeGC4Ii5aCix/QzePzBrI1bss70Hgw/d/GfQSJxOxUjCJSShMaNA==
X-Received: by 2002:a17:906:3784:: with SMTP id n4mr196820ejc.277.1594708245450;
        Mon, 13 Jul 2020 23:30:45 -0700 (PDT)
Received: from felia.fritz.box ([2001:16b8:2d88:ea00:c4fb:750d:a5d0:9d75])
        by smtp.gmail.com with ESMTPSA id t20sm11618717ejd.124.2020.07.13.23.30.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2020 23:30:44 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Jeff Chase <jnchase@google.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc:     Rob Herring <robh@kernel.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        devicetree@vger.kernel.org, linux-media@vger.kernel.org,
        Ralf Ramsauer <ralf.ramsauer@oth-regensburg.de>,
        Pia Eichinger <pia.eichinger@st.oth-regensburg.de>,
        Joe Perches <joe@perches.com>, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] MAINTAINERS: rectify CHRONTEL CH7322 CEC DRIVER section
Date:   Tue, 14 Jul 2020 08:30:35 +0200
Message-Id: <20200714063035.8635-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 7f52faabd2e5 ("media: dt-bindings: Add ch7322 media i2c device")
slipped in a typo in the CHRONTEL CH7322 CEC DRIVER section.

Hence, ./scripts/get_maintainer.pl --self-test=patterns complains:

    warning: no file matches    F: \
        Documentation/devicetree/bindings/media/i2c/chontel,ch7322.yaml

Fix the typo to address this warning.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
applies on next-20200713

Jeff, please ack this patch.
Hans, please pick this minor non-urgent patch for your -next tree.

 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index ea296f213e45..43661d432b4b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4114,7 +4114,7 @@ M:	Jeff Chase <jnchase@google.com>
 L:	linux-media@vger.kernel.org
 S:	Maintained
 T:	git git://linuxtv.org/media_tree.git
-F:	Documentation/devicetree/bindings/media/i2c/chontel,ch7322.yaml
+F:	Documentation/devicetree/bindings/media/i2c/chrontel,ch7322.yaml
 F:	drivers/media/cec/i2c/ch7322.c
 
 CIRRUS LOGIC AUDIO CODEC DRIVERS
-- 
2.17.1

