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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A792C2BA2B
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 21:45:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D8E74221F4
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 21:45:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dLhuENUj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728368AbgDPVpB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 17:45:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728112AbgDPVor (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 17:44:47 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BC3DC061A0C;
        Thu, 16 Apr 2020 14:44:47 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id y3so288501qky.8;
        Thu, 16 Apr 2020 14:44:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ri3GcCgI+is7U0tNUGQj9JVdWWpKjcSdhc08l7uOYfg=;
        b=dLhuENUjstK3nPmJgrivkwfLR0PIutDeYo8GfNiU5JR3nmw8Xy6nrbxF/3Jm/wSv2f
         iiA1VghcxRFdeoVnYlecj9fvz3BnCqIrS/E/DuoelUMOgW8HimzavT7PknL7X5Ntd+VS
         ifN07keBZCpcG6kxft91OyZ7CrZMlPv9IUJEhkJiXOjTQHBfgcMpxO1eOXy8sfx1uBnI
         28OU1UenxghWZDXclfLTI023PWghnNjT7Af9eYhRTWBghIo5aQzEvnkU29LR6wiDDOqr
         aJhEjlBBZO7pZg9E+kiTpQv0Bp2p7nUmvV79n5ZGtvzkt/nzhoE/og9xm3Eli1ohtwG6
         QgbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ri3GcCgI+is7U0tNUGQj9JVdWWpKjcSdhc08l7uOYfg=;
        b=nP17DMZj264vKlbps66A/cKqOeXRTDfze1fVJOEX2sbX3byUybm2LJyFttBQrg6/m0
         E3FFrZb/tKQLBvR/RfKUDF6t0/3TMeT4nkYrakLgX43svPmoLM5I09+qpzQauvoUxQY/
         9g36tq/a3F5tgVUVAD+XAoO/Wx+cSIKBqvV6Akm9+ROy+8tHKH+6XezKsmvL114x4J9U
         6Y7vOt0kHlXIcMqqFX2Iai1w+4xYg25DoQfjwXZYrKLIdxUVPzjYyhBjPfXkLdcSg3Uu
         U55ZulAuCB00ewKEh+tyDBXpxPYdJjxEo/sPrLVndrkWD0CnPmpDqq9113ddL2dzNcvo
         sOwA==
X-Gm-Message-State: AGi0PuasZ7+jC91oZKaf1ftkbdfRBQ5Da1ObH7HEyrehH7RtcyJFJ4bL
        rNKYYPXk8vSSeeql/O3xwEs=
X-Google-Smtp-Source: APiQypK5YPrgNfGWutFT5M7T6XGbyiU8Hyu8YP+4Buk3DQ0g671iwEqfk80lrw427qlDYbCtvIiSdA==
X-Received: by 2002:a37:7302:: with SMTP id o2mr119945qkc.466.1587073486852;
        Thu, 16 Apr 2020 14:44:46 -0700 (PDT)
Received: from localhost.localdomain (c-73-88-245-53.hsd1.tn.comcast.net. [73.88.245.53])
        by smtp.gmail.com with ESMTPSA id z34sm3164141qth.43.2020.04.16.14.44.45
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 Apr 2020 14:44:46 -0700 (PDT)
From:   frowand.list@gmail.com
To:     Rob Herring <robh+dt@kernel.org>, pantelis.antoniou@konsulko.com
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Erhard F." <erhard_f@mailbox.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Alan Tull <atull@kernel.org>
Subject: [PATCH 3/5] of: unittest: kmemleak in of_unittest_overlay_high_level()
Date:   Thu, 16 Apr 2020 16:42:48 -0500
Message-Id: <1587073370-25963-4-git-send-email-frowand.list@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1587073370-25963-1-git-send-email-frowand.list@gmail.com>
References: <1587073370-25963-1-git-send-email-frowand.list@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frank Rowand <frank.rowand@sony.com>

kmemleak reports several memory leaks from devicetree unittest.
This is the fix for problem 3 of 5.

of_unittest_overlay_high_level() failed to kfree the newly created
property when the property named 'name' is skipped.

Fixes: 39a751a4cb7e ("of: change overlay apply input data from unflattened to FDT")
Reported-by: Erhard F. <erhard_f@mailbox.org>
Signed-off-by: Frank Rowand <frank.rowand@sony.com>
---
 drivers/of/unittest.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/of/unittest.c b/drivers/of/unittest.c
index 4c7818276857..f238b7a3865d 100644
--- a/drivers/of/unittest.c
+++ b/drivers/of/unittest.c
@@ -3094,8 +3094,11 @@ static __init void of_unittest_overlay_high_level(void)
 				goto err_unlock;
 			}
 			if (__of_add_property(of_symbols, new_prop)) {
+				kfree(new_prop->name);
+				kfree(new_prop->value);
+				kfree(new_prop);
 				/* "name" auto-generated by unflatten */
-				if (!strcmp(new_prop->name, "name"))
+				if (!strcmp(prop->name, "name"))
 					continue;
 				unittest(0, "duplicate property '%s' in overlay_base node __symbols__",
 					 prop->name);
-- 
Frank Rowand <frank.rowand@sony.com>

