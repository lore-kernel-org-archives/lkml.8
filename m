Return-Path: <SRS0=6uoK=35=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 799BBC2BA83
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Feb 2020 22:33:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 403DA20820
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Feb 2020 22:33:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FYsvkDiO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727122AbgBIWdg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Feb 2020 17:33:36 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44982 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726658AbgBIWdg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Feb 2020 17:33:36 -0500
Received: by mail-wr1-f66.google.com with SMTP id m16so5183121wrx.11
        for <linux-kernel@vger.kernel.org>; Sun, 09 Feb 2020 14:33:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nYKj63iZ/uIF9KSGHoTJd2yKyNkc6TYMP/L6qvJ98sU=;
        b=FYsvkDiOECFe8ZrkDaPll8uPJPOVsL0Qdxve+hSHNhxyIn9yIGE159PaFCa+TR3BOm
         2noupIFQ5Z2lhyUVweKoco6gLEQlR4gAjUCqqOy+02iQ61d6EOs79HZOdaV9E7SV+Tfd
         tZLm1+A/ebvW/Iq4EH8y63+eFEoZIrlQqk/3SCtpmtmop2DmXV0vJJVaILTtusv39TXY
         UsUcFPIO6Sb5Gyz6HINZLqrc2p/hKbnynPSrYyFsvjaDgGP3B2c54ZIlh+QilChCQtQj
         xwIDavHOwYlbLuk2YwFFV1jD1qcGzk33zXfE2PMGg2NVDx7ZeavUFn+J7kiTsq8v8PR1
         SBUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nYKj63iZ/uIF9KSGHoTJd2yKyNkc6TYMP/L6qvJ98sU=;
        b=IwmNiZV/d9o92oif3a/S3J35Btl4bbmrDrrG7G4K7AIRTty/+7VkO4eQMlrMExHgVa
         hD43UCqQvoKAni71qFcTy6CVcV1CI8L+abcbfZuXrLmQA6S21AW5xYHEvNPAHJOgt0ZX
         SwFb5od+ACWjUJNEoSGfZfXI3Sld4dBYmQ6tWlHF7dz5/yJL8E6fJQ7xy+L3PrZVAeKe
         pQdvKEvNqY6hspZ6djy24ASRbezy2a0NjH1SIGqG6VGyLtqQsCqVJW9In4Qzb2z7gBnf
         sPsYz7hsO4ocO6XDxfh6sEau3/Z7VhUtNz2Ou2+rovAwf9jDwDL5Hib3maoA5/ZT6RMO
         A9Aw==
X-Gm-Message-State: APjAAAUSr8ltIyGCfbydcc7WwXdaa4rsVLPr1PxAlY1+lCgND6a/j7No
        xSo3NMPG1V7Hob/Gk4w+1Q==
X-Google-Smtp-Source: APXvYqzXRaanc2zdr+B1b9JKSFt5RiU0He5Mvl9EG4hbNb9mNZSmtsazIxtd8yeg2piWO4vrvX+USA==
X-Received: by 2002:adf:a389:: with SMTP id l9mr10404278wrb.411.1581287613758;
        Sun, 09 Feb 2020 14:33:33 -0800 (PST)
Received: from ninjahost.lan (host-2-102-13-223.as13285.net. [2.102.13.223])
        by smtp.googlemail.com with ESMTPSA id i16sm12956818wrr.71.2020.02.09.14.33.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Feb 2020 14:33:33 -0800 (PST)
From:   Jules Irenge <jbi.octave@gmail.com>
To:     boqun.feng@gmail.com
Cc:     dvhart@infradead.org, peterz@infradead.org, mingo@redhat.com,
        acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, linux-kernel@vger.kernel.org,
        Jules Irenge <jbi.octave@gmail.com>
Subject: [PATCH 04/11] perf/ring_buffer: Add missing annotation to perf_output_end()
Date:   Sun,  9 Feb 2020 22:33:20 +0000
Message-Id: <fb329344d8dbf825c344c6fd655dbc988b5704af.1581282103.git.jbi.octave@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <cover.1581282103.git.jbi.octave@gmail.com>
References: <0/11> <cover.1581282103.git.jbi.octave@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sparse reports a warning at perf_output_end()

warning: context imbalance in perf_output_end() - unexpected unlock

The root cause is a missing annotation for perf_output_end()

Add the missing __releases(RCU) annotation

Signed-off-by: Jules Irenge <jbi.octave@gmail.com>
---
 kernel/events/ring_buffer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/events/ring_buffer.c b/kernel/events/ring_buffer.c
index 7ffd5c763f93..c09edc49a4fc 100644
--- a/kernel/events/ring_buffer.c
+++ b/kernel/events/ring_buffer.c
@@ -294,7 +294,7 @@ unsigned int perf_output_skip(struct perf_output_handle *handle,
 	return __output_skip(handle, NULL, len);
 }
 
-void perf_output_end(struct perf_output_handle *handle)
+void perf_output_end(struct perf_output_handle *handle) __releases(RCU)
 {
 	perf_output_put_handle(handle);
 	rcu_read_unlock();
-- 
2.24.1

