Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F157DC83003
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 10:06:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CCCDA2137B
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 10:06:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZaoT/ij9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726702AbgD2KGo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 06:06:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726575AbgD2KGn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 06:06:43 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11693C03C1AD
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 03:06:43 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id x25so1366677wmc.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 03:06:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=tRSFF6YjPRMfXBqbX85nqv3CwbxXtG04SneAHAxmtSk=;
        b=ZaoT/ij9giXypBnwF0vKQfdQYcFEexr7ot2GWI7JdgQrsXo9VYV6KHH4XkLaDuZMPx
         HZKACur5XS+EEZU8wvMLwnedKLU0hgMWm9SVrHjnF4dsqeSklS1CdXY/au5GlIXXs26E
         U6ei9jVS7xMgB66/Bnr4sbL/TgjW8MAlcgiZViWSR8TgbfbVeQZTiitKsMqw+TmCGLir
         n69ERZ4ZudBSPtAlOl1K1Qhu7gQCT2l8ampFm1LlyZ54yV0Sewa4lVJ9IsrNLFl2dmey
         uj6CD0sgRArdDeOcCUUzJ4f4pBb9ez+Wg/Wgr8iaM2Hbt5M+D4zcDfurKuGfdPsJXQYO
         HJVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tRSFF6YjPRMfXBqbX85nqv3CwbxXtG04SneAHAxmtSk=;
        b=beoXjuonBFTMXN8yGYxwyQZkj8w42Q2TqDhgkhW02wHpcdwY9DGjwZ1T7FjEwtBQ2E
         Zq+ItTvWNNkO4R3hN5mH6kWqEoL1CccR+BOf3kM5tx2wk7Uxgma5ufBXRtCgiOFoiytA
         UKZiXkefCcSn+f05EKXPfh2foU50gJ40ycL0C3pfpvbQn6bwbT2D99vvfkc4+PLNPhSN
         OLRg5/dss+yiJ0dfywJkkAhucCRQJ1C8J7uq3BvbwjOoLozQ33Wyg/YaWK3WwqXdrvDZ
         W+BBvjExVNdpC5Q9uKftr8B9oGhAAMLNahI4HcQB0+ZJh/Cytv4ZzP4h6xH3GRblTWrr
         vhfw==
X-Gm-Message-State: AGi0PuZ8sAWtYihRmVz0f9LfZqf69f3hqqunU4QRdL2sGtBwAOdyuTiN
        ZdK/z3aslM/4jY/PSJB0u0kAzRx8SQ==
X-Google-Smtp-Source: APiQypL56XDldRfasfPDv99mihTbQk2Mpcz6n7bPRtYAhUmrZBRUyYh8JxA1iA1CBb/pR1zc4ttnDg==
X-Received: by 2002:a05:600c:2214:: with SMTP id z20mr2558849wml.189.1588154801433;
        Wed, 29 Apr 2020 03:06:41 -0700 (PDT)
Received: from ninjahost.lan (host-2-102-14-195.as13285.net. [2.102.14.195])
        by smtp.gmail.com with ESMTPSA id 1sm7205478wmi.0.2020.04.29.03.06.40
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2020 03:06:40 -0700 (PDT)
From:   Jules Irenge <jbi.octave@gmail.com>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH 0/6] Lock warnings cleanup
Date:   Wed, 29 Apr 2020 11:05:22 +0100
Message-Id: <20200429100529.19645-1-jbi.octave@gmail.com>
X-Mailer: git-send-email 2.25.3
In-Reply-To: <0/6>
References: <0/6>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch serie propose a solution to functions that record context
imbalance by adding annotations

Jules Irenge (6):
  usb: gadget: Add missing annotation for xudc_handle_setup()
  udp: Add missing annotations for busylock_acquire() and
    busylock_release()
  udp: Add annotations for udp_rmem_release()
  net: atm: Add missing annotation for lec_seq_stop()
  USB: dummy-hcd: Add missing annotation for set_link_state()
  net: atm: Add annotation for lec_priv_walk()

 drivers/usb/gadget/udc/dummy_hcd.c  |  1 +
 drivers/usb/gadget/udc/udc-xilinx.c |  1 +
 net/atm/lec.c                       | 11 ++++++++++-
 net/ipv4/udp.c                      | 11 +++++++++++
 4 files changed, 23 insertions(+), 1 deletion(-)

-- 
2.25.3

