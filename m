Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63D50C54E4B
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 06:00:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 39C3E2072B
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 06:00:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YhVM1qh5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728852AbgELGAb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 02:00:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725933AbgELGAa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 02:00:30 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F2D5C061A0C;
        Mon, 11 May 2020 23:00:30 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id l18so13752636wrn.6;
        Mon, 11 May 2020 23:00:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wpPUiKoxrLHYw4+DH7/6FLsY3bFbf5FDzCuTH+tpmXY=;
        b=YhVM1qh5b2JTfXSFTmL6NUVbLnY8Gh7IKyb82fxao7EP2fTdGqjahewQA39dMIEiB/
         Hez3/pLS09TYLzhhUPbBTLgOfuWQwJ1C8zt5a4Lid90U6Y0lhDJvViWS/vEndxigUoc5
         Uw0dB+xZ/SKVvxDJ3MSufBGwscUAPPZQe6WNWy+0uh/hhSZ89iyfhgHMIIIh+TIjj+Uq
         YErlj+HD+NUQdsYGRqEvkVe6eIB2nvhjrn3FhicXAPQIaggvwEFfZTASnFU/OhYAKYIs
         m+ddiZTWK875hdqG6lIeIuwf8gJdNhhjXFWUc4YNG76U3vMdr5GmEKs17feTls9f8B4v
         EO6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wpPUiKoxrLHYw4+DH7/6FLsY3bFbf5FDzCuTH+tpmXY=;
        b=NZwetAakEk1MyKNjZGojPHChJSLMEoFxLFPuy4E5Nd2hcsDlrhaGwyyN4hqD+kObO9
         oVuo1xEpbMLrlh+FPEiGkZMW7/irisSaA1SngVh4ZGi7c1Fh/Z4/ZBxeUU5N+W+HqJW7
         k8ttHEsAHmnOAXCAO92GXeJotpbfeMp7MHGKDgco5hpsvgxBJo8kmffA1T/1QpqnDgCZ
         TZg4rFMteP8oQOjuqGwN3wX5okfZnHArxED9EvUa+YatbA2Dwoivfnpl+rILS2TxJmqz
         hkqPjBqNHYgfgtYef30+548bD15F8VYIY+qz3ETsAkFk/9b1BDIzeS8sGXTNUXt8YKsK
         X8xw==
X-Gm-Message-State: AGi0PuaVpkzVhb6qa65zKpArjfJeTV0HcJ8SzHanz9acsXsKQE7X2B42
        xcuBWV8YyAg13aFFm4CGvOk=
X-Google-Smtp-Source: APiQypJxBhGzU7FEv9wDSsbA6BcB09ZI6zcZJLRr0s5b2YymW4QimDRvIKvSBklXOggyjXe+NDAoWQ==
X-Received: by 2002:adf:d091:: with SMTP id y17mr22450319wrh.418.1589263229127;
        Mon, 11 May 2020 23:00:29 -0700 (PDT)
Received: from skynet.lan (198.red-83-49-57.dynamicip.rima-tde.net. [83.49.57.198])
        by smtp.gmail.com with ESMTPSA id a13sm20539150wrv.67.2020.05.11.23.00.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2020 23:00:28 -0700 (PDT)
From:   =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= 
        <noltari@gmail.com>
To:     computersforpeace@gmail.com, kdasu.kdev@gmail.com,
        miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        sumit.semwal@linaro.org, linux-mtd@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org
Cc:     =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= 
        <noltari@gmail.com>
Subject: [PATCH v3 0/2] mtd: rawnand: brcmnand: improve hamming oob layout
Date:   Tue, 12 May 2020 08:00:21 +0200
Message-Id: <20200512060023.684871-1-noltari@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200504185945.2776148-1-noltari@gmail.com>
References: <20200504185945.2776148-1-noltari@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These patches improve the OOB hamming layout by reducing the number of oob
sections and correctly 

v3: invert patch order.
v2: extend original comment and correctly skip byte 6 for small-page.

Álvaro Fernández Rojas (2):
  mtd: rawnand: brcmnand: fix hamming oob layout
  mtd: rawnand: brcmnand: improve hamming oob layout

 drivers/mtd/nand/raw/brcmnand/brcmnand.c | 34 +++++++++++++-----------
 1 file changed, 18 insertions(+), 16 deletions(-)

-- 
2.26.2

