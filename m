Return-Path: <SRS0=xbEg=53=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09A7AC2BBC7
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 12:27:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB18620644
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 12:27:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586608053;
	bh=62LtZvjbBvw3UWpp2SXt19awvHXKGh8lr8tD/vD1OoI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=JWEvReuvlidMZdGjuCNDMWHlVIUdhKzOrC7GP25fFYe207pIlDsTk6o/elJe/RaFu
	 C5CB0Ee/yBZWN9fUPgPJyJmuQ7ln9uA3DgTF1L+j+/dIehsfKRvc3KQ3nTrtIvi1gV
	 NtplQYE9gJ9+18uLprX+ALkjsEAoi6vO7xbuv3bA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727205AbgDKM1c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Apr 2020 08:27:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:47374 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726171AbgDKMOH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Apr 2020 08:14:07 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3DAC82084D;
        Sat, 11 Apr 2020 12:14:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586607247;
        bh=62LtZvjbBvw3UWpp2SXt19awvHXKGh8lr8tD/vD1OoI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Dewa7rJvjq1/2shkDF1sD4p2TLRPIb9lrB4l091zt0WhTS7zvatLsQtzmURyhXXiT
         1n9tkJhNngz6+CwlCTxwCYGH3ayge+bcQyBqKoJIIApcRZSdxVMCkKSITyLeLePTcx
         8auPw410WJvvw1sTaaapm9nV8ryagURpaWCBOJJc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Taniya Das <tdas@codeaurora.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Lee Jones <lee.jones@linaro.org>
Subject: [PATCH 4.14 33/38] clk: qcom: rcg: Return failure for RCG update
Date:   Sat, 11 Apr 2020 14:09:17 +0200
Message-Id: <20200411115441.120293998@linuxfoundation.org>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200411115437.795556138@linuxfoundation.org>
References: <20200411115437.795556138@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Taniya Das <tdas@codeaurora.org>

commit 21ea4b62e1f3dc258001a68da98c9663a9dbd6c7 upstream.

In case of update config failure, return -EBUSY, so that consumers could
handle the failure gracefully.

Signed-off-by: Taniya Das <tdas@codeaurora.org>
Link: https://lkml.kernel.org/r/1557339895-21952-2-git-send-email-tdas@codeaurora.org
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/clk/qcom/clk-rcg2.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/clk/qcom/clk-rcg2.c
+++ b/drivers/clk/qcom/clk-rcg2.c
@@ -112,7 +112,7 @@ static int update_config(struct clk_rcg2
 	}
 
 	WARN(1, "%s: rcg didn't update its configuration.", name);
-	return 0;
+	return -EBUSY;
 }
 
 static int clk_rcg2_set_parent(struct clk_hw *hw, u8 index)


