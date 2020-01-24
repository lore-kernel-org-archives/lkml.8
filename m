Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBF03C35242
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 19:46:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3C3A20702
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 19:46:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aCZohpD/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392296AbgAXTqH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 14:46:07 -0500
Received: from mail-pf1-f202.google.com ([209.85.210.202]:46362 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391472AbgAXTqG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 14:46:06 -0500
Received: by mail-pf1-f202.google.com with SMTP id i6so1842071pfa.13
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jan 2020 11:46:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=ysPE3p2XWj7/TrBPX839YWYofjGrv+ukgcnjipDcxD8=;
        b=aCZohpD/BNjKcM0p5BeVlgSIAu0Fky6Y7QlkpQiQf9vAdhay2bbYnRC33O8zXWenq+
         ldnpRcpscbd3/HIraLq4gNlexORFSjxyCzZ5fnQSJWQWyMjVq1dRqRUEo8QXJqBsLe0j
         NoRYG+9BMIPCxApCuMuDLIP7nAfnW0qPG7KJtUvyOLVCD07qjOgpmcGlaGQkWeTgwdE0
         jjLEJyKnRfS4QSNobPBxTCDQmyS/DFHVNHwpALgT3oQ9NYxsuoO3WY9pWVAUZwu+6297
         k+bxm6TQ4QCwfLDJhq3cr+KxSNphoknTX0eoHX99oDIOkWkkv3B3YLhhaGTbEUy/v/8p
         EqUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=ysPE3p2XWj7/TrBPX839YWYofjGrv+ukgcnjipDcxD8=;
        b=pH846WNWJvstPfscBlYeSjRCse9bxfxSJZc5pq91LVJcjHKk0sklDk7fA/PjDYiXMd
         Otg1mA1fmk8pRp/Ub6qLIPghVbfcxNcZsgRbaWsf26Co1zgaZDb+aeR8WcA0Q9vEcIuz
         w5Tu+PH8zEJ6RPC80P7rlERJBFmqbbcg8XnhdzHBKuOcs6HQBtzAE8gZOaJczHuRwHBG
         8fnOfWvhWxy4aWYzxmx2JaOV5VJwXHb1NULSpwDkUmTOvqCeVGuvvWUgZ9os3TiJBPMm
         AGQ4D3bDcD7SjIN5rdYboUcazqVdMhp+T37NtmiDy2F9tY8OdTyGwaoUSp2wxmwt8BB9
         T4sg==
X-Gm-Message-State: APjAAAX1DZhluiFi35KHgrhD6SrQCje4TtDf9VzO9FDxCQ6Ar6bvOIBM
        bF+Kca3+j2kMD1xZUULhCLfV69DH1W2srg==
X-Google-Smtp-Source: APXvYqzTY7ykbizKR0RAfuVrvyVq5J9PCRIf8OWRPAufh0sITlthsUInKorHE/ZIw0kWBpH17bTEoG7KzqkHxg==
X-Received: by 2002:a63:778c:: with SMTP id s134mr5650896pgc.451.1579895165698;
 Fri, 24 Jan 2020 11:46:05 -0800 (PST)
Date:   Fri, 24 Jan 2020 11:45:08 -0800
Message-Id: <20200124194507.34121-1-davidgow@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
Subject: [PATCH] Fix linked-list KUnit test when run multiple times
From:   David Gow <davidgow@google.com>
To:     brendanhiggins@google.com, shuah@kernel.org
Cc:     kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, alan.maguire@oracle.com,
        David Gow <davidgow@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A few of the lists used in the linked-list KUnit tests (the
for_each_entry{,_reverse} tests) are declared 'static', and so are
not-reinitialised if the test runs multiple times. This was not a
problem when KUnit tests were run once on startup, but when tests are
able to be run manually (e.g. from debugfs[1]), this is no longer the
case.

Making these lists no longer 'static' causes the lists to be
reinitialised, and the test passes each time it is run. While there may
be some value in testing that initialising static lists works, the
for_each_entry_* tests are unlikely to be the right place for it.

Signed-off-by: David Gow <davidgow@google.com>
---
 lib/list-test.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/list-test.c b/lib/list-test.c
index 76babb1df889..ee09505df16f 100644
--- a/lib/list-test.c
+++ b/lib/list-test.c
@@ -659,7 +659,7 @@ static void list_test_list_for_each_prev_safe(struct kunit *test)
 static void list_test_list_for_each_entry(struct kunit *test)
 {
 	struct list_test_struct entries[5], *cur;
-	static LIST_HEAD(list);
+	LIST_HEAD(list);
 	int i = 0;
 
 	for (i = 0; i < 5; ++i) {
@@ -680,7 +680,7 @@ static void list_test_list_for_each_entry(struct kunit *test)
 static void list_test_list_for_each_entry_reverse(struct kunit *test)
 {
 	struct list_test_struct entries[5], *cur;
-	static LIST_HEAD(list);
+	LIST_HEAD(list);
 	int i = 0;
 
 	for (i = 0; i < 5; ++i) {
-- 
2.25.0.341.g760bfbb309-goog

