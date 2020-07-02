Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44956C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 23:11:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B6BA2088E
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 23:11:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ixca5eng"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726893AbgGBXLw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 19:11:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726718AbgGBXLP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 19:11:15 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E76DC08C5C1
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jul 2020 16:11:15 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id lx13so13133131ejb.4
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jul 2020 16:11:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+XseKbQnu7OoUmmVAPCmrn7d4GEgGn5BQUHGjqMQRps=;
        b=Ixca5engldjXgcEdNxLVSD4XlkjxPCoIPBbnc1TZDynedLf1uRhW+w+VMyTD8l7iJN
         oTWsW6XVkekUWRDugDU4cJvThx+rD+73ojQVsrxv8qtKERcl62PQY3tFIiyqT3mwv0Hi
         7m9WPTVQ9pDFIshPJNwBVX+qF/8wW8lsfB7QvjOgSbTP0Atns0GOKNIRsE6O8U8qXyOB
         KYrFABMncRS/B8sq4C3FLuQBc+767A0fYpkL5gN/vkGEiST4dO+n0rMkS+EvenvJ85zO
         rCknForUGDv1hfRJfV0I1yETNF4cKhLdm34ahi7ulD9UnakmniwL2UqN2bGT++GpDxIp
         mX8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+XseKbQnu7OoUmmVAPCmrn7d4GEgGn5BQUHGjqMQRps=;
        b=giiJoqG6gmneLdb/1CI/F/cBnsoEFmFQ40V3CENWaT2OmkMgE3hHKEt/Ngauz2DVnx
         47XIio1z3IRja/CnLuU8mhZG15g9c0SrphtPvpqPy9X8+b0xCE5EPFniE6gwS1ZyBuTf
         gxp5Sm5zobUGA4c888mdzsvjJFN6XhJVzfzE/PiKta5ZRwYf2Og7spC1Gy2/dJ3WGFYz
         fmEPrsim4PaaNkG17XpXHGnDjODOONP1tQfMxWK9D3TIVOUeITAx3IJk9iTF2qFhoo6Z
         WPEyV230m2WGgP0xHtO5Q17ot2nJmF77TRQopkfgbAEw6fZYPgl6YbfqC0zigLJ9ccKW
         flKg==
X-Gm-Message-State: AOAM5326kcB+YfLfpZkUQYQLUzTbTbumVFO3G4D27rcGNeAFi1XLmhgU
        r3F109QzJ2dOAAPhOJNyjbe4irF2
X-Google-Smtp-Source: ABdhPJwJ4a3xiR2VTvpmExDfvg17zUBvYDNCHTNFf5Rry/0AdTMN1/Q6VofJBU0XeOeTcMRpyCCmFw==
X-Received: by 2002:a17:906:a055:: with SMTP id bg21mr25355734ejb.516.1593731473648;
        Thu, 02 Jul 2020 16:11:13 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:b7f9:7600:bd38:c82d:5283:9f1])
        by smtp.gmail.com with ESMTPSA id x9sm8214031ejw.28.2020.07.02.16.11.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2020 16:11:13 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 09/15] options: move declaration of tabstop out of "token.h"
Date:   Fri,  3 Jul 2020 01:10:33 +0200
Message-Id: <20200702231039.55015-10-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200702231039.55015-1-luc.vanoostenryck@gmail.com>
References: <20200702231039.55015-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'tabstop' is unusual in the sense that it's one the few (the only?)
variable defined via an option flag which is not declared in "lib.h"
but in "token.h". This for to have to include "token.h" in the code
doing the parsing of the options ...

Move this declaration to "lib.h".

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 lib.h   | 1 +
 token.h | 1 -
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib.h b/lib.h
index 4f67958efdb9..e938f18dfc92 100644
--- a/lib.h
+++ b/lib.h
@@ -48,6 +48,7 @@ extern int die_if_error;
 extern int repeat_phase;
 extern int do_output;
 extern int gcc_major, gcc_minor, gcc_patchlevel;
+extern unsigned int tabstop;
 
 extern const char *base_filename;
 
diff --git a/token.h b/token.h
index 33a6eda1cc53..c5fdf3d0c879 100644
--- a/token.h
+++ b/token.h
@@ -64,7 +64,6 @@ struct stream {
 
 extern int input_stream_nr;
 extern struct stream *input_streams;
-extern unsigned int tabstop;
 extern int *hash_stream(const char *name);
 
 struct ident {
-- 
2.27.0

