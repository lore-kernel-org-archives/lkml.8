Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F422AC433E3
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 07:56:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD8AA2076E
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 07:56:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GffYcyO/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726952AbgHTH4t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 03:56:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725916AbgHTH4l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 03:56:41 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAFCAC061757
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 00:56:40 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id d188so639453pfd.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 00:56:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=F2MDOdd0OoGgs6vybFQeYltao1MwvNlpVYOoAb0GyvA=;
        b=GffYcyO/OAQ/1rdq8V28TDq9AIAg37ScewFaIl2hjHMeSYZQi+As5RX8GwIjRa8MzV
         34vz0u+AX9Fw0mNdO4kryIvMgWAShDuvBg5c4r4MFzT7iE7w92D/11ZkHT+iq3GHe3Jp
         KLkPKEuje6/33Kz+NPZDrWx7wtem5Ei/zHFRLICpXDF/LyELxK3OiCaaRM1zCP9rqFQc
         EVO0Hn32/NIVd0AWRSHwkE9ZPnNY8VVIXErTHsu0CSK3GFGeXwyhAeQ7qDEdFqhKZapi
         hrhSq2UML2xWrsewgbA1gIyMaai6mHw7LInNMdsbdRWH4rkRIcnmjBK4tWsxO2YHU1J2
         9FZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=F2MDOdd0OoGgs6vybFQeYltao1MwvNlpVYOoAb0GyvA=;
        b=Qe6OXZ9/KoVgq7Op0gpQ4PpFR5i4SzhgAtk5YQEHXuwFamPgxepS7CndOtngOL99Mi
         QOyaxKSwHnIorMQ9Xa1rHJ4N7uv9biadksx6B6LPR13ZghhQAV+ujjRL22m1IgavoTVB
         itxrl4/lLf311fOlLaPMu3xxgnbugKY6Aqpp4BQE1lq+3jAlAdl8nRKIVaZUCtkDE6kw
         SIOazsADrmjozVzHyNb9krZRfyv4St9hrv2FCLVZ/80nyQnCPawUcpVT+qKgCA8icwcC
         PK8SaJug6ouuP3TdfkaNjvC7hA36yqWFyfNA6eqDdiS15HhZkgnajkHIJ3WT0myVzC8c
         5TdA==
X-Gm-Message-State: AOAM533HW8OCVjDYIQq8rqsl2EQmC+YMWWqXiTUEjI4+8tzH7U61mece
        liokhh2Lssrq9L80pupalOuryA==
X-Google-Smtp-Source: ABdhPJw4Jn/0zPBYEpwTrrLIH/dTHNVC20asNC+zntqyl/7FF3D+c5UZ47geLTS8Gtrc8eaILv75nw==
X-Received: by 2002:a62:6186:: with SMTP id v128mr1349832pfb.211.1597910200301;
        Thu, 20 Aug 2020 00:56:40 -0700 (PDT)
Received: from localhost ([122.172.43.13])
        by smtp.gmail.com with ESMTPSA id q18sm1706490pfn.106.2020.08.20.00.56.38
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Aug 2020 00:56:39 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     rnayak@codeaurora.org, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>, sibis@codeaurora.org,
        sbhanu@codeaurora.org, linux-kernel@vger.kernel.org
Subject: [PATCH V3 0/4] opp: general cleanups
Date:   Thu, 20 Aug 2020 13:26:30 +0530
Message-Id: <cover.1597909885.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.25.0.rc1.19.g042ed3e048af
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here is another version of the cleanups I sent earlier.

Rajendra: Please see if these work fine now.

V3:
- Dropped v2 1/4 as it is already merged.
- New patch 4/4 added.
- Reordered the first two patches here (Stephen)
- disable regulator only if present

Viresh Kumar (4):
  opp: Rename regulator_enabled and use it as status of all resources
  opp: Track device's resources configuration status
  opp: Split out _opp_set_rate_zero()
  opp: Remove _dev_pm_opp_find_and_remove_table() wrapper

 drivers/opp/core.c | 103 +++++++++++++++++++++------------------------
 drivers/opp/cpu.c  |   2 +-
 drivers/opp/of.c   |   2 +-
 drivers/opp/opp.h  |   5 +--
 4 files changed, 52 insertions(+), 60 deletions(-)

-- 
2.25.0.rc1.19.g042ed3e048af

