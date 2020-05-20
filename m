Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EA23C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 22:56:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD48720884
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 22:56:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728810AbgETW45 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 18:56:57 -0400
Received: from mail-qv1-f68.google.com ([209.85.219.68]:42451 "EHLO
        mail-qv1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728596AbgETW44 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 18:56:56 -0400
Received: by mail-qv1-f68.google.com with SMTP id g20so2206130qvb.9
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 15:56:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=S5uudwBjhFE1jaf4AL5EfN6tB/5lkdbGmgsY9l3eSls=;
        b=OvjPCzkCkyNQOByuw6FRF1qaE1PIxH4+U3DHufeJAMm1N4H0CcjLCRFwdATCIf42KT
         WDwLRRjng1nVaTkAD9KGDBm6mPhm6Q8a0cMNqCurA25wZFx86/Ff/0D/fYlXYUBCSob9
         AvzW5e7oSj0aLIU0lGr2DzeLZI+G33JAX+ZBUbBCelqGLz9wWaWbjhSdtIjPxh9/8Mkm
         37e3RmmUGwSrEL9nF30jqy5JwtEoD0wWxb/gci0zUGVv9yM1ijPMq3zSebG+xnx0O4CE
         xJiLOEduMEZfqrtvAO0pVt2PTV5Y6wKl3Kaulpiti2uypjKgydYtUTjJo1MftucunX81
         fAig==
X-Gm-Message-State: AOAM532GPWIrZzjiwkpU7tl1Cgk4g7RhprV1X4co2cNY62kBsbSfYzcA
        e2S4ryJJ3b2zdn73M3+TBfQ=
X-Google-Smtp-Source: ABdhPJxtlKhC7fRJVfiHx1iMODBzFGm+VmBll4n799yX6WDy+H1O4FqDb7c3J+ee6zwZ2xEUxM/zsQ==
X-Received: by 2002:a05:6214:1372:: with SMTP id c18mr7548074qvw.194.1590015415943;
        Wed, 20 May 2020 15:56:55 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id t195sm2221514qke.110.2020.05.20.15.56.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2020 15:56:55 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     clang-built-linux@googlegroups.com, x86@kernel.org
Cc:     Fangrui Song <maskray@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/1] x86/boot: lld fix
Date:   Wed, 20 May 2020 18:56:53 -0400
Message-Id: <20200520225654.4144534-1-nivedita@alum.mit.edu>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

arch/x86/boot/setup.elf currently has an orphan section .text.startup,
and lld git as of ebf14d9b6d8b is breaking on 64-bit due to what seems
to be a change in behavior on orphan section placement (details in patch
commit message).

I'm not sure if this was an intentional change in lld, but it seems like
a good idea to explicitly include .text.startup anyway.

Arvind Sankar (1):
  x86/boot: Add .text.startup to setup.ld

 arch/x86/boot/setup.ld | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
2.26.2

