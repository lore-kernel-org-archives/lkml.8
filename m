Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD295C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 10:48:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 75D4F20724
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 10:48:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597920515;
	bh=oSg29O4EE7wm26TO9QUIlPQlcXSOZytFhnc5IbOB+N4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=DT1L/SuwuEltjtpW5aQmJy65UiZNCqEMRM+qvwii/HDEa7ZbvlTJh1k3lR92MFqkJ
	 hWKVNEnhIFKxjvOvKmLwKAPDTmUgXPsDcEynqpfamlCzjJ2XPYoftS6Ujr5f7Sx49A
	 hlJglSMjSb79BITO47UNAlq5l2V7WdebQJ7tTW18=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731874AbgHTKse (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 06:48:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:35470 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731131AbgHTKPs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 06:15:48 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5FDD120658;
        Thu, 20 Aug 2020 10:15:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597918547;
        bh=oSg29O4EE7wm26TO9QUIlPQlcXSOZytFhnc5IbOB+N4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yz2NqkOhOX/sJJECVK8/kSVfHOskx2+0cjr7c5HnB7w6gn0I/96MtbPSrg3MeArEF
         bh5AM3aSkEiTLbTM6m0b7WSH4pBP6M5VEQPFq/HGKl/i3GePeKBXWeiPQJ0TFWP+bi
         G78nY3CkqT3LJaJJOg1B4oM3rdhJD1XSiGrh57/o=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Colin Ian King <colin.king@canonical.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 209/228] Input: sentelic - fix error return when fsp_reg_write fails
Date:   Thu, 20 Aug 2020 11:23:04 +0200
Message-Id: <20200820091617.974620449@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200820091607.532711107@linuxfoundation.org>
References: <20200820091607.532711107@linuxfoundation.org>
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
index 11c32ac8234b2..779d0b9341c0d 100644
--- a/drivers/input/mouse/sentelic.c
+++ b/drivers/input/mouse/sentelic.c
@@ -454,7 +454,7 @@ static ssize_t fsp_attr_set_setreg(struct psmouse *psmouse, void *data,
 
 	fsp_reg_write_enable(psmouse, false);
 
-	return count;
+	return retval;
 }
 
 PSMOUSE_DEFINE_WO_ATTR(setreg, S_IWUSR, NULL, fsp_attr_set_setreg);
-- 
2.25.1



