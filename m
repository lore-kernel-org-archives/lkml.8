Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C258C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 14:13:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4BD9C2073E
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 14:13:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595859187;
	bh=58KyAkNxzlfX9Tzbg4tc1CYwtIyYcUOiqkzipU7lwEI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=BKsUtEL+G5BWFkgKFjo6HT/9KHYMByhEhJkQNR/xDD5yzcWEtUIL+TrdNKGVqzIQH
	 YCHgaHUCHw2/4v/9JEKvnFq8JoAv46dkZCMvdxUqrTY0Q6I4UhtGAqWpHY39Jeacss
	 IUPdCLPduU2BItU6CJmhxhOz89D23iDCcwKXwwDA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730316AbgG0ONG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 10:13:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:37626 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730293AbgG0OM6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 10:12:58 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BE6E22078E;
        Mon, 27 Jul 2020 14:12:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595859178;
        bh=58KyAkNxzlfX9Tzbg4tc1CYwtIyYcUOiqkzipU7lwEI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rxyej4wjXThZtr9tWWClVKHGrUOeu9GFpkRd+lXoZnC3doQxlftJQay+KhFm+j6lj
         Nb4P+t2Q1zVS0t0nmuOo2/S3kiW1NSxKvuWdES8+Hl/3N6FW6yrFAUNZbQBoDUmKvB
         FjZmKUUPgAojye0OAO0vswqF3feyiupC91s8+NEo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Matthias Kaehlcke <mka@chromium.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Maulik Shah <mkshah@codeaurora.org>
Subject: [PATCH 5.4 001/138] soc: qcom: rpmh: Dirt can only make you dirtier, not cleaner
Date:   Mon, 27 Jul 2020 16:03:16 +0200
Message-Id: <20200727134925.311606227@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200727134925.228313570@linuxfoundation.org>
References: <20200727134925.228313570@linuxfoundation.org>
User-Agent: quilt/0.66
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Douglas Anderson <dianders@chromium.org>

commit 35bb4b22f606c0cc8eedf567313adc18161b1af4 upstream.

Adding an item into the cache should never be able to make the cache
cleaner.  Use "|=" rather than "=" to update the dirty flag.

Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
Reviewed-by: Maulik Shah <mkshah@codeaurora.org> Thanks, Maulik
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Fixes: bb7000677a1b ("soc: qcom: rpmh: Update dirty flag only when data changes")
Reported-by: Stephen Boyd <swboyd@chromium.org>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
Link: https://lore.kernel.org/r/20200417141531.1.Ia4b74158497213eabad7c3d474c50bfccb3f342e@changeid
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/soc/qcom/rpmh.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- a/drivers/soc/qcom/rpmh.c
+++ b/drivers/soc/qcom/rpmh.c
@@ -150,10 +150,10 @@ existing:
 		break;
 	}
 
-	ctrlr->dirty = (req->sleep_val != old_sleep_val ||
-			req->wake_val != old_wake_val) &&
-			req->sleep_val != UINT_MAX &&
-			req->wake_val != UINT_MAX;
+	ctrlr->dirty |= (req->sleep_val != old_sleep_val ||
+			 req->wake_val != old_wake_val) &&
+			 req->sleep_val != UINT_MAX &&
+			 req->wake_val != UINT_MAX;
 
 unlock:
 	spin_unlock_irqrestore(&ctrlr->cache_lock, flags);


