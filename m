Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5A65C54FCB
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 12:40:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A1EB62074F
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 12:40:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FAzJ/voy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728345AbgDWMkd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 08:40:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726117AbgDWMkd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 08:40:33 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E444C08E934
        for <linux-kernel@vger.kernel.org>; Thu, 23 Apr 2020 05:40:33 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id f8so2301601plt.2
        for <linux-kernel@vger.kernel.org>; Thu, 23 Apr 2020 05:40:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=0+ryOLHPjjzdQGdX/eoLm2N7/nB+E1jdBn6VNAC44V8=;
        b=FAzJ/voykvElRMGRs01wUk5MBYseZO0gmLJsT0R4h54+gQUDI7uTMRnnbJTgO0jDvS
         a1BUwao5OE9t7nQiTmrP6dg6ctlgrO+WPA380CqOzv+A2uHtkP0+69O6g8gHODHKA5Im
         48he4tXIAvLmZ/VihYX5yVmK5JGgNYxwF/HiVCQDO+UADytgMv7/GbDtG+WNpPegUAX7
         Fq3d0+RZQQrVKVga6JBKaKXufoh3LCTMzsEL4gv/7fl9+lc2EE0XURwNdVun7HvU3JiT
         KGrAwjpqQbAYcVeH4alLFUYV6BQ6i1CvTnH0on11JadJymQZ79aubp7pbnC1ZvOhrGAt
         B0Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=0+ryOLHPjjzdQGdX/eoLm2N7/nB+E1jdBn6VNAC44V8=;
        b=ZWitm7WbW9oZHWvmUolzXffAQlbjaHn8mmYXHcFKrXO2zZJUttnoiBk6zy50GxpEOE
         FsHdSAQ7CpxElAa/2m9RYJzvtS6mom1UZXcFisCHyvc/rUtJVXdk3pC0qpEKXotb83cN
         faFVrPxO48XHJpqn+gUMFVScaHy6XbHav9+37PwQYWE9TJAxXY1qcNBG9kv/jmcYFlsk
         3+xH4bNcAMRmph/q6Jkbq/DumOrj5MoSCuP1KZBmAOO4ZIHwe6SwWJ2X1CewpZQ+hGiS
         5SKZp8qvKFg35sXW8BT2n+gGnPp8BGctAgAyAKxuZpdVvgtvEqeqtPxxFs8ZxC4tBWGK
         RMhg==
X-Gm-Message-State: AGi0PuaGGavczcFhpqmqAJO12fTqlQZcZDIdeNZEkd7PCoIfxOYzpHbA
        4AcqUABxif7KoEecduZzreY=
X-Google-Smtp-Source: APiQypJGmqa65SxFjvfg7jYXfEUkhBqiJvCOnURrL/IHmmT/jcuCuGGzAPqOoKniUOXZsAsQBcIcRg==
X-Received: by 2002:a17:90a:4fc5:: with SMTP id q63mr430093pjh.70.1587645632615;
        Thu, 23 Apr 2020 05:40:32 -0700 (PDT)
Received: from localhost.localdomain ([122.181.63.84])
        by smtp.gmail.com with ESMTPSA id u8sm2248237pjy.16.2020.04.23.05.40.29
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 Apr 2020 05:40:32 -0700 (PDT)
From:   Vamshi K Sthambamkadi <vamshi.k.sthambamkadi@gmail.com>
To:     bp@alien8.de, tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com
Cc:     Vamshi K Sthambamkadi <vamshi.k.sthambamkadi@gmail.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/2] x86: fix build warning int-to-pointer-cast 
Date:   Thu, 23 Apr 2020 18:09:46 +0530
Message-Id: <1587645588-7130-1-git-send-email-vamshi.k.sthambamkadi@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please review.

Changes in v3:
 Copied kstrtoul & _kstrtoul correctly from lib/kstrtox.c to boot code
 as suggested by Borislav petkov <bp@alien8.de>

Changes in v2:
 On 32 bit, if supplied physical address overflow acpi_rsdp pointer
 return 0 from get_cmdline_acpi_rsdp()
 as suggested by Borislav Petkov <bp@alien8.de>

Changes in v1:
 Supressed build warning through Makefile change

Thank you!

Vamshi K Sthambamkadi (2):
  x86: add kstrtoul() converter func to boot code
  x86: fix build warning int-to-pointer-cast

 arch/x86/boot/compressed/acpi.c |  6 +++---
 arch/x86/boot/string.c          | 43 +++++++++++++++++++++++++++++++++++++++++
 arch/x86/boot/string.h          |  1 +
 3 files changed, 47 insertions(+), 3 deletions(-)

-- 
2.7.4

