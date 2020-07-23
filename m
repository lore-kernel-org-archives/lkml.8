Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C57C1C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 14:27:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C3882086A
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 14:27:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qfSf18Yx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729285AbgGWO1r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 10:27:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726089AbgGWO1q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 10:27:46 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDEC8C0619DC
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jul 2020 07:27:46 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id b9so2629721plx.6
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jul 2020 07:27:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=GD12Q74OR6GJeN3xWOb2zFUMALqyHWcaZFsUpKnWDSQ=;
        b=qfSf18Yx1kk7vH3YZAyYDde0KB7jmDp7S5IdTBDNXsAzqvJMFY0US9NwhHYg0wkWRZ
         wbCc3rbrI6wDT7nBcQpZJWTRcFM0WJLQsi+fJjYb4qYjQUA5sqTZGqqjpAufKMItJckW
         Z2fSbkO+G5UFKty3NsfayEMIMMzerq/6msVolUVsU4pk8AaKEvsKy8S2geM6f0yJAtuZ
         wo8oLY7TYkarjMLrGn534Wj993VjmMytB4WZ1taa05hNZhLwltH9kHkdwEktSY4HVELx
         5ERXbNec3O8xft2vttfRHejM5Ry21VVmTUy46PYPRvcqMJUF7cd4VPkrWhyLDsd3oBB2
         Lqng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=GD12Q74OR6GJeN3xWOb2zFUMALqyHWcaZFsUpKnWDSQ=;
        b=Iv6yJA+CRMIfPyIvLN4QMf8utueSHLirydArCGe3xlvDigmQuQr4wcLn3eA+yA7Grd
         vciDxxRgiyPNRCaX3JoVV6yGfdL2uZMw6xHmcZ46FmLlF4eArodYVaba14LtNqXcriRX
         8p5VjYpLzAgA2w1JUafu5MmTYDaN+n0niBXc/7ZATmZ77O8GhVIb5KQ6uvuIfomgwSqw
         KaIeiFXysKHooP9QE41MZhXYsgkcFG+q6v1HE4wJ1abwk5loSK/RP22h13I7yNRMISBc
         3bdOdhcpC0Rr1AveZ6bzbobA/Uys7m2U7tkXTTA5kQLLJ5phmo/2HyGS4jrqmQsYLw6K
         I7wg==
X-Gm-Message-State: AOAM533yJXBLDO9ES0jZyPPxTrN1KQ2ZzonYJxblOjSMrB5zYErC0It8
        XKUOS8rDi1Q/HBMQZ2jf5rco
X-Google-Smtp-Source: ABdhPJy6/zrDKK2Gjisdl0VDYpcxJSZ2oH4T0/Y6XUQblucC3h42j5j17W/9lvR6wW2S8vJTeS+jGg==
X-Received: by 2002:a17:902:aa4c:: with SMTP id c12mr4110467plr.237.1595514466093;
        Thu, 23 Jul 2020 07:27:46 -0700 (PDT)
Received: from Mani-XPS-13-9360.localdomain ([2409:4072:6219:d937:e4bc:bef6:c190:2693])
        by smtp.gmail.com with ESMTPSA id a2sm3131977pgf.53.2020.07.23.07.27.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2020 07:27:45 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     hemantk@codeaurora.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 0/1] MHI stuff for v5.9
Date:   Thu, 23 Jul 2020 19:57:37 +0530
Message-Id: <20200723142738.27159-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

Here is a single MHI bus patch for the coming v5.9 release which fixes
the kdoc comments.

Please apply!

Thanks,
Mani

Randy Dunlap (1):
  bus: mhi: fix doubled words and struct image_info kernel-doc

 include/linux/mhi.h | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

-- 
2.17.1

