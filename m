Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F046EC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 21:02:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CBEC220775
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 21:02:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YafiIJGF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728324AbgF3VCO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 17:02:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726739AbgF3VCN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 17:02:13 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59869C061755;
        Tue, 30 Jun 2020 14:02:13 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id w73so7238222ila.11;
        Tue, 30 Jun 2020 14:02:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WRQJQwlXflGJ37/jOmBKwBicPdHtRMvLxub3PxAmuG4=;
        b=YafiIJGFdTuNrNOw5wgMfTU5z5VCFcwrmrkj5aDpKRPveSUPGb87Nix4nVeKmqyfzd
         mQ+CAaSnQkWl/svbr03I/+zkPd2YCsGg5sSVeXENjGmX9VeAm5jlxgK8qV44lDJdOPAs
         hwFNNJIc2HJ/OnEDGt5H+as2z9wK6mScltRqJWPSCioNmXilHw0aFW/SPTjRNhUEdJnl
         OmdZszUZAdEYJEHf9ync6UpH0dTsKwFesYfRthpL4F8ASAtuh9sULifQ925xgm9rzaeo
         0UrgMbxZJeUcONIDmq9Fw3Pa3fP8I1yIy+CBU/InS2ZKrl86Uycy2kHsI6DVXnOlQnMw
         5vcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WRQJQwlXflGJ37/jOmBKwBicPdHtRMvLxub3PxAmuG4=;
        b=aTuN8VZPs4/cZ3a1Cg2BBcVq0z5oAbXqsYKYLrYTete9Hy4/rOsIi8ssJADp5tkxW1
         vwm6xeMf0Lokjjx1eMDA7EpoXU9ZCdjEOWYYBoJryWX607hLtNAL1cr1yJXMc3HWLrjI
         QIUw1AgFvjfQKDrHnz4XI8t+FNHVadr07dNR6oCY24vAI1bFdrvrmmSoQ5zebv+SpQ0l
         VqQ58yE58wBLO9VpPsTrby0TYcD10/N3PKIdjnls48oYRiQ++MuoLWhySUBfc6P8OC0V
         /ciB57p1zjPgEWgrjRS1sCKFuqwdEUNJyxYgynqS9X1qt0+85t6QEK0pG+mgDeOKYVlP
         TYCQ==
X-Gm-Message-State: AOAM532zeHo6Ex2lBxr0uPLF17Fjb0qVlWvzjl+zWRHp1o2XRAsiUsCR
        Ij+8m8IgKQtszkFCVW67p7QTXAQ5
X-Google-Smtp-Source: ABdhPJzxlgl9i3L/TOVMOKrSO/CQ+RM3Rvt9gET5kEH7jf3JrlknMOqxpP5M4qAAvyEk88ReahfcxA==
X-Received: by 2002:a92:cb10:: with SMTP id s16mr4690250ilo.192.1593550932284;
        Tue, 30 Jun 2020 14:02:12 -0700 (PDT)
Received: from aford-IdeaCentre-A730.lan (c-73-37-219-234.hsd1.mn.comcast.net. [73.37.219.234])
        by smtp.gmail.com with ESMTPSA id o16sm2105042ilt.59.2020.06.30.14.02.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2020 14:02:11 -0700 (PDT)
From:   Adam Ford <aford173@gmail.com>
To:     linux-clk@vger.kernel.org
Cc:     dan.carpenter@oracle.com, aford@beaconembedded.com,
        Adam Ford <aford173@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] clk: vc5: Add memory check to prevent oops
Date:   Tue, 30 Jun 2020 16:01:54 -0500
Message-Id: <20200630210155.459250-1-aford173@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When getting the names of the child nodes, kasprintf is used to
allocate memory which is used to create the string for the node
name.  Unfortunately, there is no memory check to determine
if this allocation fails, it may cause an error when trying
to get child node name.

This patch will check if the memory allocation fails, and returns
and -NOMEM error instead of blindly moving on.

Suggested-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Adam Ford <aford173@gmail.com>

diff --git a/drivers/clk/clk-versaclock5.c b/drivers/clk/clk-versaclock5.c
index 1d8ee4b8b1f5..29cdb38dc40b 100644
--- a/drivers/clk/clk-versaclock5.c
+++ b/drivers/clk/clk-versaclock5.c
@@ -789,10 +789,14 @@ static int vc5_get_output_config(struct i2c_client *client,
 	int ret = 0;
 
 	child_name = kasprintf(GFP_KERNEL, "OUT%d", clk_out->num + 1);
+	if (!child_name) {
+		ret = -ENOMEM;
+		goto output_error;
+	}
 	np_output = of_get_child_by_name(client->dev.of_node, child_name);
 	kfree(child_name);
 	if (!np_output)
-		goto output_done;
+		return 0;
 
 	ret = vc5_update_mode(np_output, clk_out);
 	if (ret)
@@ -813,7 +817,6 @@ static int vc5_get_output_config(struct i2c_client *client,
 
 	of_node_put(np_output);
 
-output_done:
 	return ret;
 }
 
-- 
2.25.1

