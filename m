Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F002C43461
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 19:35:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CCDAF2098B
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 19:35:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=marek-ca.20150623.gappssmtp.com header.i=@marek-ca.20150623.gappssmtp.com header.b="2HYi7leT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732318AbgIHTe6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 15:34:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730901AbgIHP5a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 11:57:30 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 545DDC0612B0
        for <linux-kernel@vger.kernel.org>; Tue,  8 Sep 2020 06:11:29 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id f2so15185559qkh.3
        for <linux-kernel@vger.kernel.org>; Tue, 08 Sep 2020 06:11:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=marek-ca.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=D6PZaXfU9lSNNM5STxKLHSbdmpPO4mfVbzPzM2HEmOU=;
        b=2HYi7leTJH91BZbuOyAcGGekgns8wnQpVx1NmiD8t2s1KvGXkPdU2GaaIyofGc1rFY
         1HAA71lu4tUzVwKGXzVA8BP3rqDCZa9jJ+zXWeTc+uSdDdhb2xyZl22TPhng6UWSfUCF
         n+/NB8u/8bpw9L+plqC2Ho7/gCiLgBm28fQjdqo7+ZfKukrrYeUin0giOkSdHOE3vo3J
         sN8mCXqMRxUY+v5A00+qx3Zyx0vD/ffQY4JWuMVnjqZbjcO1526wjzMNObXMjnTCN0gk
         /rparC5vd39212atJ4ua76HwUZdqBKv+Z2IoZoIt5hhTOSmfPSWBlxCjvLB93b4yek2h
         PY0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=D6PZaXfU9lSNNM5STxKLHSbdmpPO4mfVbzPzM2HEmOU=;
        b=laOfD1F+WPJs8hLr+5tA7+c2uUdlIweia8RlY0kI4SRePGWuZ21Kjdl7RiaN6HGhDa
         wXwC4ruBauBl/cdbEtnpKxew/KiF0bR0vVWrbPgjGplSO0hKtQisopg1II34hzI50SyI
         q8uzanPdL7oTPq0PAvg/yNsBjveFhuN+rQkNLiwsyx9zjZM8Q7MvbEz0XAPnZc9qEW5c
         1nVo05rs3s119aJBjC82l4YhNy3w/xKA+vrFjDCn3wyQtUoBN082IDT4Tw+DbIGT8Ayo
         egOQb8bHDTXGv02+VHne+/UCxqI6QBqY50QLKXlfagQ//1rgJFBA2CGghPSqt12X71Q9
         KwIw==
X-Gm-Message-State: AOAM533TpSmhxO6dVI2kPAdCW7fNsKJu0NFwPsYWWeYCkxtz1eAUV+mB
        oiyXLCnrvFIOhsIlZaMTs8oBnw==
X-Google-Smtp-Source: ABdhPJxIqsYRJmgOMoluDb68Y23V5yFz/PWJz14N3xZDX7JJaWWTqdlV3IIK76fYQLTTBEeS2i8B/g==
X-Received: by 2002:a37:4b84:: with SMTP id y126mr4100qka.148.1599570688312;
        Tue, 08 Sep 2020 06:11:28 -0700 (PDT)
Received: from localhost.localdomain ([147.253.86.153])
        by smtp.gmail.com with ESMTPSA id m196sm13394069qke.87.2020.09.08.06.11.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2020 06:11:27 -0700 (PDT)
From:   Jonathan Marek <jonathan@marek.ca>
To:     linux-arm-msm@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>,
        linux-kernel@vger.kernel.org (open list),
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v2 0/3] misc: fastrpc: add ioctl for attaching to sensors pd
Date:   Tue,  8 Sep 2020 09:10:08 -0400
Message-Id: <20200908131013.19630-1-jonathan@marek.ca>
X-Mailer: git-send-email 2.26.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Initializing sensors requires attaching to pd 2. Add an ioctl for that.

This corresponds to FASTRPC_INIT_ATTACH_SENSORS in the downstream driver.

v2:
 - define names of PD values in a separate patch
 - split out identation fix in a separate patch

Jonathan Marek (3):
  misc: fastrpc: fix indentation error in uapi header
  misc: fastrpc: define names for protection domain ids
  misc: fastrpc: add ioctl for attaching to sensors pd

 drivers/misc/fastrpc.c      | 16 ++++++++++++----
 include/uapi/misc/fastrpc.h |  5 +++--
 2 files changed, 15 insertions(+), 6 deletions(-)

-- 
2.26.1

