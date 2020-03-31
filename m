Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FCD7C2D0EE
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 09:16:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2607208E0
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 09:15:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585646159;
	bh=vyN0q/Mby/jKTZE4uf+PFH1Dn406yt9qQeu/2DXlDMI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=e2oU2pTVR8VVdT4a1LDP2bwBa67NFC2dS6R/7/8xA7U6pq8lqOUIAr4YEdRvpqaap
	 gc6djoNX9VTHFdraXCXhLuNtyuTpmkylWF5FD4ldS85DHmjyM7IAZ1R7sHuqiUXXoZ
	 2SelPeBQv6fLVrpmQUddynhZKh+yps74fT/3pg0A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731938AbgCaJP6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 05:15:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:36448 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726299AbgCaJPx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 05:15:53 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 289D0208E0;
        Tue, 31 Mar 2020 09:15:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585646152;
        bh=vyN0q/Mby/jKTZE4uf+PFH1Dn406yt9qQeu/2DXlDMI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=g4P7QpLzg8LFnW6zX5fydpsFY9zb3Rr9ApKDViSWdTPAzdjUGtFPnfHF0oS9GX7Zu
         weHiyK/mFFOm3dJSL3Wn0uONfVYcvdkWDJzlHGAe5y2h+RZxhxM4LxW7AnbfNjKz5y
         o/umQMoaTY/i5oECv9sSysch8V04DFcP3rjIVsWA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 5.4 099/155] mac80211: mark station unauthorized before key removal
Date:   Tue, 31 Mar 2020 10:58:59 +0200
Message-Id: <20200331085429.618753498@linuxfoundation.org>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200331085418.274292403@linuxfoundation.org>
References: <20200331085418.274292403@linuxfoundation.org>
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
 net/mac80211/sta_info.c |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

--- a/net/mac80211/sta_info.c
+++ b/net/mac80211/sta_info.c
@@ -4,7 +4,7 @@
  * Copyright 2006-2007	Jiri Benc <jbenc@suse.cz>
  * Copyright 2013-2014  Intel Mobile Communications GmbH
  * Copyright (C) 2015 - 2017 Intel Deutschland GmbH
- * Copyright (C) 2018-2019 Intel Corporation
+ * Copyright (C) 2018-2020 Intel Corporation
  */
 
 #include <linux/module.h>
@@ -1032,6 +1032,11 @@ static void __sta_info_destroy_part2(str
 	might_sleep();
 	lockdep_assert_held(&local->sta_mtx);
 
+	while (sta->sta_state == IEEE80211_STA_AUTHORIZED) {
+		ret = sta_info_move_state(sta, IEEE80211_STA_ASSOC);
+		WARN_ON_ONCE(ret);
+	}
+
 	/* now keys can no longer be reached */
 	ieee80211_free_sta_keys(local, sta);
 


