Return-Path: <SRS0=7zi/=BF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45557C433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 14:18:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0ADD52070B
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 14:18:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IzjanIr1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726730AbgGZOSw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Jul 2020 10:18:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725848AbgGZOSw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jul 2020 10:18:52 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31707C0619D2
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jul 2020 07:18:52 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id e22so746125pjt.3
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jul 2020 07:18:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=f/P5ugQTvYO61SPrMwSZlOV5zbLJcAGZu1SsfWZekIc=;
        b=IzjanIr1aVtuaTGVFq9I4jtNZDdzHtGD7spyU4VRgb7Uu+L5ntDCdSjCeQCpnqIpV+
         n+cZttzGARjrVTwQ/lE95l0/8E2OQt+trcuCYTVuKMtmpW0TjBApVwioFWdDobWJAtKW
         WSjDL3XTxCavbAP95Za2S3nktRnh0omcr3re4AGHHxjG2a7x19d5i8UpkoFybgxImY7u
         t/nHQSFRA6f2UvT1rSsDPJ2mjKmy95y/U2IxngZSsWpeXzy4N+3PoDIw8VLnrT54jNG4
         skr0P40J/Bqd399Yo0Xe+IaSezRc7XD3bYAzwOxazm5hJK8o/R+YoyLEMQ8LAZHvVd0X
         G31Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=f/P5ugQTvYO61SPrMwSZlOV5zbLJcAGZu1SsfWZekIc=;
        b=dsaRbJKaKohLsDVhuAN/eC/1Er93J9+NHFwK8qMTtzepDPGHz7UHALLsr5eyTsMNhM
         vItjgamvBx5gQ5VVq3dYls3ddQL3eugsXLqLkyY5awySP+WR+8+GSg21dhUYndBtN8O7
         zWAS7N66hNseM91psnyr1m9Hgd8RxkaoSWW6RLHwW/QNu7RUMosK/Hu/LviMVBi+53yu
         WSWQBCiU1TuFeIFTQI4btz6/VGnd38MkTQgo0lqYemcz9/EqhRb3FLA5UR1tUZmsUCjJ
         CzQn2+R91I1l6R2bfAUbAO+ouMU66gFkSPX7qhzjKRr8jRBD7KeUn6fScPMdqBwxSST8
         heiQ==
X-Gm-Message-State: AOAM533PzGOiyWqqkwwq+ec9iCk+Y/edAaiN0jB8+2tiJ36q/GkSj8BT
        c0JeXlhLQIu8cjhgsdDnRrU=
X-Google-Smtp-Source: ABdhPJx/0Mgm9FWkZU4nZ97I/recHI8SwOqM4b3at07+amCPenBe+kmwbQQNc16u3NZcKQYqxAV0Lg==
X-Received: by 2002:a17:902:968a:: with SMTP id n10mr15727676plp.67.1595773131465;
        Sun, 26 Jul 2020 07:18:51 -0700 (PDT)
Received: from localhost.localdomain ([122.167.86.75])
        by smtp.googlemail.com with ESMTPSA id y198sm11873072pfg.116.2020.07.26.07.18.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jul 2020 07:18:50 -0700 (PDT)
From:   Aditya Jain <aditya.jainadityajain.jain@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     hdegoede@redhat.com, Larry.Finger@lwfinger.net,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Fix code style issues in staging
Date:   Sun, 26 Jul 2020 19:48:27 +0530
Message-Id: <20200726141831.2662-1-aditya.jainadityajain.jain@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <CAJAoDUjVBon2iiztdER82mHgJtVS6s5XYSajbCTne0KWAzoLvg@mail.gmail.com>
References: <CAJAoDUjVBon2iiztdER82mHgJtVS6s5XYSajbCTne0KWAzoLvg@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

The following series of patches fixes code style issues in 
the file staging/drivers/rtl8723bs/include/hal_phy_cfg.h

Regards,
Aditya Jain

