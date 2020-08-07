Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EAA0C433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 19:46:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 464EF2086A
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 19:46:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mfmTGLvw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726191AbgHGTqN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 15:46:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725893AbgHGTqN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 15:46:13 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72002C061756
        for <linux-kernel@vger.kernel.org>; Fri,  7 Aug 2020 12:46:13 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id m34so1445791pgl.11
        for <linux-kernel@vger.kernel.org>; Fri, 07 Aug 2020 12:46:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=UcUw3rxHEgfz/gVgnuf3nAaZlI9+TIiIw4mKTCVHTQc=;
        b=mfmTGLvwVaps0XNQSPnQmtE3IibTJ2pMdtvftT67qGaCfqdQHGIwedAuc+5SDxvZV5
         MHwWMo/f071Ot2nakFejqgbxhRs0VxvsSAQ0VD/S0u9mUa9kIIASfQ3OKW7rQy0fWGQm
         LFEQxqy8L5pvEbQfuYzxC/PO+K9afkWVHqJFw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=UcUw3rxHEgfz/gVgnuf3nAaZlI9+TIiIw4mKTCVHTQc=;
        b=EYUbMt54lxY3vOlkVvAVwYeQzJJOKcMlZAE4QMgvnxFyytqHklcDHp+OTBap/27XWX
         qtK61H6NCv6Azq5/cLXiSS+LWxebQEYonomdfhBsE7WWp6bG5Gt1qq/734z+Wga9/eFT
         AAHbCjtVTIZhzhQGSwd6uJKcamjKnUhdP55Kl7em2iltuIbdW1tX/q2LjWZYBVKAfyiT
         O9hF3Txf0KBLYvWPXnYFcwrAI0qOdaqtVcHVEVePM4YnP5Xe4YCGuF6qFQQ55nC5XixP
         ApxYZ4cVodj5MxQcJyt6Vm5oV0lvICFWeeeNdZBiJDPDq81sKON0jXbUYjSdvnP2juCj
         AFTg==
X-Gm-Message-State: AOAM533j1ejJeYY3BHgFE301TcqTjucbTcMyu9Um5Lv951TCY134FNaY
        prD45K93XQ+S5fcz1xQZZnrq/g==
X-Google-Smtp-Source: ABdhPJyv0vkCMLuJSm3fyYTiYlnyYLFPdNFF9ZXjb00Hoy5yIJJU8zBB1lSt03q2kiyg7XHoTCDhJA==
X-Received: by 2002:a63:1b42:: with SMTP id b2mr12155054pgm.397.1596829572915;
        Fri, 07 Aug 2020 12:46:12 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id k8sm12015188pje.28.2020.08.07.12.46.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2020 12:46:12 -0700 (PDT)
Date:   Fri, 7 Aug 2020 12:46:11 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        "Alex Xu (Hello71)" <alex_y_xu@yahoo.ca>,
        Christian Zigotzky <chzigotzky@xenosoft.de>,
        Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
Subject: [GIT PULL] seccomp update for v5.9-rc1-fix1
Message-ID: <202008071245.B375826@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull this seccomp update for v5.9-rc1-fix1. This fixes my typo in
the SCM_RIGHTS refactoring, thanks to Thadeu Lima de Souza Cascardo for
tracking it down, and to Christian Zigotzky and Alex Xu for their
reports.

Thanks!

-Kees

The following changes since commit 25d8d4eecace9de5a6a2193e4df1917afbdd3052:

  Merge tag 'powerpc-5.9-1' of git://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux (2020-08-07 10:33:50 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/seccomp-v5.9-rc1-fix1

for you to fetch changes up to 16b89f695313d91c99bdaf6898f28a51d0af1b17:

  net/scm: Fix typo in SCM_RIGHTS compat refactoring (2020-08-07 12:43:25 -0700)

----------------------------------------------------------------
Fix SCM_RIGHTS compat mode

----------------------------------------------------------------
Kees Cook (1):
      net/scm: Fix typo in SCM_RIGHTS compat refactoring

 net/compat.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
Kees Cook
