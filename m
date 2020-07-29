Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8BD0C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 19:21:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7417B2068F
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 19:21:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FRfOzvLb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726903AbgG2TV4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 15:21:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726509AbgG2TVz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 15:21:55 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FDF1C061794
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jul 2020 12:21:55 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id d1so12306770plr.8
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jul 2020 12:21:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CyZyqFI+XAr4XPDXxXl/eruhWi9Hm+rYqmX4iZ+USns=;
        b=FRfOzvLbV/mf5lnlVREPCAuLLWN993iqbGhRBftPZBoNeFAkU2XbZjCgBKw0nkU6Lb
         fNIBcg/B4NcVq35Qk2vIizFFcHDK3E8/iIYDnNN9p9SdWsZZfcCuGO7da1L2SOBEr8wt
         /WcLELl09txi5pqBKeyodMdyHCeZcF3z0LXAax46+ypLjcp7zBaSoZhsoQOi/3mu5fw6
         WNZ2opzWv1EFV+mkd+IJJRvseEE/8n96xEOsGCopMjF863lK7VudXfH30A5UdyuN7UbF
         tB05rKoTI4eMN9+n+caFMzv9yWZ276cgY4EtZ1MMtrNYUPdZgC+DNbEp6Tg5vSEge9XT
         cecw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CyZyqFI+XAr4XPDXxXl/eruhWi9Hm+rYqmX4iZ+USns=;
        b=g71m7KrBXtLeNJoobYX3c6Krg73wAlJhyFOlkpuLYmG0J+mADdUEAc3drxuvLb37u7
         I6xKt3GG6wnx4ynuffOT9NCn5yUc45kDjZUBLsBBFZRHeS0b0dPeAU+z5aJAUcnLXpJm
         Cr3lLJ0JRa1gyW27vLsPM1afBLVGJaUf70Oft7jpGAS8Su7NKJjouVYvr5rXGd8Z8xSu
         DBHL+AgzeW34v2YEINHYIRsg/sfZ6nVjm8XulDUczByPA7enDhfjjs+83unEYXDjgOWp
         WPbo9KFfv0L/FYBn6DeoN+/h2Qb2IS6AIsrsbubvFlqQMpaWoR2IVOXbopEOGw+WXjWw
         24Ew==
X-Gm-Message-State: AOAM530p26QrJT1ycJL/grtRlNb8LdtOIG1mbdXU9ZAaPXDKA1YLGYi9
        yMe8WQVA+nLfMmMRXLLM1Gw=
X-Google-Smtp-Source: ABdhPJwSMhh3G/aPj7aRHxIrocMc+jlvrmkMz+HumqEtyC+4OjsjsEBRGXKhcJLLnw6Tc4CoM8EpHg==
X-Received: by 2002:a17:90a:ea8e:: with SMTP id h14mr11149292pjz.105.1596050514903;
        Wed, 29 Jul 2020 12:21:54 -0700 (PDT)
Received: from localhost.localdomain ([122.167.86.75])
        by smtp.googlemail.com with ESMTPSA id hg7sm599431pjb.24.2020.07.29.12.21.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2020 12:21:54 -0700 (PDT)
From:   Aditya Jain <aditya.jainadityajain.jain@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     hdegoede@redhat.com, joe@perches.com, Larry.Finger@lwfinger.net,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Aditya Jain <aditya.jainadityajain.jain@gmail.com>
Subject: [PATCH v4 0/3] Fix coding style issues in staging
Date:   Thu, 30 Jul 2020 00:51:33 +0530
Message-Id: <20200729192136.23828-1-aditya.jainadityajain.jain@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <CAJAoDUjVBon2iiztdER82mHgJtVS6s5XYSajbCTne0KWAzoLvg@mail.gmail.com>
References: <CAJAoDUjVBon2iiztdER82mHgJtVS6s5XYSajbCTne0KWAzoLvg@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey everyone,

Following the comments received I've updated the patch.
The patch cleans up coding style issues in the file
drivers/staging/rtl8723bs/include/hal_phy_cfg.h

Changelog:

v1:
Fixed ERROR: "foo *	bar" should be "foo *bar" reported by
checkpatch.pl

v1 -> v2:
Cleaned up multiline function declarations as suggested
by Greg and adjusted spacing in macro definitions to align them.

v2 -> v3:
Broke the single patch in v2 into multiple patches with each
patch doing one single task.

v3 -> v4:
1. Corrected the patch subject following Larry's suggestion.    
2. Merged the second and third patches into one following Greg's 
comment.
3. Removed comments from the PHY_SetBWMode8723B function declaration.

Aditya Jain (3):
  staging: rtl8723bs: Fix coding style errors
  staging: rtl8723bs: Clean up function declations
  staging: rtl8723bs: Align macro definitions

 .../staging/rtl8723bs/include/hal_phy_cfg.h   | 116 +++++-------------
 1 file changed, 32 insertions(+), 84 deletions(-)

-- 
2.25.1

