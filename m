Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8A85C43461
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 00:34:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7559F20716
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 00:34:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cMCzrfCU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729036AbgIDAeg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 20:34:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726397AbgIDAed (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 20:34:33 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EDABC061244
        for <linux-kernel@vger.kernel.org>; Thu,  3 Sep 2020 17:34:33 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id g29so3431670pgl.2
        for <linux-kernel@vger.kernel.org>; Thu, 03 Sep 2020 17:34:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IAJoEh+6AzC+pKTWp/bOcEFzbdoQ52Nyw5yIscBfr1w=;
        b=cMCzrfCUtqRc1nmYxs2wvQHa172v0v+L5ucazx+Eh+kn/j4HMo1nlDNN+LmF5s/V90
         /K3aUdV9IuwY3khbOtHSqEd6AZsZ7rUQZgxfSFDCUVry1aU0ScVy+qDKEHIsDDznw50a
         /YRhAYGl4p4pEfwO38kik1Pqw4rt0eAWPF5otnIpAntDpaYJZfJpjD624bXGqFKILfSF
         q/KXzddAvo3eys0xyW46uBduglw0h0+XCFBOlhx7B4JTjRLi+cLWK9fkuECZMd4pXYpc
         UZLcu5iqesbONCFhep9whhQtarYSIoRVbV111xpKL75HfzDgJ+rTE8/7A91uqmZqCpjk
         uilA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IAJoEh+6AzC+pKTWp/bOcEFzbdoQ52Nyw5yIscBfr1w=;
        b=m3VfKWITMPnYRd4GTvdcrlC1uWYfqGCji28/MzrJ4/qk+ThUFfD32pACtiKRJqR+ey
         OusKtWCLA6Mw+yTauWWvV1n8cWTCr6sTQgWhlKV1UTy2pc55iAET+PBLyLS1coJTHEJB
         JIhsEQZRNTpikM89ekWVR/XJy6nXOrpowSb/QBKDxRn51lqOBmbjYb4Zls76pL1IXf5v
         Wt73nLbL7tVKsW+sad9aBuuAwNm3s1Q6TOjbXykLy+m9ahBGdvbkAC90jFVpi+K9A+TE
         dIVOYjs6+XWVhhtNN6RQuK9IVi4MGVBS6sTUNmtcDA9WftH7tNC5Gti3lL455Le6ZpBm
         Ui8A==
X-Gm-Message-State: AOAM531sNgf58lMIgaTt38GXam68eRZnGRGP0U/icacxh70K/I1P+rtE
        yXbQ8QnvPxTL/5yvY+0Fh3M=
X-Google-Smtp-Source: ABdhPJzg0g/r/JRAq1RMe5JuWkOkXDNZ26WMpp7IGq6R51F5xXzfvpMyaX3rFnKeL8iB2qbXMWriZA==
X-Received: by 2002:a63:ba18:: with SMTP id k24mr5215503pgf.335.1599179672743;
        Thu, 03 Sep 2020 17:34:32 -0700 (PDT)
Received: from localhost.localdomain ([49.207.195.77])
        by smtp.gmail.com with ESMTPSA id n68sm4412817pfn.145.2020.09.03.17.34.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2020 17:34:31 -0700 (PDT)
From:   Anant Thazhemadam <anant.thazhemadam@gmail.com>
Cc:     Anant Thazhemadam <anant.thazhemadam@gmail.com>,
        Ian Abbott <abbotti@mev.co.uk>,
        H Hartley Sweeten <hsweeten@visionengravers.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Alexander A. Klimov" <grandmaster@al2klimov.de>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Remove unused variables
Date:   Fri,  4 Sep 2020 06:04:06 +0530
Message-Id: <20200904003408.452999-1-anant.thazhemadam@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A few unused variables that were defined were found and removed.

Signed-off-by: Anant Thazhemadam <anant.thazhemadam@gmail.com>
---
 drivers/staging/comedi/drivers/dt2814.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/staging/comedi/drivers/dt2814.c b/drivers/staging/comedi/drivers/dt2814.c
index bcf4d5444faf..1a36d8612d9f 100644
--- a/drivers/staging/comedi/drivers/dt2814.c
+++ b/drivers/staging/comedi/drivers/dt2814.c
@@ -190,7 +190,6 @@ static irqreturn_t dt2814_interrupt(int irq, void *d)
 	struct comedi_device *dev = d;
 	struct dt2814_private *devpriv = dev->private;
 	struct comedi_subdevice *s = dev->read_subdev;
-	int data;
 
 	if (!dev->attached) {
 		dev_err(dev->class_dev, "spurious interrupt\n");
@@ -229,7 +228,6 @@ static int dt2814_attach(struct comedi_device *dev, struct comedi_devconfig *it)
 	struct dt2814_private *devpriv;
 	struct comedi_subdevice *s;
 	int ret;
-	int i;
 
 	ret = comedi_request_region(dev, it->options[0], 0x2);
 	if (ret)
-- 
2.25.1

