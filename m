Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0BC1C55185
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 11:01:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C6C92076E
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 11:01:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587553263;
	bh=MlK/zlRV4Vbr+VBF6tClXVnQyWd7bATBm1JqPTpxmts=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=bpzqlN7CfN/hSZIScKN2mUAiRdYbzmz+2qLAhOPATczIugoCngQOfKjQHMZyO07st
	 fL4IA9Kyn/jCGcc8gnvqHWRLixx89MsW+/KCt2pBf1KNeF3xWNjDeDkdKxUg/SUHjD
	 nPj+tzuELZwCtIq56RUPfzxh2JbxrxT/3oETmlvE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732336AbgDVLBC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 07:01:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:50362 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726841AbgDVKBo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 06:01:44 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4658720735;
        Wed, 22 Apr 2020 10:01:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587549703;
        bh=MlK/zlRV4Vbr+VBF6tClXVnQyWd7bATBm1JqPTpxmts=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vDwZ8Sqo6zZj5plH6QQKaJ4uvOOYgbYyvjPrkza9YB5jObopPxYQQrkiOwackRqr1
         ISLuLbAF6z0DNvW11XxSmhSHT13kywLPTgkaQ/063Da98RNxf7Q2LUNkfcT6q9k5y3
         mdsFdz78kYzTYG6q+wqSKZzaqLSRXkeeKQ9r9Fzs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, "Erhard F." <erhard_f@mailbox.org>,
        Frank Rowand <frank.rowand@sony.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH 4.4 073/100] of: unittest: kmemleak on changeset destroy
Date:   Wed, 22 Apr 2020 11:56:43 +0200
Message-Id: <20200422095036.308047614@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200422095022.476101261@linuxfoundation.org>
References: <20200422095022.476101261@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frank Rowand <frank.rowand@sony.com>

commit b3fb36ed694b05738d45218ea72cf7feb10ce2b1 upstream.

kmemleak reports several memory leaks from devicetree unittest.
This is the fix for problem 1 of 5.

of_unittest_changeset() reaches deeply into the dynamic devicetree
functions.  Several nodes were left with an elevated reference
count and thus were not properly cleaned up.  Fix the reference
counts so that the memory will be freed.

Fixes: 201c910bd689 ("of: Transactional DT support.")
Reported-by: Erhard F. <erhard_f@mailbox.org>
Signed-off-by: Frank Rowand <frank.rowand@sony.com>
Signed-off-by: Rob Herring <robh@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/of/unittest.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/drivers/of/unittest.c
+++ b/drivers/of/unittest.c
@@ -544,6 +544,10 @@ static void __init of_unittest_changeset
 	mutex_unlock(&of_mutex);
 
 	of_changeset_destroy(&chgset);
+
+	of_node_put(n1);
+	of_node_put(n2);
+	of_node_put(n21);
 #endif
 }
 


