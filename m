Return-Path: <SRS0=7RkH=3E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7259AC33CB3
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 06:48:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 492BC24684
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 06:48:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T1uYIjGS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729099AbgAOGsM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jan 2020 01:48:12 -0500
Received: from mail-yw1-f67.google.com ([209.85.161.67]:40304 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726018AbgAOGsM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 01:48:12 -0500
Received: by mail-yw1-f67.google.com with SMTP id i126so10602807ywe.7;
        Tue, 14 Jan 2020 22:48:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=F7vs1YGAJ4kzE6+yTQsSoP5REK6YTmTdG8UvUxh6zDI=;
        b=T1uYIjGSzzOcD8CHmhPZc2STTHxF6YzXAqmc4Xtd9w23iuL0O0iyJF3hi8XPTP7SlV
         Z/kaMS014zarex/LGAM+Jz7oQuNw5sQi0pE+Bk8X3x8ARvkd4/qL+NsTbSraKN5SLtH8
         PdVlSiXSfQCbp7Zfc6FP/nVF78pvg2hYKW1VTIvSEjAY4TmDNSUwwu8PsfghhsTRmRN6
         We3Vm4Pim+N8G7o5nqT6Iv6+T+LF2hbFlZ9K4qlksxdd2e396rto2gXsVoClpPYXKPtj
         TQAmlLNMT/I4yNT6tPBxrdbW2ws/JmeyU2Phpn9RMQV9qvrmF6Nbk+3gVCByFmVwbuDR
         1xwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=F7vs1YGAJ4kzE6+yTQsSoP5REK6YTmTdG8UvUxh6zDI=;
        b=r1KfMqu6E+g+yVfYQTvjac2BeNY0+OvwM2UTCuKZ6RPg+ejEHoMnENN91mySjHFQMB
         KcFfpjEMMbcKNef+cRLUt0dmvYJPucBB/NunB4e8LUVY0G9pUNVwvNFbN47ujI8kzqXV
         ASR6ysLzw+YFuDnJw7WQmUKj6NxlBO9S843RJVNIkjVKuZZTPbAXXwUxwzI5k826krpk
         MOgGEqMuYj+HGTnxgp7d34IuqQQQzGKRfJzVGCV7O7REV59F24FwGl950cW5chE6uKtv
         b3MgLRdzRWnvyMzXH1l3csrit++i8hRr8i7NiEHWeDOjQeX5z7sB3rKsCL1of9rpn3Ax
         jhCA==
X-Gm-Message-State: APjAAAVQYvEOVgsPlG1QngzCW6XyB2Fv4b3Cz7f0Zrs6ejbdW0ytbVzL
        ok/5kxvpotvk4mefTT15O0k=
X-Google-Smtp-Source: APXvYqwlEMG2a2Ly55dbGBlX+2oqoAfy8VDNy0ug9Vvy3IjVXU4C4OOX0qetXw0hOa1u35vf6wmh8g==
X-Received: by 2002:a0d:d384:: with SMTP id v126mr20207429ywd.30.1579070891164;
        Tue, 14 Jan 2020 22:48:11 -0800 (PST)
Received: from localhost.localdomain (c-73-88-245-53.hsd1.tn.comcast.net. [73.88.245.53])
        by smtp.gmail.com with ESMTPSA id r66sm8056738ywr.50.2020.01.14.22.48.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 14 Jan 2020 22:48:10 -0800 (PST)
From:   frowand.list@gmail.com
To:     Rob Herring <robh+dt@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        pantelis.antoniou@konsulko.com,
        Pantelis Antoniou <panto@antoniou-consulting.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alan Tull <atull@kernel.org>
Subject: [RFC PATCH 0/2] of: unittest: add overlay gpio test to catch gpio hog problem
Date:   Wed, 15 Jan 2020 00:47:06 -0600
Message-Id: <1579070828-18221-1-git-send-email-frowand.list@gmail.com>
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

This series is a work in progress and I have not properly reviewed
it yet myself.  The work behind the series has resulted in my
following several paths and distractions, resulting in more delay
than I would desire in continuing to review Geert's RFC patches.
I am thus releasing these patches as an RFC so that my work
behind the review is visible and available for Geert and other
reviewers of his patch.

The annotations added in patch 2/2 add a small amount of verbosity
to the console output.  I have created a proof of concept tool to
explore (1) how test harnesses could use the annotations and
(2) how to make the resulting console output easier to read and
understand as a human being.  The tool 'of_unittest_expect' is
available at https://github.com/frowand/dt_tools


[1] https://lore.kernel.org/linux-devicetree/20191230133852.5890-1-geert+renesas@glider.be/


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
 drivers/of/unittest.c                         | 632 ++++++++++++++++++++++++--
 8 files changed, 719 insertions(+), 31 deletions(-)
 create mode 100644 drivers/of/unittest-data/overlay_gpio_01.dts
 create mode 100644 drivers/of/unittest-data/overlay_gpio_02a.dts
 create mode 100644 drivers/of/unittest-data/overlay_gpio_02b.dts
 create mode 100644 drivers/of/unittest-data/overlay_gpio_03.dts
 create mode 100644 drivers/of/unittest-data/overlay_gpio_04a.dts
 create mode 100644 drivers/of/unittest-data/overlay_gpio_04b.dts

-- 
Frank Rowand <frank.rowand@sony.com>

