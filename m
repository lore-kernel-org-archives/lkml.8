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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07531C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 20:52:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D2D8820663
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 20:52:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eqyEV5/8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389886AbgF2Uww (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 16:52:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730527AbgF2TNX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:13:23 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD43EC0005E1;
        Mon, 29 Jun 2020 04:49:34 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id w16so16268548ejj.5;
        Mon, 29 Jun 2020 04:49:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GLjynTsVrR6VbalMpEbWa6xOYmDXyiUF5lBzn2Cag8M=;
        b=eqyEV5/8wo72dYbOmPN4wgCvRYBqfaAoyfDWTA/CziIDDGjlgp5AMb9qLoJ1vL2AN7
         hmGOj1A/wyNdaKWhtlgIZLRLxiX2fEpb4IOPAhSdmzJ7oGaVY+axBuEfBypjDhCz/Zg8
         EXIfHry5/6cYajE3ATmDROKLRJ4k3bYc/6CrcuWhsgyAlMAHp3ZnckE0m+pMIEZhymLz
         P26GvXuz2urtiK7i65JWdY1i9xYu2sbgLPUcqRMzLNuBZXzatJWsx+KkjjF3QXnjNKOl
         75gpg48B6xD+z5UzuML/n8RJdX2buPaYyuSPKy05xio8NsmF4TxI8sHXJJ75QnI+f38e
         HCQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GLjynTsVrR6VbalMpEbWa6xOYmDXyiUF5lBzn2Cag8M=;
        b=pxQYIkMZjc3LEJjjFcTk9hHmDgTJPLSGCu9LCU+jj+6NYZ8LDP1FZ4Z3tM7SRDG2bC
         xm/MNNI7PATOfVzvTw4NvCUT2GG+Vr3qRS4g7AF4x6wfsGcRY1N7MHxUPH3oiJ1uDhz5
         uNHIDztFPkjVhiJbq27atZkEZVTPDZwxWkciiybXV5GT90zVUVv1KpiUSTfDn+loGjt1
         1LqYdybqxBJI6JdsU+4aiITHoXz0rwk02aIJpLz55qNiWJm3HyPw+im3N8fEWo8q3E5A
         DrlEVjmYCvH03QDVfZEc/8w0qhPSjaadWnpU2SsJcbr8zR58O9fPTivYJAOfpqkIKHqc
         qjkA==
X-Gm-Message-State: AOAM530+ECgnXufHSdHz6mFbIIZd9SHCHNOSOOhgdzNd1KowT2esqq/Y
        eQjSTje4tyt+dYTdtrXh2v0wxViityE=
X-Google-Smtp-Source: ABdhPJwqTPpW4lJkydjKNl2Ck5Ak3OQZa+r9ZAz2vMIOcNY6+NsQKHqERgvNSE0oQIqUe9KpwlAafg==
X-Received: by 2002:a17:906:fc20:: with SMTP id ov32mr12827208ejb.531.1593431373396;
        Mon, 29 Jun 2020 04:49:33 -0700 (PDT)
Received: from xps13.lan (3e6b1cc1.rev.stofanet.dk. [62.107.28.193])
        by smtp.googlemail.com with ESMTPSA id z20sm9818006edq.97.2020.06.29.04.49.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2020 04:49:32 -0700 (PDT)
From:   Bruno Thomsen <bruno.thomsen@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>, bth@kamstrup.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Bruno Thomsen <bruno.thomsen@gmail.com>
Subject: [PATCH 3/3] MAINTAINERS: Add Bruno Thomsen as reviewer of Kamstrup DTS
Date:   Mon, 29 Jun 2020 13:49:27 +0200
Message-Id: <20200629114927.17379-3-bruno.thomsen@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200629114927.17379-1-bruno.thomsen@gmail.com>
References: <20200629114927.17379-1-bruno.thomsen@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add myself as reviewer of device trees for Kamstrup
Concentrators.

Signed-off-by: Bruno Thomsen <bruno.thomsen@gmail.com>
---
 MAINTAINERS | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 496fd4eafb68..97fc112309af 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9282,6 +9282,11 @@ S:	Maintained
 F:	Documentation/hwmon/k8temp.rst
 F:	drivers/hwmon/k8temp.c
 
+KAMSTRUP CONCENTRATORS
+R:	Bruno Thomsen <bruno.thomsen@gmail.com>
+S:	Maintained
+F:	arch/arm/boot/dts/imx7d-flex-concentrator*.dts
+
 KASAN
 M:	Andrey Ryabinin <aryabinin@virtuozzo.com>
 R:	Alexander Potapenko <glider@google.com>
-- 
2.26.2

