Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60698C433E1
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 20:57:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3110120885
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 20:57:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="U3U0QbtP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726948AbgGCU5N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 16:57:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726923AbgGCU5I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 16:57:08 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1DCDC061794;
        Fri,  3 Jul 2020 13:57:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=ER9INp1xkSyqdiyLU3ujpdio8GueQUvIZBaizd2Mgo4=; b=U3U0QbtPmGoxRFNfTjHazOebZX
        nZsMOdt7Xl3NLG0vKOpUxKfNz5JjHau2Urq3mbuxRHu48HTRk7AzH98aY3uNSBUrejTyS3Q6eLVrk
        tC+c93kdUqMfXEQMmyMddnV8bcik+uy88QH+XHe+5RucwApBPIID2y0KvN/pOxLw0hv3QyuLBrAlY
        B2hED+14k8jtQWzmhwfZtfQ0aHCQRoMc7/fTLTf0vA79XvmBKCWfoKMMCdCkOcOeQnFFw9YyIzz4K
        i+fhK75nWcpB2CP34OFvFqATaURVizH0rm1LP3NIjEahFdqA4psFC7ezN7d3Pm07HBe/rc9pxLZRK
        SmDjcVBQ==;
Received: from [2601:1c0:6280:3f0::19c2] (helo=smtpauth.infradead.org)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jrSk6-0003a5-Bw; Fri, 03 Jul 2020 20:57:06 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>, linux-hwmon@vger.kernel.org
Subject: [PATCH 4/5] Documenation: hwmon/w83627ehf: drop duplicate words
Date:   Fri,  3 Jul 2020 13:56:48 -0700
Message-Id: <20200703205649.30125-5-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200703205649.30125-1-rdunlap@infradead.org>
References: <20200703205649.30125-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop the doubled word "and".

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
Cc: Jean Delvare <jdelvare@suse.com>
Cc: Guenter Roeck <linux@roeck-us.net>
Cc: linux-hwmon@vger.kernel.org
---
 Documentation/hwmon/w83627ehf.rst |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20200701.orig/Documentation/hwmon/w83627ehf.rst
+++ linux-next-20200701/Documentation/hwmon/w83627ehf.rst
@@ -96,7 +96,7 @@ sensors. The configured source for each
 in tempX_label.
 
 Temperatures are measured in degrees Celsius and measurement resolution is 1
-degC for temp1 and and 0.5 degC for temp2 and temp3. For temp4 and higher,
+degC for temp1 and 0.5 degC for temp2 and temp3. For temp4 and higher,
 resolution is 1 degC for W83667HG-B and 0.0 degC for NCT6775F and NCT6776F.
 An alarm is triggered when the temperature gets higher than high limit;
 it stays on until the temperature falls below the hysteresis value.
