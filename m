Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1FCEC433E1
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 18:34:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 92E2A20739
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 18:34:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WnQdeME9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729753AbgGFSe5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 14:34:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729550AbgGFSe5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 14:34:57 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 301D6C061755;
        Mon,  6 Jul 2020 11:34:57 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id d10so15666546pls.5;
        Mon, 06 Jul 2020 11:34:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZsEH9GB4QLFFmyWG76IABNXZSgpM1RjJGPOIkiiU5Q8=;
        b=WnQdeME9ikGfZFnhbuUMVks6mz2VLpBoALevc0j7CPEhcQYN286bS4XpydcK3KIL/A
         awCk4zrTgZ4w3satk5FXvtgjmg3uh+V3RhX69Pt3mFNYv0zEuaqLCVE9vkZsgAvNTzD0
         u6NHX0Em7tAyrwQCJDLwa2ubTguYp/xZV51uw2AT9rracGL316Gr/kASQDyEVGiYLdhM
         utGCIW5JoihT2nmRoc9+bFSl78j3eMOsYHjOXvjboIev6X0Eeye1RCzShzO5RUz8gErC
         qD8geN/sdUf2Eo4ofndJsa9AOO9lN8ElNosmnAUqLsizlHCi85WkUF9Gtj8tWdwGG1Xk
         rcVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZsEH9GB4QLFFmyWG76IABNXZSgpM1RjJGPOIkiiU5Q8=;
        b=tyPYdVZv8dYdqMB/9pztOFYCvdHmA77XV2CMa3+1jQ+AJqziKDELzsNX7hZhUAgAqy
         oc5gcITO8YQBsJLjoj9fXWZWe7hFT57s6YXEa8P6FG9hbIWt82Uq2lzWUfAfaaHNg8cz
         mGmWvE/FXKMpVfU3X3kfUk/im7zoNQTiR2cZ4GqfHZrOB6NFdqTLBj+znpGe9gH/KU+f
         R8UCclev/Iw+PwVit7fHfEvWnaq+6BPw/6N2hpYF2ga5aZ7+Uoob68/0HI0NvxfmV7ES
         ISSfJxvYj2jXn4M4wrtUFWya5BDZjzt/NPpbD8fQCTycVYlFZjexuOA9l7XgDSwMmgRq
         o0CQ==
X-Gm-Message-State: AOAM530AdHUBjhL+BN23JSz/h2/1oXGp/n63k4/Ms02HJak2deoUA7kb
        6zGS6Rwvf3CGO49zi0uQlmo=
X-Google-Smtp-Source: ABdhPJw+1lKh2DCfiBPza3tQXTwuS+U7plcQ18oIP0lIgMSa5JofucC0xpLYMXBziaEUk2JeNpL0PQ==
X-Received: by 2002:a17:90a:22ab:: with SMTP id s40mr460587pjc.27.1594060496633;
        Mon, 06 Jul 2020 11:34:56 -0700 (PDT)
Received: from localhost.localdomain ([210.56.100.149])
        by smtp.googlemail.com with ESMTPSA id oc6sm177281pjb.43.2020.07.06.11.34.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2020 11:34:56 -0700 (PDT)
From:   Puranjay Mohan <puranjay12@gmail.com>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Puranjay Mohan <puranjay12@gmail.com>, skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1] Security: Documentation: Replace deprecated :c:func: Usage
Date:   Tue,  7 Jul 2020 00:04:37 +0530
Message-Id: <20200706183437.7239-1-puranjay12@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace :c:func: with ``func()`` as the previous usage is deprecated.
Remove an extra ')' to fix broken cross reference.

Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>
---
V1: Change the subject line and remove deprecated :c:func: usage
---
 Documentation/security/credentials.rst | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/security/credentials.rst b/Documentation/security/credentials.rst
index 282e79feee6a..77b534f61c2a 100644
--- a/Documentation/security/credentials.rst
+++ b/Documentation/security/credentials.rst
@@ -453,9 +453,9 @@ still at this point.
 
 When replacing the group list, the new list must be sorted before it
 is added to the credential, as a binary search is used to test for
-membership.  In practice, this means :c:func:`groups_sort` should be
-called before :c:func:`set_groups` or :c:func:`set_current_groups`.
-:c:func:`groups_sort)` must not be called on a ``struct group_list`` which
+membership.  In practice, this means ``groups_sort()`` should be
+called before ``set_groups()`` or ``set_current_groups()``.
+``groups_sort()`` must not be called on a ``struct group_list`` which
 is shared as it may permute elements as part of the sorting process
 even if the array is already sorted.
 
-- 
2.27.0

