Return-Path: <SRS0=1cir=3Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C935C33CB1
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 23:54:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53DCB206BF
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 23:54:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="B0D4GdH3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726871AbgA0Xyj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jan 2020 18:54:39 -0500
Received: from mail-pf1-f201.google.com ([209.85.210.201]:41196 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726323AbgA0Xyj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jan 2020 18:54:39 -0500
Received: by mail-pf1-f201.google.com with SMTP id b62so6971042pfb.8
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jan 2020 15:54:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=0WVlBZ9h/3UAmHAjFKk1i1lby5ArQALhCHp8vRDwf6s=;
        b=B0D4GdH37zFLkAB6DLlyqBHlLmNEXHfnkYgFffeTOmOr475hSOENtNB8TIo3G4sGe0
         FGQeW1LRFZFwEwZe0xYBNGSrbzuvSB/n522fs6/iqw0svGmiqpGIgfsGVIAnWpo0xe6b
         BoM87ucGn23bNOQFBFwtOThLn+0+3twkPtHYFFqqNHT27mvPiaZYPxgu4N/l/e8eaXcg
         7jQiGP//cNxEUu+McL7virtX6XQNY1Tl0esKP2c/WrVvCyn1rDqO+BVfbr+AnTAAodm8
         8eaZUZJdgvoPLStiKNbl0DHxWBNzGU98A6D6t+uV4+grA51Z1w5tPzJYd+kP7DcwXnGr
         FQyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=0WVlBZ9h/3UAmHAjFKk1i1lby5ArQALhCHp8vRDwf6s=;
        b=ArpQXaP10DjuSoDWYsmUKnDYFIGa+Fmym906r2hHKxXFMzKY59vyn1T+Srx4njsnTS
         A7LwTWqXepbesXJJ1gdHV3uVY45YE+o2fv+/x2/R5ADoo8PlNz4vf0ix33PbExPMIdGi
         a7tM41UdvuCPmQ4+Io1eHCADYoLqaVx/mfrnf9a8P7jhi1Wd3SVJuzUQIVm8VMBKxl3F
         LzLxULHiSzZ1xkd4f6sru978SqpKToPrUhh+OONmeN5lVBpP2vA1Q1DGzjA4+FMUWJD/
         h5AXi35CWgpLPsCLVBbY2LzcHt8AA2KnF0KKAp0FWyP7JYejxsCYDOnZ9OXFCuvieKIe
         3oIg==
X-Gm-Message-State: APjAAAUZ04FBwgl1Uiwg02fbNCvROiFCc59BMK1peisD0qqmYuWcN2jD
        lEKhKDz5+U+egJeYfXmO60DXpHyTrAkUBiUBodj67Q==
X-Google-Smtp-Source: APXvYqxuHlif8YoC09sMp36DADFxZKUEjmOezwoOELE8SswXmvcrc2Cpl4SiqOBpXxHMb1qSYM81/g2GJjm81WrtmsBS6w==
X-Received: by 2002:a63:ea4c:: with SMTP id l12mr20867620pgk.29.1580169278383;
 Mon, 27 Jan 2020 15:54:38 -0800 (PST)
Date:   Mon, 27 Jan 2020 15:53:51 -0800
Message-Id: <20200127235356.122031-1-brendanhiggins@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
Subject: [PATCH v1 0/5] uml: add more unspecified HAS_IOMEM dependencies
From:   Brendan Higgins <brendanhiggins@google.com>
To:     jdike@addtoit.com, richard@nod.at, anton.ivanov@cambridgegreys.com,
        Kevin Hilman <khilman@kernel.org>, Nishanth Menon <nm@ti.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "David S . Miller" <davem@davemloft.net>,
        Michal Simek <michal.simek@xilinx.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Robert Hancock <hancock@sedsystems.ca>,
        Esben Haabendal <esben@geanix.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
Cc:     linux-um@lists.infradead.org, linux-kernel@vger.kernel.org,
        davidgow@google.com, heidifahim@google.com,
        Brendan Higgins <brendanhiggins@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

# TL;DR

This patchset adds a missing HAS_IOMEM dependency to several drivers in
an attempt to get allyesconfig closer to working for ARCH=um. Although I
had caught all the broken ones in early 5.5[1], some new ones have
broken since then.

# What am I trying to do?

This patchset is part of my attempt to get `make ARCH=um allyesconfig`
to produce a config that will build *and* boot to init, so that I can
use it as a mechanism to run tests[2].

# Why won't allyesconfig break again after this series of fixes?

Well, in short, it will break again; however, as I mentioned above, I am
using UML for testing the kernel, and I am currently working on getting
my tests to run on KernelCI. As part of our testing procedure for
KernelCI, we are planning on building a UML kernel using allyesconfig
and running our tests on it. Thus, we will find out very quickly once
someone breaks allyesconfig again once we get this all working. So this
will keep breaking until we have a build test on KernelCI running, but
we will need to send out these fixes anyway.

Brendan Higgins (5):
  net: axienet: add unspecified HAS_IOMEM dependency
  reset: brcmstb-rescal: add unspecified HAS_IOMEM dependency
  reset: intel: add unspecified HAS_IOMEM dependency
  ptp: 1588_clock_ines: add unspecified HAS_IOMEM dependency
  power: avs: qcom-cpr: add unspecified HAS_IOMEM dependency

 drivers/net/ethernet/xilinx/Kconfig | 1 +
 drivers/power/avs/Kconfig           | 2 +-
 drivers/ptp/Kconfig                 | 1 +
 drivers/reset/Kconfig               | 3 ++-
 4 files changed, 5 insertions(+), 2 deletions(-)

[1] https://lore.kernel.org/lkml/20191211192742.95699-1-brendanhiggins@google.com/
[2] https://bugzilla.kernel.org/show_bug.cgi?id=205223

-- 
2.25.0.341.g760bfbb309-goog

