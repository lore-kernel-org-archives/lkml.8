Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72D07C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 19:18:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 43D662176B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 19:18:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e0F2J7/d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730981AbgGTTS6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 15:18:58 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:30117 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730944AbgGTTS4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 15:18:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1595272735;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=1Kbu8ZJB+PbpYpnvxeXN5DGnvBoImp+SwBun1XbwpDw=;
        b=e0F2J7/dBWRF2ANA5jdbc3z5Pg+kkbBwr6HeWdkdtKCutJPjedNzSH3TyJ2WfqYRVrucgD
        bThkCTzQ548BQZNFPmQd8hCbE1j3VK90oWcXBTtaFqJEYDdeLpXAL21ElII4O58GOQ1OV7
        H9X3wIUCnjqfP17rffq89Exhw9CtoRc=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-138-MWnT-1tGO46ypihVECORuQ-1; Mon, 20 Jul 2020 15:18:53 -0400
X-MC-Unique: MWnT-1tGO46ypihVECORuQ-1
Received: by mail-qk1-f199.google.com with SMTP id 124so12090094qko.8
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 12:18:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=1Kbu8ZJB+PbpYpnvxeXN5DGnvBoImp+SwBun1XbwpDw=;
        b=Ls+UhNN52gX4RKFuxHVNi8Oum9ZGudchAdOAeW+R3AOhlV0Q/rETNTZ3wJSj0173fB
         8FeK8fyAOysMdxRdwaBWtEdT/wpABDsLXBUtwfTvKbyPHnfwmodeYV+v8rqZoyPJvM0n
         H2x15oklbFHitE6NivDDfTkUjSqPTGYj46ZpkWjk8bYrUX6faAGN1DffjsuxseDejCwM
         95Fos2rQ2DZAyo4kYbfY33+AOH968wXhe+TevH35nnt8fGn8cZMzt+uo0vY/WppLu0D7
         r9GAiF/hHSavhr5FEpVqik50fAp4+Evd4+efXAEwAO1JJ/4Aa9v1MgkWH0mVY68HL/EU
         fMfQ==
X-Gm-Message-State: AOAM530BJu5IAxZ13oYla25LM/CgsIOnH3CymzaqEvnj1NJ/Ry0NImt4
        1zeV7s/bFLS8b40+6OQ4Kl5Sm6TRcDRn5om761sgDRLy9FTkjtU+tgE5BqEFaO1BRUiNrM0DE4C
        D6zem4gicl9Scv4YO27Xrwd+l
X-Received: by 2002:ac8:bc2:: with SMTP id p2mr26252059qti.374.1595272733342;
        Mon, 20 Jul 2020 12:18:53 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwnHhkZMNBQS0nyRzKMd1uLYdyrRKd2rgZ6H9zo8r0jm3gmVaJyLQcNPC2s6t9n52ICM5SvqQ==
X-Received: by 2002:ac8:bc2:: with SMTP id p2mr26252034qti.374.1595272733050;
        Mon, 20 Jul 2020 12:18:53 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id c80sm335957qkg.72.2020.07.20.12.18.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2020 12:18:52 -0700 (PDT)
From:   trix@redhat.com
To:     b.zolnierkie@samsung.com, jhubbard@nvidia.com, sam@ravnborg.org,
        daniel.vetter@ffwll.ch, gustavo@embeddedor.com, arnd@arndb.de,
        jani.nikula@intel.com
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Tom Rix <trix@redhat.com>
Subject: [PATCH] video: fbdev: pvr2fb: initialize variables
Date:   Mon, 20 Jul 2020 12:18:45 -0700
Message-Id: <20200720191845.20115-1-trix@redhat.com>
X-Mailer: git-send-email 2.18.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

clang static analysis reports this repesentative error

pvr2fb.c:1049:2: warning: 1st function call argument
  is an uninitialized value [core.CallAndMessage]
        if (*cable_arg)
        ^~~~~~~~~~~~~~~

Problem is that cable_arg depends on the input loop to
set the cable_arg[0].  If it does not, then some random
value from the stack is used.

A similar problem exists for output_arg.

So initialize cable_arg and output_arg.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/video/fbdev/pvr2fb.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/video/fbdev/pvr2fb.c b/drivers/video/fbdev/pvr2fb.c
index 2d9f69b93392..f4add36cb5f4 100644
--- a/drivers/video/fbdev/pvr2fb.c
+++ b/drivers/video/fbdev/pvr2fb.c
@@ -1028,6 +1028,8 @@ static int __init pvr2fb_setup(char *options)
 	if (!options || !*options)
 		return 0;
 
+	cable_arg[0] = output_arg[0] = 0;
+
 	while ((this_opt = strsep(&options, ","))) {
 		if (!*this_opt)
 			continue;
-- 
2.18.1

