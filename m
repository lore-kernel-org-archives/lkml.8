Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8CA0C433E1
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 16:39:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 852DB20738
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 16:39:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Yjk9E/lb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729886AbgFDQjx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 12:39:53 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:26896 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729789AbgFDQjt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 12:39:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591288788;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MeNHDufylgfgT2BEBGZ7dMeWJwugUdwUrhiENouAjaA=;
        b=Yjk9E/lbvmUcPfajfjEe2TaGWEqPQadh0YSHoxHrtT6T68+2hROC/jEdc9o5gfQzDyUNfu
        dm2C8LXfsPAOXJcHLyzb+aLr2392wEF3VMWj0h42bCa98n/yIF8YFOEBLRhCm+CUFWqVfl
        jgPqRA1tIpHOKA7tF9oNgLpDkPTigIg=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-325-P4D0NHrZPaC69uUufPuP0w-1; Thu, 04 Jun 2020 12:39:47 -0400
X-MC-Unique: P4D0NHrZPaC69uUufPuP0w-1
Received: by mail-wm1-f71.google.com with SMTP id b65so2174938wmb.5
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jun 2020 09:39:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MeNHDufylgfgT2BEBGZ7dMeWJwugUdwUrhiENouAjaA=;
        b=Yp22vqkwOkaS3+QSeuQTvu49xKif0frZzKD8vxsIM2Q53M5HnunShjGide+F02oMDP
         Pqx1KBInCcP8H7MLFcV/CPcq6rSirs0Aw8fYpgu/zr2Cvlfgrxp2x3zfGb7qF+x8HNON
         tBev+ZURBZGcy5kve5dl1PR9CmRiJjUGhbIGqLaGJjQ8fEMGSDwzYXk1GvB7d7TeRQo5
         FrvySsFwt2hx4Cu/PPp2fsVvI3hJMg4YkWs2HqU5dCJ4AaxNn0Pr7O5lOoRXUYkseN79
         o+c4ylaRWhtn+4Th1oTCLoKxdvsQHf7JFukulzxArscgZT6PflK74plnPYsBsMhuzupM
         /fqA==
X-Gm-Message-State: AOAM531fFp9xxYKMn6TNXaDf+akvP6O2Ks+1NomzjsxxbDBwB+SXoh21
        9tm5qwmBJgFOnnTYzRuATmX24ib6zeLi41XGKQ9nn8MUU2GKqNgLw9S+XX5jKCR814UvTel8aNH
        aIocwQTWimeRtO4GvWvBL4emw
X-Received: by 2002:adf:e751:: with SMTP id c17mr4988643wrn.134.1591288785738;
        Thu, 04 Jun 2020 09:39:45 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxccHrZexfZGNOsrR7uQGN1fRdp8e4dG3x3GnMWq9Faj9TbycCm/wbLRRWwASvuulzWjF1FYA==
X-Received: by 2002:adf:e751:: with SMTP id c17mr4988628wrn.134.1591288785541;
        Thu, 04 Jun 2020 09:39:45 -0700 (PDT)
Received: from redfedo.redhat.com ([2a01:cb14:499:3d00:cd47:f651:9d80:157a])
        by smtp.gmail.com with ESMTPSA id p9sm7881636wma.48.2020.06.04.09.39.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2020 09:39:45 -0700 (PDT)
From:   Julien Thierry <jthierry@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     jpoimboe@redhat.com, peterz@infradead.org, mhelsley@vmware.com,
        Julien Thierry <jthierry@redhat.com>
Subject: [PATCH 3/4] objtool: orc: Skip setting orc_entry for non-text sections
Date:   Thu,  4 Jun 2020 17:39:37 +0100
Message-Id: <20200604163938.21660-4-jthierry@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200604163938.21660-1-jthierry@redhat.com>
References: <20200604163938.21660-1-jthierry@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Orc generation is only done for text sections, but some instructions
can be found in non-text sections (e.g. .discard.text sections).

Skip setting their orc sections since their whole sections will be
skipped for orc generation.

Signed-off-by: Julien Thierry <jthierry@redhat.com>
---
 tools/objtool/orc_gen.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/objtool/orc_gen.c b/tools/objtool/orc_gen.c
index c9549988121a..e74578640705 100644
--- a/tools/objtool/orc_gen.c
+++ b/tools/objtool/orc_gen.c
@@ -18,6 +18,9 @@ int create_orc(struct objtool_file *file)
 		struct cfi_reg *cfa = &insn->cfi.cfa;
 		struct cfi_reg *bp = &insn->cfi.regs[CFI_BP];
 
+		if (!insn->sec->text)
+			continue;
+
 		orc->end = insn->cfi.end;
 
 		if (cfa->base == CFI_UNDEFINED) {
-- 
2.21.1

