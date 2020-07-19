Return-Path: <SRS0=EKp2=A6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DECEC433E4
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jul 2020 00:28:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B956208B3
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jul 2020 00:28:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="V4tF1w36"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726618AbgGSA20 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Jul 2020 20:28:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726242AbgGSA2Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jul 2020 20:28:24 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A383C0619D2;
        Sat, 18 Jul 2020 17:28:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=Y82geW6BmIH2FBIJLxAiCkMl+xL8yusbwG1Zpki0JXg=; b=V4tF1w36xnLbasa8RwBc6SYsbl
        bW/f5PPWXkUf7xHQYmE6MRvPfoiE6xefSrK8Opq9xL4Oa1z73nTesfdc9a+tmEIvEIMVs7XCVZ+eH
        03NBGsn1JGGq/bcEG26b3GDl1u58Ox0uS12RA3ZRW6jpUHY55oICDg+846aT9s2OBv6Yey+XPZbrH
        tguZpysD9GYINxV0haq84UDsxycsL4/F+joB0N48gQRhUqKWhfqNMogVNpCZpMUZ29H/ZB8Zgovp3
        fKYAU4HlMuos3EyH2agejeJuZoaTIZvUK8JEDl92r8+mAM4XL8BX5wRDBl0hNzarqKA7vEf34YdNm
        GEgM3RxA==;
Received: from [2601:1c0:6280:3f0::19c2] (helo=smtpauth.infradead.org)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jwxBk-0002gH-Vh; Sun, 19 Jul 2020 00:28:22 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Peter Rosin <peda@axentia.se>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Subject: [PATCH] dt-bindings: mux: mux.h: drop a duplicated word
Date:   Sat, 18 Jul 2020 17:28:16 -0700
Message-Id: <20200719002816.20263-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop the repeated word "the" in a comment.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Peter Rosin <peda@axentia.se>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: devicetree@vger.kernel.org
---
 include/dt-bindings/mux/mux.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20200717.orig/include/dt-bindings/mux/mux.h
+++ linux-next-20200717/include/dt-bindings/mux/mux.h
@@ -3,7 +3,7 @@
  * This header provides constants for most Multiplexer bindings.
  *
  * Most Multiplexer bindings specify an idle state. In most cases, the
- * the multiplexer can be left as is when idle, and in some cases it can
+ * multiplexer can be left as is when idle, and in some cases it can
  * disconnect the input/output and leave the multiplexer in a high
  * impedance state.
  */
