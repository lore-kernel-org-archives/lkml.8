Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E322BC47255
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 06:28:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA84620708
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 06:28:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="TK5ix1Aq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728176AbgEKG22 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 02:28:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725790AbgEKG21 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 02:28:27 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65273C061A0C
        for <linux-kernel@vger.kernel.org>; Sun, 10 May 2020 23:28:27 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id m7so3517369plt.5
        for <linux-kernel@vger.kernel.org>; Sun, 10 May 2020 23:28:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=a4iKDHDfwXIZnclrQfgS67RLIOsPVKwr8wpBYyznDe8=;
        b=TK5ix1Aqqwb7Ya/K/+Dg2lsMf6en52o6TcUSLW0/ToOvgHkP7M9gBpRFLRmUEUrVh1
         azNOMkRX9XsqNKW0FF4v3aXHdcEu4z1g75sKgrV/lI8Kt+VRhZukhweuWLKV4ibcpYuY
         tWm6B8kqKJYUqdtmMrJuCRux8/cfCtPMBromlCGykLLX6tOnA13OkO4S/YkhPsArcY52
         qLBClSFo5WIVAy5drn+Vxlwp3ysDic9Pn9Evch4yoP2ayx2hg4qbe4jEPTo3yLzs2Y8v
         WQQiw9M9LCTzUZcGCsD0mebbcoZFFVrjIQ155szyW1XpS5UU1v3DyRaTSHSM4+3H1zaN
         QBYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=a4iKDHDfwXIZnclrQfgS67RLIOsPVKwr8wpBYyznDe8=;
        b=Pbh+NMgPyLAr1DrnK5BbSqgbBOqoog9gRLyi1Evaa1ok23DmOba+LBQK3iivHUE13K
         WwaNbeLri2e7J9aQvNOY2ELqkptmyQW6SPww+EAH6ARt/V8/XCjbSpaMZdTkzZcck/KS
         zuQeizXtyH2FyGLXFKQ0akIXMR0dPa26L81yy2JKAYZO2q7cJbR/sfeyrHt1S+rhBae4
         9fEpi8XfSmGovTJYCG7jznv8THHMpFCEvGFoLMjjd6fQsbvJMtTrUbORi/pcEH8Y8FEJ
         M7S7gVxioxRIA9mnkymKkniXkuyUWcjvQY7i8+N/Lg/72vcwtPXMPfjxm20GiLOYwtBw
         gg3w==
X-Gm-Message-State: AGi0PuYbjiLcQwv1PA9IJvZPUk9ZJ4Mm/FRfTCXTuXoZIb7SDSE3euXD
        LY/n0k8CLKZXPJRIPxJfRJa73A==
X-Google-Smtp-Source: APiQypK8mjxuRz2P3irW1qyXDtd3yypojhgL1c6Dyx2PCKudZ5BmeoTbCsuBHB6B0Ib5O6XvYpJQGQ==
X-Received: by 2002:a17:902:70c6:: with SMTP id l6mr12577052plt.31.1589178506784;
        Sun, 10 May 2020 23:28:26 -0700 (PDT)
Received: from hsinchu02.internal.sifive.com (114-34-229-221.HINET-IP.hinet.net. [114.34.229.221])
        by smtp.gmail.com with ESMTPSA id j63sm5179558pge.76.2020.05.10.23.28.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 May 2020 23:28:26 -0700 (PDT)
From:   Zong Li <zong.li@sifive.com>
To:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     Zong Li <zong.li@sifive.com>
Subject: [PATCH 0/2] Bugs fix up for DEBUG_WX
Date:   Mon, 11 May 2020 14:28:18 +0800
Message-Id: <cover.1589178399.git.zong.li@sifive.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These patches fix some bugs of DEBUG_WX. The first one is removing the
name of arm64 page talbe use. The second one is adding MMU dependency,
otherwise, it causes build error on NOMMU system, which reported by
kbuild test.

Zong Li (2):
  mm: remove the specific name of arm64
  mm: add MMU dependency for DEBUG_WX

 mm/Kconfig.debug | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

-- 
2.26.2

