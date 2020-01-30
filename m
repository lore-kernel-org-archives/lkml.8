Return-Path: <SRS0=4zup=3T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD1E6C2D0DB
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 23:08:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CE92214D8
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 23:08:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Cea+74kK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727809AbgA3XIv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jan 2020 18:08:51 -0500
Received: from mail-pl1-f202.google.com ([209.85.214.202]:35155 "EHLO
        mail-pl1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727764AbgA3XIt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 18:08:49 -0500
Received: by mail-pl1-f202.google.com with SMTP id v24so2617626plo.2
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jan 2020 15:08:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=dCX2LQDaoIcwFmYSq3cgmAkx+Exp0YNCPmOsw4OCxis=;
        b=Cea+74kKLR/GteXq64Op60MuNDLPdMizqbgVfNpoWkuF8hmEB2KWidlL87tYLsXrua
         8Xzbo2dCO77srQ679vBOopPPaT5k/SDDfLFgk2PVYP32VYXEliWcHSPQQvW7RJouxHAe
         hc+sUOuQ6TRmwjFRtbnmDP2UOQJ2LzmbdTH38wKl5fTpIu7RcFxSIOf2vAfgqu8CZAVW
         GLEzOaHOLVt2EVc2azlbEU9baY7XraTtjjWlZ/jKsLTm/MLozD7uXkqirkr8AYc/6GXF
         us3u/wuW2oRnrheLqJLro/pS7keuZISgD+5hxQQ9fLdo+8fcCY/HdMmki7Y+kyw+/l1K
         d+6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=dCX2LQDaoIcwFmYSq3cgmAkx+Exp0YNCPmOsw4OCxis=;
        b=R/ZLeLGml1xGy3j3HIbD2mK5dDzpDfG0YJqF46AXx/MTlJMn7Lp1PUPwx9tm/Ri9Gd
         UFqKtNwffg+jvP+Crkti3ong918gwG+3cR+v+sL31Oh8Xh+HkE6jkKkf+WPeggw5xdRF
         0b2+bYZqhmLwX7nQ7oBkKdhDBLLQ1mRQ5mXIXYjVgwWXaxSAhRxh9k86LkKwYikOduZu
         gyNfpDBOFJId+xoy9HSjO8kn5hDQ2VymbTi5Y/FHhUfx22jGWTuqeCGmvzsxRIy6jYQE
         J49UKn4Bibsg+1kD01+VufcPdbp2D57zVLw3lvQbB8Id1Hx9mauXWf1PGJyp513wLtx1
         dAVA==
X-Gm-Message-State: APjAAAUqgVr2EiX+SajRko94UAbbhS5QjnRjdVgbES5zuz6PmEFTh71X
        YJbqYyz7iSrBOQWdB568U9gn1Ro/Q/uPe4tVBYvzFg==
X-Google-Smtp-Source: APXvYqx+2ri6MUmVYy6ptSJgWKOGMVZfjLQX0JTmgMuADBux9koL0KUnaGALzsStF3tXii//z0M3FTNmV1ggHaNXMBaSXw==
X-Received: by 2002:a63:78cf:: with SMTP id t198mr6898466pgc.287.1580425727146;
 Thu, 30 Jan 2020 15:08:47 -0800 (PST)
Date:   Thu, 30 Jan 2020 15:08:12 -0800
In-Reply-To: <20200130230812.142642-1-brendanhiggins@google.com>
Message-Id: <20200130230812.142642-8-brendanhiggins@google.com>
Mime-Version: 1.0
References: <20200130230812.142642-1-brendanhiggins@google.com>
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
Subject: [PATCH v2 7/7] Documentation: Add kunit_shutdown to kernel-parameters.txt
From:   Brendan Higgins <brendanhiggins@google.com>
To:     jdike@addtoit.com, richard@nod.at, anton.ivanov@cambridgegreys.com,
        arnd@arndb.de, keescook@chromium.org, skhan@linuxfoundation.org,
        alan.maguire@oracle.com, yzaikin@google.com, davidgow@google.com,
        akpm@linux-foundation.org, rppt@linux.ibm.com,
        frowand.list@gmail.com
Cc:     gregkh@linuxfoundation.org, sboyd@kernel.org, logang@deltatee.com,
        mcgrof@kernel.org, knut.omang@oracle.com,
        linux-um@lists.infradead.org, linux-arch@vger.kernel.org,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Brendan Higgins <brendanhiggins@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add kunit_shutdown, an option to specify that the kernel shutsdown after
running KUnit tests, to the kernel-parameters.txt documentation.

Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
Reviewed-by: Stephen Boyd <sboyd@kernel.org>
---
 Documentation/admin-guide/kernel-parameters.txt | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index ade4e6ec23e03..522fd8bdec949 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -2054,6 +2054,13 @@
 			0: force disabled
 			1: force enabled
 
+	kunit_shutdown	[KERNEL UNIT TESTING FRAMEWORK] Shutdown kernel after
+			running tests.
+			Default:	(flag not present) don't shutdown
+			poweroff:	poweroff the kernel after running tests
+			halt:		halt the kernel after running tests
+			reboot:		reboot the kernel after running tests
+
 	kvm.ignore_msrs=[KVM] Ignore guest accesses to unhandled MSRs.
 			Default is 0 (don't ignore, but inject #GP)
 
-- 
2.25.0.341.g760bfbb309-goog

