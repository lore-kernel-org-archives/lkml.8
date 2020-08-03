Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90DBFC433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 01:15:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 75702206E6
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 01:15:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726825AbgHCBPh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Aug 2020 21:15:37 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:33138 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725820AbgHCBPh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Aug 2020 21:15:37 -0400
Received: by mail-qt1-f195.google.com with SMTP id 6so27200480qtt.0
        for <linux-kernel@vger.kernel.org>; Sun, 02 Aug 2020 18:15:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bdvA4w6Bwj8TJ1EZmhXyGVXgKTLjZhrZ4On5mhobaSE=;
        b=ZdYQPVUFoYXP3/CPtUwIfKKWGLPOusewaDIn1msRxvq9Ic7Pj75Fija8YtaT7WLXtJ
         iT1Et5jo7UK3tvn47lLmljJsVYPP1EQXljrX72UUWqiUAgPO9n5CMy1lOwH0m3mbG3Rf
         TElad4zlMlxMpLoeg+hSjSwlvKJbmhAmv4w+fhJdXnSyFs8zoQd8p7reGiL7H22GpznF
         XZCWpx0ICf3+dFGTRCArfO1mHUz0OTASEAGd7FoFkRB3l9VaBRzClsTiFOyl/PTvSsgk
         10ZYTsAq2vGMdNxOpeL/S15yuZSgoLWSc9ERhn33h88BCoeYKjq/wumC4IzsPCTKSsYn
         BrcQ==
X-Gm-Message-State: AOAM531pm2yGiuOEC1/mxpmrWjJYs/AgatkXrdgmxh85PhwdljW0LLRi
        pu5fiIXBWNkwjNfhRk6BfbA=
X-Google-Smtp-Source: ABdhPJyw50UErO10DBBY0z71R4xhaG+D5zj3ulYbxlA+0OXb6ztgNaxVU8aGucio6p1UOfRo3XptSQ==
X-Received: by 2002:ac8:7297:: with SMTP id v23mr25654qto.154.1596417336110;
        Sun, 02 Aug 2020 18:15:36 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id q29sm22015801qtc.10.2020.08.02.18.15.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Aug 2020 18:15:35 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     Ingo Molnar <mingo@kernel.org>, Kees Cook <keescook@chromium.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/1] x86/kaslr: Replace strlen with strnlen
Date:   Sun,  2 Aug 2020 21:15:33 -0400
Message-Id: <20200803011534.730645-1-nivedita@alum.mit.edu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <202007311632.54A7554192@keescook>
References: <202007311632.54A7554192@keescook>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I'd like to add one more patch to the series if that's ok.

Thanks.

Arvind Sankar (1):
  x86/kaslr: Replace strlen with strnlen

 arch/x86/boot/compressed/kaslr.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

-- 
2.26.2

