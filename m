Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EB6DC2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 11:34:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B61321734
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 11:34:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579865660;
	bh=Dt2eASxlKSurFyEQ+Ptqvu0N/ipmPwxfppQ0phlny48=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=s0gFl42wGVktWKzzffrdAgPGCTa3vcPyn5WFcN1e9MKH4XP+zBfS66NqCsjT0ZR9W
	 ssAmFbh4Bh3wubY3dE3PCvAmSoyW+L5zU9uDkZE4gl16iTmMPJjdKKC+7sZxzoq1tb
	 HcXFLPCxf0QItGKBdSBxleuX8z6YQB8UrL46VDYg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404718AbgAXLeT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 06:34:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:54142 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404691AbgAXLeR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 06:34:17 -0500
Received: from localhost (ip-213-127-102-57.ip.prioritytelecom.net [213.127.102.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1442321734;
        Fri, 24 Jan 2020 11:34:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579865656;
        bh=Dt2eASxlKSurFyEQ+Ptqvu0N/ipmPwxfppQ0phlny48=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=B2hYIzRee2BVehU3LlTzc/opM27phQMSugrzTtdCQ+wc4KH6DYw+uuHjR/s7uqy65
         tBNEq/LSUx1UJApv+54LS3j3Kl6j/AVAwvpM9J13j0rT4kqP+3vlbfSj100iPE0gTF
         IWT8NMzWQUp9QQH7mkVyZf8ajZR/kpGOQn0hGS5A=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Alexandra Winter <wintera@linux.ibm.com>,
        Julian Wiedmann <jwi@linux.ibm.com>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 597/639] s390/qeth: Fix initialization of vnicc cmd masks during set online
Date:   Fri, 24 Jan 2020 10:32:47 +0100
Message-Id: <20200124093204.146493671@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200124093047.008739095@linuxfoundation.org>
References: <20200124093047.008739095@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexandra Winter <wintera@linux.ibm.com>

[ Upstream commit be40a86c319706f90caca144343c64743c32b953 ]

Without this patch, a command bit in the supported commands mask is only
ever set to unsupported during set online. If a command is ever marked as
unsupported (e.g. because of error during qeth_l2_vnicc_query_cmds),
subsequent successful initialization (offline/online) would not bring it
back.

Fixes: caa1f0b10d18 ("s390/qeth: add VNICC enable/disable support")
Signed-off-by: Alexandra Winter <wintera@linux.ibm.com>
Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
Signed-off-by: Jakub Kicinski <jakub.kicinski@netronome.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/s390/net/qeth_l2_main.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/s390/net/qeth_l2_main.c b/drivers/s390/net/qeth_l2_main.c
index b9be2c08e8dfa..aa90004f49e28 100644
--- a/drivers/s390/net/qeth_l2_main.c
+++ b/drivers/s390/net/qeth_l2_main.c
@@ -2358,11 +2358,15 @@ static void qeth_l2_vnicc_init(struct qeth_card *card)
 			sup_cmds = 0;
 			error = true;
 		}
-		if (!(sup_cmds & IPA_VNICC_SET_TIMEOUT) ||
-		    !(sup_cmds & IPA_VNICC_GET_TIMEOUT))
+		if ((sup_cmds & IPA_VNICC_SET_TIMEOUT) &&
+		    (sup_cmds & IPA_VNICC_GET_TIMEOUT))
+			card->options.vnicc.getset_timeout_sup |= vnicc;
+		else
 			card->options.vnicc.getset_timeout_sup &= ~vnicc;
-		if (!(sup_cmds & IPA_VNICC_ENABLE) ||
-		    !(sup_cmds & IPA_VNICC_DISABLE))
+		if ((sup_cmds & IPA_VNICC_ENABLE) &&
+		    (sup_cmds & IPA_VNICC_DISABLE))
+			card->options.vnicc.set_char_sup |= vnicc;
+		else
 			card->options.vnicc.set_char_sup &= ~vnicc;
 	}
 	/* enforce assumed default values and recover settings, if changed  */
-- 
2.20.1



