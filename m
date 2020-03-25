Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 987C3C18E5B
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 08:42:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E5942073E
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 08:42:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NDFxItVO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727601AbgCYImr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 04:42:47 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:58935 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727448AbgCYImT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 04:42:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585125738;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LkILQqLeJ/zPMBY6DkeS39fjniyl7+maeMVPF6b4gpE=;
        b=NDFxItVO0x35OnXSK7ypuPjMC10V1FZa/ET2eRqoy6x5Tj+TMHxyCDnY2TYr8PzF3Hv6Ek
        2Qf8tA8XPa4aevoFtBo/0Yvw1Gdhm0NWlVBbOfEWmDJbZ1+oE3sbQ/qCcO66FNdRkTTKbn
        hNlGwjKgEJ50vsHWxuvtuA18tfCTWW0=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-128-nF1_sdJtPE-xukzyOnMqtg-1; Wed, 25 Mar 2020 04:42:17 -0400
X-MC-Unique: nF1_sdJtPE-xukzyOnMqtg-1
Received: by mail-wr1-f69.google.com with SMTP id h17so795735wru.16
        for <linux-kernel@vger.kernel.org>; Wed, 25 Mar 2020 01:42:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LkILQqLeJ/zPMBY6DkeS39fjniyl7+maeMVPF6b4gpE=;
        b=t9TZElxee7KiF4jbOlOZ86V9UP/8nhflg49uC67GxfD3eOUHEjRMjLyPBHLlDAtZud
         4zvG5aAd5dDhpMqpcrkS4zfRC2AzpRN7RMH+9oFZMG0mK76T4IDSQkoHQGNAr8dwx70h
         pXAe60vJ91ox+AlfmPxOhe2LisjInlpUVlb/pqEGEUoxlB5ghpk2+4UvNE5xTDVep2/e
         gk2DsGqSK8ZN0MQnKtaeBkOtXASqxdehxHKb+emvqjDZcT411I1n6saeeMBMProEVfkJ
         LCclYjjthrob2JaTpWMbHG7ic/fBljFvILHqBIgXGxAA4p352EJrHejPUG+NN3uduTOq
         S6Xg==
X-Gm-Message-State: ANhLgQ2tNBesMNCp/xe/qyelR2J0+/R8fQkqdR1Mjq7dDagJDxdFaOe2
        yKcdUxez4t3X7xvlw3MtvfuXljR7ivgvK5XSyVN9HltITs7TW7DLezQtbOx75YpSTAFrVNiq7L5
        vnh3qEbfK7jIGq/GF/AKMC8xt
X-Received: by 2002:adf:eb0c:: with SMTP id s12mr2146701wrn.293.1585125735569;
        Wed, 25 Mar 2020 01:42:15 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vtvHkIQdl9JjQlSF5P+Gi1rUMMc2pSmPDbMM39ShVd694myUMdKbxgUgxmolVWbomDOiO6XEg==
X-Received: by 2002:adf:eb0c:: with SMTP id s12mr2146674wrn.293.1585125735325;
        Wed, 25 Mar 2020 01:42:15 -0700 (PDT)
Received: from redfedo.redhat.com ([2a01:cb14:58d:8400:ecf6:58e2:9c06:a308])
        by smtp.gmail.com with ESMTPSA id f12sm8055323wmf.24.2020.03.25.01.42.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2020 01:42:14 -0700 (PDT)
From:   Julien Thierry <jthierry@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     jpoimboe@redhat.com, peterz@infradead.org, raphael.gault@arm.com,
        Julien Thierry <jthierry@redhat.com>
Subject: [PATCH 04/10] objtool: check: Ignore empty alternative groups
Date:   Wed, 25 Mar 2020 08:41:57 +0000
Message-Id: <20200325084203.17005-5-jthierry@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200325084203.17005-1-jthierry@redhat.com>
References: <20200325084203.17005-1-jthierry@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Atlernative section can contain entries for alternatives with no
instructions. Objtool will currently crash when handling such an entry.

Just skip that entry, but still give a warning to discourage useless
entries.

Signed-off-by: Julien Thierry <jthierry@redhat.com>
---
 tools/objtool/check.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 0ccf6882d8ce..75ebaa0a6216 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -917,6 +917,12 @@ static int add_special_section_alts(struct objtool_file *file)
 		}
 
 		if (special_alt->group) {
+			if (!special_alt->orig_len) {
+				WARN_FUNC("empty alternative entry",
+					  orig_insn->sec, orig_insn->offset);
+				continue;
+			}
+
 			ret = handle_group_alt(file, special_alt, orig_insn,
 					       &new_insn);
 			if (ret)
-- 
2.21.1

