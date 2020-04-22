Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED00DC55189
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 10:38:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C76052073A
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 10:38:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587551910;
	bh=qf2dcxdlSyp8hF1Man+929JVoDmyuznROXXiamjfelU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=dIN9jXt1F5fjRW9FoZMfCNQQa0QMHZqV9rRWMUGsUh9ZU2hHnzbqAf2LnWGwLF0ww
	 hTM+VN232hJr80WJ+vwfslK8kFnyruUxc9j1zsHQXi08fFXolaOiP/rmYQ8HMYvfk6
	 YciwXB7YbUsjUxr7sE5vwmkxr8jTT1RVo7Qb+Vdw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731476AbgDVKia (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 06:38:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:58434 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729922AbgDVKWG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 06:22:06 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9D3622084D;
        Wed, 22 Apr 2020 10:22:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587550921;
        bh=qf2dcxdlSyp8hF1Man+929JVoDmyuznROXXiamjfelU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0SArciEdBcH5Tjk59Uz/gxC12j+VRGXnwZ8p35x/bbPY9Uxge1Oxta5SwaZh1LVIE
         ILzmvtOK60/JQrjOEJ8n2tV1b2WVhNreOhi9KNrDJ37vSJDCN042QXh9fmDapJmLzq
         4i31qH24ePutD9tYBB0TjPf8vnFmZ6+DOdfcmumQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, "Erhard F." <erhard_f@mailbox.org>,
        Frank Rowand <frank.rowand@sony.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH 5.6 021/166] of: unittest: kmemleak on changeset destroy
Date:   Wed, 22 Apr 2020 11:55:48 +0200
Message-Id: <20200422095050.780723107@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200422095047.669225321@linuxfoundation.org>
References: <20200422095047.669225321@linuxfoundation.org>
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
@@ -777,6 +777,10 @@ static void __init of_unittest_changeset
 	unittest(!of_changeset_revert(&chgset), "revert failed\n");
 
 	of_changeset_destroy(&chgset);
+
+	of_node_put(n1);
+	of_node_put(n2);
+	of_node_put(n21);
 #endif
 }
 


