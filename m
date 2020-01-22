Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E936EC2D0DB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 14:00:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF94F2253D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 14:00:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gKeNkdhQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728904AbgAVOAZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 09:00:25 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45822 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728205AbgAVOAW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 09:00:22 -0500
Received: by mail-wr1-f66.google.com with SMTP id j42so7329724wrj.12;
        Wed, 22 Jan 2020 06:00:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=S37mEzjCuwUx3aUpRGSkg86M1G/8BxlVxMLDTrBU45Q=;
        b=gKeNkdhQteJze3+inzS/DmFaXeftA2GIDDb5gWL2wbUMDsgt9u0CKsv3dVmRkjfA2b
         rsZ0D44FZ5gBrRpFWM+jBXNdPD7q8HdQX7+TuqboIOU+GyYeB+d28926IQKuIcnXX5Ht
         NCnX2AAsEhIYtVW0eVl6rp+3aGTD3/6dzfsRMLOCr7wMjaFl3jpAO8xLEYNXzqgrIcEt
         vEK7ER5Jb48mcyFMnMnzsZWxMktW3qLkSgmbciwTuufiD1P2FaaYIGPkWLuq2biBh6FV
         6Xs1pj4JkDWGEoLCU+hPia4ytI4SO61Y0mNVyzQKM4HHwzhXoocRM7OjLIwxRAedsiP5
         +EGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=S37mEzjCuwUx3aUpRGSkg86M1G/8BxlVxMLDTrBU45Q=;
        b=pfud9V33xMOzFX/IXvEphtPPYBmJbg3998P77/H+cqd5AHlRrkFSd2gH/u+hU/RQy6
         //NQRm9etPTMfc6o+NIMMAXCtxdZOEHAuRxFP8gfyuYZi2suHAwS1W6KVt5ky3yPOeai
         dn+hE7GSFgi/+ogSscd5sRReKMScLijGLhqDsooi7b5R1QCNJRqpVL8QeKLMEqrBQvh7
         MRA1wIU2KJZg+/99JM110Kly5dZIUWaizUe1V/jNMIYKxDT0GDI75+9IJGWq5shsEI5c
         nHkrXD3RiGnB1csGh6bD5KKqg+CcE9NYHZoDkI07THXgNtlFUn3xt2jLVs+ptofeiU2r
         vctA==
X-Gm-Message-State: APjAAAWoIaR+FYPr0OSNrM5lA7KrbLO0aHHlb+XLJXx9sYl3c3I+q1TP
        bq+MoOe0+al4J8gFj+0yvPY=
X-Google-Smtp-Source: APXvYqxy7k3w+Ry+EG/OXolbGJ7YMhHfWHqAGRBmrzdj+tQhUspgDtyTLtuwJscjM4rMsMprG13zFg==
X-Received: by 2002:adf:b64b:: with SMTP id i11mr11998529wre.58.1579701621000;
        Wed, 22 Jan 2020 06:00:21 -0800 (PST)
Received: from localhost.localdomain (p5DCFF1C1.dip0.t-ipconnect.de. [93.207.241.193])
        by smtp.gmail.com with ESMTPSA id g2sm57388270wrw.76.2020.01.22.06.00.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jan 2020 06:00:20 -0800 (PST)
From:   Saravanan Sekar <sravanhome@gmail.com>
To:     sravanhome@gmail.com, lgirdwood@gmail.com, broonie@kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com,
        gregkh@linuxfoundation.org, Jonathan.Cameron@huawei.com,
        davem@davemloft.net, mchehab+samsung@kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] MAINTAINERS: Add entry for mp5416 PMIC driver
Date:   Wed, 22 Jan 2020 14:59:58 +0100
Message-Id: <20200122135958.13663-4-sravanhome@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200122135958.13663-1-sravanhome@gmail.com>
References: <20200122135958.13663-1-sravanhome@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add MAINTAINERS entry for Monolithic Power Systems mp5416 PMIC driver.

Signed-off-by: Saravanan Sekar <sravanhome@gmail.com>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 9aa438cb9836..e575029f5b89 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11240,7 +11240,9 @@ F:	drivers/tty/mxser.*
 MONOLITHIC POWER SYSTEM PMIC DRIVER
 M:	Saravanan Sekar <sravanhome@gmail.com>
 S:	Maintained
+F:	Documentation/devicetree/bindings/regulator/mps,mp5416.yaml
 F:	Documentation/devicetree/bindings/regulator/mpq7920.yaml
+F:	drivers/regulator/mp5416.c
 F:	drivers/regulator/mpq7920.c
 F:	drivers/regulator/mpq7920.h
 
-- 
2.17.1

