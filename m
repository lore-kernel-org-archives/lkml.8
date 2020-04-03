Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92D1AC43331
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 09:09:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 667AF20737
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 09:09:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="I6UgOsF6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390539AbgDCJJl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 05:09:41 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:55921 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727635AbgDCJJl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 05:09:41 -0400
Received: by mail-wm1-f67.google.com with SMTP id r16so6356167wmg.5
        for <linux-kernel@vger.kernel.org>; Fri, 03 Apr 2020 02:09:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=2gkr4KlFk4YS8HJyizvYsExYmXwMrzpZS3taWUjv3xI=;
        b=I6UgOsF6o6NF9f0BzLi/D3H3BGoopvvgYdtDWeA04JdW6WOZkFHu5uNuMOZfm/oyj5
         Ru8eqERQc82qE43jQrinqF4IPJQN78PmbLC+rL2uy4BM9l/XoojOQz4Zps2d+XAz/d9q
         oLcrGu8F+3c5SGT0DMpHIKFGfKV/E8S0o1eEVmRyrcPFk+rhIfP9eGoJ5ZR/6vLGHnvv
         8LRQQPJYdWOVa4gT693D/mAGx/quCtrraAm/9L/K8EfgqnvDH2xUfnwKNHbMfcgoI5Hz
         GSAOf3bEjiiVq4vxhWOUF2oSaKhxDnE3KC1zltAdd9rb2ht0I9TM1HV9/tFKvZ3QsrGV
         ntsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=2gkr4KlFk4YS8HJyizvYsExYmXwMrzpZS3taWUjv3xI=;
        b=GCoRqZDYab77qRRj6LtQmdb2yVMf4/um6B9JhCyHMl6kKWe2cIr3IGbHe9HxnpHSbE
         d/BnfiwAaDdTYcI+8FHilitLs7y2LpfaBaIQ0NUwjvuwLnFXCLidGMm4cgjI2pX5akH7
         EqgxM9RDhlfbJylnPWaO3cUYg0T0bCJTu/PFiIGiwROBNRLPFZv/frFMzNo+4m7bN7DF
         K9+Dyqaz7uBHzBY10UMlrUbf/9BkRWtSnVbHaD5Kkcu0r4W8X13/8NUP0SiEEj/qGUqt
         iBbVF/EuqwfU8V/gEbejaFntz235TkyaBqDum/KVwD2ax5D+e6OHnFCtmHJElAVhNt+m
         RR7A==
X-Gm-Message-State: AGi0Puag87rF7BMcGYFJcgdD1tSPAn3VBozxRpAMKFL2i+Zei/LGBJrS
        8wkaHXSojTeTYiiHVXJKNGW5Hg==
X-Google-Smtp-Source: APiQypKyfjADxHU3IVxi3mueR2668bfiqEq9S7GQqVwFX4lESPlqUjNus79ji9SFRGUj7sdxUHaUPA==
X-Received: by 2002:a1c:7301:: with SMTP id d1mr8023631wmb.26.1585904979100;
        Fri, 03 Apr 2020 02:09:39 -0700 (PDT)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id v7sm11114555wrs.96.2020.04.03.02.09.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2020 02:09:38 -0700 (PDT)
Date:   Fri, 3 Apr 2020 10:09:36 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jason Wessel <jason.wessel@windriver.com>,
        linux-kernel@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>
Subject: [GIT PULL] kgdb changes for v5.7-rc1
Message-ID: <20200403090936.4xygjiuct5jtbulb@holly.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 7111951b8d4973bda27ff663f2cf18b663d15b48:

  Linux 5.6 (2020-03-29 15:25:41 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/danielt/linux.git/ tags/kgdb-5.7-rc1

for you to fetch changes up to ad99b5105c0823ff02126497f4366e6a8009453e:

  kdb: Censor attempts to set PROMPT without ENABLE_MEM_READ (2020-04-01 16:59:11 +0100)

----------------------------------------------------------------
kgdb patches for 5.7-rc1

Pretty quiet this cycle. Just a couple of small fixes from
myself both of which were reviewed by Doug Anderson to keep
me honest (thanks).

Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>

----------------------------------------------------------------
Daniel Thompson (2):
      kdb: Eliminate strncpy() warnings by replacing with strscpy()
      kdb: Censor attempts to set PROMPT without ENABLE_MEM_READ

 kernel/debug/kdb/kdb_main.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)
