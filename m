Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1495C3F2D1
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 10:32:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B21D217F4
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 10:32:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ri8EY8zj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727412AbgCBKc3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 05:32:29 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:43515 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726674AbgCBKc3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 05:32:29 -0500
Received: by mail-lf1-f65.google.com with SMTP id s23so7570741lfs.10
        for <linux-kernel@vger.kernel.org>; Mon, 02 Mar 2020 02:32:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=QnYXcIKWVcVSniTvImIOUV2GKYnwwg6k3OeoObFRdpM=;
        b=Ri8EY8zjK8JQBlTwBx2lPNX4EJyj2l0TFRRuH965V0Dj13z0lqud6RgyZnmchIT3mL
         i4kB/cPt3Qs+Pzey02cSv5WkFTPpkId23mXl9MEIu1B9ODeukat2DB7Yu9lxNaddFEFi
         jVOuf5L3ZPXefhjqnIRG2EuOmKGw3QWf3vm21KVXQVnh9zbMTBiG9nti2Z4eVtfMW/pk
         s/mUUQY3Aku49cOy/dx8baIcHtONli0joOFAowL3ySG9fe+VcmXaUCRDdH0sFNf2ecBp
         flyGcYDnGwRG1mKJV0Nj6Wmzbk6VrIAnx0Ke2rBlhUGVg2QKtsQmsMQlKLAs0rV5UZMW
         b2Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=QnYXcIKWVcVSniTvImIOUV2GKYnwwg6k3OeoObFRdpM=;
        b=qHwW4KYFGHR7sjDMZqepKMPA4cCbz/MDj+pqMtJcQrVOOLIfTLS9i6RY0QNQiZlZAO
         1I6SRjhY/OpttHXnek63WQQtzJvN1MZJQqxFvQSqxaEF4XlcxJFcIF0W72pbTqIFMVdE
         PNEKm5pG0FWqG48QC1BisgDFVazAmAHjnDn6szPLF+wA0vMgSWuz/GVaR1EggLMvDBEd
         eI71vd4jVZDw9mLBpdhbfY85fnMakwyNKR66DXwZk9ZGefTP15ckzoa9+MDXtFquOO6T
         RibsNgpjd43pEulX/TeJOe+zvHofzuPdRHnxflxZKlkXJ6XYREgx6T9td7qp7NHGF5+F
         Kdjg==
X-Gm-Message-State: ANhLgQ3+Hq4oqK1dtnCDR0nvUYpB2sAYn7e6UPhDVTdNR/pDiOBkjPXG
        ut7/TJU57YweMVHsh85VCg0=
X-Google-Smtp-Source: ADFU+vum+gRzgYNjn0fs2L8U2Ud019xJc9t09+jbn5reMOsLMhPUU7XhcnXXsDSa0U8EPiu3o1eJHA==
X-Received: by 2002:a19:48cf:: with SMTP id v198mr10081652lfa.68.1583145147101;
        Mon, 02 Mar 2020 02:32:27 -0800 (PST)
Received: from localhost.localdomain ([149.255.131.2])
        by smtp.gmail.com with ESMTPSA id n21sm3895328lfh.2.2020.03.02.02.32.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2020 02:32:26 -0800 (PST)
From:   Roman Stratiienko <r.stratiienko@gmail.com>
To:     jernej.skrabec@siol.net, mripard@kernel.org, wens@csie.org
Cc:     airlied@linux.ie, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org
Subject: .[PATCH v4 0/4] drm/sun4i: Improve alpha processing
Date:   Mon,  2 Mar 2020 12:31:34 +0200
Message-Id: <20200302103138.17916-1-r.stratiienko@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <.>
References: <.>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Patches 1-2 already reviewed and ready to be applied.

Patch 4 is RFC and require more testing on real hardware.

[PATCH v4 1/4] drm/sun4i: Add alpha property for sun8i UI layer
[PATCH v4 2/4] drm/sun4i: Add alpha property for sun8i and sun50i VI
[PATCH v4 3/4] drm/sun4i: Add support for premulti/coverage blending
[PATCH v4 4/4] RFC: drm/sun4i: Process alpha channel of most bottom layer

 drivers/gpu/drm/sun4i/sun8i_mixer.h    |  2 +
 drivers/gpu/drm/sun4i/sun8i_ui_layer.c | 50 ++++++++++++++++
 drivers/gpu/drm/sun4i/sun8i_ui_layer.h | 10 ++++
 drivers/gpu/drm/sun4i/sun8i_vi_layer.c | 72 +++++++++++++++++++++---
 drivers/gpu/drm/sun4i/sun8i_vi_layer.h | 16 ++++++
 5 files changed, 142 insertions(+), 8 deletions(-)

