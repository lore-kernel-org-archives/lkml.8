Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07D55C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 19:51:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6A9A206E9
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 19:51:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="h+VsbrHo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728310AbgDCTvy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 15:51:54 -0400
Received: from mail-pf1-f171.google.com ([209.85.210.171]:45931 "EHLO
        mail-pf1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727873AbgDCTvy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 15:51:54 -0400
Received: by mail-pf1-f171.google.com with SMTP id r14so4027639pfl.12
        for <linux-kernel@vger.kernel.org>; Fri, 03 Apr 2020 12:51:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9gQpMpP65smhU9h4fCxGG/DL26lj4XPv0cgPw/bIETY=;
        b=h+VsbrHoeL2K991q/zwn2zBwZp9oObUS/klUUb0ba5Xz+CI8LR/NHkR/F9+NMtU/HZ
         U87+M6hEmP1SJq4C+W4r4vex5FZTrwQEPJv/tMZU2eg63xmq/UPkn/qAVTD5e/hme0QT
         sGri8EjFqoyim5+8h9BOT1deGwEssInCFiRU9mUr3AH9No0yrwR+xp647Z6HiKGOJG1l
         mP983EgHZ4cQqTi29cfCcUATvYOvb6gFNAQMr04TXiHczx1J7+WCDiLQYMAoXflVjCeq
         jsxso78SkSipZjyvutqkRlDmhM/D4FjLP/xzCsBYyIcKtJiycSwPno3XFgC6UR1yI0yJ
         12Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=9gQpMpP65smhU9h4fCxGG/DL26lj4XPv0cgPw/bIETY=;
        b=jgL8ZQJXQcHdqx3ltRKLhKMd2O4BCqWo1VaFnHLvBvioVE+aRqLB7J2sbTkZcK3JKX
         tMJax88QpU13nT3OEA8zPg0nQRdoXJIL+FKJwodgWXP3/KjcJ4E+FuKqkjAPQ9v8VWYd
         0N97bu2qbpsPViWXB7yefw5THcwuEwv60iut39F3Em8zm/yu+eyS9fbkNsPqIxebE1Ck
         QSKOFMV63ZGjdnapLdrO3Z1TTxW0RvFCNlzCCZ5ig9ukWZVOXNqFBmhibPyplcdzfGK/
         Xh9xFh9/+WxOBuCBYm3YAIWiE00BnVKtI5rhMkJV3UNoEkHRLjb2O2hkIeEDQSZVmz1c
         fCJQ==
X-Gm-Message-State: AGi0PuZwrLMXaup1iWfEsK0jD18C7UPV4DNvWO/eHrd6AbDWYyMlcLbb
        dLKhUJwBR43vrr0mKGalOrAhLQ==
X-Google-Smtp-Source: APiQypK6eaKDH374gWinPksnmI/KFYMVfn16Q0XQhiv0hhYFhpiB0PC8os24xQIIqPfiER3Xbt5/Ag==
X-Received: by 2002:a62:19d8:: with SMTP id 207mr10308346pfz.278.1585943510950;
        Fri, 03 Apr 2020 12:51:50 -0700 (PDT)
Received: from nuc7.sifive.com (c-24-5-48-146.hsd1.ca.comcast.net. [24.5.48.146])
        by smtp.gmail.com with ESMTPSA id h15sm6375239pfq.10.2020.04.03.12.51.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 03 Apr 2020 12:51:50 -0700 (PDT)
From:   Alan Mikhak <alan.mikhak@sifive.com>
X-Google-Original-From: Alan Mikhak < alan.mikhak@sifive.com >
To:     kishon@ti.com
Cc:     lorenzo.pieralisi@arm.com, bhelgaas@google.com,
        linux-pci@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH][next] PCI: endpoint: functions/pci-epf-test: fix memory leak of buf
Date:   Fri,  3 Apr 2020 12:51:34 -0700
Message-Id: <1585943494-23977-1-git-send-email-alan.mikhak@sifive.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <20200401223541.403438-1-colin.king@canonical.com>
References: <20200401223541.403438-1-colin.king@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Colin,

Please note a similar leak in pci_epf_test_write().

Regards,
Alan Mikhak

