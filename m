Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C5C0C3815B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 13:46:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4988120857
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 13:46:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aSSpQWTq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728624AbgDTNqx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 09:46:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726307AbgDTNqw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 09:46:52 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32EA1C061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 06:46:52 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id t40so4445542pjb.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 06:46:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oVXo0ylRGYJ4zwuQfXiYyJn0JMdjSeEuDU/G14GSpRI=;
        b=aSSpQWTqjHFqwRMNUGZzpNFg6nXaNN4W/AGY722ZMQ1vLO/09Mhj1CKZdp8tmcqpC6
         S6NPwmSWHlUo1sM5YUo6eoe987jgRFw8NBYN4cvzZrg6z6zm9EVFKvIPnFTSgJt8GkMP
         5J2TYhrpdG8fUkikFoHMfSEDcBqnOsTsXlP0ox66vBtXZVkzz7i4LFOCg5LoOaPF08MN
         5UU5FZRP04YXxxCaUNx6eNoXLoHQ+HWUhR4/+ulaNM52VAot1LkCEaFbpD3RLhEacQyv
         +3JcRRJvBATQLzZRF4p2b0f+iGlYo1v3S4daLCy2IsKfCznN/pyDCsplt+k39+VYwIYj
         KGIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oVXo0ylRGYJ4zwuQfXiYyJn0JMdjSeEuDU/G14GSpRI=;
        b=IJ6ODd74yBPrCCBkdNflYp15eNOa9sxXHbbZkO6Ba/Vw9zaSPNfxcdBkFBdoW1UIJH
         nX200S9xXABsg4c3sgTYGaO1l3w4nrSPQ9z9vYEM7JTO1sNpYZJqXXqe487/k7+e37dQ
         QN60P3C0PVlpcgAXZccWDwGn4m8wocm1WSXYo6A1/gRFkFBYCzJcY2wXePcqNymYlpQA
         ALf7GfpkgMYTskIs3sUHCzAe/NlLYAWuo9Zg0jgfCqXiHCTbX0tNxntZt62E/XCLlQNO
         Jf1uBxSni/BNwES3kbTtr8zZd5+skv68cd4TwWJ5X4OExruWIJhprsDDUi6/Aymmx/Jc
         qiew==
X-Gm-Message-State: AGi0PublHvS2/Uj4vOtOOe1fa1yxDtcCs4jcf1OuMNEwHGadVYjExp1c
        sBuRRHxMhWzlLRhZ3QCpbmJjoeOs
X-Google-Smtp-Source: APiQypLfKCWIfDLE5D9Ilqwo6/7gH0ofgASq9lgw+gOe9g3kSwo9GM6we80kF/99uNBWGFZZWsAywQ==
X-Received: by 2002:a17:90a:9a89:: with SMTP id e9mr22316534pjp.108.1587390411732;
        Mon, 20 Apr 2020 06:46:51 -0700 (PDT)
Received: from localhost (89.208.244.140.16clouds.com. [89.208.244.140])
        by smtp.gmail.com with ESMTPSA id 135sm1154133pfx.58.2020.04.20.06.46.50
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 20 Apr 2020 06:46:51 -0700 (PDT)
From:   Dejin Zheng <zhengdejin5@gmail.com>
To:     broonie@kernel.org
Cc:     Markus.Elfring@web.de, linux-kernel@vger.kernel.org,
        Dejin Zheng <zhengdejin5@gmail.com>
Subject: [PATCH v2 0/2] use read_poll_timeout macro to simplify code
Date:   Mon, 20 Apr 2020 21:46:45 +0800
Message-Id: <20200420134647.9121-1-zhengdejin5@gmail.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Simplify implementation of regmap_read_poll_timeout() macro and
regmap_field_read_poll_timeout by read_poll_timeout() macro, they have
many similar codes.

v1 -> v2:
	- modify the commit comments by Markus's suggestion .

Dejin Zheng (2):
  regmap: Simplify implementation of the regmap_read_poll_timeout()
    macro
  regmap: Simplify implementation of the
    regmap_field_read_poll_timeout() macro

 include/linux/regmap.h | 48 ++++++++----------------------------------
 1 file changed, 9 insertions(+), 39 deletions(-)

-- 
2.25.0

