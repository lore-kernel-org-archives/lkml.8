Return-Path: <SRS0=PjrZ=CH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA740C433E7
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Aug 2020 08:23:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D3852075B
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Aug 2020 08:23:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DzhKqam4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727050AbgH2IX4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Aug 2020 04:23:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726083AbgH2IXz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Aug 2020 04:23:55 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD0A7C061236;
        Sat, 29 Aug 2020 01:23:54 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id b17so2119498ejq.8;
        Sat, 29 Aug 2020 01:23:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=A+ePr4BS1Z98zja7dCsplHsBCgKfxFgBSR6fpgiDjMo=;
        b=DzhKqam4WpPggvejEM6VMouvSX2LDHPdCSxVvBV6/JEI4AjsUPXhla7k0XmSG4dxad
         84r6HevrWA4ozDGFzyOsoD735T7RdcEyiKBPdpUaNwwYy3tTmqrXLg4/xiM0bXUgCzYi
         m0MU2DKE5Aw7qBJre/1AMO4nXokz0eiu7aFtIROU5b7Rb1yI1QPQd7NqHYnF4eHTJ4Ys
         tQX415VtEQUJjU6MhMYUJHo/NukrDLDOdnD4YeHVQySkHFk3WS+EE0QvezX50PYSv3ZJ
         iGQj0aSj31onRuabQyrYY0uK81x74VAuVymvhBlCLt2yrvvhh+XZq1WUIGmMkvbYuOpz
         ZIww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=A+ePr4BS1Z98zja7dCsplHsBCgKfxFgBSR6fpgiDjMo=;
        b=dYRct84eKmidMijJOxJjsEW9M2j/CYCioZ+jd21XMhP/y/UzhRJV05Q2k2tiotAsJH
         HZ4R7A9ynPPNn16txDdys1FGFqid6exneFvfSxNindsPb9rsmVOWkg1NGR1yEh6BJqg8
         TuMTSFnicBa5D8HIr+uLWIjJ7TagnDSMhe/qn2umJCvs/CxtHFnzYqhL5bfULRa2kkt3
         BXvo/PMihUMd1fnhxj8DGOC8MYcrketLPDzEpWanuA5LgBvg1/+M4bonpQmzKp1mL7f0
         vfY2kei6kzsKPPf/vYcNoeTZkwyCENv3RxjvAy7esMeeJyTOrJU8ehPY9DdltSjQpLNV
         +qtw==
X-Gm-Message-State: AOAM530k9eTj3Nbf5GVfrFd86XmfkEVf1ySYkcIWRTqyAVYjqktmcq0U
        T8z5moQN2WwK+AaXi1fkVmE=
X-Google-Smtp-Source: ABdhPJyFJcNIvvPtmwdrOsdxCFCyI0FBscvF8fIa/6qoazM4ga9d69QYvrxfQ1fZUzOWnX/xbvXn2w==
X-Received: by 2002:a17:906:a0c5:: with SMTP id bh5mr2540962ejb.120.1598689433361;
        Sat, 29 Aug 2020 01:23:53 -0700 (PDT)
Received: from localhost.localdomain ([2a02:2450:10d2:194d:f90b:b3a9:1300:5b1a])
        by smtp.gmail.com with ESMTPSA id o8sm1589184eji.34.2020.08.29.01.23.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Aug 2020 01:23:52 -0700 (PDT)
From:   SeongJae Park <sj38.park@gmail.com>
To:     corbet@lwn.net
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        SeongJae Park <sjpark@amazon.de>
Subject: [PATCH v2 0/2] docs/howto.rst: Sync with original
Date:   Sat, 29 Aug 2020 10:23:41 +0200
Message-Id: <20200829082343.2979-1-sj38.park@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: SeongJae Park <sjpark@amazon.de>

This patchset syncs howto.rst for recent changes to the original doc and
fix some trivial nits in the translation itself.

The patches are based on v5.9-rc2.

Changes from v1
 - Fix mismatch between author and Signed-off-by:

SeongJae Park (2):
  Documentation/kokr: bring process docs up to date
  Documentation/kokr/howto: Wordsmith

 Documentation/translations/ko_KR/howto.rst | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

-- 
2.17.1

