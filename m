Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E415C2BA2B
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 21:44:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E4ED221F4
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 21:44:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U/wZmwFF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728307AbgDPVox (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 17:44:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725843AbgDPVos (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 17:44:48 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE45AC061A0C;
        Thu, 16 Apr 2020 14:44:48 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id b10so250842qtt.9;
        Thu, 16 Apr 2020 14:44:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=sthAapj68aXnXI+RTvpMX6Wnzn0JdQZcGOOuG2S5PBw=;
        b=U/wZmwFFE2+EDMGQltvGpyA0vQDc9HEPWleqF6o//HJIleVvCBxrzqyG8LoupuNO6X
         aK/0TxVGE8qCSwwlHYSXVUe03ikiIy/WYtYMuRQN0SNUHHXj242GqrATPys++GD7vV4Y
         3TOeUeyKOBBP8lrwyQ+bq2nglijA6+nm37+HefH/rH19DlNoAq78X/x7reN0X7MCfH0W
         qoD88FNNzlr/PM5xwW6EFMOZHjxOEkpgmDxIgYvORkRbzFGhXSENirIg9F4DBskJuopx
         rvza9knEBZd0+ThVTdcpykEXSu2Dmwtx/XZhgFAsBRwRWhZSUMWX4y5DILLEeZRMP/m7
         5mBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=sthAapj68aXnXI+RTvpMX6Wnzn0JdQZcGOOuG2S5PBw=;
        b=mv6P2aO3IzAQOt453cHtAfu8x2R0aRTbLdY7QcQwcq7omhvsb+Um9gyBOgqVfpvSVB
         G3JXx0EJUqW1Kk9BglKhDPrjLIvnV9T19lN1lNmBqgvnFejxGpkyCU9x1Qm6eYvVTFnK
         78W88oJGc/1Ani3Rj7mTlwN/7Ccwhdrcw+2TFTxrVxYq5jxUS93vn4qKsu0WV8Lo5Q9L
         ThTMoKj16+9OXE/0GpdxKnPob9Cvd4jaduCqWyOInewgWodIVZCLluCcr7fKkfWRoXr/
         lwkA1iamQhu9dUvkmjL1YdA5tCTFXQBEOMmHswve82bOgIpMz4h8ZECv5z7tG3kTrzEi
         /5ew==
X-Gm-Message-State: AGi0PuZ6e9DE1JbsSOQGmuGvO276EB1A/ajtVICWtYxe9rAv9wHvFmbn
        qZN6u/ukz2FXZbtkAFCMTO0=
X-Google-Smtp-Source: APiQypL6FrzR3vybWwRzyKZ+ZYw6voEB2hXvgpwAE4GXnyw43EMvCotfFZFjd2NKKnKJOQcqrGakHQ==
X-Received: by 2002:ac8:71c1:: with SMTP id i1mr26103907qtp.280.1587073487971;
        Thu, 16 Apr 2020 14:44:47 -0700 (PDT)
Received: from localhost.localdomain (c-73-88-245-53.hsd1.tn.comcast.net. [73.88.245.53])
        by smtp.gmail.com with ESMTPSA id z34sm3164141qth.43.2020.04.16.14.44.46
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 Apr 2020 14:44:47 -0700 (PDT)
From:   frowand.list@gmail.com
To:     Rob Herring <robh+dt@kernel.org>, pantelis.antoniou@konsulko.com
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Erhard F." <erhard_f@mailbox.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Alan Tull <atull@kernel.org>
Subject: [PATCH 4/5] of: overlay: kmemleak in dup_and_fixup_symbol_prop()
Date:   Thu, 16 Apr 2020 16:42:49 -0500
Message-Id: <1587073370-25963-5-git-send-email-frowand.list@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1587073370-25963-1-git-send-email-frowand.list@gmail.com>
References: <1587073370-25963-1-git-send-email-frowand.list@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frank Rowand <frank.rowand@sony.com>

kmemleak reports several memory leaks from devicetree unittest.
This is the fix for problem 4 of 5.

target_path was not freed in the non-error path.

Fixes: e0a58f3e08d4 ("of: overlay: remove a dependency on device node full_name")
Reported-by: Erhard F. <erhard_f@mailbox.org>
Signed-off-by: Frank Rowand <frank.rowand@sony.com>
---
 drivers/of/overlay.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/of/overlay.c b/drivers/of/overlay.c
index c9219fddf44b..50bbe0edf538 100644
--- a/drivers/of/overlay.c
+++ b/drivers/of/overlay.c
@@ -261,6 +261,8 @@ static struct property *dup_and_fixup_symbol_prop(
 
 	of_property_set_flag(new_prop, OF_DYNAMIC);
 
+	kfree(target_path);
+
 	return new_prop;
 
 err_free_new_prop:
-- 
Frank Rowand <frank.rowand@sony.com>

