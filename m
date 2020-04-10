Return-Path: <SRS0=VV4q=52=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 890F5C2BA2B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 08:52:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DE2E20757
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 08:52:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fbEA6K3h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726594AbgDJIwe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Apr 2020 04:52:34 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:37047 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725893AbgDJIwe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Apr 2020 04:52:34 -0400
Received: by mail-wm1-f65.google.com with SMTP id z6so2017880wml.2
        for <linux-kernel@vger.kernel.org>; Fri, 10 Apr 2020 01:52:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:content-transfer-encoding:mime-version:subject:message-id:date
         :to;
        bh=+A2FBT+EgaTV4x8K1+NWhSsfJl1fW7GZeR05aSrVv9o=;
        b=fbEA6K3hGjdH1B9nSYa1KWJ7nnpc/UR3lZt5JDCv2VCYqM7opgxbBre/XiUylHH30z
         VwnXUSCXKzntxXGK3yXA38iNvbdCVqJwLeRdB88IT8FbPNScy5ks6OjFwwMZJLDEtqnA
         WaQiL7qrBvSLksKBcKbkDRdHq90w9munUq8hr7B2FxjhDTCWfy2v10/95LJmG0bgUvV/
         +Ec8ckLPguObZ1F/tQnMt7BihFO9sAPEWcr+Du9X2dJ7pYaiQj2FbpLzuESNdTgy6yOH
         jI0fsX1v9dexC5ysVccYqR191FGKL+gYIvfgt6pzXdWJNTahNDT4NnhYM2obmYITCvW6
         qEfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:content-transfer-encoding:mime-version
         :subject:message-id:date:to;
        bh=+A2FBT+EgaTV4x8K1+NWhSsfJl1fW7GZeR05aSrVv9o=;
        b=G5cp/e16fOmUmUUsK24jzwlum3KRRmAfGsop2im0lusMvQ8SAYFMs/BiZrY4w5EHiv
         y3ljIVVC+6+pQ3bMI5QwV3L6mXRsMmJVceGywkzvuSJylNkoLsNGT5cHaAE/73vkRz5u
         fXRnhod65kWd62AfD3nRlF5oliXvr+lCg1a9Ol0yLfldxccErYWQgTnpOS2IxuXeqhrV
         6sERZih40bB4M9KKzSYKIXLktU6aeIrWUSDN+6gGj/JFm734cFlWUlQw+V6QhX4emraH
         /sRvp1QBYhJG6uadZy6OW4jhdBUXlY1LqbJjzYGWKjOcQQ7obPCNJ6uxMvJdqMFvTH6Y
         +ejQ==
X-Gm-Message-State: AGi0Pub5dfho67w02rAqiRqDV1+jzJzP9fNlTVJHKCc+9LUXFlqjK1Q9
        cTY2nTJPiwQYMNphvyL7ffSNOTH0+sk=
X-Google-Smtp-Source: APiQypJBcNWtteuMj944OkiOxHUdEe5WUIlm53+V8HQqRT8QbfG3RLwdYWq1CCM76tXH4Fx+JJHVbw==
X-Received: by 2002:a1c:b356:: with SMTP id c83mr4335880wmf.10.1586508752747;
        Fri, 10 Apr 2020 01:52:32 -0700 (PDT)
Received: from [192.168.0.5] (cpc147642-aztw34-2-0-cust65.18-1.cable.virginm.net. [92.232.187.66])
        by smtp.gmail.com with ESMTPSA id n131sm1862507wmf.35.2020.04.10.01.52.31
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Apr 2020 01:52:32 -0700 (PDT)
From:   Jim Cownie <jcownie@gmail.com>
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: perf c2c man page typo
Message-Id: <8F166394-C091-4477-B90A-1DBDE7C5D3DA@gmail.com>
Date:   Fri, 10 Apr 2020 09:52:31 +0100
To:     linux-kernel@vger.kernel.org
X-Mailer: Apple Mail (2.3445.104.11)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The perf c2c man page (at least as rendered at =
http://man7.org/linux/man-pages/man1/perf-c2c.1.html which says it is =
derived from =
"=E2=9F=A8http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git=E2=
=9F=A9 on 2020-02-08=E2=80=9D=20
contains this text
           Store Reference - Total, L1Hit, L1Miss
             Total - all store accesses
             L1Hit - store accesses that hit L1
             L1Hit - store accesses that missed L1

The final line there should clearly start =E2=80=9CL1Miss=E2=80=9D.

Enjoy.

-- Jim
James Cownie <jcownie@gmail.com>
Mob: +44 780 637 7146


