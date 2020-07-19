Return-Path: <SRS0=EKp2=A6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F52CC433E3
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jul 2020 00:27:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B6C3208B3
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jul 2020 00:27:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ypCsSJNj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726589AbgGSA1t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Jul 2020 20:27:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726242AbgGSA1t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jul 2020 20:27:49 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E04D7C0619D2
        for <linux-kernel@vger.kernel.org>; Sat, 18 Jul 2020 17:27:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=Ytkx/iABdWSM1OWWt77vJCDOzuRIDi0fCU44Zd9lt/Y=; b=ypCsSJNjoGhGqYIsbAvJrsww3d
        zMcu0eGsxT63gAQNKl177O4oMjxLez0Z5zbDqWy+pV9DvMgEl+dviVOYgoTz48NnjKPH5KkF3f1Ck
        Ba4opGFois6UiRk3cGhoQ92TgcEV9P8NsRdoWLKdip3cPj3abdt/5EWHwAtu6hhI/GyAzYTKV6JS0
        oWpAfPzmDLKhfsimeZDWpcGw/s54TyfrF9m0IOVHhp6Uo1+gPZ6V5TYdhHaw8fe47AVCV5xHk2UhJ
        4J6FAv5S006YeINBpgv7NL3hYlKgTwt+RuVCxmVIVndiBN4j2YC5IOjBHKqO/85tjwsiolNVo0iwp
        nOYw/oUQ==;
Received: from [2601:1c0:6280:3f0::19c2] (helo=smtpauth.infradead.org)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jwxB9-0002Vh-Uq; Sun, 19 Jul 2020 00:27:44 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <christian@brauner.io>,
        Hridya Valsaraju <hridya@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        devel@driverdev.osuosl.org
Subject: [PATCH] android: binder.h: drop a duplicated word
Date:   Sat, 18 Jul 2020 17:27:38 -0700
Message-Id: <20200719002738.20210-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop the repeated word "the" in a comment.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Arve Hjønnevåg <arve@android.com>
Cc: Todd Kjos <tkjos@android.com>
Cc: Martijn Coenen <maco@android.com>
Cc: Joel Fernandes <joel@joelfernandes.org>
Cc: Christian Brauner <christian@brauner.io>
Cc: Hridya Valsaraju <hridya@google.com>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: devel@driverdev.osuosl.org
---
 include/uapi/linux/android/binder.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20200717.orig/include/uapi/linux/android/binder.h
+++ linux-next-20200717/include/uapi/linux/android/binder.h
@@ -404,7 +404,7 @@ enum binder_driver_return_protocol {
 
 	BR_FAILED_REPLY = _IO('r', 17),
 	/*
-	 * The the last transaction (either a bcTRANSACTION or
+	 * The last transaction (either a bcTRANSACTION or
 	 * a bcATTEMPT_ACQUIRE) failed (e.g. out of memory).  No parameters.
 	 */
 };
