Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ED21C33C99
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 04:47:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F36FD2072E
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 04:47:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="QTRXwB6i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731332AbgAJErA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 23:47:00 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:35387 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731311AbgAJEq7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 23:46:59 -0500
Received: by mail-pl1-f193.google.com with SMTP id g6so370705plt.2
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jan 2020 20:46:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=mmwQ7jPGKNwbOPltHO8M7g65UjLbnBZQNHg3JNc9VhM=;
        b=QTRXwB6iSVj/CEg1r/7arrXLz5AJzSMRf0EzOyAby3vYzJJLgnRfHIxeICLoS0dBvQ
         dZmYHrRYL6qOoIRT2LfDGo2sw5uMaTBZTHQFkKud+ghd+pSgo8cAsLqi7erC28PGfFDc
         d9+xaLpocIfKhN5JMTE04HOaVWZJyhPh75k64=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=mmwQ7jPGKNwbOPltHO8M7g65UjLbnBZQNHg3JNc9VhM=;
        b=ot2tdHfGjjHm5RzBZozUshsOgSpAinBA+k+EwpkOlFAWWwuZ/SjIkXtNi/r880BE4b
         ikTudNenH7nOLueliS3T/DMic+nRraJzoCUt8+8iLOQo3FRcnmSGzNFAH6ouONHL81Jo
         sTBwnAeFIsL/jIgAum67gyoFu6F7EAsbXf0U+UprJzY8wiH0LMFs1xzuZXsNEODIwKem
         2Umda72jetsL+qhW37Fp7NPDIQSxDG+CCMVyltylx87cConO1YfH58rAmXwUpZibdNGp
         Na1uSb0Xo4l5aRz3yjLAlukKJEbdh4T9GShHBKUlqXiXCVDO/3nycYu3bquhWeL6xPXC
         RAnQ==
X-Gm-Message-State: APjAAAWMDGM6j/dmrmYrj1hkWjIZA2rgx6dw5mR76KTm/0qWvy8Yv3D1
        PVlplSUcUSe4UQFAkCG0J3mUKW1OjrQ=
X-Google-Smtp-Source: APXvYqwGheilOqgg/r3flYdv8jnKTS0gkJf4Ii/+0+IFy9MmnNGavCYYCygAwnkR6XWFfBA/4tc6tw==
X-Received: by 2002:a17:90b:258:: with SMTP id fz24mr2160382pjb.6.1578631619161;
        Thu, 09 Jan 2020 20:46:59 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id u23sm759716pfm.29.2020.01.09.20.46.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2020 20:46:58 -0800 (PST)
Date:   Thu, 9 Jan 2020 20:46:57 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Cengiz Can <cengiz@kernel.wtf>
Subject: [GIT PULL] pstore fix for v5.5-rc6
Message-ID: <202001092044.EE43B805@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull this pstore fix for v5.5-rc6. Cengiz Can forwarded a Coverity
report about more problems with a rare pstore initialization error path,
so the allocation lifetime was rearranged to avoid needing to share the
kfree() responsibilities between caller and callee.

Thanks!

-Kees

The following changes since commit 9e5f1c19800b808a37fb9815a26d382132c26c3d:

  pstore/ram: Write new dumps to start of recycled zones (2020-01-02 12:30:50 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/pstore-v5.5-rc6

for you to fetch changes up to e163fdb3f7f8c62dccf194f3f37a7bcb3c333aa8:

  pstore/ram: Regularize prz label allocation lifetime (2020-01-08 17:05:45 -0800)

----------------------------------------------------------------
pstore fix for rare error path

- Fix label allocation lifetime/visibility to avoid further mistakes

----------------------------------------------------------------
Kees Cook (1):
      pstore/ram: Regularize prz label allocation lifetime

 fs/pstore/ram.c      | 4 ++--
 fs/pstore/ram_core.c | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

-- 
Kees Cook
