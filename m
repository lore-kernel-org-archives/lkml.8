Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29724C2D0EB
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 07:16:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDC0D20733
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 07:16:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZVmV7gvv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729470AbgC3HQC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 03:16:02 -0400
Received: from mail-pj1-f68.google.com ([209.85.216.68]:54177 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729378AbgC3HQB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 03:16:01 -0400
Received: by mail-pj1-f68.google.com with SMTP id l36so7182980pjb.3;
        Mon, 30 Mar 2020 00:16:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QSDEHsq+T3M2HyYEVAPG7v1i3TxckoesdyTyV+7L4vI=;
        b=ZVmV7gvvetKHG422yrPAT3Dt6aI68pAqZ0TXnHmlQJNWAD+XuDomlP+7B/q8uowZ8x
         1YCSlPdzclJjonnFjyRS03Bob2/GHElavLW66FLqjpAv9SzDzNC6jAOQEN89QTdprQd7
         1qrL3dw84YWMrSstJ/XnXFECx3hmhO8Z+T+ny5XELzpFj1xXksMc0JbHCeYgVI3LQDzI
         X/KjCOvArhvFhmD091db6Nu/7qkeEgIaTBGALVeZ0qoTBFEhnXicvE1xarKaQpo9EGyH
         1qEyS51B97l3nH6a8EMmP0Atjumz24BQw/Lae3sJNR2xFcQlh0oIhgxerErtGAaLvCb2
         DLYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QSDEHsq+T3M2HyYEVAPG7v1i3TxckoesdyTyV+7L4vI=;
        b=FbW8M2oM9Lobie1tyrfjAYWMIPs5xTzy6YiHwqCSdmhLB/QdN6Xm+C304T/yNj0Qlo
         L+MqXqf9WRJLXqlfblaXu/KP6WQngX+vxJkWWt+50FuLVj3iTYhIjk5rXSXsy9AUBe+t
         wWtWcSi5AVDC8gRX3Pd4LQPohpRB9by4j15+gmzgTuCaZ93hju002mwgWfsXeM9snacH
         sgjoEJjfd1zxpzlQ6t88LTZMfSZXW272JA4J99ftVuHico0SLe691TDX1ETw2J0zvZcB
         1H3CG/dOY+Z7Pw7/GKJcbZjN/aGXgzIDO7BuyzbIC3XbdHtYTLbBfX+x4kelH0E9y05w
         W4JA==
X-Gm-Message-State: ANhLgQ1jiNZuZtCWSAhIAjIClO+7+KBhFvZLKopoFYbv/Ess6jFNd/m6
        wWAKNmzXRDGVkOe0uaNgT/c=
X-Google-Smtp-Source: ADFU+vvHJn5Xd4xkWEK3fdbOxMY7F7oj14Ak7QRF2dL84l25qr3otLk0k4w60ZitN4MpfwAyvi2YnA==
X-Received: by 2002:a17:90b:1b05:: with SMTP id nu5mr14351709pjb.110.1585552560490;
        Mon, 30 Mar 2020 00:16:00 -0700 (PDT)
Received: from ubt.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id l1sm9490484pje.9.2020.03.30.00.15.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2020 00:15:59 -0700 (PDT)
From:   Chunyan Zhang <zhang.lyra@gmail.com>
To:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>
Subject: [PATCH 2/4] dt-bindings: clk: sprd: add mipi_csi_xx clocks for SC9863A
Date:   Mon, 30 Mar 2020 15:14:49 +0800
Message-Id: <20200330071451.7899-3-zhang.lyra@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200330071451.7899-1-zhang.lyra@gmail.com>
References: <20200330071451.7899-1-zhang.lyra@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chunyan Zhang <chunyan.zhang@unisoc.com>

mipi_csi_xx clocks are used by camera sensors.

Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
---
 Documentation/devicetree/bindings/clock/sprd,sc9863a-clk.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/clock/sprd,sc9863a-clk.yaml b/Documentation/devicetree/bindings/clock/sprd,sc9863a-clk.yaml
index bb3a78d8105e..87e8349a539a 100644
--- a/Documentation/devicetree/bindings/clock/sprd,sc9863a-clk.yaml
+++ b/Documentation/devicetree/bindings/clock/sprd,sc9863a-clk.yaml
@@ -28,6 +28,7 @@ properties:
       - sprd,sc9863a-rpll
       - sprd,sc9863a-dpll
       - sprd,sc9863a-mm-gate
+      - sprd,sc9863a-mm-clk
       - sprd,sc9863a-apapb-gate
 
   clocks:
-- 
2.20.1

