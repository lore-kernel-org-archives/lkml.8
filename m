Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9F90C433FC
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 07:48:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 882EE20720
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 07:48:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="K3d3Rmaz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729614AbgGMHsq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 03:48:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728985AbgGMHqw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 03:46:52 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AA71C061755
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 00:46:52 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id j18so12321073wmi.3
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 00:46:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/GI6WmzBD/tXdjRqMOCJ6wEDBpBeiEpQ/v95OUrVAL8=;
        b=K3d3RmazezaQ2JfntIC75Qh0KE2jdoNSsaYM7hkzV2Bb+6dWctrMMtyr7sZ7VQkSib
         zGc6Z0TdG4wRnNN/oCRTKOPCxNtvu45UnCRbWmN5hQLpfD12YM3KsoBSpp0iKq3VNtW7
         GE5YPDWrqyuRC24k4YNMDLVLkpwl2bZOGvrzS4WiFpSZ+wnNJCOuVQFcHqYhEUZZMERB
         PvI2MrT06G34KgwgztjCSDDvaa2zuvsxnJNiDNyCU1oxPT59rQiejRsHpMvxvvADRl+w
         gzEiksVelJJuezSK6nLRnh4qSJxnagPKE7ksTzR6IsY0fhlkfDCtzD1sYkH1mBswrJ9u
         ZDrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/GI6WmzBD/tXdjRqMOCJ6wEDBpBeiEpQ/v95OUrVAL8=;
        b=DwoZWsgsnGl9/9BzbePW5Em/Lry13rN3PJ063OeRk16jxHYEwBu9NPkpAmGMw7Cxj9
         7rGnADkhRPRS4fNLlKUD+pauJy+r3qqtho1rL0uqou9gR3qaup8kclbeg0m46oYUOPpS
         7gRGJVNlSUHDdTTdPogQjir5eXcMBux6cso0nHBSSXYsuy2OgE6/E3ayfc2T7TROhd7n
         FzMRHOqoEtYgNM67lKsQDozqQpRu2mTwpOYihsoKCUKN3aIcvqjWX1XSTjgxrPjpIJU2
         7NeHjaBoyqq22eCdW7it5aqXc2UBGtZUc80UHHFe8rk2QiNepRAhxevkgYkgR04fXMjv
         zvsA==
X-Gm-Message-State: AOAM531ZhTFzGAzoIIfKQjjZd+SAW2wGFvuwrKZGnP6Sh0O8Mx1a0fxZ
        qXtTdqNZ4R8mT4WI0C/w4FG6Af55CDU=
X-Google-Smtp-Source: ABdhPJw9WHbvL6VorgcZFT06HWZpJbARMOhY6Zz1TTGVDytZyAhxgah8k0Sy81uCL7Ul9FtWUW9C/w==
X-Received: by 2002:a1c:7315:: with SMTP id d21mr16920174wmb.108.1594626411102;
        Mon, 13 Jul 2020 00:46:51 -0700 (PDT)
Received: from localhost.localdomain ([2.31.163.6])
        by smtp.gmail.com with ESMTPSA id k11sm25142488wrd.23.2020.07.13.00.46.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2020 00:46:50 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        Hannes Reinecke <hare@suse.de>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Subject: [PATCH v2 03/29] scsi: libfc: fc_disc: trivial: Fix spelling mistake of 'discovery'
Date:   Mon, 13 Jul 2020 08:46:19 +0100
Message-Id: <20200713074645.126138-4-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200713074645.126138-1-lee.jones@linaro.org>
References: <20200713074645.126138-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is my fault (can't even blame copy/paste).

Cc: Hannes Reinecke <hare@suse.de>
Reported-by: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/scsi/libfc/fc_disc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/libfc/fc_disc.c b/drivers/scsi/libfc/fc_disc.c
index 428f40cfd1c36..19721db232839 100644
--- a/drivers/scsi/libfc/fc_disc.c
+++ b/drivers/scsi/libfc/fc_disc.c
@@ -370,7 +370,7 @@ static void fc_disc_gpn_ft_req(struct fc_disc *disc)
 
 /**
  * fc_disc_gpn_ft_parse() - Parse the body of the dNS GPN_FT response.
- * @disc:  The descovery context
+ * @disc:  The discovery context
  * @buf:   The GPN_FT response buffer
  * @len:   The size of response buffer
  *
-- 
2.25.1

