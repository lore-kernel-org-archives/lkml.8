Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11F20C433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 09:19:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E128722D08
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 09:19:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596791980;
	bh=rayCLryKPpPKBu9/9sd60KyfJNb42Dkn1KQtpLzSMis=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=a6Iu3EmI/vuhuIycqglwVx9V1Ap7TxDQ3AGvjdfuwoJYu1dcPviXe98iJhp+Rv1zY
	 hH/q4pGBTRpXE+V1L1WhQpICmtjyYT/Y7VfNM/XCU17uymZoJ0dweHFq+Mu5TK904X
	 V7aAqrkBGDJq1GN7Yxgs6I7v/GLXkk8UjVAGw3jk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728037AbgHGJTj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 05:19:39 -0400
Received: from conuserg-12.nifty.com ([210.131.2.79]:41480 "EHLO
        conuserg-12.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726923AbgHGJTf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 05:19:35 -0400
Received: from localhost.localdomain (softbank060134047170.bbtec.net [60.134.47.170]) (authenticated)
        by conuserg-12.nifty.com with ESMTP id 0779JBQ2032147;
        Fri, 7 Aug 2020 18:19:15 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com 0779JBQ2032147
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1596791956;
        bh=TXoaOYE/LqjQwMgElir8ZhV7uTIN1YLGXs2By2r4H68=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jpp0pfSKHqg3iR6DIdQ3ByOKWKcS1v849BolOsuqjqAS2r+twMPyiN2sUpbFURzYv
         /rOt83P9NbKZlIVXGilhEqtPIuA4BPyWhYw3PyoKVgK37iieZ4mR/y8UNG3+OvguTG
         uWQ/3VNV+U9f6GVtza49b7P1Nt5embxk/2nAcyAlH6yOiJAOdnSLRH9rg9q8D+gQ5f
         ifWjE7w3Hi08+GF9/RJx1e1zUHM2HwPMxrBkE/SIVAIZeBJac044nLa7AK9gQ6rXv7
         3dLbA2vbi6dYmtuOAet8/0/qBJkryOzQLETEAIIqB270cp59xMSJQBLR7qAIH3Stv+
         3tDIkNAhCBxUg==
X-Nifty-SrcIP: [60.134.47.170]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 06/19] kconfig: qconf: remove unused ConfigList::listView()
Date:   Fri,  7 Aug 2020 18:18:56 +0900
Message-Id: <20200807091909.2985787-6-masahiroy@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200807091909.2985787-1-masahiroy@kernel.org>
References: <20200807091909.2985787-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I do not know how this function can be useful. In fact, it is unsed.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

(no changes since v1)

 scripts/kconfig/qconf.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/scripts/kconfig/qconf.h b/scripts/kconfig/qconf.h
index b80683998635..6e6bb0a96348 100644
--- a/scripts/kconfig/qconf.h
+++ b/scripts/kconfig/qconf.h
@@ -88,10 +88,6 @@ public slots:
 		updateList(NULL);
 		updateAll = false;
 	}
-	ConfigList* listView()
-	{
-		return this;
-	}
 	void addColumn(colIdx idx)
 	{
 		showColumn(idx);
-- 
2.25.1

