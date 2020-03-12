Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67D01C2BAEE
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 00:22:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FB1620754
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 00:22:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MmlVyRPr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731605AbgCLAWI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 20:22:08 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:55302 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726194AbgCLAWH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 20:22:07 -0400
Received: by mail-wm1-f67.google.com with SMTP id 6so4181865wmi.5
        for <linux-kernel@vger.kernel.org>; Wed, 11 Mar 2020 17:22:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/Y07gbfPjF/rDVII6hbI+/pDFRnbg5DF5S+FUcUOsKo=;
        b=MmlVyRPrIaPl3nCRHHcDC/20Sr8pYadVfiz/QxL0Xb1YfW84qOrgiY1GJpzt9CNXb4
         Y1BzdFWTAMc9X+QbFWvalnFFSCEibFi4NcIdzLhEFg2PHIQuw5MkD8siLW+8fpD8zc2y
         vWkt6OzVNAuuT0RvZ8F9k467fiktgLv7bjoogUgja0gLjA3L4BZRNl/BUUtAbwlCykvG
         cPAfaYErTmOXY9WBqr/Mv7tSNMxvnEk08uDIMkMe+EMoYP7nWnfIPjHo6HBUMGJlZPAV
         rPQVIGrLQeD5i5EUDqVdqCBwy454PzYzB7BBG8AVwXvpHr96sgdXQPhSyMfZotpM1H7j
         oHMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/Y07gbfPjF/rDVII6hbI+/pDFRnbg5DF5S+FUcUOsKo=;
        b=rYsR3UF9K58NCtmxw81QJP8hHudsr+jtQr8xtvdUsBnQSe5c2g9OJNMseEPEumQS+n
         RQsd/v7hOBIIWO0157feUT5BsT1G7sci10QjXBTOQkKBy1GAn++tY1Cftsl52+h2VjWh
         VD0ipGTwEnTyTwNcZMfi5sIc736Hoy7MIK0cRQetx4PVsAlrumKTJK/mUUww4WQLVGy3
         S/zqlg0AD+jH3nxevTmuHcoC1Q24FawQeWraUi4/8Q53xmFW6QVxfNgQMtniLJaSbyBE
         gz6nOsU7plGNqm00S5xhJMbCRLw+6uzF7czW+UVfVj/ZH6mktljWZfBW4VTWF4OeMcX4
         Ug5Q==
X-Gm-Message-State: ANhLgQ3urBJWMvodIeEX7HP+SHNGdTgK8k0Hf7JDmJgpoujcRb/u9whF
        fC4NeIoGIZO6hHhiollxQA==
X-Google-Smtp-Source: ADFU+vuCvxULa3JEnprAXgBLXGgXtbV/Ki5Ic449nRaBfHz9jsFrSrK7PdZzKqfirOlGVDXpNDHB/Q==
X-Received: by 2002:a7b:cd13:: with SMTP id f19mr1344348wmj.10.1583972525650;
        Wed, 11 Mar 2020 17:22:05 -0700 (PDT)
Received: from ninjahost.lan (host-2-102-15-144.as13285.net. [2.102.15.144])
        by smtp.googlemail.com with ESMTPSA id w9sm35254337wrn.35.2020.03.11.17.22.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2020 17:22:05 -0700 (PDT)
From:   Jules Irenge <jbi.octave@gmail.com>
To:     boqun.feng@gmail.com
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/1] Refactoring wb_congested_put()
Date:   Thu, 12 Mar 2020 00:21:55 +0000
Message-Id: <20200312002156.49023-1-jbi.octave@gmail.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi
I expanded the lock function refcount_dec_and_lock_irqsave(&congested->refcnt, &cgwb_lock, &flags) 
and rearrange the code so that it can look simple and Sparse will not throw a warning.
Please feel free to leave me any feedback
Thanks

Jules Irenge (1):
  backing-dev: refactor wb_congested_put()

 mm/backing-dev.c | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

-- 
2.24.1

