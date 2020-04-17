Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A29FC38A2C
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 15:12:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2741321924
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 15:12:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="rq2k6P67"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729000AbgDQPMH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 11:12:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728272AbgDQPMG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 11:12:06 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 690A4C061A0C
        for <linux-kernel@vger.kernel.org>; Fri, 17 Apr 2020 08:12:06 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id hi11so531386pjb.3
        for <linux-kernel@vger.kernel.org>; Fri, 17 Apr 2020 08:12:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=VssLVJtiB325wjdikuLcJO7qQVio1ynuoUzBYLGhnNA=;
        b=rq2k6P675E8FoDCpcGOEyjYIk5Uu5aNHQHq/wjW42K2inZYWG54BH4x3amLttLWrew
         jQVZAVPQhT6izA1LzJAKUn6lHqdRrLsLrbJ//hVQgsTCpzn3NCYDI5qsFTmM7bDm3rq9
         7vMsw2WYNAETz5majoV2NIn2AE742Cu7KjVT936+lqATI6C8j4YVG7LOXgY6CJMLCRZF
         toy6pjvJGreL8tJUaTsRMf8k52xpUt9eNyGl+nQ/51f1jgf09l2JLdc+irrGvC5SntCS
         GHUIzoY1MHbEOu4fKlOhhHFa7yZk7hBLiyWyvieZLqxUPMZqi4cRYFZtDkvjJJXX1MEI
         FLsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=VssLVJtiB325wjdikuLcJO7qQVio1ynuoUzBYLGhnNA=;
        b=WpzPFdMCH03dd9lqCxd5vM55gTL77CrV7t6++yShwhASlt7YydAwJ4KHwfUJtYHhgx
         VZJU+5hP3Ckt67FQFbnvJPnheDpkP5D8RN/4zF157xRnx+zVb3r9LoWuAy5RnBtnEuLZ
         CMXPLe4CmhegrzP0YPP1Fqzjtw/RMTsBrC0//BKdortyfA6752Y4pMWOVJJ3nHUJ9iiv
         m6fsPfs+WPszM+M3MIU3B/QphQ6KCp1GYR8DUnPIAarU6cGVH1XtxfcE8fyHyYM++lht
         51V2X/r3K+W7CiNssJVhd7SYv/ZXxst7qdGccAtc0ntCyxx4SLezlmllt5K7chmTd9rL
         yFIA==
X-Gm-Message-State: AGi0PuYpw2K6GJg6gOBCJfalDewTg+zpZtpfxw5TA3h4i0VknHTLBKrH
        szPro9hMz5AlmkcPje8sUNxMq1rPUgOViA==
X-Google-Smtp-Source: APiQypINOYdpsKWP7KepoP5+mAhJ99M+w/Qzo8/kTs+zMqUSKPmGL5ez8nr9Lie1TaawbtoChO0pig==
X-Received: by 2002:a17:902:9b95:: with SMTP id y21mr3919438plp.101.1587136323895;
        Fri, 17 Apr 2020 08:12:03 -0700 (PDT)
Received: from [192.168.1.188] ([66.219.217.145])
        by smtp.gmail.com with ESMTPSA id c84sm11569505pfb.153.2020.04.17.08.12.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Apr 2020 08:12:03 -0700 (PDT)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     IDE/ATA development list <linux-ide@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] libata fixes for 5.7-rc
Message-ID: <635fe4ef-c1e1-cba6-f4f6-a0c795b5fac8@kernel.dk>
Date:   Fri, 17 Apr 2020 09:12:01 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Add yet another Comet Lake PCI ID for ahci.


  git://git.kernel.dk/linux-block.git tags/libata-5.7-2020-04-17


----------------------------------------------------------------
Kai-Heng Feng (1):
      ahci: Add Intel Comet Lake PCH-U PCI ID

 drivers/ata/ahci.c | 1 +
 1 file changed, 1 insertion(+)

-- 
Jens Axboe

