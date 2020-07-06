Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB687C433E1
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 20:37:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A1E520715
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 20:37:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q6HZnhYl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727124AbgGFUhm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 16:37:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726898AbgGFUhm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 16:37:42 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46039C061755;
        Mon,  6 Jul 2020 13:37:42 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id t4so20940301iln.1;
        Mon, 06 Jul 2020 13:37:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=2x42L3ZjIc07umJeW7MZC6jIGWIpEhQ6LTYn0is3+aI=;
        b=q6HZnhYl2qQbqdWygKEk3xv1SiBRyGUd6foPIxRcLKip/tL1fKh2mfPgyvEySzlipQ
         mHNiS9/kNEXJxaWZ+yBnV/aV/+g5/uuJ14UzLJ36NHTEhYWSniogJAX24APRQhcopRV8
         N99JSdpiq6uHz/gX1Vdk5lILukoK/csy09xjFJCeFdGFjUApZbEwWALqQ7MxnvunO+e/
         N51M4SUkCgIkvF0p+j+JmHG2PGi2eAoVoVtxs1v8W3pMlAdk+OT9XxjTNKYQCg7t03N+
         HfhXwFPgnI60c0UDPvhh7YamVwuiMMCzkoCIunrGrEy9EYZAWGsO798YKG8CQZVtpFD7
         YG3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=2x42L3ZjIc07umJeW7MZC6jIGWIpEhQ6LTYn0is3+aI=;
        b=D5FO5XQBUVSES2EpQp7JUwlhJdgM84ZCgRRhxqF06lSFad0K7OXLEPHR5pTt/5xJML
         QG73VfAMtxSNuXp1NtWbI6V6YNL5l/Oun2D+FCZ2TjxU8U5sBdPFIE4CtHs10BH0d2tk
         d2DpBVHNfZMZamNtn06nP/LGqV1cyZKSaYGoREfQkQqZYug/FS756gceYiiyqTRyoDEr
         ggJD64+aRfElEmoUnk3yknC4cpllCtPI5ExRbC37FHf6eLZSIPR68WyQi1dge+RfSIoX
         lAUj8O9nBC3iZQhB/aHO76NPrEHOVOK4I3kR3SKmmdSST/xD/naDWHsse7mgX1oL3Z9H
         RkSw==
X-Gm-Message-State: AOAM533GMFbPHv/zop6I2OG65P2Wd0IlesO1mM0jEX2BoGNklZHtYfSW
        FcvOdh8IAfjIZahoV+rRweg+iPON
X-Google-Smtp-Source: ABdhPJwAMvn7e6gl5GO2W+I1wGddhwqLOPQqDM8w3GaIVyd3+g9yR0PC0ULx2Ydb00/0C8uhWjbFtg==
X-Received: by 2002:a92:d64d:: with SMTP id x13mr31995829ilp.287.1594067861055;
        Mon, 06 Jul 2020 13:37:41 -0700 (PDT)
Received: from aford-OptiPlex-7050.logicpd.com ([174.46.170.158])
        by smtp.gmail.com with ESMTPSA id t83sm11937595ilb.47.2020.07.06.13.37.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2020 13:37:40 -0700 (PDT)
From:   Adam Ford <aford173@gmail.com>
To:     linux-clk@vger.kernel.org
Cc:     dan.carpenter@oracle.com, aford@beaconembedded.com,
        charles.stevens@logicpd.com, Adam Ford <aford173@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH V2] clk: vc5: Add memory check to prevent oops
Date:   Mon,  6 Jul 2020 15:37:27 -0500
Message-Id: <20200706203727.18380-1-aford173@gmail.com>
X-Mailer: git-send-email 2.17.1
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

Fixes: 260249f929e8 ("clk: vc5: Enable addition output configurations of the Versaclock")

Suggested-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Adam Ford <aford173@gmail.com>

diff --git a/drivers/clk/clk-versaclock5.c b/drivers/clk/clk-versaclock5.c
index 9a5fb3834b9a..926a370a0eda 100644
--- a/drivers/clk/clk-versaclock5.c
+++ b/drivers/clk/clk-versaclock5.c
@@ -789,10 +789,13 @@ static int vc5_get_output_config(struct i2c_client *client,
 	int ret = 0;
 
 	child_name = kasprintf(GFP_KERNEL, "OUT%d", clk_out->num + 1);
+	if (child_name == NULL)
+		return -ENOMEM;
+
 	np_output = of_get_child_by_name(client->dev.of_node, child_name);
 	kfree(child_name);
 	if (!np_output)
-		goto output_done;
+		return 0;
 
 	ret = vc5_update_mode(np_output, clk_out);
 	if (ret)
@@ -813,7 +816,6 @@ static int vc5_get_output_config(struct i2c_client *client,
 
 	of_node_put(np_output);
 
-output_done:
 	return ret;
 }
 
-- 
2.17.1

