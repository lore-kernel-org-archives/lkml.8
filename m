Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9CDBC352A4
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 03:11:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 811B520724
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 03:11:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C9v8ruOY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729572AbgBMDLj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 22:11:39 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:41984 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729531AbgBMDLj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 22:11:39 -0500
Received: by mail-oi1-f195.google.com with SMTP id j132so4306185oih.9
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2020 19:11:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=7Jxk3ZsRFc3/YFTDblpD+Mq1gRETolyk9jgC+WBc/KA=;
        b=C9v8ruOYZJ1gnA9z3smSBpPvTK+zMit6K2kMpLoDrciBoWOsSLSbzsG2sxInd0sIoC
         rkxTL55WnZK3YLIsZDxrxC0278hMpYbX7buLTwsS1Egxv9LjH62M3G9YwFoEktTwHZdr
         IeIME5r6sYqEf+NphUV+yXviKsRiMprrklojF8vATIBg0rl8IKxSxGaJRR0L5/CcjHY/
         rmpI0c3ZxPULgobOi9VLS39OPLSIwrQjD9Z4lJn+HANb2OdIk6OtKFPEgBWyrz3cVQiq
         Wd++CmXua+rWkMx0pEWQaGteFL3R0SqXDYPnj4UN/BiYJ9Hmx919TjqLrzB6FESS7AyN
         C+sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=7Jxk3ZsRFc3/YFTDblpD+Mq1gRETolyk9jgC+WBc/KA=;
        b=ODkXcQT7Zrot/SDO2gFF0eIsLJ7T9yWC1SIF3OtbihlTpVskefdrOndCt+mUgVykVT
         WehkXTVim3gln4ncKWvrbi0QEjlHs4+TnUfQexnAkYEQ09vXfWeMzpC/MyHeiatqCYlt
         KpBwChTcVKGZMEsOx3g4rAA2MS1kOHKfiy157jNO1vZfyTww1h/uzeT/QOXqUBCflRsq
         CX5Ydz2XNR94LPLXjxXNovOw/5F/BwIj/B3ATLpOhVJk0aEYPE34bVXVTKrTRSACnOyI
         9Jz9ergSt3IXAJ9+fbRHtS4JX/WA2DFswj0OTGh22ZzkpT3/8/3KSRLt44HoCv38ek70
         TrxQ==
X-Gm-Message-State: APjAAAXmWG6wQ+zUWXt+Uv3LsoTlpXrxGU71sGdlFxEjnNTaRYwzyu+i
        fE6qw+KPnBwpPFdLPf2jZInyaxc=
X-Google-Smtp-Source: APXvYqxvRPrg3Efx6AjL/K8iKSSEeflxng8SctmU7z/7pLjgENpcXgOzuN+ct+nuttO04suXBx9Xyg==
X-Received: by 2002:aca:b2c5:: with SMTP id b188mr1557327oif.163.1581563498253;
        Wed, 12 Feb 2020 19:11:38 -0800 (PST)
Received: from serve.minyard.net (serve.minyard.net. [2001:470:b8f6:1b::1])
        by smtp.gmail.com with ESMTPSA id u66sm311468oie.17.2020.02.12.19.11.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2020 19:11:37 -0800 (PST)
Received: from t560.minyard.net (unknown [IPv6:2001:470:b8f6:1b:e166:6491:dd75:4196])
        by serve.minyard.net (Postfix) with ESMTPA id 54FB918004F;
        Thu, 13 Feb 2020 03:11:36 +0000 (UTC)
From:   minyard@acm.org
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org
Subject: [RFC PATCH 0/2] arm64 kgdb fixes for single stepping
Date:   Wed, 12 Feb 2020 21:11:29 -0600
Message-Id: <20200213031131.13255-1-minyard@acm.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I got a bug report about using kgdb on arm64, and it turns out it was
fairly broken.  Patch 2 has a description of what was going on.  I am
using a Marvell 8100 board.

The following patches fix the problem, but probably not in the
best way.  They are what I hacked out to show the problems.

I am not quite sure how this will interact with kprobes and hardware
breakpoints which use the same code, but they would have been broken,
too, so this is not making them any worse.


