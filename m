Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A4C1C43331
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 16:44:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2507820719
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 16:44:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585759498;
	bh=XvHQyiQydphPefD+h6BTBcAHzrhmw4kWpystoqDYjlw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hyPstqKwtj09/nVtAjPISyq6LI+JXuzMmg0h8cUANIH3N79TZ8xN9UlyOysl5q7X/
	 y0sTyWcSc/nnzREMxCUP+T29vtnvdW3vnF5iGT+gD5KiG3NYTIUOaSo4L2XKhRS9GO
	 SiqogcIFULfdW3jEi4IX0957GXXTyBS/BA6lOiEg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389506AbgDAQo4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 12:44:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:46026 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389786AbgDAQoy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 12:44:54 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C32C120719;
        Wed,  1 Apr 2020 16:44:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585759494;
        bh=XvHQyiQydphPefD+h6BTBcAHzrhmw4kWpystoqDYjlw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FmAWbIV539yb03C0gxJmVm/xyCKPHR9hgXcKZ0oCxiGe1ZbrQGIi+V0ADJfK0xj0k
         j19MFhTA5EkCjZC2EM1fkUY2Ewl06b/4yI6e5u1SECuNe2IbS5CzPRXdpbqOEkQhl0
         VRKOP0/U1lVL+wZw0KAKOM9Gntj8sgW8Zww8vZl8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 4.14 097/148] mac80211: mark station unauthorized before key removal
Date:   Wed,  1 Apr 2020 18:18:09 +0200
Message-Id: <20200401161602.187233939@linuxfoundation.org>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200401161552.245876366@linuxfoundation.org>
References: <20200401161552.245876366@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

commit b16798f5b907733966fd1a558fca823b3c67e4a1 upstream.

If a station is still marked as authorized, mark it as no longer
so before removing its keys. This allows frames transmitted to it
to be rejected, providing additional protection against leaking
plain text data during the disconnection flow.

Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20200326155133.ccb4fb0bb356.If48f0f0504efdcf16b8921f48c6d3bb2cb763c99@changeid
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/mac80211/sta_info.c |    6 ++++++
 1 file changed, 6 insertions(+)

--- a/net/mac80211/sta_info.c
+++ b/net/mac80211/sta_info.c
@@ -3,6 +3,7 @@
  * Copyright 2006-2007	Jiri Benc <jbenc@suse.cz>
  * Copyright 2013-2014  Intel Mobile Communications GmbH
  * Copyright (C) 2015 - 2017 Intel Deutschland GmbH
+ * Copyright (C) 2018-2020 Intel Corporation
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
@@ -951,6 +952,11 @@ static void __sta_info_destroy_part2(str
 	might_sleep();
 	lockdep_assert_held(&local->sta_mtx);
 
+	while (sta->sta_state == IEEE80211_STA_AUTHORIZED) {
+		ret = sta_info_move_state(sta, IEEE80211_STA_ASSOC);
+		WARN_ON_ONCE(ret);
+	}
+
 	/* now keys can no longer be reached */
 	ieee80211_free_sta_keys(local, sta);
 


