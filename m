Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF162C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 20:32:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B3807206A5
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 20:32:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593462733;
	bh=ndz9JqMuoWKFJXjIUL+1TD9ie22pA9R+CVEVaN8GQd8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=cY9VkygZx3o62kiSIEPW1y8bF3PycFMuHpblQ0oW3VVEGkSvbq4MWN4ZZataqSny1
	 U+MXlrbhBbTekdMhZawXC812YqRbgjBVnMdAi8DCMLcPEwY5Dd5oSkFGSTyv1YoW/+
	 SLiozPm0WRbOuX3VlKbJo3C0xXmJtDslGrPs7dQg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388435AbgF2UcI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 16:32:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:37040 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732472AbgF2TZT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:25:19 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1310B253F3;
        Mon, 29 Jun 2020 15:42:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593445340;
        bh=ndz9JqMuoWKFJXjIUL+1TD9ie22pA9R+CVEVaN8GQd8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SQeTzuYw+sNTeNeLUhyE+n4E+PZP0or0R7Q6JIBxSLpU+7wdrMN2xRruwrATR+ogo
         1m5+vh8fihOUZ/Dlo7i4eLCADEg266KNgQE1BB939+chxbLGCJatcwfZpbk04hJEG3
         1Be7bU9c/MGoEPWgEIFRv80BsI6TVmYhUD+Jzz7k=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Colin Ian King <colin.king@canonical.com>,
        Shuah Khan <shuahkh@osg.samsung.com>,
        Mauro Carvalho Chehab <mchehab@s-opensource.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 4.9 099/191] media: dvb_frontend: initialize variable s with FE_NONE instead of 0
Date:   Mon, 29 Jun 2020 11:38:35 -0400
Message-Id: <20200629154007.2495120-100-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200629154007.2495120-1-sashal@kernel.org>
References: <20200629154007.2495120-1-sashal@kernel.org>
MIME-Version: 1.0
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.229-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.9.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.9.229-rc1
X-KernelTest-Deadline: 2020-07-01T15:39+00:00
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

commit 450694c3b9f47b826a002089c463b9454b4bbe42 upstream.

GIT_AUTHOR_NAME=Colin King
GIT_AUTHOR_EMAIL=colin.king@canonical.com

In a previous commit, we added FE_NONE as an unknown fe_status.
Initialize variable s to FE_NONE instead of the more opaque value 0.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
Reviewed-by: Shuah Khan <shuahkh@osg.samsung.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/media/dvb-core/dvb_frontend.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/dvb-core/dvb_frontend.c b/drivers/media/dvb-core/dvb_frontend.c
index 372057cabea45..3b045298546c7 100644
--- a/drivers/media/dvb-core/dvb_frontend.c
+++ b/drivers/media/dvb-core/dvb_frontend.c
@@ -458,7 +458,7 @@ static int dvb_frontend_swzigzag_autotune(struct dvb_frontend *fe, int check_wra
 
 static void dvb_frontend_swzigzag(struct dvb_frontend *fe)
 {
-	enum fe_status s = 0;
+	enum fe_status s = FE_NONE;
 	int retval = 0;
 	struct dvb_frontend_private *fepriv = fe->frontend_priv;
 	struct dtv_frontend_properties *c = &fe->dtv_property_cache, tmp;
-- 
2.25.1

