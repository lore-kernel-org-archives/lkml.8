Return-Path: <SRS0=xNW4=3S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D23B9C3F68F
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 05:47:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA60021734
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 05:47:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mfr0bO06"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726214AbgA2FrN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jan 2020 00:47:13 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:35889 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725858AbgA2FrM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jan 2020 00:47:12 -0500
Received: by mail-qk1-f193.google.com with SMTP id w25so10222768qki.3;
        Tue, 28 Jan 2020 21:47:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=uHB/7NPMQeL/2eB735CuqyO7WdQQC3wimQXDh+1rHic=;
        b=Mfr0bO06Vo+/HOIjlzgIdmAjy2yqxlyOJ+iSgcjRSxMXbiaTrDU3xHwBt8jVmZwYB+
         z9ZF72sehbbURA/eQGesCNeM/PQqkF0bY7p/gFBjDHYOflCXMEPojCbaPGozKWV+PJIF
         PmzQdsTYqYIv7w65cnjWGiZ52ynRoopUXArm8xZzJF6wbwfqCgMPwPeZgOBg2wftZY5d
         23j1l8E1hJ98YRmCHLo1Q/WSITrpJeAIMM07SezVBJjGWe8GhN241PbJqAzxpBTHO63s
         Zn5s0qeXfIBHgY3z1vijYnvhMFnZ81bTo06V5mG/RX0m9kWAJdnAnFZd/ZV9qsoHLh0y
         CBDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=uHB/7NPMQeL/2eB735CuqyO7WdQQC3wimQXDh+1rHic=;
        b=Vt5EJAApq7qbHcV1i3GRMQr6DITuQBVDH7bN/Ao9PyDAmrcyArtSzbSRvoZklxT0Id
         fzGVvIf9xgDrWs8joU/zhwlVgKSpbQZ+OtZIrLN+nNIQ0J1eXrehY+JhWBmMdibzp2ui
         pOvjv7V8Ui7xV4U1CL4ZgkH4qtIr6MB9sXb05Lnvq3IcC1C4tTcZwYPnY3tEmzIJjoTa
         cUXvaYCxbQc7mrkoISKjsEo1iawS8D59PWtdFW8/ZSrc7VvHqBH3Tqz+D1dvBLWcogHz
         Z6cvYIIPRssliBywWJbglmKX7z3Te6WVXVysrpEThDIkTv7pac8XjkfnmPGApFHaktQq
         MuQA==
X-Gm-Message-State: APjAAAVCydwudWq7HOTgG89xBMGsOkZzlFR6QgHh3Bng8NNeRLX/u6aH
        mAJLf6Acg+6ntglmmuSlAXs=
X-Google-Smtp-Source: APXvYqwuBZdSIDGsjDqjeylHLXetRC7hNupAcojinAgDWmy0M/joadQCqWf1b5QcIgDD/Yt1XlaKCQ==
X-Received: by 2002:a05:620a:13e3:: with SMTP id h3mr25801361qkl.319.1580276831830;
        Tue, 28 Jan 2020 21:47:11 -0800 (PST)
Received: from localhost.localdomain (c-73-88-245-53.hsd1.tn.comcast.net. [73.88.245.53])
        by smtp.gmail.com with ESMTPSA id r10sm472929qkm.23.2020.01.28.21.47.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 28 Jan 2020 21:47:11 -0800 (PST)
From:   frowand.list@gmail.com
To:     Rob Herring <robh+dt@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        pantelis.antoniou@konsulko.com
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alan Tull <atull@kernel.org>
Subject: [PATCH 0/2] of: unittest: add overlay gpio test to catch gpio hog problem
Date:   Tue, 28 Jan 2020 23:46:03 -0600
Message-Id: <1580276765-29458-1-git-send-email-frowand.list@gmail.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frank Rowand <frank.rowand@sony.com>

Geert reports that gpio hog nodes are not properly processed when
the gpio hog node is added via an overlay reply and provides an
RFC patch to fix the problem [1].

Add a unittest that shows the problem.  Unittest will report "1 failed"
test before applying Geert's RFC patch and "0 failed" after applying
Geert's RFC patch.

I did not have a development system for which it would be easy to
experiment with applying an overlay containing a gpio hog, so I
instead created this unittest that uses a fake gpio node.

Some tests in the devicetree unittests result in printk messages
from the code being tested.  It can be difficult to determine
whether the messages are the result of unittest or are potentially
reporting bugs that should be fixed.  The most recent example of
a person asking whether to be concerned about these messages is [2].

Patch 2 adds annotations for all messages triggered by unittests,
except KERN_DEBUG messages.  (KERN_DEBUG is a special case due to the
possible interaction of CONFIG_DYNAMIC_DEBUG.)

The annotations added in patch 2/2 add a small amount of verbosity
to the console output.  I have created a proof of concept tool to
explore (1) how test harnesses could use the annotations and
(2) how to make the resulting console output easier to read and
understand as a human being.  The tool 'of_unittest_expect' is
available at https://github.com/frowand/dt_tools

The format of the annotations is expected to change when unittests
are converted to use the kunit infrastructure when the broader
testing community has an opportunity to discuss the implementation
of annotations of test triggered messages.

[1] https://lore.kernel.org/linux-devicetree/20191230133852.5890-1-geert+renesas@glider.be/
[2] https://lore.kernel.org/r/6021ac63-b5e0-ed3d-f964-7c6ef579cd68@huawei.com

Frank Rowand (2):
  of: unittest: add overlay gpio test to catch gpio hog problem
  of: unittest: annotate warnings triggered by unittest

 drivers/of/unittest-data/Makefile             |   8 +-
 drivers/of/unittest-data/overlay_gpio_01.dts  |  23 +
 drivers/of/unittest-data/overlay_gpio_02a.dts |  16 +
 drivers/of/unittest-data/overlay_gpio_02b.dts |  16 +
 drivers/of/unittest-data/overlay_gpio_03.dts  |  23 +
 drivers/of/unittest-data/overlay_gpio_04a.dts |  16 +
 drivers/of/unittest-data/overlay_gpio_04b.dts |  16 +
 drivers/of/unittest.c                         | 630 ++++++++++++++++++++++++--
 8 files changed, 717 insertions(+), 31 deletions(-)
 create mode 100644 drivers/of/unittest-data/overlay_gpio_01.dts
 create mode 100644 drivers/of/unittest-data/overlay_gpio_02a.dts
 create mode 100644 drivers/of/unittest-data/overlay_gpio_02b.dts
 create mode 100644 drivers/of/unittest-data/overlay_gpio_03.dts
 create mode 100644 drivers/of/unittest-data/overlay_gpio_04a.dts
 create mode 100644 drivers/of/unittest-data/overlay_gpio_04b.dts

-- 
Frank Rowand <frank.rowand@sony.com>

