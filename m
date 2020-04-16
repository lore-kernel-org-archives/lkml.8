Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED64AC2BB55
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 21:44:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD550221F9
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 21:44:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EN9E/AtM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728273AbgDPVot (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 17:44:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727972AbgDPVop (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 17:44:45 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71246C061A0C;
        Thu, 16 Apr 2020 14:44:45 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id l25so326730qkk.3;
        Thu, 16 Apr 2020 14:44:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=KlgFG+M3n9abjMqYN2fUYHQh7LbcgicpBKBoW2XqS7k=;
        b=EN9E/AtMGYsycKXsHLAOvljbsIVPHZurm3pkOxLWDdUHsZxrHYWnTa9C7V/HlsLSib
         p9wwP0zCWVMQtmh5RmzRyo9HsMLiglCvBqJNOzQjWWqSOFvyH7o4KH/5tXnvDwPaXFaL
         4PwIvE2BCCICQtLnNTg1QiwZvbW8cA7iZ6sUoIMiRcowUGygnHyOy90tmhTtc/zSLBIX
         xVz2874iIt9kK+oRP2M6yIe76OpekpGt6wUgx8V+QBX3mvRUJRZ+MrSZ5MGhdvVYUJ7a
         +3YUriVDzCh97Y9qf/3rPqvEl+f3QFgki3FfveFOnWZwut2pNHlligttE6+SbfFKS78u
         FQUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=KlgFG+M3n9abjMqYN2fUYHQh7LbcgicpBKBoW2XqS7k=;
        b=ggfojVL7fZujvd2XDKnL2WfRG6ki+/gu9h1r/oACDlohJEVLCQQcInk0uajniiDhrA
         DrKeirIy3CT2sBzLcWbgOAd3jrUF2sMlCipDPRDPOCmGPYboNT4DQ7dJ4sM/fVdBiTs7
         0U8XQ1er+NTAFfYabU/cmETeTsScCdfBXZLotwgYKwbh6uucN71IiEKA5jwUHKjK/wRr
         dBIgWS7B/BaL/XzUHqcMN2GQG+E9OJZNfB0HOVxAGcVSdGr3t+o5xVxppZhhCVaHUKIa
         5Hdgj2svdT/N8ghUqfli2B+YY6/2kZXJOWGoOibBDrCrQ2cKcAS5mxxOrWxOSrlpIWsv
         V80A==
X-Gm-Message-State: AGi0PuZzisnEqrOGDA3oUOuimXzhl1VTmayl4nb5/IWMoxanBA5/yM7M
        eBxVgXxyF1sCrTqJo3tl72E=
X-Google-Smtp-Source: APiQypJno+bvZVNrX7XSnObtFbZHzCOvk4SdtwSQ/XavQBrMX063GCXwhjOx7xBEshZhItF3qpFF2w==
X-Received: by 2002:ae9:ddc6:: with SMTP id r189mr162068qkf.14.1587073484738;
        Thu, 16 Apr 2020 14:44:44 -0700 (PDT)
Received: from localhost.localdomain (c-73-88-245-53.hsd1.tn.comcast.net. [73.88.245.53])
        by smtp.gmail.com with ESMTPSA id z34sm3164141qth.43.2020.04.16.14.44.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 Apr 2020 14:44:44 -0700 (PDT)
From:   frowand.list@gmail.com
To:     Rob Herring <robh+dt@kernel.org>, pantelis.antoniou@konsulko.com
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Erhard F." <erhard_f@mailbox.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Alan Tull <atull@kernel.org>
Subject: [PATCH 1/5] of: unittest: kmemleak on changeset destroy
Date:   Thu, 16 Apr 2020 16:42:46 -0500
Message-Id: <1587073370-25963-2-git-send-email-frowand.list@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1587073370-25963-1-git-send-email-frowand.list@gmail.com>
References: <1587073370-25963-1-git-send-email-frowand.list@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frank Rowand <frank.rowand@sony.com>

kmemleak reports several memory leaks from devicetree unittest.
This is the fix for problem 1 of 5.

of_unittest_changeset() reaches deeply into the dynamic devicetree
functions.  Several nodes were left with an elevated reference
count and thus were not properly cleaned up.  Fix the reference
counts so that the memory will be freed.

Fixes: 201c910bd689 ("of: Transactional DT support.")
Reported-by: Erhard F. <erhard_f@mailbox.org>
Signed-off-by: Frank Rowand <frank.rowand@sony.com>
---
 drivers/of/unittest.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/of/unittest.c b/drivers/of/unittest.c
index 7e27670c3616..20ff2dfc3143 100644
--- a/drivers/of/unittest.c
+++ b/drivers/of/unittest.c
@@ -861,6 +861,10 @@ static void __init of_unittest_changeset(void)
 	unittest(!of_changeset_revert(&chgset), "revert failed\n");
 
 	of_changeset_destroy(&chgset);
+
+	of_node_put(n1);
+	of_node_put(n2);
+	of_node_put(n21);
 #endif
 }
 
-- 
Frank Rowand <frank.rowand@sony.com>

