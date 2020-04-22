Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ACC4C55186
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 10:16:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F25D32084D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 10:16:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587550608;
	bh=UIBcd+yZ43da0Fg8DCYkAQjetLwbCFsNSrD+YwNNLmg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=UeNw2nEw7O+nVFoWu8H9VlW2e+G5NBzyq8WO7ItMQQttpMhIbSfmtnJKEB7sDfT5D
	 jsMOqnggFQqnyVPncDAdXOxNbM0kJsjiA49KH+FNz3pfd7D5Y3ReZ78tiTopUUen9Q
	 9v4yhCkVgFWyIQYAWPHMo4ZJcucixC2z8CzSMSJ4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729774AbgDVKQq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 06:16:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:51496 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729740AbgDVKPy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 06:15:54 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6D49620575;
        Wed, 22 Apr 2020 10:15:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587550553;
        bh=UIBcd+yZ43da0Fg8DCYkAQjetLwbCFsNSrD+YwNNLmg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=c0RVi1CK1HuZnYCzgUcTpxIJaTvNrhRTaymUqUZ4ZUHuVTlhj2snj4d0PWr/LbvkF
         C1BXajcxBYB8gPnnYBjnr7n6STqrx1EX8bjW3qXejCug/yuyxYF0SKVLnj/3vehels
         vNPYTcpYtdhKhRcJ5ERM5nD8oWizuu9BLaqBBZ6M=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, "Erhard F." <erhard_f@mailbox.org>,
        Frank Rowand <frank.rowand@sony.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH 4.19 11/64] of: unittest: kmemleak on changeset destroy
Date:   Wed, 22 Apr 2020 11:56:55 +0200
Message-Id: <20200422095014.643788327@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200422095008.799686511@linuxfoundation.org>
References: <20200422095008.799686511@linuxfoundation.org>
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
@@ -772,6 +772,10 @@ static void __init of_unittest_changeset
 	unittest(!of_changeset_revert(&chgset), "revert failed\n");
 
 	of_changeset_destroy(&chgset);
+
+	of_node_put(n1);
+	of_node_put(n2);
+	of_node_put(n21);
 #endif
 }
 


