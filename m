Return-Path: <SRS0=L1Qp=6D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE2D9C3A5A0
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Apr 2020 13:52:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF773206F9
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Apr 2020 13:52:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SwuyYD/w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726424AbgDSNwP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Apr 2020 09:52:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725969AbgDSNwP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Apr 2020 09:52:15 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D1E0C061A0C
        for <linux-kernel@vger.kernel.org>; Sun, 19 Apr 2020 06:52:15 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id w65so3599633pfc.12
        for <linux-kernel@vger.kernel.org>; Sun, 19 Apr 2020 06:52:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=a2JPTNHsre8TtIIWil0DekMhDjcaFRhKr/80hktKWDo=;
        b=SwuyYD/wnOZgLWkmUkd+9Jro/vGvMGLtNSs/GlsuwCjuKTDS9O4uPY6agKwbtiCXlW
         aM6mVIRyPqR8eLt+0VsCpLDfBhd2Lzkdzvcu8ODSmMTfrOTIvalhJCsPJWFpUfrABiKE
         /zK/dXuJwLIZ+3pMBTM1ZTpA5GdR/i0hxT5z6JYxY5J1zaeGA0yTmTbuwXVmYKGu5ejO
         2M0C0lpJGtGTfOddmBXcEnoC6rA/rTcTFCRkhoz/T88OBlUNzcVkK0vTtWXDnHbe10qv
         H16AFvh3I63Cdl6Fc5HgfyOddxOgc5stvclSN5bWT17vommQwT3uHDkCUKnWTkmXsLwV
         v27Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=a2JPTNHsre8TtIIWil0DekMhDjcaFRhKr/80hktKWDo=;
        b=InBdSdrnyI8CXfM1tcyz4CEeoINXm2PURKGR+tWuVE4ZT45BaKUbfE06OTSgYph38G
         EjTExeWnTpdpbskwRv/N/ccH11TAvue6PahpgCpQHvmpB26/CLBj+HiNn4nRGPAJZj8L
         XMkOGPnzJXzmh0U73SuN3WrLhUAu3uNUms8PUGhqDP/7yFYU3UG+7HXG1efzGUjGRr5G
         IjwWN1VvPVi5oafI2qgOQm/lo44v4RzklLZ0GcXNvPB/Nc6X1ignyP1WSmHMrP7vfGum
         Kj4hxXDpnGoEVFdYgyIRwGb0jOim/n3nP1T7isnBxWE3vyInagl9lYCzE4u0Qfvxlfq9
         5hJA==
X-Gm-Message-State: AGi0PuaGuebbizrcmGdDKGdWIe5XzmYuDEhGqvru0BQBVpwdJ1SD0QQ/
        59Tw1lo9a7yQ6frtkskY+1Y=
X-Google-Smtp-Source: APiQypIUirpVQ73XVpwn2vrZIR+wugyDGUlfFujU7pNtJBbQjPX/c0lJ3XV9AP91vKZlx4LuoPPoHg==
X-Received: by 2002:a62:8202:: with SMTP id w2mr12155579pfd.117.1587304334936;
        Sun, 19 Apr 2020 06:52:14 -0700 (PDT)
Received: from localhost ([89.208.244.140])
        by smtp.gmail.com with ESMTPSA id s22sm25286904pfh.18.2020.04.19.06.52.13
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 19 Apr 2020 06:52:14 -0700 (PDT)
From:   Dejin Zheng <zhengdejin5@gmail.com>
To:     broonie@kernel.org, linux-kernel@vger.kernel.org
Cc:     Dejin Zheng <zhengdejin5@gmail.com>
Subject: [PATCH v1 0/2] use read_poll_timeout macro to simplify code
Date:   Sun, 19 Apr 2020 21:51:48 +0800
Message-Id: <20200419135150.14741-1-zhengdejin5@gmail.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

redefined regmap_read_poll_timeout and regmap_field_read_poll_timeout
by read_poll_timeout to simplify code, they have many similar codes.

Dejin Zheng (2):
  regmap: redefined regmap_read_poll_timeout to simplify code
  regmap: redefined regmap_field_read_poll_timeout to simplify code

 include/linux/regmap.h | 48 ++++++++----------------------------------
 1 file changed, 9 insertions(+), 39 deletions(-)

-- 
2.25.0

