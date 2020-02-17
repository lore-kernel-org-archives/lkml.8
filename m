Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83564C35242
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 04:44:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5815A20718
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 04:44:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="kTA/xvgx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727901AbgBQEoM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Feb 2020 23:44:12 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:40338 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726656AbgBQEoL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Feb 2020 23:44:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:Date:Message-ID:Subject:From:Cc:To:Sender:Reply-To:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=1lvp+IDsJ8STAlLQx2axXCMnO3DgipEE+529qyr+2EY=; b=kTA/xvgxXJtM8EXzu1djvXwqZK
        Sjy6Vhu0J0kWK4k7DbomEaDsdp40F+zHiH118i+E9WX+5WnhTU3KHRUcE41V2fuR6BVtZd8ihGJYk
        htCDB42KbLgAmb1EmZU2sMTwhVIgrNtsuC7+HnKaxyE+ZGjCArCi+fKTQneMjgtlXP3aLIjMwpKVu
        EpN2i/gsB0FgUHVFejmO63fv5qy2jEnGRDIz7cOGQRx8v7RUEQ5tEhaQzRx1SWGyJysUL6YNMI1By
        X1NFiY8aTewZCc8NA2W61bv2Yu37tQCYKl2rnUqVLOiUW+l3m5BiXNfAD60IQN2RcElmNLd7Ay6wq
        clVY8pLQ==;
Received: from [2601:1c0:6280:3f0::19c2]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j3YGQ-0001B0-Ey; Mon, 17 Feb 2020 04:44:10 +0000
To:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     Vadim Pasternak <vadimp@mellanox.com>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] Documentation/hwmon: fix xdpe12284 Sphinx warnings
Message-ID: <0094c570-dd4c-dc0e-386d-ea1c39b6a582@infradead.org>
Date:   Sun, 16 Feb 2020 20:44:09 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

Fix Sphinx format warnings by adding a blank line.

Documentation/hwmon/xdpe12284.rst:28: WARNING: Unexpected indentation.
Documentation/hwmon/xdpe12284.rst:29: WARNING: Block quote ends without a blank line; unexpected unindent.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Jean Delvare <jdelvare@suse.com>
Cc: Guenter Roeck <linux@roeck-us.net>
Cc: linux-hwmon@vger.kernel.org
Cc: Vadim Pasternak <vadimp@mellanox.com>
---
 Documentation/hwmon/xdpe12284.rst |    1 +
 1 file changed, 1 insertion(+)

--- lnx-56-rc2.orig/Documentation/hwmon/xdpe12284.rst
+++ lnx-56-rc2/Documentation/hwmon/xdpe12284.rst
@@ -24,6 +24,7 @@ This driver implements support for Infin
 dual loop voltage regulators.
 The family includes XDPE12284 and XDPE12254 devices.
 The devices from this family complaint with:
+
 - Intel VR13 and VR13HC rev 1.3, IMVP8 rev 1.2 and IMPVP9 rev 1.3 DC-DC
   converter specification.
 - Intel SVID rev 1.9. protocol.


