Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C9A7C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 17:45:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4099320885
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 17:45:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597945526;
	bh=CmfN+na+1NU7RTunOfTAQ7rkaTgJsL087BoPb2agcJs=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=ms4LQtqwiWUqIfCpF6VE4yFzP+fu+HDvrxbt2yiZmQyrIx/itKuIMlBsYNEYB3E1X
	 qhsJ+8lEfptktTvwFBB2ZJBRZUuHT0BQcz42Bb/zVyc82PsM5op/MjdZnEVxWdpICk
	 2ChSKPqES3G6opwCGhSc7LT5HpERlMQn81+iK9EU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728046AbgHTRpY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 13:45:24 -0400
Received: from conuserg-08.nifty.com ([210.131.2.75]:42324 "EHLO
        conuserg-08.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727854AbgHTRpF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 13:45:05 -0400
Received: from oscar.flets-west.jp (softbank126090211135.bbtec.net [126.90.211.135]) (authenticated)
        by conuserg-08.nifty.com with ESMTP id 07KHhX9q017281;
        Fri, 21 Aug 2020 02:43:33 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com 07KHhX9q017281
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1597945414;
        bh=yiy7JLyFur4PVxRb7fWremVgVxDABMqosufnldJPcNs=;
        h=From:To:Cc:Subject:Date:From;
        b=EuAJcEtD50UrAOPyYALKNJ1fa7qp8R0JbB8aMeFUESB3h1Olh6O3qGIiNT4tVA5Tw
         +FmW/Ml/RQVCryGkYi8sz18LC0Ch1GTC7IO8gJvgXXcklkzREVznR9/xHw1w0jNvk/
         N+dnH4hct2TQ/wh4PthFqg41CGqzlX6bxCH22iIPUyMzrIg/scv11Eb+VJdgK2uTT4
         SWnYbv9pTBxKW4Quo1+4z4vrdstyLdt23Awyyng1I83LSAUfO4H6v8hMWVZwuRQ/ng
         w456RUJMFDf7eRAurRMNHhRIZ6hAbWvTMH+8SUQcRV2X7zygoRz4rsXp4JakTEFD8y
         2D7RKApnqa12A==
X-Nifty-SrcIP: [126.90.211.135]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     Robert Crawford <flacycads@cox.net>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] kconfig: qconf: remove redundant help in the info view
Date:   Fri, 21 Aug 2020 02:43:27 +0900
Message-Id: <20200820174328.490374-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The same information is repeated in the info view.

Remove the second one.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/kconfig/qconf.cc | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/scripts/kconfig/qconf.cc b/scripts/kconfig/qconf.cc
index 3a8f6251a727..4c5688a845f8 100644
--- a/scripts/kconfig/qconf.cc
+++ b/scripts/kconfig/qconf.cc
@@ -1106,11 +1106,6 @@ void ConfigInfoView::menuInfo(void)
 
 		if (showDebug())
 			debug = debug_info(sym);
-
-		struct gstr help_gstr = str_new();
-		menu_get_ext_help(_menu, &help_gstr);
-		help = print_filter(str_get(&help_gstr));
-		str_free(&help_gstr);
 	} else if (_menu->prompt) {
 		head += "<big><b>";
 		head += print_filter(_menu->prompt->text);
@@ -1126,7 +1121,7 @@ void ConfigInfoView::menuInfo(void)
 	if (showDebug())
 		debug += QString().sprintf("defined at %s:%d<br><br>", _menu->file->name, _menu->lineno);
 
-	setText(head + debug + help);
+	setText(head + debug);
 }
 
 QString ConfigInfoView::debug_info(struct symbol *sym)
-- 
2.25.1

