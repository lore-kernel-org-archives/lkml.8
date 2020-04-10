Return-Path: <SRS0=VV4q=52=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_LOCAL_NOVOWEL,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDBC2C2D0EC
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 19:53:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B34DA2083E
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 19:53:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qAg92dm1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726671AbgDJTxp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Apr 2020 15:53:45 -0400
Received: from mail-pf1-f175.google.com ([209.85.210.175]:40842 "EHLO
        mail-pf1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726263AbgDJTxo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Apr 2020 15:53:44 -0400
Received: by mail-pf1-f175.google.com with SMTP id x3so1190522pfp.7
        for <linux-kernel@vger.kernel.org>; Fri, 10 Apr 2020 12:53:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GnS+iKPshB2H+iJx2B0bBeNxXYNge8mXSC0GNXOAR6E=;
        b=qAg92dm1m90uJbKfYO0c0g0rgZ3OyQah5Ijz3Nx2D7DW9+pNksOZBVrn6JtbETCaup
         QVTWEdPHIf8gAcaZJExiXN7j8owgBiGl0/9c+aqvFUWIrCLnvu9AvqJRfwQndqsXxV96
         zueVO/zOpS/xkC0zEgDXwm2Jnz1+pfnODPV5iwLbrwkNg8diNhhl0dlLaELC3PjlxGLt
         PCXN+Ab5Pr3GB6D3NnyGPFYrA2/9fx1VP7z6cTvD5IaTEcQsAZOnbrgDyaZrtHGTXooI
         7+6v0TZiL1GYqwWSZUpywkSn/1iG/LoEbPp5gMmbBsmHvQV8buJvcSX//wx9w6jcYxJq
         hlDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GnS+iKPshB2H+iJx2B0bBeNxXYNge8mXSC0GNXOAR6E=;
        b=tqU3sGIP2KWHxSYIbGKyqHvDMQhai31V8tA4b+YYNWNQI0bqzVjf7LP8Q58JiyLozi
         0MjjtQTNfRrNVSEpNaesRDWLbHXfSjLFAEdaPYQfsdJWRnOUneZ11zqiqZ/u3uPXbltV
         Ke7UeGUw/HPxqM94dEny6RtiJ2hynRo7FKyrpQ0VA8PaBeSJsNjcBgMc0nNGpwVQguzl
         0MpfDf0JcjdCBPDYxV3AQR2OAVlvYRg7tTCvtuHItqS8Q12BJN3byONIKlo4z93FhOMx
         EpnK3Pq0ybSr8NAEOZK1Vc7gGjPkSOffqQcLs+JpxQvIeUPyyLo/vBHfZZAHpoENcSPY
         Qb1w==
X-Gm-Message-State: AGi0PuaJHGorsrw1n14gp3RFSsEvzP9KgcHYCdeG7rSTAGh4VcLZnSvb
        rbCkOFSLNl2oH3UrD5CDBK4=
X-Google-Smtp-Source: APiQypKtqv3FkYH83kX4elGfmQtsEbuXFeu29FerD++flwUmaRjooBkKO+s8F/RccjUYQxUoI3jMCQ==
X-Received: by 2002:a62:5341:: with SMTP id h62mr6375982pfb.183.1586548422818;
        Fri, 10 Apr 2020 12:53:42 -0700 (PDT)
Received: from octofox.hsd1.ca.comcast.net ([2601:641:400:63f0:a487:3b8:7ffc:c9e4])
        by smtp.gmail.com with ESMTPSA id w142sm2468983pff.111.2020.04.10.12.53.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2020 12:53:42 -0700 (PDT)
From:   Max Filippov <jcmvbkbc@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>
Subject: [PULL 0/3] xtensa updates for v5.7
Date:   Fri, 10 Apr 2020 12:53:31 -0700
Message-Id: <20200410195331.12735-1-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull the following Xtensa architecture updates for v5.7:

The following changes since commit 98d54f81e36ba3bf92172791eba5ca5bd813989b:

  Linux 5.6-rc4 (2020-03-01 16:38:46 -0600)

are available in the Git repository at:

  git://github.com/jcmvbkbc/linux-xtensa.git tags/xtensa-20200410

for you to fetch changes up to 70cbddb973859158731ce77ab20cd5e53822c089:

  arch/xtensa: fix grammar in Kconfig help text (2020-03-30 13:35:31 -0700)

----------------------------------------------------------------
Xtensa updates for v5.7:

- replace setup_irq() by request_irq();
- cosmetic fixes in xtensa Kconfig and boot/Makefile.

----------------------------------------------------------------
Hu Haowen (1):
      arch/xtensa: fix grammar in Kconfig help text

Masahiro Yamada (1):
      xtensa: remove meaningless export ccflags-y

afzal mohammed (1):
      xtensa: replace setup_irq() by request_irq()

 arch/xtensa/Kconfig       |  2 +-
 arch/xtensa/boot/Makefile |  1 -
 arch/xtensa/kernel/smp.c  |  8 ++------
 arch/xtensa/kernel/time.c | 12 +++++-------
 4 files changed, 8 insertions(+), 15 deletions(-)

-- 
Thanks.
-- Max
