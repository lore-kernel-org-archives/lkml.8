Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB37AC34022
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 20:54:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDCA32070B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 20:54:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tyhicks-com.20150623.gappssmtp.com header.i=@tyhicks-com.20150623.gappssmtp.com header.b="c62OHk5B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729704AbgBQUyF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 15:54:05 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:41501 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727300AbgBQUyF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 15:54:05 -0500
Received: by mail-qk1-f194.google.com with SMTP id d11so17471657qko.8
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2020 12:54:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tyhicks-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=fZySxfAnANnt+nsj5/OVRGywRHdZ5tW9LOHavZZDjwo=;
        b=c62OHk5BUlt072x6HnPdx+3Ya+PHAQsN/DiZq2P0o2DD9Jw1mv/hqeLtB66Sf8vRdf
         2VlKisVCL2fw8NoqsYti+odq6ZIIggslxnDiBDe9FsjRENpWGFk6opGUKyKVhdWpa8pz
         0oYBHK//B1F8VVi69tooXo5L7HLU4jpgK9TOt6QZEAzgsrSoABPxhoSEgca1jQrivDt5
         GK+13UzTfmL7OY1ubRO8bHhTxtoeJmOdBvJNPHfqZsYk9H5ZaHBAF9bEHEI2mtGf+F8Y
         a9OFx+ugPLD8fRXewLyTfd3rKus56LuAwiLIbZ0AUboEE/cripAfKJ6e/tC4x9s05diI
         p4jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=fZySxfAnANnt+nsj5/OVRGywRHdZ5tW9LOHavZZDjwo=;
        b=OHUevWN3gF74cqpMxPmj2A9xfAXMEfowzhkA7F+DX/+ROLPdR7ueYNJdKvMWBG7jWK
         XnUekHYf/DhF393iRN+9kbpsagrO2neqfOcS0AwIzsJ9sCh3RfXtSGOMkq4GdMv245cl
         IIj2MKudR/C8FcQLmyYLvfeDPNG1Z/FboFbENezyyjhM0zpyXYZAIs7t9tq8MQaqEih3
         SCNLzi7tslHr0eQiIz8pFG6UVpAqE91785BLS+SPXmL/WXxJR/WkPyILe/es3ApMsMB3
         8AnhBy7MZ7uLfcrdjvLGsQnnIboiZdk5PzJL7qlJs/f7x8h0hXCiAk1sRFlxxWG/dZLE
         DJ3A==
X-Gm-Message-State: APjAAAXcM07sfOqLtofzeATJ7VQy9Q8eb0qX6LNG0cj3ERw8zEPt9+7V
        kMIt1TY81o6VBBeZu8nxyx7bDA==
X-Google-Smtp-Source: APXvYqzo4BZD6sctn/CUnMu2enQgFPYYUY0WU1tDjzIDMVLPiD1tQTPeT96pUKdZ1uz+ZaKUKwBQSA==
X-Received: by 2002:a37:494f:: with SMTP id w76mr16265607qka.309.1581972844290;
        Mon, 17 Feb 2020 12:54:04 -0800 (PST)
Received: from elm ([184.169.45.4])
        by smtp.gmail.com with ESMTPSA id m27sm810734qta.21.2020.02.17.12.53.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2020 12:54:03 -0800 (PST)
Date:   Mon, 17 Feb 2020 14:53:43 -0600
From:   Tyler Hicks <code@tyhicks.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, ecryptfs@vger.kernel.org
Subject: [GIT PULL] eCryptfs fixes for 5.6-rc3
Message-ID: <20200217205343.GA280196@elm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

The following changes since commit 5f97cbe22b7616ead7ae267c29cad73bc1444811:

  Merge tag 'clk-fixes-for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/clk/linux (2019-08-19 16:28:25 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/tyhicks/ecryptfs.git tags/ecryptfs-5.6-rc3-fixes

for you to fetch changes up to 2c2a7552dd6465e8fde6bc9cccf8d66ed1c1eb72:

  ecryptfs: replace BUG_ON with error handling code (2020-02-14 20:07:46 +0000)

----------------------------------------------------------------
eCryptfs fixes for 5.6-rc3
- Downgrade the eCryptfs maintenance status to "Odd Fixes"
- Change my email address
- Fix a couple memory leaks in error paths
- Stability improvement to avoid a needless BUG_ON()

----------------------------------------------------------------
Aditya Pakki (1):
      ecryptfs: replace BUG_ON with error handling code

Tyler Hicks (2):
      MAINTAINERS: eCryptfs: Update maintainer address and downgrade status
      eCryptfs: Replace deactivated email address

Wenwen Wang (2):
      ecryptfs: fix a memory leak bug in parse_tag_1_packet()
      ecryptfs: fix a memory leak bug in ecryptfs_init_messaging()

 MAINTAINERS                   | 4 ++--
 fs/ecryptfs/crypto.c          | 6 ++++--
 fs/ecryptfs/ecryptfs_kernel.h | 2 +-
 fs/ecryptfs/keystore.c        | 2 +-
 fs/ecryptfs/main.c            | 2 +-
 fs/ecryptfs/messaging.c       | 3 ++-
 6 files changed, 11 insertions(+), 8 deletions(-)
