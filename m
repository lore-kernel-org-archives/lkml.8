Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED673C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 04:07:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C1FA0206D5
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 04:07:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=netflix.com header.i=@netflix.com header.b="o4u7oQMF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726900AbgFIEHo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 00:07:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725772AbgFIEHm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 00:07:42 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDC94C03E969
        for <linux-kernel@vger.kernel.org>; Mon,  8 Jun 2020 21:07:41 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id j189so17472166oih.10
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jun 2020 21:07:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netflix.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kcejXHVr0uPuufny+fpt/7B1mpNCm88I0z6cAzFfi+8=;
        b=o4u7oQMFJn1d0+UfvVvq8De/R/SOF//a+JKt6mz0YUEPNPfNrtOqpEgF6BoweSG+hL
         1/N0PYtVrNv017WCtDaNVWcnFTeo310ag/8h/MB5UrFOydL8IYJvSkZ0PVSFdBK1FK+j
         SWCNhLOS+krU+vGMEQkoK0D7DiA2amAHGSfWw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kcejXHVr0uPuufny+fpt/7B1mpNCm88I0z6cAzFfi+8=;
        b=nH6IFDWIoMlHwuxkPiM7k1LwuaC4TwxY2knNBa73oyY9Xttf3CJCbSPk8y+H9DMVxt
         gBY9uvww+jYisbp1q+OrZxW9xt6rY/wYoKHZZZK+R24JtXDuoqJYob3OMWlbkDZYTemq
         5buCKO9/pEhWMW3IhbMotU08ISBf/QvPXIOD0uZWAQnDLTbb9djgq0xGXRe6cpBJx4mo
         g2cz8BVlpkJHpseyoxtZs+feYoCq8ML17/qPUxV6Y6p1DVaZ5YNzCHOfaEDRIRLbEmE5
         9LLni6oY8Iq3XggZhmYRBL7ieny9hmiEdMrJwgeeoAFHZymKp9Bf+FmjFYcOHbdbEUOv
         MRhg==
X-Gm-Message-State: AOAM532FNxmTAXpQT/ReXm+ytR9IRBa/gc2VDeHWn4Nd0Mq8LTCXQThP
        yqIgdOKnMcCytsz9h7vlgSamaw==
X-Google-Smtp-Source: ABdhPJwm03Kl4WWtHwIjNfFhS7xGmtEXve1FejvxLCkA/ont055fHl4spBwJz7esrM24f9dfAWoWng==
X-Received: by 2002:aca:4d13:: with SMTP id a19mr2020978oib.158.1591675660976;
        Mon, 08 Jun 2020 21:07:40 -0700 (PDT)
Received: from mezcal.netflix.com ([2600:1700:3ec3:2450:25ca:3996:acb2:84a6])
        by smtp.gmail.com with ESMTPSA id b3sm2846415ooq.36.2020.06.08.21.07.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2020 21:07:40 -0700 (PDT)
From:   Josh Snyder <joshs@netflix.com>
To:     Jens Axboe <axboe@kernel.dk>,
        Mikulas Patocka <mpatocka@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Josh Snyder <josh@code406.com>
Subject: [RFC 0/2] Increase accuracy and precision of sampled io_ticks
Date:   Mon,  8 Jun 2020 21:07:22 -0700
Message-Id: <20200609040724.448519-1-joshs@netflix.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 5b18b5a73760 ("block: delete part_round_stats and switch to less
precise counting") introduces a sampling technique for calculating
io_ticks. The sampling algorithm introduces bias in the calculation of
I/O utilization. In my production system, this bias means that a
workload which previously reported 10% I/O utilization now reports 80%.
Patch 1 of this series eliminates the bias.

The sampling technique is also subject to statistical noise. Because it
infers io_ticks based on only 100 samples per second, io_ticks becomes
imprecise, and subject to swings when measuring both random and
deterministic workloads. Patch 2 of this series provides increased
precision by raising the sampling rate.


