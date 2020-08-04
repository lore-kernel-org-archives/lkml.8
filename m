Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33C9BC433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 20:48:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 13E3620842
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 20:48:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WKeGul3K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728229AbgHDUsK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 16:48:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728203AbgHDUsD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 16:48:03 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 314B8C0617A2
        for <linux-kernel@vger.kernel.org>; Tue,  4 Aug 2020 13:48:02 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id lk11so3141535pjb.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Aug 2020 13:48:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=e9HT6AS5pNuhm0IIEReS4jZdj/HAbOxw73GUYA4oHss=;
        b=WKeGul3KEmcWpYGkwOPuVNB4KHstNGi/6UCVOenRedf0cDpH6p3N89em9zoCkJX65A
         YwY93C9vP5AeXLg6dD+Df8uE9y2uyVPzYuwA+jYo6+NU0T72fcbt0V/T0asicft1AvSa
         99WMuzMxTO67XWoZMW2zQAp8oWB5obGAFel9NIZ1qWvVsujj/eVRbXW05xPYoMBZdRVJ
         cKBW1gC6e9Zl09JEkGwle03eAHNJksK27r3Zb1TfSbk9bwX3QL2530KKioWMzCnfhrjh
         6hNPdTCQEp+UpMnqlccneAqNP9ehdDxEQeDqaV0cQGF5OWhztg1MongG3VrIlfKmdoGk
         yNlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=e9HT6AS5pNuhm0IIEReS4jZdj/HAbOxw73GUYA4oHss=;
        b=PZmYUJ4Cn4Q5i39IB/6/EMcBJm1RW0SFtFcqsC/0D1/6FG8nJDQ9pR4KPN+bf3dUbc
         e9PFIkCyO6IwGMZJas2eHbiwzuUuFmdy6huzAneWJzm3yBWeKte0s/pLtzjmTVMV07NJ
         BLfsTFNjV7UtLFtgawsdlo3aULp7+MqLFfGgg34+UE6c0pv4haYQIktu8mAj/GgOl7YL
         TWH0iJ4XmPdJ+v8yKFCJQ8L6qoEYWC5XO6CRk8R8cwle6QrIHw4M5VgADOYueDgKu/A8
         5ZuSghh9nfrxESKNxMJ7uxVCu+Vuw5bvYIMpSIr7GBqxTLQ25MMK2ZnfPmITccwtW2Bi
         b50w==
X-Gm-Message-State: AOAM531widwF+CVqckd0xmdOuVHT7brhSiBOWFQ+L8EGbw+RtpfrBKhP
        rF1c0wCcFb1qMCrXpDzDXjHGr2RPzyGDB2SVBNeTDg==
X-Google-Smtp-Source: ABdhPJwvVPf58Z+s5F3/exJw2LvrTU9deyzhRpg78+XvTlgNql9h3A7N5TCVgZfFd9nf9/1cES1eS4gEGASc8UKOHawR4Q==
X-Received: by 2002:a17:902:9682:: with SMTP id n2mr87047plp.11.1596574081620;
 Tue, 04 Aug 2020 13:48:01 -0700 (PDT)
Date:   Tue,  4 Aug 2020 13:47:45 -0700
In-Reply-To: <20200804204745.987648-1-brendanhiggins@google.com>
Message-Id: <20200804204745.987648-6-brendanhiggins@google.com>
Mime-Version: 1.0
References: <20200804204745.987648-1-brendanhiggins@google.com>
X-Mailer: git-send-email 2.28.0.163.g6104cc2f0b6-goog
Subject: [PATCH v6 5/5] Documentation: kunit: add a brief blurb about kunit_test_suite
From:   Brendan Higgins <brendanhiggins@google.com>
To:     jdike@addtoit.com, richard@nod.at, anton.ivanov@cambridgegreys.com,
        arnd@arndb.de, keescook@chromium.org, skhan@linuxfoundation.org,
        alan.maguire@oracle.com, yzaikin@google.com, davidgow@google.com,
        akpm@linux-foundation.org, rppt@linux.ibm.com,
        frowand.list@gmail.com
Cc:     gregkh@linuxfoundation.org, sboyd@kernel.org, logang@deltatee.com,
        mcgrof@kernel.org, linux-arch@vger.kernel.org,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Brendan Higgins <brendanhiggins@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a brief blurb saying how and when the kunit_test_suite() macro
works to the usage documentation.

Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
---
 Documentation/dev-tools/kunit/usage.rst | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/dev-tools/kunit/usage.rst b/Documentation/dev-tools/kunit/usage.rst
index 3c3fe8b5feccf..961d3ea3ca19a 100644
--- a/Documentation/dev-tools/kunit/usage.rst
+++ b/Documentation/dev-tools/kunit/usage.rst
@@ -211,6 +211,11 @@ KUnit test framework.
 .. note::
    A test case will only be run if it is associated with a test suite.
 
+``kunit_test_suite(...)`` is a macro which tells the linker to put the specified
+test suite in a special linker section so that it can be run by KUnit either
+after late_init, or when the test module is loaded (depending on whether the
+test was built in or not).
+
 For more information on these types of things see the :doc:`api/test`.
 
 Isolating Behavior
-- 
2.28.0.163.g6104cc2f0b6-goog

