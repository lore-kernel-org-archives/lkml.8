Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FC70C35247
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 23:39:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2236C20838
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 23:39:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DubTVcqO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727129AbgBCXjl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 18:39:41 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:59072 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726287AbgBCXjl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 18:39:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580773179;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=5I1HAxr39AdpMHsVkl2MOFdKX0uTzBJ2hmslg/vYG7U=;
        b=DubTVcqOFVj39bd7gdrUSPyjF2hSDz8hYCnaXJr7jZ8Xt4tQVfsdfRdbhIlZ9NazTY3lAT
        Qd4tB78xBZeHKQigs8IUs9M/goi7cuotV1p77mG8DDbI0SAUmXjhGMxQAy13t59xBZtrhN
        9L6y/C7uPTndWHwEXp0C5MZwkvZms/0=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-363-o-HuKVCfNPOI0C9G5s94ow-1; Mon, 03 Feb 2020 18:39:38 -0500
X-MC-Unique: o-HuKVCfNPOI0C9G5s94ow-1
Received: by mail-wr1-f69.google.com with SMTP id j4so9085707wrs.13
        for <linux-kernel@vger.kernel.org>; Mon, 03 Feb 2020 15:39:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5I1HAxr39AdpMHsVkl2MOFdKX0uTzBJ2hmslg/vYG7U=;
        b=QOvX848flluUcL6PSs0VizcvoWPnXfgSjVysLIn6C7ja55AuW4cVjeF2lQoSO0LF0r
         kGaCUWFxjesG1nXrMemruTkRt8fcDTAibOtzDon9h4BHfXx4t1rLHrGrhpbfhWdQJbUp
         CfFGGNxSxtEDCIAn5eACMhIgJ7lhEjaE4oKzWeX5o0dQD2Ga/lmN8hGAjN1MnOdk47pc
         cHq27iaB6frPWlmAE049Ao0GlcF31Ahn3O/u1I7X1a5PcRdWQZfsj3Q6Hkfv4GMNDg8f
         evdBfkk6r5DHVhpQLhp4INnGeQk2VDb0+OiaUeUlGVF+BRlj3I2/Dc+fVFjPlUl6dKgy
         ozIw==
X-Gm-Message-State: APjAAAW/SMWyVnmK+9snM81C/a7IWDGojkXCnTgzzbmkokXcU6+n9zOC
        3HSR6snfjAgmafFbh/OE/b9sGMSPQ8lpGngVs1Zgit9oxjOAJrNo0EtdljWCRhqtJx1F3hLfrae
        //HOuzxYEenCI2HEJwgo+IJZk
X-Received: by 2002:a5d:6692:: with SMTP id l18mr17323060wru.382.1580773177188;
        Mon, 03 Feb 2020 15:39:37 -0800 (PST)
X-Google-Smtp-Source: APXvYqyZsbPh5JGaqRxiFxIHmn8GVyOzze6usAiUfosb3U5cluC+GypdbmtQRvgfeOTfq2Jb0PdZjw==
X-Received: by 2002:a5d:6692:: with SMTP id l18mr17323047wru.382.1580773177034;
        Mon, 03 Feb 2020 15:39:37 -0800 (PST)
Received: from raver.teknoraver.net (net-2-36-173-8.cust.vodafonedsl.it. [2.36.173.8])
        by smtp.gmail.com with ESMTPSA id h17sm28264258wrs.18.2020.02.03.15.39.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2020 15:39:36 -0800 (PST)
From:   Matteo Croce <mcroce@redhat.com>
To:     linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Ard Biesheuvel <ardb@kernel.org>, linux-kernel@vger.kernel.org,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: [PATCH] crypto: arm64/poly1305: ignore build files
Date:   Tue,  4 Feb 2020 00:39:33 +0100
Message-Id: <20200203233933.19577-1-mcroce@redhat.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add arch/arm64/crypto/poly1305-core.S to .gitignore
as it's built from poly1305-core.S_shipped

Fixes: f569ca164751 ("crypto: arm64/poly1305 - incorporate OpenSSL/CRYPTOGAMS NEON implementation")
Signed-off-by: Matteo Croce <mcroce@redhat.com>
---
 arch/arm64/crypto/.gitignore | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/crypto/.gitignore b/arch/arm64/crypto/.gitignore
index 879df8781ed5..e403b1343328 100644
--- a/arch/arm64/crypto/.gitignore
+++ b/arch/arm64/crypto/.gitignore
@@ -1,2 +1,3 @@
 sha256-core.S
 sha512-core.S
+poly1305-core.S
-- 
2.24.1

