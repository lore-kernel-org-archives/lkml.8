Return-Path: <SRS0=BhYR=34=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1F64C35250
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Feb 2020 11:20:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8D8D20726
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Feb 2020 11:20:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="fXEJwVBl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727175AbgBHLUd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Feb 2020 06:20:33 -0500
Received: from mail-pj1-f42.google.com ([209.85.216.42]:52312 "EHLO
        mail-pj1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726970AbgBHLUc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Feb 2020 06:20:32 -0500
Received: by mail-pj1-f42.google.com with SMTP id ep11so2060370pjb.2
        for <linux-kernel@vger.kernel.org>; Sat, 08 Feb 2020 03:20:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ljpS3PkVVMGrf7RsA17UJi8czPEMPANgJ4hzQfBJIBE=;
        b=fXEJwVBl+Nx6n9uFdw+2qXi8608Wt3D+SrzgUmRPMlyQ5bQzhdLV50s3sJCRTbUpnF
         xYIZ2OqdnMpf5WxmZUFRcvp8SMW1fJelmJuhUDRJqILH2p1662AopsEZBd9FxFDUI3a2
         SHzx1D3BRRVilg4Gyqcv4EJvq1wfFF6HqGtBU8CleysRIphvWhm+5StZTdyRfS3Y/4CW
         totiPq6gd0ioRgmqLbv1gi7jpL6zBkAng8NH2O3hP4cFnFoHa7NcE7itqjRuLu41iEJ7
         WKHYXJXKRVfX7jK9+QStXJSUyxm+RZWVBFlsldKXl1WF+qfk+bIWfJp+RPzcGPoQ5l5f
         DrCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ljpS3PkVVMGrf7RsA17UJi8czPEMPANgJ4hzQfBJIBE=;
        b=ZRiB9Woyf6V+abriXNslf0+j6oXqaP/XqnctT04CtYEoFkud/Xet4B4/WtUKeoU/cS
         E8d8CVuhfod3bSIYrKKcVLIW3KUMuwrZmeH4f0YGTiqtIAvoe0NezGw8QJ/r8VNVdALB
         UFDQtUgtA1hPlRqLnBNg3I3H3zrZi4LyPeX7eyuWnXYtcLWnIEwD1tfa2yEJWwKKFxSv
         SskMFVhsgxF4+ob8Mr7XHs/tOQxZVSn2U4IoILU53LFb40S7re5vbmtgrY90fww+e9sD
         jtCb4hp4qJdy1gbsrXuVOtNYPzsBg3pkiiNGf+MRnEShgiQ0QSoVTD7HzjDt25cOoET9
         Y7/A==
X-Gm-Message-State: APjAAAWJyy0PMpgezTvridNaLnEujnii9/zueZsRyE+V7/+npKGPgsnc
        zH/bv1a1IGDG8J+ZMOWbgB7saJMqbQ5YRA==
X-Google-Smtp-Source: APXvYqxE0q3H6VeLXgKS1duTDycKaHyBh+oH1G+2Z9b/aQTAqmKLooI8ohPfdOU8o7fSlNccjGudlQ==
X-Received: by 2002:a17:902:467:: with SMTP id 94mr3536884ple.267.1581160831876;
        Sat, 08 Feb 2020 03:20:31 -0800 (PST)
Received: from localhost.localdomain (99-152-116-91.lightspeed.sntcca.sbcglobal.net. [99.152.116.91])
        by smtp.gmail.com with ESMTPSA id a19sm5707281pju.11.2020.02.08.03.20.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 08 Feb 2020 03:20:30 -0800 (PST)
From:   Olof Johansson <olof@lixom.net>
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        arm@kernel.org, soc@kernel.org
Subject: [GIT PULL 0/5] ARM: Changes for 5.6 merge window
Date:   Sat,  8 Feb 2020 03:20:13 -0800
Message-Id: <20200208112018.29819-1-olof@lixom.net>
X-Mailer: git-send-email 2.22.GIT
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Here are our pull requests for this merge window. While I've generally
been bad at getting these in during the early merge window, this cycle
is unusually late due to travel and bad planning on my behalf.

Good news (and part of the reason why I didn't stress getting them in)
is that it's a relatively quiet cycle w.r.t. conflicts and overlapping
changes, only one driver had minor conflicts (described in 3/5 pull
request).

Most of the new machines/SoC added this cycle are described in the
Devicetree pull request (2/5). Some of the highlights are Amazon Echo
(gen1), Google Coral Edge TPU and SolidRun HoneyComb/ClearFog 16-core
ITX systems.


Please merge. Thanks!


-Olof



