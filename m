Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A02FC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 21:10:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E14C7206BE
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 21:10:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QoyX5QkL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726532AbgFZVKQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 17:10:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726370AbgFZVJf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 17:09:35 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2248DC08C5E1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 14:09:34 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id 16so7525027qka.15
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 14:09:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=hVa5/5YjHA4HA55L6gqApWSV/fHdhhYIjiCaFnqYV3g=;
        b=QoyX5QkLkeZufbY3DPWqVcx8p1G2Pf6aerfPyt2zQE/ujAwEYOP4MavORdpoC0kiKu
         EBTjnDggRXo0KQe45lMKlqgesoVoq2M/WZaVEKYilzw17KOXTZudXtu6crQek7qlLud6
         wgqfeApVUIS2o9DKhJa1hfmORSYPYOqHxCziPwrSa4G+57ASkLll7CukI9nktN3Owv9v
         NukYDAxu7zl52PVDoi+7jdhfKkThnizMJ68rg/tVzgIVSHiP3aAKWELQxmH03U/bRKpt
         6Wgu+YeU85Wm8LsbzjbD34Ud+5/9JGpyI65sawIxfi18MEFZnvGjX41U/bIx6IVwD7H1
         RvYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=hVa5/5YjHA4HA55L6gqApWSV/fHdhhYIjiCaFnqYV3g=;
        b=aJ2FTHJEqJ/l3yN1EGFbn9MGKGj8GvZLJI9Mu8iU8czI2WXGPcteojMwb2YrkOGBj5
         ZS0RQugyrKf99FjrLqtpiUrAYq1AGZW3iXzSR0bugbN6RCO27Xs5iCWREAfw1s04XVD3
         3FWhYLC20tqAQCeD9CYy3UhOTb0MVR8GNZZACTRnz8W8eFxKqByiiwISBQuMeQd43oX+
         FCnWHt2SY/tCjx/8pwqNNYrYpacbd8zzjmCsfWx6D+eQl340DWwjhRc/eqzeg5cAgfMd
         BRHysjJjRZwHOgiEagCfcGmP4Z/Ys09gvAWOwi4t6sS2rfw+edi8UR5NJ9lp9lFB94KT
         l6sw==
X-Gm-Message-State: AOAM530QjM3Q4ASRdt7f6wKHkedzVE97aFsYNXti6Og5by88MyLBD5i4
        29gK3B06dSmbg/zerxIwAapw/SeYNLMA4Jy3sXIzbA==
X-Google-Smtp-Source: ABdhPJypYrK6iZse6cCSs4YnSv2AzXM6d8Vad2NCnBdBrfM4NUTiqCIXIvHzUdHQAv3Yb81UEf64dXgB2cs8yGqX9AXtcw==
X-Received: by 2002:a0c:8e8c:: with SMTP id x12mr5032791qvb.55.1593205773222;
 Fri, 26 Jun 2020 14:09:33 -0700 (PDT)
Date:   Fri, 26 Jun 2020 14:09:10 -0700
In-Reply-To: <20200626210917.358969-1-brendanhiggins@google.com>
Message-Id: <20200626210917.358969-6-brendanhiggins@google.com>
Mime-Version: 1.0
References: <20200626210917.358969-1-brendanhiggins@google.com>
X-Mailer: git-send-email 2.27.0.212.ge8ba1cc988-goog
Subject: [PATCH v5 05/12] arch: um: add linker section for KUnit test suites
From:   Brendan Higgins <brendanhiggins@google.com>
To:     jdike@addtoit.com, richard@nod.at, anton.ivanov@cambridgegreys.com,
        arnd@arndb.de, keescook@chromium.org, skhan@linuxfoundation.org,
        alan.maguire@oracle.com, yzaikin@google.com, davidgow@google.com,
        akpm@linux-foundation.org, rppt@linux.ibm.com,
        frowand.list@gmail.com, catalin.marinas@arm.com, will@kernel.org,
        monstr@monstr.eu, mpe@ellerman.id.au, benh@kernel.crashing.org,
        paulus@samba.org, chris@zankel.net, jcmvbkbc@gmail.com
Cc:     gregkh@linuxfoundation.org, sboyd@kernel.org, logang@deltatee.com,
        mcgrof@kernel.org, linux-um@lists.infradead.org,
        linux-arch@vger.kernel.org, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, linux-xtensa@linux-xtensa.org,
        Brendan Higgins <brendanhiggins@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a linker section to UML where KUnit can put references to its test
suites. This patch is an early step in transitioning to dispatching all
KUnit tests from a centralized executor rather than having each as its
own separate late_initcall.

Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
Reviewed-by: Stephen Boyd <sboyd@kernel.org>
---
 arch/um/include/asm/common.lds.S | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/um/include/asm/common.lds.S b/arch/um/include/asm/common.lds.S
index eca6c452a41bd..9a9c97f45694c 100644
--- a/arch/um/include/asm/common.lds.S
+++ b/arch/um/include/asm/common.lds.S
@@ -52,6 +52,10 @@
 	CON_INITCALL
   }
 
+  .kunit_test_suites : {
+	KUNIT_TEST_SUITES
+  }
+
   .exitcall : {
 	__exitcall_begin = .;
 	*(.exitcall.exit)
-- 
2.27.0.212.ge8ba1cc988-goog

