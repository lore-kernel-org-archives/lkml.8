Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C354DC11D1B
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 18:41:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 949D42467A
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 18:41:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jB7Kf9eA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728542AbgBTSlq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 13:41:46 -0500
Received: from mail-yb1-f193.google.com ([209.85.219.193]:43145 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728162AbgBTSlp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 13:41:45 -0500
Received: by mail-yb1-f193.google.com with SMTP id b141so2624513ybg.10;
        Thu, 20 Feb 2020 10:41:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Q6NpLVKYuYi5r+jdGs6JgcjNvxF5K/nCtRTkokndCLM=;
        b=jB7Kf9eATRokx4yVa67z5alKyMt7TcXh+Qfrk2lfkX+mrEoh7O5Hw2+J9XECgbHVmP
         GodIvDCRYdyNpwvKSX/ftWtPZSHO7NSIQMyCKy7vyrNaz159hFqqrtlaVV57LQE4BeWF
         ksTrlocT/Q+2Jygm8iGzH3d5aQYYKx/eIwNjebErDAn/4SFz7/grcb3UslDDh6bpffa5
         NqsoRIuUGqVnqkObnG1nCYSfEGjTV7nyXJ8qu4hE8+R1+mMjmvvl0QsNt85Cc6ZK8c8S
         q93eO1mzUoBN8mlOkuRwXEpPjI9QxmAMSoJM6E7v9vmx0ZE1I8PWUiaWQfv+R/HAwGLg
         9uJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Q6NpLVKYuYi5r+jdGs6JgcjNvxF5K/nCtRTkokndCLM=;
        b=QTY64saCPcqhcNaCz7mkCPjUmt1KpTykr3hsBD7Xiqh6XWlqrrWCZ39GgEUBp4zCk2
         yaZDiAT9KhdDnA1hKcbcxTvn1nlAG4pdoMxWaYf9PbgQwOKCHwa78NQprglzmTqznffY
         wAGxq+QFmlDUSdZB8CFW8ajuStimXRBoC5MqFBHaQFUHRqIUAMfbrp6tqEVCfhdJnHcp
         dZvhCGUyoHB+5Qu5wAZeRoqK7MRlvxL/NYpHNwhec+bCni4m2S1ZMWhj3q7lMd5MEHt7
         P9K2f0pTtZkXzSUEBpHZBPB4sWMrEGus4W57O3EiBZmV21vCRIRurFWp7ekBhu6DPkN8
         s6Jg==
X-Gm-Message-State: APjAAAWS/AbI/BTRkgUzJGj8Juatz078Y61vSa6kI9xL/0O0rcuTjj9x
        xWcXmBXqp+McBakf1oEu/TAIev5p
X-Google-Smtp-Source: APXvYqx3CwEaEHhpxLKjKq3vFV9xCWLqBYVre652RPmvaoc3Nx9spul/8rcTt+y/1Ia9/Abrc1MUEQ==
X-Received: by 2002:a25:68cf:: with SMTP id d198mr27744979ybc.502.1582224104695;
        Thu, 20 Feb 2020 10:41:44 -0800 (PST)
Received: from localhost.localdomain (c-73-88-245-53.hsd1.tn.comcast.net. [73.88.245.53])
        by smtp.gmail.com with ESMTPSA id a74sm206875ywe.42.2020.02.20.10.41.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 20 Feb 2020 10:41:44 -0800 (PST)
From:   frowand.list@gmail.com
To:     Rob Herring <robh+dt@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        pantelis.antoniou@konsulko.com
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alan Tull <atull@kernel.org>
Subject: [PATCH v2 0/2] of: unittest: add overlay gpio test to catch gpio hog problem
Date:   Thu, 20 Feb 2020 12:40:19 -0600
Message-Id: <1582224021-12827-1-git-send-email-frowand.list@gmail.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frank Rowand <frank.rowand@sony.com>

Geert reports that gpio hog nodes are not properly processed when
the gpio hog node is added via an overlay reply and provides an
patch to fix the problem [1].

Add a unittest that shows the problem.  Unittest will report "1 failed"
test before applying Geert's patch and "0 failed" after applying
Geert's patch.

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

[1] https://lore.kernel.org/r/20200220130149.26283-1-geert+renesas@glider.be
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
 drivers/of/unittest.c                         | 628 ++++++++++++++++++++++++--
 8 files changed, 715 insertions(+), 31 deletions(-)
 create mode 100644 drivers/of/unittest-data/overlay_gpio_01.dts
 create mode 100644 drivers/of/unittest-data/overlay_gpio_02a.dts
 create mode 100644 drivers/of/unittest-data/overlay_gpio_02b.dts
 create mode 100644 drivers/of/unittest-data/overlay_gpio_03.dts
 create mode 100644 drivers/of/unittest-data/overlay_gpio_04a.dts
 create mode 100644 drivers/of/unittest-data/overlay_gpio_04b.dts

-- 
Frank Rowand <frank.rowand@sony.com>

