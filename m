Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97294C43461
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 19:51:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 60CDE20658
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 19:51:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TEO8RRc7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732205AbgIHTvT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 15:51:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:58851 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730750AbgIHPt5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 11:49:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599580165;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TK94hr65Pbv4WiScR8vAMileXVguzlpR5hueFys4tHc=;
        b=TEO8RRc7GVKLmaJoAfhg1T338E0r7FO4uBIhWGRwr2p2vrxj5t+hKn87wHcKGcY1qcfw1K
        ksbsN9q8dx7DyefJviDsSgOadzelRuv4kE4dHg37FjC/8Ec6RGAMpPCfKVW+PXRSQezLA4
        WvYLOcfHs3fMSN6iEvHT/wYdKT5gvSs=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-508-CZ7pTKpoPyuzZLo04vASuQ-1; Tue, 08 Sep 2020 09:24:21 -0400
X-MC-Unique: CZ7pTKpoPyuzZLo04vASuQ-1
Received: by mail-wr1-f69.google.com with SMTP id j7so5352277wro.14
        for <linux-kernel@vger.kernel.org>; Tue, 08 Sep 2020 06:24:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TK94hr65Pbv4WiScR8vAMileXVguzlpR5hueFys4tHc=;
        b=MJc6+IUh9EEWm0omkVE2tKEM+Y14amlPpIo/OGLQwl/HPQq71OM0Q7RSrEUCOJJF5k
         PcKaYv6D/8Q0POQCSNGYGYo3p7e4ylrlX5nFePnnHqTdfnzzbR6Eg/RnvZWFsgoRC75i
         Piva/Uh403pgvY/MyC8bV+t19Fg1VM8U+lKMUM8J3MNdfxSjwpt+d/sOCDDR8IQlgy28
         HrMtexEtfi4GOJMnmNpmzihuIGPouU8ir+lHzy3O9c490VxPRQNbFjRnkqBR/K1pFzCM
         wyr1sYM4u51i8KO/jbpn5+B+PoHDXztykuFfZDzUxLcUE8FrlB6KJy2d5tdYXehVo0r/
         yxIQ==
X-Gm-Message-State: AOAM530i1XYAu0pVW9OG7JbH1wdcIW3yNZp/TPpzuS0HSSe+MN7YFH+F
        Q7fsxdI0k2kydKGc/snouFmBv9SS53+SUpyRIjnhxVaJ/1d/Y2utXkeN6uU8y8KWLgaD5gVwZea
        q6xCK06hLaRT6PjowuMKOkQ93
X-Received: by 2002:a7b:cb4d:: with SMTP id v13mr4725441wmj.56.1599571459925;
        Tue, 08 Sep 2020 06:24:19 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxbG9zYpOvvSdnyHs/XbOTDJjHLbjapXGRQTUuUk/Hgs+HBWnBntmzUuBZteAFqsH8+99po4A==
X-Received: by 2002:a7b:cb4d:: with SMTP id v13mr4725423wmj.56.1599571459736;
        Tue, 08 Sep 2020 06:24:19 -0700 (PDT)
Received: from redfedo.redhat.com ([2a01:cb14:499:3d00:cd47:f651:9d80:157a])
        by smtp.gmail.com with ESMTPSA id f1sm33267503wrt.20.2020.09.08.06.24.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2020 06:24:19 -0700 (PDT)
From:   Julien Thierry <jthierry@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     jpoimboe@redhat.com, peterz@infradead.org, mbenes@suse.cz,
        raphael.gault@arm.com, Julien Thierry <jthierry@redhat.com>
Subject: [PATCH] objtool: Fix sync-check.sh bashisms
Date:   Tue,  8 Sep 2020 14:24:15 +0100
Message-Id: <20200908132415.27753-1-jthierry@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200904153028.32676-1-jthierry@redhat.com>
References: <20200904153028.32676-1-jthierry@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Previous patches introduced some non SUS compliant changes
to sync-check.sh.

Replace used bash features for standard shell.

Signed-off-by: Julien Thierry <jthierry@redhat.com>
---
 tools/objtool/sync-check.sh | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

Note: This patch applies on Josh P.'s objtool/core.WIP.julien branch

diff --git a/tools/objtool/sync-check.sh b/tools/objtool/sync-check.sh
index b81cda59d878..606a4b5e929f 100755
--- a/tools/objtool/sync-check.sh
+++ b/tools/objtool/sync-check.sh
@@ -8,7 +8,7 @@ fi

 FILES="include/linux/objtool.h"

-if [ "$SRCARCH" == "x86" ]; then
+if [ "$SRCARCH" = "x86" ]; then
 FILES="$FILES
 arch/x86/include/asm/inat_types.h
 arch/x86/include/asm/orc_types.h
@@ -60,4 +60,6 @@ while read -r file_entry; do
     fi

     check $file_entry
-done <<< "$FILES"
+done <<EOF
+$FILES
+EOF
--
2.21.3

