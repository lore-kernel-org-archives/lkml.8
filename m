Return-Path: <SRS0=Atmy=73=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56689C433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jun 2020 01:29:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 29CEF20739
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jun 2020 01:29:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="ENLR6Uv6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726853AbgFNB3Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Jun 2020 21:29:25 -0400
Received: from mta-p8.oit.umn.edu ([134.84.196.208]:57448 "EHLO
        mta-p8.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726814AbgFNB3Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Jun 2020 21:29:24 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p8.oit.umn.edu (Postfix) with ESMTP id 49kxhM1yl7z9vY7J
        for <linux-kernel@vger.kernel.org>; Sun, 14 Jun 2020 01:29:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p8.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p8.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id IlTBTJiQQPyk for <linux-kernel@vger.kernel.org>;
        Sat, 13 Jun 2020 20:29:23 -0500 (CDT)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p8.oit.umn.edu (Postfix) with ESMTPS id 49kxhM09hNz9vY6X
        for <linux-kernel@vger.kernel.org>; Sat, 13 Jun 2020 20:29:22 -0500 (CDT)
DMARC-Filter: OpenDMARC Filter v1.3.2 mta-p8.oit.umn.edu 49kxhM09hNz9vY6X
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-p8.oit.umn.edu 49kxhM09hNz9vY6X
Received: by mail-il1-f197.google.com with SMTP id i7so9419194ilq.16
        for <linux-kernel@vger.kernel.org>; Sat, 13 Jun 2020 18:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=L2grYbPpWTCRicijBKU2oLG0fehNUWKsBMP/uZoFaP4=;
        b=ENLR6Uv6OYFB2FBobdBXjvIgmjG7TgPlMF4kIjLxf7/VKA9E9/zJVo5f5L6woaa0Mn
         o2B7YbIzyXva+i9dWkIaatyIdSo5EyHWlX+GrWPf/3vTnkUFdOazPQeLVRwsjeeU+yzo
         A4dvcMGyvp1+GEELbTFx3/eC1hsihbcXSIrD393b9DF2hmzjE/2KHZbse2hdZPDg8N9R
         CcUgdwS/1uDocUY0oeaCwNUm5ZSWSKGtqgR3uikep86JukPMtmEBnK+nZCA/gJ1I1FJj
         1QEMIBQpUFCSdmceEzCrOW5Zu0a1fF/ZL9XsFJhb81B8Ds2B5tf0UMYpdDf9OLhwr7fx
         bkuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=L2grYbPpWTCRicijBKU2oLG0fehNUWKsBMP/uZoFaP4=;
        b=QIA2UpQBUO04eWAG1IaL5kaJQquztrXngtnDXl1ci+Bud5vYoP5ljRPIK89nweO6Dw
         isoqsG1tOwtBskMWxmuolqNyi2TmU96yIwhhvntmr4ZtGrmHniPuw3AU3BQzuKrCkl75
         9rOLhZTErJdZ1zWoqUZhp9a5N0XvfjAKFN88tn0U4NUS+btIWkXj0DE23u/K9XXSqAk9
         Sf9SEfjebY/k3jJdDiGCsnRQaluaTAb5OGiF2R3KkwO0SHn6GvndvIOZz5FgXit0wrzI
         BAPYUXFMvvEdkhE1SHdcQmUP1WYZ4NYOVWPCiLpkWUiS0pv5Pq8DfKaIU7+AKBahujXr
         nmlA==
X-Gm-Message-State: AOAM532XcT4hTuluKnPnRDvUcXGrNLmcaa+arWJByzpd/+JBiNaIR9dC
        /OK7ThXEgdRu5gdFW68BbH9h7naYYFBYkRYyHrfJ+APf0zPqSA05Cp6x1PrFE/l0HhTu0t9y5KZ
        cNiGWPnIlzs/kK9bWCIL9O0se5OqD
X-Received: by 2002:a92:d0a:: with SMTP id 10mr13099242iln.162.1592098162648;
        Sat, 13 Jun 2020 18:29:22 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJycMLCnYhfdrrzjxhUUQ64OpH4a0ic/KTaj5fbtI0gClLIryWVz5kdC9pcvawqEgmaNt7hJkA==
X-Received: by 2002:a92:d0a:: with SMTP id 10mr13099234iln.162.1592098162507;
        Sat, 13 Jun 2020 18:29:22 -0700 (PDT)
Received: from syssec1.cs.umn.edu ([2607:ea00:101:3c74:d65:8ac4:1b02:86ac])
        by smtp.gmail.com with ESMTPSA id 18sm5424749ion.17.2020.06.13.18.29.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Jun 2020 18:29:22 -0700 (PDT)
From:   Aditya Pakki <pakki001@umn.edu>
To:     pakki001@umn.edu
Cc:     kjlu@umn.edu, wu000273@umn.edu, Ben Skeggs <bskeggs@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Lyude Paul <lyude@redhat.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Pankaj Bharadiya <pankaj.laxminarayan.bharadiya@intel.com>,
        Takashi Iwai <tiwai@suse.de>, James Jones <jajones@nvidia.com>,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drm/noveau: fix reference count leak in nv50_disp_atomic_commit
Date:   Sat, 13 Jun 2020 20:29:18 -0500
Message-Id: <20200614012920.121567-1-pakki001@umn.edu>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

nv50_disp_atomic_commit() calls calls pm_runtime_get_sync and in turn
increments the reference count. In case of failure, decrement the
ref count before returning the error.

Signed-off-by: Aditya Pakki <pakki001@umn.edu>
---
 drivers/gpu/drm/nouveau/dispnv50/disp.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/nouveau/dispnv50/disp.c b/drivers/gpu/drm/nouveau/dispnv50/disp.c
index d472942102f5..b4039907f0d6 100644
--- a/drivers/gpu/drm/nouveau/dispnv50/disp.c
+++ b/drivers/gpu/drm/nouveau/dispnv50/disp.c
@@ -2157,8 +2157,10 @@ nv50_disp_atomic_commit(struct drm_device *dev,
 	int ret, i;
 
 	ret = pm_runtime_get_sync(dev->dev);
-	if (ret < 0 && ret != -EACCES)
+	if (ret < 0 && ret != -EACCES) {
+		pm_runtime_put_autosuspend(dev->dev);
 		return ret;
+	}
 
 	ret = drm_atomic_helper_setup_commit(state, nonblock);
 	if (ret)
-- 
2.25.1

