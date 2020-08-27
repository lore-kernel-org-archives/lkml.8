Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF21FC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 03:12:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 955C62076C
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 03:12:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726871AbgH0DMF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 23:12:05 -0400
Received: from smtprelay0227.hostedemail.com ([216.40.44.227]:36230 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726798AbgH0DMF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 23:12:05 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id C59B21802DA53;
        Thu, 27 Aug 2020 03:12:03 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: meal91_421740e27069
X-Filterd-Recvd-Size: 2732
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf08.hostedemail.com (Postfix) with ESMTPA;
        Thu, 27 Aug 2020 03:12:02 +0000 (UTC)
Message-ID: <5e10c1645dd8f735215cf54a74db0f8dd3f6cbd5.camel@perches.com>
Subject: [PATCH] deprecated.rst: Remove now removed uninitialized_var
From:   Joe Perches <joe@perches.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-doc <linux-doc@vger.kernel.org>
Date:   Wed, 26 Aug 2020 20:12:01 -0700
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's now gone from the kernel so remove it from the deprecated API text.

Signed-off-by: Joe Perches <joe@perches.com>
---
 Documentation/process/deprecated.rst | 18 ------------------
 1 file changed, 18 deletions(-)

diff --git a/Documentation/process/deprecated.rst b/Documentation/process/deprecated.rst
index 918e32d76fc4..70720f00b9aa 100644
--- a/Documentation/process/deprecated.rst
+++ b/Documentation/process/deprecated.rst
@@ -51,24 +51,6 @@ to make sure their systems do not continue running in the face of
 "unreachable" conditions. (For example, see commits like `this one
 <https://git.kernel.org/linus/d4689846881d160a4d12a514e991a740bcb5d65a>`_.)
 
-uninitialized_var()
--------------------
-For any compiler warnings about uninitialized variables, just add
-an initializer. Using the uninitialized_var() macro (or similar
-warning-silencing tricks) is dangerous as it papers over `real bugs
-<https://lore.kernel.org/lkml/20200603174714.192027-1-glider@google.com/>`_
-(or can in the future), and suppresses unrelated compiler warnings
-(e.g. "unused variable"). If the compiler thinks it is uninitialized,
-either simply initialize the variable or make compiler changes. Keep in
-mind that in most cases, if an initialization is obviously redundant,
-the compiler's dead-store elimination pass will make sure there are no
-needless variable writes.
-
-As Linus has said, this macro
-`must <https://lore.kernel.org/lkml/CA+55aFw+Vbj0i=1TGqCR5vQkCzWJ0QxK6CernOU6eedsudAixw@mail.gmail.com/>`_
-`be <https://lore.kernel.org/lkml/CA+55aFwgbgqhbp1fkxvRKEpzyR5J8n1vKT1VZdz9knmPuXhOeg@mail.gmail.com/>`_
-`removed <https://lore.kernel.org/lkml/CA+55aFz2500WfbKXAx8s67wrm9=yVJu65TpLgN_ybYNv0VEOKA@mail.gmail.com/>`_.
-
 open-coded arithmetic in allocator arguments
 --------------------------------------------
 Dynamic size calculations (especially multiplication) should not be


