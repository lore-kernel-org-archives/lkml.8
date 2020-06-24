Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48364C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 17:48:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0DCCE207E8
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 17:48:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CDQat+FI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405745AbgFXRs0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 13:48:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405713AbgFXRsK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 13:48:10 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18A19C0613ED;
        Wed, 24 Jun 2020 10:48:09 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id l12so3288761ejn.10;
        Wed, 24 Jun 2020 10:48:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aFckNX9NLOxkT9VVmqntFDU4vDqtUDB+vNvhonzHfkg=;
        b=CDQat+FIQQkKqjt5EUTXOuYkZBmovwx8odIdBVkG09sJjX4aMQbEvW+klelcp1hFcT
         KRRVimnTHIbGlfJWVBOJVuSAFnb/HgUsXEqrzUvlwYafGUq3egMpMP4TmSKUGYcHCE6o
         Wm4buySsvUHutlK3p8GYHXeR0kfn41lfX4xN2GOsPRLauqAbIfcdAlj0z0Y31aul6Qjk
         Tp7SDRwJAYuMJF1xIK9cuueeU0ZL0Bk3sxPij1TxsJzIYWT5fm0/rtF2pIkNIOL88Gl2
         aGPvYooj4SkRT1o+qchvi6lfaDgSa5QfJltxlooST0RZ2N7RPBPYfh39D0dUWNwJ0ZNv
         lN0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aFckNX9NLOxkT9VVmqntFDU4vDqtUDB+vNvhonzHfkg=;
        b=X7Ta9jVnR/sytvKgQTQoLMSi37ebeHgmlF9ROTylzksLZis6kkRsFPQnHJMdZBaKMB
         iCan+nw75sEtN43+VtHwmIYTYNyxQeBmAfhA65YoeIDvJjRY1SWVXGv8NE5F8VQnbxrS
         41sFb/fTfytzqHZ2fk8xhd6wLtO2AkMN6P69mG87ax7k8XWCCzjgHS0dJcAbvex1bTQH
         TsDYDwDU+5tfUkdSplxUxd3MRbaFLQbVCnR0m7UPddfJ+AbXk7UxwqVIfM6XTptHJpCt
         FpmBVmO/IXgVNU4Hr0ytEykY55pXWbzrj3igXl5ftBNDefhZVLMmTF42qde6Rhmgxh4A
         HqYQ==
X-Gm-Message-State: AOAM533ygN90gMEOrx+sl/sNXbL/8TQdTbLspPXJEsPkxQtKY+nVytzk
        PxbBaaa90AxLmkzRpu88Qc+uwJPE40s=
X-Google-Smtp-Source: ABdhPJwATqcPo6q9bRMf+TLJtKkRF1/FTj/bQyatO2j85T/dipXkYm9bDA1SzjVywVfAzt10qh0V2g==
X-Received: by 2002:a17:906:4056:: with SMTP id y22mr25343775ejj.304.1593020887757;
        Wed, 24 Jun 2020 10:48:07 -0700 (PDT)
Received: from localhost.localdomain ([188.24.137.55])
        by smtp.gmail.com with ESMTPSA id s14sm8044146edq.36.2020.06.24.10.48.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2020 10:48:07 -0700 (PDT)
From:   Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
To:     Stephen Boyd <sboyd@kernel.org>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-actions@lists.infradead.org
Subject: [PATCH v2 6/6] MAINTAINERS: Add reset binding entry for Actions Semi Owl SoCs
Date:   Wed, 24 Jun 2020 20:47:57 +0300
Message-Id: <c7db5abf78656af8d5a4ff8d677a08e03713c1f3.1592941257.git.cristian.ciocaltea@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1592941257.git.cristian.ciocaltea@gmail.com>
References: <cover.1592941257.git.cristian.ciocaltea@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a reset binding entry to match all members of Actions Semi Owl SoCs.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 7b5ffd646c6b..e6285c13bab0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1533,6 +1533,7 @@ F:	drivers/mmc/host/owl-mmc.c
 F:	drivers/pinctrl/actions/*
 F:	drivers/soc/actions/
 F:	include/dt-bindings/power/owl-*
+F:	include/dt-bindings/reset/actions,*-reset.h
 F:	include/linux/soc/actions/
 N:	owl
 
-- 
2.27.0

