Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED738C2D0E7
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 01:25:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BED9520733
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 01:25:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EN6zdjyR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728280AbgC3BZI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Mar 2020 21:25:08 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45159 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727830AbgC3BZH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Mar 2020 21:25:07 -0400
Received: by mail-wr1-f65.google.com with SMTP id t7so19375815wrw.12
        for <linux-kernel@vger.kernel.org>; Sun, 29 Mar 2020 18:25:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vvVNz/dCC3Pp0jd+BVDOSr6q8PbYsHQO5xWmDmPIZ9M=;
        b=EN6zdjyRFmvz8gT6YiTOEvA3n8BuG+QOoxVf/9opOdvUSdodz4/kbKv7f449QrJLhH
         Q4k2xZUao3jkVyJqy/Q5mc1KDrX38hxP2nhH4XuaiZIuDsSEFPuUKL2VeKpCVax28Tnu
         X105I3cV++SPsSXFO7xmgsrL7xlqT6mgjHEwcULEJnTVAfX1X9KimpZXDLugQH7Hyr39
         tTFPWDMgtMc0xsBaHRGRAvOQsrcY4Dx7ssbTAAznS163cmJ8FufNLdHRuw9fRquMTfKC
         ylbC+VhrUtjUC/fiK7ZTWmvUgCi7x79c6mPbuNCBtrvkXhzOrBc1pO1yIlZ/1F5C2A7O
         3HiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vvVNz/dCC3Pp0jd+BVDOSr6q8PbYsHQO5xWmDmPIZ9M=;
        b=YuXaNMw/fbXzmjcq+1fbcusGnMFy8dVGqE2ccWpAYvYlibGZq5lh7faQt++lniJRfh
         lBaJGPDf1aL4MZUExmJmoUbzWhoE8lKccMQWHZjg1esbHQTzXizskMJG1CVKgLkjzdVw
         Q/xD8tbK+zYEiHI0KE/cxM02BcLS6Pzb/VUwxrmeFbxj7ZP+U4VAzvaq7ZOOrPx+7v57
         8DBL+V7idpRmmHld/J4IKATsoHUStotBfVb0lF1au8hr9QFaI+bA1LfFuVaDYqWMTVlB
         Zji4PssMckxE+vY1lwOtNYPVX1CHvGhT0p0qEFRFMRa2XbRy+yvNwgdCzhjVqckF9Tbg
         0tTQ==
X-Gm-Message-State: ANhLgQ0wtjMGePr3qOVwUby/n1ht1Pl2NeWHSvSsOIzTB1dDK9Ygf4+/
        HjeaGASozAwF68w32uuh+XpUbFCN2l0i
X-Google-Smtp-Source: ADFU+vsfyNr2Nfuz0GkAvroTo3SSCQ4V0ayjUa8ha12uRbT4ICpNO4+X2/UgirDHkOD5PfTc+e3Wuw==
X-Received: by 2002:a5d:49c8:: with SMTP id t8mr12472254wrs.5.1585531505670;
        Sun, 29 Mar 2020 18:25:05 -0700 (PDT)
Received: from earth.lan (host-92-23-85-227.as13285.net. [92.23.85.227])
        by smtp.gmail.com with ESMTPSA id f12sm18679545wmh.4.2020.03.29.18.25.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Mar 2020 18:25:05 -0700 (PDT)
From:   Jules Irenge <jbi.octave@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     julia.lawall@lip6.fr, boqun.feng@gmail.com,
        Thomas Gleixner <tglx@linutronix.de>,
        Jiri Kosina <jkosina@suse.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Eiichi Tsukata <devel@etsukata.com>,
        Tyler Hicks <tyhicks@canonical.com>
Subject: [PATCH v2 1/4] cpu: Remove Comparison to bool
Date:   Mon, 30 Mar 2020 02:24:47 +0100
Message-Id: <20200330012450.312155-2-jbi.octave@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200330012450.312155-1-jbi.octave@gmail.com>
References: <0/4>
 <20200330012450.312155-1-jbi.octave@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Coccinelle reports a warning inside __cpuhp_state_add_instance_cpuslocked()

WARNING: Comparison to bool

To fix this a comparison to a bool variable to false is removed
and replaced with the operator ! before the variable

Signed-off-by: Jules Irenge <jbi.octave@gmail.com>
---
 kernel/cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/cpu.c b/kernel/cpu.c
index 9c706af713fb..97f8b79ba5f5 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -1682,7 +1682,7 @@ int __cpuhp_state_add_instance_cpuslocked(enum cpuhp_state state,
 	lockdep_assert_cpus_held();
 
 	sp = cpuhp_get_step(state);
-	if (sp->multi_instance == false)
+	if (!sp->multi_instance)
 		return -EINVAL;
 
 	mutex_lock(&cpuhp_state_mutex);
-- 
2.25.1

