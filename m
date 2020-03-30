Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33268C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 04:22:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 026C6206F6
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 04:22:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ST3qPOvm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728369AbgC3EWC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 00:22:02 -0400
Received: from mail-pj1-f67.google.com ([209.85.216.67]:50727 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726312AbgC3EWB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 00:22:01 -0400
Received: by mail-pj1-f67.google.com with SMTP id v13so7025185pjb.0
        for <linux-kernel@vger.kernel.org>; Sun, 29 Mar 2020 21:22:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=iNGyBxxlrgr0c38rH5YG+PKV12q5rXlSv+UAoaFRSv0=;
        b=ST3qPOvmh+0JBucJ2kV+/SDvfVSd6rtUtAf6+kIZIA4ynAa4fDsPGCHQ7pffRJr4E6
         6xAesTLQoXaIGlOH9+9zqqyJn+A6AYRjaQPQVJtg5u7H8pCm854xK43ojw4tUVu6Ze8H
         sqeSY8sgBoTih3tswGknPx6oOt3PPbV/+m2hY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=iNGyBxxlrgr0c38rH5YG+PKV12q5rXlSv+UAoaFRSv0=;
        b=eOEz0vnEmPPz8jbZd3GqyOxxK4ELBN+0WTFc1S9oqELAUFWnxpe6qoqbV1Sov7oekH
         uEOFEiH//UzhLdUILMEgh3ILjk94ZYIzlghK6BTNyuXO/pq7gGJIEboKWpY/r1udf5Ix
         6s5GAIHslr7ViaKyrSSM1CafQ7zmuyTH6MD+ID4x8+TgWqZZc2GSyoNVl4+lfkZat/Tw
         BhPMWDjUJQ/fANX7tw/x/IwH0ymXiNqweQJr4kRkQU5fqNfzWQkLuVBj4Js8DPZgvbyM
         p7oZb6Q+VK0/X6AZSS1mwccoVME+B4EGwXvwVY4nLlBPWhHz/tXyyFXW7YK0ZDf84LDj
         hN4w==
X-Gm-Message-State: ANhLgQ022fw/RqQCX3mdcLP4vpfzC+9NV5WIE/irfBsv/iDQqt4WERaK
        gYMy3ArFDp8jGs26RrL52AZ4DQ==
X-Google-Smtp-Source: ADFU+vviOJrOxTlwa/uii0vaf4kvBJ5FKycDinxHK1qIaKvwfLwTl+R8Qo9h0vQCG9+M1rBkF9HnbQ==
X-Received: by 2002:a17:902:850a:: with SMTP id bj10mr10765110plb.28.1585542119581;
        Sun, 29 Mar 2020 21:21:59 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id nh14sm3991527pjb.17.2020.03.29.21.21.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Mar 2020 21:21:58 -0700 (PDT)
Date:   Sun, 29 Mar 2020 21:21:57 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, chenqiwu <chenqiwu@xiaomi.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Kees Cook <keescook@chromium.org>,
        Vasily Averin <vvs@virtuozzo.com>
Subject: [GIT PULL] pstore updates for v5.7-rc1
Message-ID: <202003292120.2BDCB41@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull these pstore updates for v5.7-rc1. These mostly some minor
cleanups and a bug fix for an ftrace corner case.

Thanks!

-Kees

The following changes since commit 11a48a5a18c63fd7621bb050228cebf13566e4d8:

  Linux 5.6-rc2 (2020-02-16 13:16:59 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/pstore-v5.7-rc1

for you to fetch changes up to 8128d3aac0ee3420ede34950c9c0ef9ee118bec9:

  pstore/ram: Replace zero-length array with flexible-array member (2020-03-09 14:45:40 -0700)

----------------------------------------------------------------
pstore updates

- Improve failure paths (chenqiwu)
- Fix ftrace position index (Vasily Averin)
- Use proper flexible-array member (Gustavo A. R. Silva)

----------------------------------------------------------------
Gustavo A. R. Silva (1):
      pstore/ram: Replace zero-length array with flexible-array member

Vasily Averin (1):
      pstore: pstore_ftrace_seq_next should increase position index

chenqiwu (2):
      pstore/platform: fix potential mem leak if pstore_init_fs failed
      pstore/ram: remove unnecessary ramoops_unregister_dummy()

 fs/pstore/inode.c    | 5 ++++-
 fs/pstore/platform.c | 4 ++--
 fs/pstore/ram.c      | 1 -
 fs/pstore/ram_core.c | 2 +-
 4 files changed, 7 insertions(+), 5 deletions(-)

-- 
Kees Cook
