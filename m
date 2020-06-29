Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E05D9C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 20:46:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B7C2020724
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 20:46:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eDtph5pc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389760AbgF2Uq5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 16:46:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731525AbgF2TNw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:13:52 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D1DFC0068BA;
        Mon, 29 Jun 2020 04:49:32 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id e22so12548169edq.8;
        Mon, 29 Jun 2020 04:49:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2uPO3vckqsooDcWfKZuORVgJvTI2dPV4QqBlpSlJ+WY=;
        b=eDtph5pcsYHKVqyYe7AqdGWv7pSMpgITQFZvs/tZftfHXbon6dnQcD4JpPZjxHQ4F4
         6Qi0Gxx6aAe54M7RXwfq7FsQrd54aX60+g3cBZ9COLWkFBcN2f+8NZmPYZ0/NGnAPacK
         C44sHkNGCrA6E9leq32IEneHBWGF1XpmCsGzBiIjN9Nt+POJcFADpVYSffVo6ejOLTah
         lE4W5B0yghA//VCbi493fDcVq892KnnCwZFJdO0XA0oZwD5H0YCL/dZnW/UYyPVeWWDt
         YkyOJsSrGo/btZkZU7JP76om4gRGwk6XgIEgVb5wQxDaZOxxJ9kme+A4fhgZQXnYyF4i
         pStA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2uPO3vckqsooDcWfKZuORVgJvTI2dPV4QqBlpSlJ+WY=;
        b=YlGUEDK0rFZAS0NnsaEFxmEFv0dfMIXMmiqP+MFrQP/yk6LWuw+w8j7i75+8eyejrC
         NM6fRRnjocCKIXcHjzv1Cebk3NTLaoyQBn4BvJZ+l81kvnDTCgZrcN0V1CV1Ken62tfb
         pUfMNKA/fqNNGE1zo7bSO+5yZjBHlHfWilnRaEvl1iyl63TCUj2x0EKOqC6a5oxRxFEF
         9eMY1845hMtGTuUM2bTaZNjHRTm6iaYw6II3YDLcoeWCwnInf93ANESZEpqyyJ0iamKm
         lqBv+Hagx1aIP56Q5zs6HKaxPbuX3nCv+iUQYJ6VMO3MzBZfxKT7nazrCZ3gx6RLB0mm
         ZZbQ==
X-Gm-Message-State: AOAM53292xZoNRIXG5spEQp/w5uultxPiA5zP56Afqwp4L+OSoj3HVNs
        WWPFmAVoGK4lP5ySkmAqgqSQgQIkvTM=
X-Google-Smtp-Source: ABdhPJxX3ZkbA575LdtUr7ABCDWqwZSDSB4e/xyVQw9NjMO+OlKeImrqaZVJLNLDkt+5mICUb79hhw==
X-Received: by 2002:a50:e1c5:: with SMTP id m5mr17248608edl.47.1593431370952;
        Mon, 29 Jun 2020 04:49:30 -0700 (PDT)
Received: from xps13.lan (3e6b1cc1.rev.stofanet.dk. [62.107.28.193])
        by smtp.googlemail.com with ESMTPSA id z20sm9818006edq.97.2020.06.29.04.49.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2020 04:49:30 -0700 (PDT)
From:   Bruno Thomsen <bruno.thomsen@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>, bth@kamstrup.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Bruno Thomsen <bruno.thomsen@gmail.com>
Subject: [PATCH 1/3] dt-bindings: ARM: imx: add kamstrup flex concentrator to schema
Date:   Mon, 29 Jun 2020 13:49:25 +0200
Message-Id: <20200629114927.17379-1-bruno.thomsen@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Kamstrup flex concentrator compatibles to the schema so we can
make use of them for the validation.

Signed-off-by: Bruno Thomsen <bruno.thomsen@gmail.com>
---
 Documentation/devicetree/bindings/arm/fsl.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index 05906e291e38..66627b272e40 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -299,6 +299,8 @@ properties:
           - enum:
               - fsl,imx7d-sdb             # i.MX7 SabreSD Board
               - fsl,imx7d-sdb-reva        # i.MX7 SabreSD Rev-A Board
+              - kam,imx7d-flex-concentrator       # Kamstrup OMNIA Flex Concentrator
+              - kam,imx7d-flex-concentrator-mfg   # Kamstrup OMNIA Flex Concentrator in manufacturing mode
               - novtech,imx7d-meerkat96   # i.MX7 Meerkat96 Board
               - technexion,imx7d-pico-dwarf   # TechNexion i.MX7D Pico-Dwarf
               - technexion,imx7d-pico-hobbit  # TechNexion i.MX7D Pico-Hobbit

base-commit: 9ebcfadb0610322ac537dd7aa5d9cbc2b2894c68
-- 
2.26.2

