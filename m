Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81F8FC433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 07:12:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 60DB6204EF
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 07:12:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J5TyKa12"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729099AbgFHHMg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 03:12:36 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:31747 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728914AbgFHHMP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 03:12:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591600335;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MeNHDufylgfgT2BEBGZ7dMeWJwugUdwUrhiENouAjaA=;
        b=J5TyKa12ss9LaYY3TuYqjiMOY95bI+h5oIFKeONWh1uuy9lPSvEJCB4N6W/3302+qLg7jr
        rT7FN2+5PzTp9UeIPHUuAKJrTLzMMSdKIUR8MacoN+3qYi3oLW/2zVKSOw6tztoUgZmDG3
        70qD/rz8zDR40xr5a7XXKPz5FCVyv0g=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-100-hblYLxyAPFOSRp9vKVaMWg-1; Mon, 08 Jun 2020 03:12:13 -0400
X-MC-Unique: hblYLxyAPFOSRp9vKVaMWg-1
Received: by mail-wm1-f71.google.com with SMTP id j128so4877295wmj.6
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jun 2020 00:12:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MeNHDufylgfgT2BEBGZ7dMeWJwugUdwUrhiENouAjaA=;
        b=WPrILocHiHd6VxBdfB1RrmAKU2R3UQ/jXKsIY+n8Rma6zlcRSJ931dJzcsKQRBfeFh
         2gTK6nQIebwXnMkWbS7OF8DjMA59+OzXq9gv34oe9l92rJLFp+QsXqdXMsiWB+O38FK/
         nAM7gjSDq6/aiU6jqqxMKjCpeQn0EwTK/8E5TU0iPXjnbtePpAWaC70nND5LY6mmBWrw
         pyGkUoq8EqnFMvYqNHcHvAa3dx1RuID+oyxf5cVPmTAftFqfkUigNbCaFrtF7RTOcv8n
         Xc20Dkepsmy94s84hZlJvuIInN651j5I21Rauq2ND9JwhkRa8DJUxS0Qv8AZzPrR/8vp
         2AwA==
X-Gm-Message-State: AOAM533cAVtVspwh/grxe9UAR+fKsLobSwTj/gBFM6iq/ezCH/rqztae
        ppcxtwr0qfODmrbBXnxA7Zkt5tS3j/6BqW6fd1lkRpbSpYNTxY4e/SvV7vAvEFyhQdpXyWDgoV7
        qgsqqX2CBlB7z+uVWfvNXO0th
X-Received: by 2002:a1c:ab07:: with SMTP id u7mr15025008wme.130.1591600331106;
        Mon, 08 Jun 2020 00:12:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyXc8a0D6fiO/OBMGJUel7uNPXQzXHcNbZ6vTCu0wKf+g/2irR8Ud4+f3JjC9ClJ3hhw0R35Q==
X-Received: by 2002:a1c:ab07:: with SMTP id u7mr15024993wme.130.1591600330946;
        Mon, 08 Jun 2020 00:12:10 -0700 (PDT)
Received: from redfedo.redhat.com ([2a01:cb14:499:3d00:cd47:f651:9d80:157a])
        by smtp.gmail.com with ESMTPSA id w17sm22908254wra.71.2020.06.08.00.12.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2020 00:12:10 -0700 (PDT)
From:   Julien Thierry <jthierry@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     jpoimboe@redhat.com, peterz@infradead.org, mhelsley@vmware.com,
        mbenes@suse.cz, Julien Thierry <jthierry@redhat.com>
Subject: [PATCH v2 3/4] objtool: orc: Skip setting orc_entry for non-text sections
Date:   Mon,  8 Jun 2020 08:12:02 +0100
Message-Id: <20200608071203.4055-4-jthierry@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200608071203.4055-1-jthierry@redhat.com>
References: <20200608071203.4055-1-jthierry@redhat.com>
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

