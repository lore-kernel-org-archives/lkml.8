Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D72BC433E4
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 20:57:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0DCD3214D8
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 20:57:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="tbW7Ee+d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726926AbgGCU5I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 16:57:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726379AbgGCU5G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 16:57:06 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6A66C061794;
        Fri,  3 Jul 2020 13:57:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=M6C6YySqQi70TS5xHaBxSfjFdMg/sJtCXqPgg4DcCHY=; b=tbW7Ee+d3uWUKqGcHQH4L9RyvS
        n+/Ob0cWxgvUBrVuv7LdiEXZyjt2BbPVfSbMucpgNrnbJPjkZRp7R9Vwf2lb6A5sXn2Vz1Ooypv0q
        VylyX/hPfdiN1F5GhAJrhABm2bWhQhJFDooqMMgUVO8JolZQFV9sYL9FXH/a4y5wymhi59BiOi70p
        VCXp6N1Aebe5JtpsOJpZzQWCKFUEfghrJkoTYGNfXhO7P9b9VRe7eJV80RNcvPpI8diyWC+1vizV6
        WWI0HKgGyV+hHHCa5pf4Z5vH3jFeI/5wG+B/FK1A22wvztgm1IN56KO+QzUfCe0SH/QitK3r4MU0z
        ZEnhHwdg==;
Received: from [2601:1c0:6280:3f0::19c2] (helo=smtpauth.infradead.org)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jrSk3-0003a5-Jv; Fri, 03 Jul 2020 20:57:04 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>, linux-hwmon@vger.kernel.org
Subject: [PATCH 3/5] Documenation: hwmon/nct7665: drop duplicate words
Date:   Fri,  3 Jul 2020 13:56:47 -0700
Message-Id: <20200703205649.30125-4-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200703205649.30125-1-rdunlap@infradead.org>
References: <20200703205649.30125-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop the doubled word "be".

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
Cc: Jean Delvare <jdelvare@suse.com>
Cc: Guenter Roeck <linux@roeck-us.net>
Cc: linux-hwmon@vger.kernel.org
---
 Documentation/hwmon/nct6775.rst |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20200701.orig/Documentation/hwmon/nct6775.rst
+++ linux-next-20200701/Documentation/hwmon/nct6775.rst
@@ -276,5 +276,5 @@ temperature measurement device. As a res
 will not reflect a usable value. It often reports unreasonably high
 temperatures, and in some cases the reported temperature declines if the actual
 temperature increases (similar to the raw PECI temperature value - see PECI
-specification for details). CPUTIN should therefore be be ignored on ASUS
+specification for details). CPUTIN should therefore be ignored on ASUS
 boards. The CPU temperature on ASUS boards is reported from PECI 0.
