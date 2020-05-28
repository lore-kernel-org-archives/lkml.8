Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 777E6C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 07:20:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D931207D3
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 07:20:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HfZBaRmT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726195AbgE1HUy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 03:20:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725601AbgE1HUx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 03:20:53 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1826C05BD1E;
        Thu, 28 May 2020 00:20:53 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id s69so2668256pjb.4;
        Thu, 28 May 2020 00:20:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ozAlwFH/NsWPPQoM9O+65J2hW1Eu0am6VJ0Xg8vPREI=;
        b=HfZBaRmTcehGAquB+2TCmx4tZEnb6ebfNWxV0Dct73pTOMQgvMrFx16FkJSXtsGbdj
         EqN2wBeTNRT41qrt0ZsrFn1R20Nm3FoQW6YcN7+2pZVT1WOqTNEpjAKAXoawFZv4JWyE
         nv2xvnOLJce4vsSA4MqHc+KOPRNT6xFAdWAO8KISoW10pj5KYY3wiS7rq3foJu70yznb
         T1GrguuGmYsInwugN5b8FzbsRGczidcHuc9jK0lrstw3Vbwc7HPUi0Jxge+5RIZB4I9p
         pbfDrd3eWPejCWItVGBynN/th9a79enJ+Vse6vVP74pcRtpuwOBAsPWp7QanUVYakYwU
         k1xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=ozAlwFH/NsWPPQoM9O+65J2hW1Eu0am6VJ0Xg8vPREI=;
        b=Tmf18bMhez2wdqKZpoGgZjGWzPohyOj1vFe6Sj70VV1cSwcF+QbYI/9rUV3AZiyNLW
         7eLAGYhFWNxnFDgnq3FQPW3yy++UL0cDZ8yZne1tgh2ajMpbqA+0sS4jDrLBbE1g7+7E
         iGgcaSmBepVJBaw1eQcO3Mn88Z1Jg2CvD6K8EDo8fpPGOXBiSlUq/ymE66O+Gazhn/nX
         g6bdwczXShl+h4g3BbZoY74AFdyk8wk7M5ax2KuIHvRXofVQl9kMeW+59rm92nS3SFxh
         AQM+H2NvKzIb7NjtAQK/sPfbSmy1fn98dMFoQ6xl+a6Tt0apIKlZwk/HLWNZNHqtlsmF
         crLQ==
X-Gm-Message-State: AOAM533W3Di3tiVuZ+TsSm3PDbiH44XcPnJQavVqyE1MDEiz71aY488o
        wYN6h6d12hwKtVj8woAhMRQdzQkZ
X-Google-Smtp-Source: ABdhPJzpmPx+4JbPRteTD6hcWOms2QSVJh9pkuEc9akN7HSbm2biWhaZygCNvnO3yELh5ZlDXt2Z0Q==
X-Received: by 2002:a17:90a:9f95:: with SMTP id o21mr2334838pjp.91.1590650452510;
        Thu, 28 May 2020 00:20:52 -0700 (PDT)
Received: from localhost.localdomain ([45.124.203.15])
        by smtp.gmail.com with ESMTPSA id k2sm4090628pfd.108.2020.05.28.00.20.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2020 00:20:51 -0700 (PDT)
From:   Joel Stanley <joel@jms.id.au>
To:     devicetree-compiler@vger.kernel.org,
        David Gibson <david@gibson.dropbear.id.au>
Cc:     linux-kernel@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v2 0/2] dtc: Improve checks for i2c reg properties
Date:   Thu, 28 May 2020 16:50:35 +0930
Message-Id: <20200528072037.1402346-1-joel@jms.id.au>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is to fix a build warning in the Linux kernel caused by dtc
incorrectly warning about I2C_OWN_SLAVE_ADDRESS.

v2 contains a second patch to check for 10 bit vs 7 bit addresses.

Joel Stanley (2):
  checks: Remove warning for I2C_OWN_SLAVE_ADDRESS
  checks: Improve i2c reg property checking

 checks.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

-- 
2.26.2

