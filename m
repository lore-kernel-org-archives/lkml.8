Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E407C54FCB
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 12:53:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F28022078E
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 12:53:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oQyaUavq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729626AbgDTMxk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 08:53:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728960AbgDTMqk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 08:46:40 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2C23C061A0C;
        Mon, 20 Apr 2020 05:46:38 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id v4so4541634wme.1;
        Mon, 20 Apr 2020 05:46:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pu26cOg7Ypo8qZd3E3+gaE3VF/W7RLp9DeHS6yBo9EU=;
        b=oQyaUavqXa3iGQJgooPh2t5s3nVk6PE6gxB0c0GlC/DfZjcLOyvYsSkta5NiIHZ5P8
         UQBbI/p/iyBoLeuXvcqAyjemrxuT4vrJgdEq7daMz3wZjZkIoxO+Xej4LGYiE81mBki2
         0/Nxb3YobRorIJkhJVyZTCYqydI3gZcjPjjzdqda/MLSuv7tgnAinNBTefxzkxu0aHCi
         QhO4jzu6wvo+wedkVMaGfgyiy/TpLoj/iB3P55wOOcYXkrSIvMxlsJDrU+vI48TRxA3k
         sRVv+hBuXVUv+0Kckejr5wuRG34nGnd7ZgFdRL5YQ97cS2DZAIIBdoax8UHBg6Q92ae6
         BkxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pu26cOg7Ypo8qZd3E3+gaE3VF/W7RLp9DeHS6yBo9EU=;
        b=WbX9Sdi0+DrOpfjPrEpdN2wUEsSVuiiYGCCFcxI///vV9tEdJGe0i5pAi8viWpz7eL
         jev4UCbd/4DPZMD34TPYva4bq5pjS5dUELwUYxLMtZLEeZ8R0PmfHO/jWQMT8rhs2izb
         hJ/QruqM+fCkjhAaRmCgsxtPDdt8eWFVIJdY9ywOKcdPNJgCMKUBeq5F5BozIdecr8uK
         6EJIgQKeQECbi/bhlS3EZfGUgFd0Fhv8HedB61kRu6O7A5NFWxKVuS9x9Kh2Qfhyja8J
         AvA0buM7PoXMy5I1M/gwmQpZqQE/mJqbAq6SWU7HeC9vMBD7bRXkNiE5ozD/JdTPp3xz
         2zLg==
X-Gm-Message-State: AGi0PuYGISGbPWsHhzqOLbLgg4D2wNNvIVZF/ctCac8xt/iUOmrgr37Q
        Ja3+Hkr5jmmmClfHyoHmw58=
X-Google-Smtp-Source: APiQypJ9gcFdsuDN76of2BCdFnuseMAVACiI5/xyZaIL2Ek6MR2Fx/Gsh/MUL8sNqS/VvoeZH+slNA==
X-Received: by 2002:a05:600c:244:: with SMTP id 4mr16270764wmj.0.1587386797247;
        Mon, 20 Apr 2020 05:46:37 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:1f1:d0f0:4e7:1fdd:b7c2:b3ab])
        by smtp.gmail.com with ESMTPSA id h17sm1217802wmm.6.2020.04.20.05.46.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2020 05:46:36 -0700 (PDT)
From:   =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
Subject: [PATCH v4 0/2] Add support for Allwinner H6 DVFS
Date:   Mon, 20 Apr 2020 14:46:32 +0200
Message-Id: <20200420124634.32726-1-peron.clem@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Maxime,

I have sent the v3 serie with the same command as used for the v2.

$> git send-email --to=XXXX HEAD~7

Which is now wrong because I have introduced 2 new commits.

Sorry for that I should have used:

$> git send-email --to=XXXX next/master

Could you apply these patches before the other DVFS patches to keep
a clean order?

Thanks to Ondrej Jirman for the catch,
And sorry for the mistake,
Regards,
Clement

Ondrej Jirman (1):
  arm64: dts: allwinner: h6: Add thermal trip points/cooling map

Yangtao Li (1):
  arm64: dts: allwinner: h6: Add clock to CPU cores

 arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi | 32 ++++++++++++++++++++
 1 file changed, 32 insertions(+)

-- 
2.20.1

