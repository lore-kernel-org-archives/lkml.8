Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AD4EC43461
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 18:07:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 03488207DE
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 18:07:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599588422;
	bh=e9WJCK5h35QdVgPJQzxQpC7m4BWtaGhxmc/XG81Dzhw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wLBy+0hgTaxrfBC10Z0seUpzxMk4bFprzcZ5WkcHgjhjRphjt8OYslT0NOgj7Jpwa
	 DH7X45OfzAg6fj2V+QcKBqK+kz2bJELJVRNidsv7G9UOETZLBFbn4kiMNP2Q0Ga+ez
	 wC2q4vEIMhv+22sJFK/LQx2lce02KPN5iq4HqzWo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732269AbgIHSG5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 14:06:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:55372 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731511AbgIHQLz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 12:11:55 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4A45524744;
        Tue,  8 Sep 2020 15:50:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599580242;
        bh=e9WJCK5h35QdVgPJQzxQpC7m4BWtaGhxmc/XG81Dzhw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QiHU49rS2sTjpK4hXsRfzw/R5M7txcTIr8LCZSmMCjJ+uyFjViFo7ja9VyQnQHNbT
         hs7+Q7RnEjbSBg2MPGY7ORwxS97Xy5+i0pK5ZAYBeHEREojaVCQ0evhwwUW7+RrJW8
         DiUG6iZyYlIh/Kk+O08nNYj5jnEu08O9WAfubrGM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+d451401ffd00a60677ee@syzkaller.appspotmail.com,
        Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 4.19 87/88] cfg80211: regulatory: reject invalid hints
Date:   Tue,  8 Sep 2020 17:26:28 +0200
Message-Id: <20200908152225.559306868@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200908152221.082184905@linuxfoundation.org>
References: <20200908152221.082184905@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

commit 47caf685a6854593348f216e0b489b71c10cbe03 upstream.

Reject invalid hints early in order to not cause a kernel
WARN later if they're restored to or similar.

Reported-by: syzbot+d451401ffd00a60677ee@syzkaller.appspotmail.com
Link: https://syzkaller.appspot.com/bug?extid=d451401ffd00a60677ee
Link: https://lore.kernel.org/r/20200819084648.13956-1-johannes@sipsolutions.net
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/wireless/reg.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/net/wireless/reg.c
+++ b/net/wireless/reg.c
@@ -2936,6 +2936,9 @@ int regulatory_hint_user(const char *alp
 	if (WARN_ON(!alpha2))
 		return -EINVAL;
 
+	if (!is_world_regdom(alpha2) && !is_an_alpha2(alpha2))
+		return -EINVAL;
+
 	request = kzalloc(sizeof(struct regulatory_request), GFP_KERNEL);
 	if (!request)
 		return -ENOMEM;


