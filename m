Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFA99C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 13:00:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B0C25207BB
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 13:00:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="RRO5W51x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729246AbgHTNAj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 09:00:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729028AbgHTM6f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 08:58:35 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40250C061385
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 05:58:31 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id o21so1515103wmc.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 05:58:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bjjzUyjqxUTgADSqZ4AEGlgmQLd6hH97YwJfRgNRrW4=;
        b=RRO5W51xetH2hSun5LBxUXBN+1ILaB2b2Woui8OkARAIJOlWdAQPA7dyKZnP5p75IR
         HtXeQut75Cu1xU071fRPLL2WhuwWTLGPbpEUHf4Nocft9Nn8RF5eXeCU1+s4NMqG1hzF
         s/MSh2oHQLOWDc2mz55ji2AgsvjxWddxefAUs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bjjzUyjqxUTgADSqZ4AEGlgmQLd6hH97YwJfRgNRrW4=;
        b=rFgmA+ktFHvaZ3CwrCd4paHScT/W8vEhE2ZPG9hRNbfES4XVBgSCufhlKJqBsUhGg4
         iHhlfoNr1wnHDg0RqkrZ/IKwrqk94iwizt58bNwboezShrV+7p5wtvvTP0tITuIXieiR
         hbfYe6VK8TqLAO8TfhSfWzxmJ4a88r8ymF6+dsyaM/0rVXSvIARGiH/FA6lIXF/Jf/+Q
         QnaJTWfu07G6fAT6K1d+kthwAUA2ymE7FhQ8Pnh5yN743trNg4O7xKPC4f4FTygjQjl5
         7hEDWCF+txfJZu+Lx9G2pLtJWxiliEQTcxCQIYtZwJ4Tzi8L/5nxcfoDaNQSCV9KO020
         lLAw==
X-Gm-Message-State: AOAM531x+RR0x1R3F5BlkG+G9Zq8XJnaTHscU3FYWa/aaXJgBnW9hqHG
        /PUXU/WgMaY8MfR/XbYvqArksQ==
X-Google-Smtp-Source: ABdhPJxBvtfxib5dNL686AtnsEgnavbEPNHEvjkC1eMzOzqRPR+lmo2H3iHzsR6k2KoeFiZn1iJ/wQ==
X-Received: by 2002:a05:600c:224e:: with SMTP id a14mr3518439wmm.80.1597928309945;
        Thu, 20 Aug 2020 05:58:29 -0700 (PDT)
Received: from tfiga.c.googlers.com.com (88.140.78.34.bc.googleusercontent.com. [34.78.140.88])
        by smtp.gmail.com with ESMTPSA id o66sm4517760wmb.27.2020.08.20.05.58.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2020 05:58:29 -0700 (PDT)
From:   Tomasz Figa <tfiga@chromium.org>
To:     linux-media@vger.kernel.org
Cc:     Mauro Carvalho hehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Hans Verkuil <hverkuil@xs4all.nl>,
        =?UTF-8?q?Pawe=C5=82=20O=C5=9Bciak?= <posciak@chromium.org>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Pawel Osciak <pawel@osciak.com>,
        Tomasz Figa <tfiga@chromium.org>
Subject: [PATCH 0/3] Clean the videobuf2 maintainer list
Date:   Thu, 20 Aug 2020 12:58:22 +0000
Message-Id: <20200820125825.224788-1-tfiga@chromium.org>
X-Mailer: git-send-email 2.28.0.220.ged08abb693-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently the MAINTAINERS file lists 3 maintainers and 1 reviewer for
the VIDEOBUF2 FRAMEWORK entry. From the list, two people have been
inactive for several years. This series tries to clean the list to
ensure that the framework has only active maintainers.

The series proposes removing Kyungmin Park and Pawel Osciak from the
maintainers list. I know both of the people in person and am well aware
of their achievements for the framework in the past. However, the
framework needs to move forward and thus, it needs active maintainers.

Therefore, I'd like the people in question to comment on their plans
regarding the maintenance of this framework or lack of thereof (and thus
being fine with the removal).

Tomasz Figa (3):
  MAINTAINERS: Make Tomasz the main maintainer of videobuf2
  MAINTAINERS: Remove Kyungmin from the maintainers list of videobuf2
  MAINTAINERS: Remove Pawel from the maintainers list of videobuf2

 MAINTAINERS | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

-- 
2.28.0.220.ged08abb693-goog

