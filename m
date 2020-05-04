Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 922B9C3A5A9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 17:46:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C9E0206A4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 17:46:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="OPD0Xtwa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730394AbgEDRqw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 13:46:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729667AbgEDRqw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 13:46:52 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 443F5C061A0E
        for <linux-kernel@vger.kernel.org>; Mon,  4 May 2020 10:46:52 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id 7so110782pjo.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 May 2020 10:46:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :content-transfer-encoding;
        bh=gt27CLurvYsK7qkWUdWOy6wuN6djEE1cyv2+umNLdkI=;
        b=OPD0XtwaaTz+TwDb5S2Ga3A9WGt7H977EIyB2Mafk4tVLlj1upGyCin1tsVAn0QnWg
         cwUgKrJn9xecbT06PIrxsRHkxuigdwYITA5cPTBxtPF9aznwrRn6aevPRBWIVw6/2e+n
         xneS7YhQ7CK2mXy+JN0quWUBZZF5EF3rhcMJU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding;
        bh=gt27CLurvYsK7qkWUdWOy6wuN6djEE1cyv2+umNLdkI=;
        b=f6LsvqCV7vbSlChTqsN+b9nYDEcXn0kazULf+o8Htk7hX1kZFR8Q2DHGW3G4uD2U7i
         gpSRb8BWjZG8XLbropxeo3QhQkegIXl7LvHQCaUID8K6IorJSZDCRWkHJm2yb2+97Zqy
         IggdTXQ9v8WUT+RW540mqJ3YWniVQ9K3gBzBXStWErBYQCs4dtseJbUqZEAKvjuv3vnV
         zYLBh9v4gOGdy5Lj5VJEHKvy8sZ0TtA0B22NDHrFltAhbjBbzZr1YIPRzWCJUWW7mAWI
         rR7InoiJimTQfoO+rliWxtOjcHSfUeo6LZr7FQOTBCn60MOv84KThpKOD2/WFG2pHkMg
         iDEQ==
X-Gm-Message-State: AGi0Pub4LiFwczoohBZLG9GFfCO2fHggdZc7ZPavthzqPlokABRh7yWC
        wawFLIaS/y4QvudRe3lhT3831tb0cyI=
X-Google-Smtp-Source: APiQypIr927pMvZ40rFFE8e3cKWdt2STWcPYwJMQ9H7kZsorAAdojehUHsHyF0v+Tl7SaxB6g3a+Sw==
X-Received: by 2002:a17:902:82c6:: with SMTP id u6mr373243plz.146.1588614411839;
        Mon, 04 May 2020 10:46:51 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id t23sm91508pji.32.2020.05.04.10.46.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2020 10:46:51 -0700 (PDT)
Date:   Mon, 4 May 2020 10:46:49 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        =?iso-8859-1?Q?Fr=E9d=E9ric?= Pierret 
        <frederic.pierret@qubes-os.org>
Subject: [GIT PULL] gcc-plugins fixes for v5.7-rc5
Message-ID: <202005041045.BC2557B6@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull these gcc-plugins fixes for v5.7-rc5. These are some more
clean-ups for using the plugins under GCC 10.

Thanks!

-Kees

The following changes since commit 8f3d9f354286745c751374f5f1fcafee6b3f3136:

  Linux 5.7-rc1 (2020-04-12 12:35:55 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/gcc-plugins-v5.7-rc5

for you to fetch changes up to c7527373fe28f97d8a196ab562db5589be0d34b9:

  gcc-common.h: Update for GCC 10 (2020-04-13 10:19:20 -0700)

----------------------------------------------------------------
GCC 10 fixes for gcc-plugins

- Adjust caller of cgraph_create_edge for GCC 10 argument usage
- Update common headers to build under GCC 10 (Frédéric Pierret)

----------------------------------------------------------------
Frédéric Pierret (fepitre) (1):
      gcc-common.h: Update for GCC 10

Kees Cook (1):
      gcc-plugins/stackleak: Avoid assignment for unused macro argument

 scripts/gcc-plugins/Makefile           | 1 +
 scripts/gcc-plugins/gcc-common.h       | 4 ++++
 scripts/gcc-plugins/stackleak_plugin.c | 5 ++---
 3 files changed, 7 insertions(+), 3 deletions(-)

-- 
Kees Cook
