Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 752C8C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 12:31:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 379A5207DA
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 12:31:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597926718;
	bh=ujjmrEC6yLqifjsXw+51ksnycUu8RYHEvep7NS0yCZI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=aQcYQYEToff4rfFWuZ3gfQumxZ3NxmXKz6h6FbAR6cOpX9Q9qW6nL9X2ZVX7ZMvAh
	 NYRJiyvWCvEQR4p4A92c+nf0OK2nkqZdhV+l6L7aWSzvD+fIqp5ZafO8P4NBA0YcwI
	 4a8JoER/OFrIOXk5cRhKBB++6cP0nrdDJaS/OpW0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730234AbgHTMb4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 08:31:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:57540 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729712AbgHTJuO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 05:50:14 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EE7A72224D;
        Thu, 20 Aug 2020 09:50:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597917014;
        bh=ujjmrEC6yLqifjsXw+51ksnycUu8RYHEvep7NS0yCZI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GMr30xdqLj5SJO5/1y5rXTqZ4+0bCkGcsSQKPUFSL1zFEORWQuJsPMAREEcihyLKj
         Z4YVeRSihGoGqHjTrXxLXqVbZG0kj98pX0e6Tz+MhyzHBfzpeHYjBTtxd96nmdLLF3
         zpTKIVW9FlMGT6uSCmiLzwKus4i+eo2OqVqy5xs4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Colin Ian King <colin.king@canonical.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 126/152] Input: sentelic - fix error return when fsp_reg_write fails
Date:   Thu, 20 Aug 2020 11:21:33 +0200
Message-Id: <20200820091600.256616070@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200820091553.615456912@linuxfoundation.org>
References: <20200820091553.615456912@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

[ Upstream commit ea38f06e0291986eb93beb6d61fd413607a30ca4 ]

Currently when the call to fsp_reg_write fails -EIO is not being returned
because the count is being returned instead of the return value in retval.
Fix this by returning the value in retval instead of count.

Addresses-Coverity: ("Unused value")
Fixes: fc69f4a6af49 ("Input: add new driver for Sentelic Finger Sensing Pad")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
Link: https://lore.kernel.org/r/20200603141218.131663-1-colin.king@canonical.com
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/input/mouse/sentelic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/mouse/sentelic.c b/drivers/input/mouse/sentelic.c
index e99d9bf1a267d..e78c4c7eda34d 100644
--- a/drivers/input/mouse/sentelic.c
+++ b/drivers/input/mouse/sentelic.c
@@ -441,7 +441,7 @@ static ssize_t fsp_attr_set_setreg(struct psmouse *psmouse, void *data,
 
 	fsp_reg_write_enable(psmouse, false);
 
-	return count;
+	return retval;
 }
 
 PSMOUSE_DEFINE_WO_ATTR(setreg, S_IWUSR, NULL, fsp_attr_set_setreg);
-- 
2.25.1



