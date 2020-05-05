Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDBD7C47247
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 02:26:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE1CC206B9
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 02:26:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pef09ARp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728245AbgEEC0u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 22:26:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727799AbgEEC0q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 22:26:46 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1459C0610D5;
        Mon,  4 May 2020 19:26:45 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id a9so57230lfb.8;
        Mon, 04 May 2020 19:26:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WnQqR023+ir0BJrdWrfcrZC9w8PLUveI615nAiop8/M=;
        b=Pef09ARp6m8/4flEy5daoIFl6O4RYZLlZgByHpYSRJ3TDpWPkEoEA/Is6NxvLmdwLR
         y7otsNXLVqT7vLSJ+t7+QIGfxoxs8vCW+0zkUTYi/KkAkNmqF9RnJuatchpt5VP112JO
         ooW1Wwwdjx88imrwSFCC4QsQ0bhQWV+9q7JuJiudC05Kg0RjNvWEYoz0MfYOjXK7ggbn
         uwF8IvOK3XuOa4nGvyd4Jx8gqVqk8d5vma5dJdlxzOCGlscAaOcHCzvux//tn0XUqDIz
         3rfuoGZh+gieAngdNw3/yeGVoqZymxUHrcG2NByy1g8Z65WUmSR1oGb++tBfZFW1JpYy
         dcMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WnQqR023+ir0BJrdWrfcrZC9w8PLUveI615nAiop8/M=;
        b=hvvxK0HaqUiN1SS0v2xzWR0MK8ZTeaM7AVyRAT5s09cVyADMnkV5MRwxgSFb68Qg34
         616U5I/ikKmiqU+2JxGQN+7uxOE9V/usLatcpglJ6FDOy4UmR+ND415oZOdHBAX1NG6w
         0ePP7upjj4EKvPevLIcONz8SZe3UO13gi7ACFkCV6PnJ4dSBlyhLD4AhmZron1iSOGEy
         EpMNAqeaYRGJU4wYtNmWeW3cZULgdBUtlEqHngW32opqOyi5pxVQbQywdUo1cVO6iDTQ
         tLENR6jl7MntGl6pYNZUm2q1WtJMuk5w7XosMp3umdYTnb0tSYyByaR4csr5hQt/Ic+5
         Jxfw==
X-Gm-Message-State: AGi0Pua3dBYGwg/ZdWRDFNz9neB+xM47t3SvTihBN0fTn6LICGT1x7R3
        7MXFuNmQvXxeFSiMXdCRFGc=
X-Google-Smtp-Source: APiQypIESoE1mXV53Yr9Hetiv2xZyYULOpPBTiQayCud77ZutRYgNCbJTUZ6kb+d86uw9+M88QNg2A==
X-Received: by 2002:ac2:4466:: with SMTP id y6mr62406lfl.125.1588645602818;
        Mon, 04 May 2020 19:26:42 -0700 (PDT)
Received: from localhost.localdomain (ppp91-78-208-152.pppoe.mtu-net.ru. [91.78.208.152])
        by smtp.gmail.com with ESMTPSA id l25sm449251lfh.71.2020.05.04.19.26.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2020 19:26:42 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
        David Heidelberg <david@ixit.cz>,
        Peter Geis <pgwipeout@gmail.com>,
        Stephen Warren <swarren@wwwdotorg.org>,
        Nicolas Chauvet <kwizart@gmail.com>,
        =?UTF-8?q?Pedro=20=C3=82ngelo?= <pangelo@void.io>,
        Matt Merhar <mattmerhar@protonmail.com>,
        Zack Pearsall <zpearsall@yahoo.com>
Cc:     linux-tegra@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v7 3/6] dt-bindings: Add vendor prefix for Acer Inc.
Date:   Tue,  5 May 2020 05:25:14 +0300
Message-Id: <20200505022517.30523-4-digetx@gmail.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200505022517.30523-1-digetx@gmail.com>
References: <20200505022517.30523-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Acer is a hardware and electronics corporation, specializing in advanced
electronics technology. Acer's products include desktop PCs, laptop PCs,
tablets, servers, displays, storage devices, virtual reality devices,
smartphones and peripherals. Their web site is http://www.acer.com/.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 334393037861..2c2ef989e273 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -27,6 +27,8 @@ patternProperties:
     description: Abilis Systems
   "^abracon,.*":
     description: Abracon Corporation
+  "^acer,.*":
+    description: Acer Inc.
   "^acme,.*":
     description: Acme Systems srl
   "^actions,.*":
-- 
2.26.0

