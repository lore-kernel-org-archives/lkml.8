Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1695C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:25:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8BFC5208B6
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:25:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FpwdF7V1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729117AbgF2VZY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 17:25:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729123AbgF2Smv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 14:42:51 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79FF4C030F05;
        Mon, 29 Jun 2020 09:13:18 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id o18so12702400eje.7;
        Mon, 29 Jun 2020 09:13:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZdeFEpNDYkXFwTK4R5nfayVzl1J/Ocu3hnRhqkjhhqg=;
        b=FpwdF7V1gcTCIKfgLOQYaXG7D5pZHEOv2lGFKzleZXMdNHT09dvKTyMItQ4HR6jw5Y
         Jn1uJKAT3IKyK5wua6R4aKYRCSoZo1w1VhHVcmVVnswhrM7QW694+fjN0hd3bWxPkDGx
         xK3hLXGvQPqAfzFJ5XEV/JF2Dd6PB+LD2Ae33nTPyvaANMoWkFDyV5BR0Rl+A96BHNXe
         CPY5G4klZQI/aD7U5KuruNhhBf7tH3HtnhReiQ7RtnsLWsBUt/uuXnj3tm2qc/b32v1w
         kfDRIpwqeDPHNcpCiiaphYtEwFMHWEmQnHZy4VM9C8Zcyly67SJk9+8AdbL2khyWCnyp
         jhdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZdeFEpNDYkXFwTK4R5nfayVzl1J/Ocu3hnRhqkjhhqg=;
        b=rMcdN1rhKPGpbdymli0Fye89pK8TTumgt3u1a06EZolSucmi9f7ZWmsK1jUPbe4mVQ
         mx8iPBK4keGO9CdHGXHK/euCQXzoM3mzUyfItrBOViDBkAG4Jw44mKHJ2V5ZaxdMZ6BN
         c9Nkrk6E4IoWnOo8Owrp324qT6qHiaJRDMHaRP6VIqqldztQTMcEqhsxCpDtFycCVPns
         kRRXKk1evfVcqhEGl2xH79oXRFPgUUHEC+BY3jFsluhWg5r/zcG9r9qB/GwwMNaX3RRC
         ckjRNWSKHVLAwccsnxwtM/LS1nILoV3c08CBAV7aOK0VQpW8HGj1aFXflD8MIuDxZBRq
         cEuw==
X-Gm-Message-State: AOAM530EK7ofJ00/v6b5FGd2hxAz5tXxJ7oi9bQpCm5DbWEWf2ErShZ2
        KDi7I0Ni7wE23MwuZsPpFR0=
X-Google-Smtp-Source: ABdhPJyYH8JXIDkgPspXRN2vNPMMQ+uX2Q9v7t9x0iqMg6ZIkNek0dm4JqwSffuIxDQxiUiNWQCxMQ==
X-Received: by 2002:a17:906:71d4:: with SMTP id i20mr15394732ejk.533.1593447197127;
        Mon, 29 Jun 2020 09:13:17 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:b7f9:7600:8d8b:2aae:ac29:9590])
        by smtp.gmail.com with ESMTPSA id l1sm222822edi.33.2020.06.29.09.13.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2020 09:13:16 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mike Rapoport <rppt@kernel.org>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v2] doc: add link to sparse's home page/internal docs
Date:   Mon, 29 Jun 2020 18:13:10 +0200
Message-Id: <20200629161310.89783-1-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200629044154.GB1492837@kernel.org>
References: <20200629044154.GB1492837@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sparse's home page used to be a wiki (sparse.wiki.kernel.org)
but this wiki only contained a short intro and the release notes.
But nowadays, sparse's main page is sparse.docs.kernel.org,
which contains all what was in the wiki but also other documentation,
mainly oriented about sparse's internals.

So, add a link to this in the kernel documentation.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---

Changes since v1:
* fix a typo (s/kernl/kernel/) thanks to Mike Rapoport.

 Documentation/dev-tools/sparse.rst | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/dev-tools/sparse.rst b/Documentation/dev-tools/sparse.rst
index 8a7055593c31..02102be7ff49 100644
--- a/Documentation/dev-tools/sparse.rst
+++ b/Documentation/dev-tools/sparse.rst
@@ -9,6 +9,8 @@ Sparse is a semantic checker for C programs; it can be used to find a
 number of potential problems with kernel code.  See
 https://lwn.net/Articles/689907/ for an overview of sparse; this document
 contains some kernel-specific sparse information.
+More information on sparse, mainly about its internals, can be found in
+its official pages at https://sparse.docs.kernel.org.
 
 
 Using sparse for typechecking
-- 
2.27.0

