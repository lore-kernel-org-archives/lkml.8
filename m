Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE7BEC433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 17:42:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D3B3220870
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 17:42:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ducnwHyY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726965AbgGCRms (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 13:42:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726905AbgGCRmp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 13:42:45 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DD85C061794
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jul 2020 10:42:45 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id f139so34882048wmf.5
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jul 2020 10:42:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iR7UBjy9b+GnDxxSAohGssAzGZu9g74Tp/QmVOl6H2Q=;
        b=ducnwHyYnt1Euvl0f4+BWCbuzEg8Fov/NpURhw5+20HmnMl1J/sAR30xHQb54zWlsc
         8ylR62njZpvZKMYJmXQzbyCwGAGVC8pDWzbyYh2po23NCMBqyIkNgsIyxX/9JgCgQJfu
         I7QGyxJMasm839b6jGVpSsPgPAzSGAsHKJmm7kTyFg+rp1Y95hEhQdGu/Du80koYKyPI
         WAdK4rpXnQ5sgM9wxlRx6YPlGLmvvxZXNCMjFdWC2cqVVfV1lkU01XJjo9uvmAuMZ3PY
         pR9Z4zPWOgalslyfm3pr3/mQgbVeJFyzo4rb8b/EaMS/2q/D4HOl0yVvz21fy5HYW2es
         6iyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iR7UBjy9b+GnDxxSAohGssAzGZu9g74Tp/QmVOl6H2Q=;
        b=APMohBv9+spXI9pbomTBSVNjlykDGduQX+diwpbyoF0c0F74N1g5ssMyRMSoZLJY/1
         69xQcbfL6tSinkM4muqGGcDrxy7ijBUXAaKOn/qem2Ab/T9z5c0r+h2RPtkGOtOR7QTP
         aXoNlXaZ7sBfFLC8L1Jxo/D4SWWKXWO+HIWIHTwhixfjMdHDY4/C0IF7iLvthQNsWu0J
         WFYMXS3u25PMOO8xu8geE25h7mCLLtid2OPezWuxBesIRv0DrE80FDRk4Mc2zxpfO/qt
         teBF3TVNLDHeq/pe+jtLIh+SKFGpB9rGnz2oxF2rz8teAzAMRYTiP+7qqcVDmuFdsdYB
         UbCA==
X-Gm-Message-State: AOAM531qZyJDqLdTSC4Q8Q1zoG0XpkR1lcZAbskmPWjco8j6Hco2StHa
        AW8fZtBA/ePek1Eh+kYb496tyg==
X-Google-Smtp-Source: ABdhPJzWDElIsWsgZs5aFyQnkGgXFAh1NXyvJLsupvxSIpseD/CGSj1lFbaE7ttaa7WKZibdweL68Q==
X-Received: by 2002:a1c:81d3:: with SMTP id c202mr24362378wmd.54.1593798163896;
        Fri, 03 Jul 2020 10:42:43 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.144])
        by smtp.gmail.com with ESMTPSA id x11sm13625799wmc.26.2020.07.03.10.42.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2020 10:42:43 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH 18/30] usb: host: xhci-debugfs: Use 'gnu_printf' format notation
Date:   Fri,  3 Jul 2020 18:41:36 +0100
Message-Id: <20200703174148.2749969-19-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200703174148.2749969-1-lee.jones@linaro.org>
References: <20200703174148.2749969-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/usb/host/xhci-debugfs.c:128:2: warning: function ‘xhci_debugfs_regset’ might be a candidate for ‘gnu_printf’ format attribute [-Wsuggest-attribute=format]
 128 | vsnprintf(rgs->name, sizeof(rgs->name), fmt, args);
 | ^~~~~~~~~

Cc: Mathias Nyman <mathias.nyman@intel.com>
Cc: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/usb/host/xhci-debugfs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/host/xhci-debugfs.c b/drivers/usb/host/xhci-debugfs.c
index 76c3f29562d2b..92e25a62fdb5b 100644
--- a/drivers/usb/host/xhci-debugfs.c
+++ b/drivers/usb/host/xhci-debugfs.c
@@ -110,6 +110,7 @@ static void xhci_debugfs_free_regset(struct xhci_regset *regset)
 	kfree(regset);
 }
 
+__printf(6, 7)
 static void xhci_debugfs_regset(struct xhci_hcd *xhci, u32 base,
 				const struct debugfs_reg32 *regs,
 				size_t nregs, struct dentry *parent,
-- 
2.25.1

