Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC56AC433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 12:04:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CBC2E207CD
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 12:04:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728827AbgGBME2 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 08:04:28 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:41773 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728730AbgGBME2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 08:04:28 -0400
Received: from mail-pg1-f199.google.com ([209.85.215.199])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1jqxx3-0006zz-S2
        for linux-kernel@vger.kernel.org; Thu, 02 Jul 2020 12:04:26 +0000
Received: by mail-pg1-f199.google.com with SMTP id j9so16868123pgm.8
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jul 2020 05:04:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:content-transfer-encoding:mime-version
         :subject:message-id:date:cc:to;
        bh=6U4bdTq8kytYWqveDbphl0yfVzNtHItRUMAWKUCvHZ8=;
        b=eKivTAvvAM8WY/W6mbnbpYG9xrOrIs4PVesXbgQ34+7G7R2woqIy4d458OcNRQnH9a
         l9NmjiDbf5KbhLJgie54ndYl1mg59B1VD5dEmLRTc8ts6vqYGR28jnn+/OuYKG/2+LeO
         Xx5PV9cLVl5pHWfTNK1uoonLsZDOkiMO8O+KusoDx2JS2wM3W+2woCirHq9xzIBLOXc7
         kBeSBTS/q2Q4owbfJt2Jly2pn7nOdFKfRWirovoCkHKRcdNHSenyQFD28UizyhmlF7hK
         0ojRueH6kNsct+ehlp6fAmXq+Rfz2fsnB097PTsgueVO51I7Fr8UBxBlv1zV60pdaItA
         0h/Q==
X-Gm-Message-State: AOAM530k+l3yotAJg7LIBl3oj2g1UVWfQN6RLWFH4NYB5XeQqQDYSUGw
        6eOqSsayRlqDV8GtpvJs+LE7qzlpmwwz4gGjNitMD5AJXSSgbCDBnDe+u5xNWN7tXRuGTZLT3Wc
        iifdAQUId3x7UrPittfULgT328ALbO850kOkO1E73kw==
X-Received: by 2002:a63:5013:: with SMTP id e19mr24290812pgb.68.1593691464572;
        Thu, 02 Jul 2020 05:04:24 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyRvd+NbScka7tYb6z92sznSO8thLnWMVPdDQU4d17B5jU9vGbiHDEXuLN8ZHl6gVSFbzEj/Q==
X-Received: by 2002:a63:5013:: with SMTP id e19mr24290787pgb.68.1593691464269;
        Thu, 02 Jul 2020 05:04:24 -0700 (PDT)
Received: from [192.168.1.208] (220-133-187-190.HINET-IP.hinet.net. [220.133.187.190])
        by smtp.gmail.com with ESMTPSA id 193sm8577808pfz.85.2020.07.02.05.04.21
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Jul 2020 05:04:23 -0700 (PDT)
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: 8BIT
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: [BUG] "Pre-boot DMA Protection" makes AMDGPU stop working
Message-Id: <546DB0FA-FDEB-4FD1-93CD-AA5474B5F0DD@canonical.com>
Date:   Thu, 2 Jul 2020 20:04:20 +0800
Cc:     "Deucher, Alexander" <alexander.deucher@amd.com>,
        iommu@lists.linux-foundation.org,
        open list <linux-kernel@vger.kernel.org>
To:     Joerg Roedel <jroedel@suse.de>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

A more detailed bug report can be found at [1].

I have a AMD Renoir system that can't enter graphical session because there are many IOMMU splat.

Alex suggested to disable "Pre-boot DMA Protection", I can confirm once it's disabled, AMDGPU starts working with IOMMU enabled.
So raise the issue here because I have no knowledge on how to reset the IOMMU.

[1] https://gitlab.freedesktop.org/drm/amd/-/issues/1204

Kai-Heng
