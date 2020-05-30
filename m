Return-Path: <SRS0=qKPt=7M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18B60C433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 20:54:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E1FD02076B
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 20:54:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729338AbgE3UyJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 May 2020 16:54:09 -0400
Received: from mail-lf1-f49.google.com ([209.85.167.49]:44798 "EHLO
        mail-lf1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728741AbgE3UyI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 May 2020 16:54:08 -0400
Received: by mail-lf1-f49.google.com with SMTP id w15so1689322lfe.11
        for <linux-kernel@vger.kernel.org>; Sat, 30 May 2020 13:54:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xw605j63H08pFbKFHsgPllo2g2mBV5dsiKNt9j9qDLc=;
        b=tmykBg+vWUucIWYEdM5Odrs2olSYNVnbUZZZDPGx/HjKdvAwC/BMu8sOMaqJhUnPif
         8wsD5ZroVqGcM3B009JV8sk7Y8GBvqYuLRh6l/FIaBHokxyvak1YnJzmpySVOtt492Me
         3fXq22wkACD6u21EW63/OIkJNgrNBbYxtzMIHHr58BACwQPIjrdgtEpOTZR20EiGmjB2
         dqV9u5EZQwK8CYf3BoM34EbHwerGLS9wixVhuSDWP2APzNEzoUROl/Da5eEnxjsPdNBp
         j2Mmwlu9JzYvXkTMlktaVDPJa8NwkjiRY8AOyVnY29iol6xHDpO7LL8M8OImHKJksjA8
         tWMg==
X-Gm-Message-State: AOAM531ZKAlxFcrUFr7PkgWUbQ4AQWiQcObBZGvi714UaaDzMEr+KZCc
        y9O7rMTfmStVnB4FwPtMRMfFRC9o
X-Google-Smtp-Source: ABdhPJzSEX8QyOMAA1V//YoNaGqRWRM7xSXsjtYzlT6TUuXeEa9s4HUs0M09UkMHrrAXbFMqG0jCJw==
X-Received: by 2002:a19:be55:: with SMTP id o82mr7363818lff.168.1590872045818;
        Sat, 30 May 2020 13:54:05 -0700 (PDT)
Received: from localhost.localdomain ([213.87.147.196])
        by smtp.googlemail.com with ESMTPSA id f6sm2816670ljn.91.2020.05.30.13.54.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 May 2020 13:54:05 -0700 (PDT)
From:   Denis Efremov <efremov@linux.com>
To:     Julia Lawall <Julia.Lawall@lip6.fr>, Joe Perches <joe@perches.com>
Cc:     Denis Efremov <efremov@linux.com>, cocci@systeme.lip6.fr,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] Update memdup_user.cocci
Date:   Sat, 30 May 2020 23:53:46 +0300
Message-Id: <20200530205348.5812-1-efremov@linux.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add GFP_USER to the allocation flags and handle vmemdup_user().

Denis Efremov (2):
  Coccinelle: extend memdup_user transformation with GFP_USER
  Coccinelle: extend memdup_user rule with vmemdup_user()

 scripts/coccinelle/api/memdup_user.cocci | 53 ++++++++++++++++++++++--
 1 file changed, 49 insertions(+), 4 deletions(-)

-- 
2.26.2

