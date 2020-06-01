Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD512C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 00:54:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B3412067B
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 00:54:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iSFRfX2O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728479AbgFAAyo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 May 2020 20:54:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728395AbgFAAyn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 May 2020 20:54:43 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DAC1C061A0E
        for <linux-kernel@vger.kernel.org>; Sun, 31 May 2020 17:54:42 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id c12so6477891qtq.11
        for <linux-kernel@vger.kernel.org>; Sun, 31 May 2020 17:54:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=oYJCiCsJ5rLqUom9oCyqrR/lBdyEXmqQQtn1m7mSt/0=;
        b=iSFRfX2Oeg2nK5+eMsKrbn9rOWlvhobnIu7lOvWqt11y6XacLKTS6Gq3Ti43ZMN0RK
         h23ezvserR9TgsXx38pfm+ZyE5f1m8NWETJpYafrGBfdtiDyc/po+WeMe0d7MCX/mfTX
         WwUrbVKmGnz9AmoxW3ETuElx44nHpI7iX/4h9wMSzpFD+j4MEQnZ+XiyAlCF44/t8H1/
         j1aYQNnnWCUpyddrlWub6zvjOJyebL4CtP4C2spSwRtCYhKdnmmfmVzT0CjNQY/v4Tn+
         vVmQEzofSxX8DAh7VYd6+WOGmF+qN4Bnn1KrHIKyD8QzKskIp/gGg+JqTDTZlb2fme5s
         Jg8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=oYJCiCsJ5rLqUom9oCyqrR/lBdyEXmqQQtn1m7mSt/0=;
        b=tbWf9NaHwZzJoKVhIND5dkGvEqAkBAF945n/RgzeNIL1dBRkk/23P41qYE1n67vsBK
         /jHTsBNLbwcw7lCwY0EmqsOGxWRrzfNE3DYH4j1HXRc+ujvQAO8fX4zEAGsdijqyGMGg
         pxIGb6owpBFLXLevLQC08tCDyt6UfFH9VeYjWVLwOjGCOq/+HPpF4uLJ8xi83bJltH8o
         ZaQRz00YSKBBk3QlmrZbKpw4x3Uu9HkQ/mrB/63RFoeqTiioHu8hFjtDgGBt/uu3qttR
         djAn4M4hEQFsHXRI0/rSmrrBo4nRNcoOQK1FTewzDTdy9uuLH2gMz5Sf4JhxtlKnaUut
         Amgw==
X-Gm-Message-State: AOAM531RbD7LG+kexz5vgQethjrAUo/lzPVgMJJMiwnV1l+82xkd8CDm
        hki8bj4oqksqSKMJRzwb3ELHWAtJLnG6IQ==
X-Google-Smtp-Source: ABdhPJx0qlqlnp0/w0aVKv9ByK3iYUUSlvOk1rMYr7XYLf7juDCKBoPJuUbtzjKdypHuK1BVOUC+qg==
X-Received: by 2002:ac8:7296:: with SMTP id v22mr19863238qto.239.1590972880948;
        Sun, 31 May 2020 17:54:40 -0700 (PDT)
Received: from ip-172-31-24-31.ec2.internal (ec2-54-234-246-66.compute-1.amazonaws.com. [54.234.246.66])
        by smtp.gmail.com with ESMTPSA id g47sm12882388qtk.53.2020.05.31.17.54.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 May 2020 17:54:40 -0700 (PDT)
From:   "Rodolfo C. Villordo" <rodolfovillordo@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     rodolfovillordo@gmail.com, Rob Springer <rspringer@google.com>,
        Todd Poynor <toddpoynor@google.com>,
        Ben Chan <benchan@chromium.org>, Richard Yeh <rcy@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org
Subject: [PATCH] staging: gasket: replace symbolic permissions
Date:   Mon,  1 Jun 2020 00:52:40 +0000
Message-Id: <20200601005240.6315-1-rodolfovillordo@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

WARNING: Symbolic permissions 'S_IRUGO' are not preferred. Consider using octal permissions '0444'.
+               .attr = __ATTR(_name, S_IRUGO, _show_function, NULL),          \
warning detected by checkpatch.pl

Signed-off-by: Rodolfo C. Villordo <rodolfovillordo@gmail.com>
---
 drivers/staging/gasket/gasket_sysfs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/gasket/gasket_sysfs.h b/drivers/staging/gasket/gasket_sysfs.h
index ab5aa351d555..d5e167dfbe76 100644
--- a/drivers/staging/gasket/gasket_sysfs.h
+++ b/drivers/staging/gasket/gasket_sysfs.h
@@ -71,7 +71,7 @@ struct gasket_sysfs_attribute {
 
 #define GASKET_SYSFS_RO(_name, _show_function, _attr_type)                     \
 	{                                                                      \
-		.attr = __ATTR(_name, S_IRUGO, _show_function, NULL),          \
+		.attr = __ATTR(_name, 0444, _show_function, NULL),          \
 		.data.attr_type = _attr_type                                   \
 	}
 
-- 
2.17.1

