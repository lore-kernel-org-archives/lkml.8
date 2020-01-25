Return-Path: <SRS0=aedO=3O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ACEBC35241
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jan 2020 08:48:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5202A2071E
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jan 2020 08:48:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dk0l57cF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728797AbgAYIoL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Jan 2020 03:44:11 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:34963 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726303AbgAYIoK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jan 2020 03:44:10 -0500
Received: by mail-pl1-f195.google.com with SMTP id g6so1790515plt.2
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jan 2020 00:44:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=Sg499Tfb3mohA4p0m6z4rC8Gw18lzl843VQiZsEcJYk=;
        b=dk0l57cF9lRQaWGwIvxjXe+NoAH6ao/tNUFBd/bpqpCSWiIjuln2HYMQybiYS21HnU
         IXF9wbTdpRCaxLd0ITc/LK8Y3RgXgYgAVm+pGDfy0n8Hg72ut6O+1B916MNpkiQpDRI1
         sfg3rDCfNaUB1QGNROSBfbGaqrHKOFxRz+NW9Ga6EX8LRFAGQxZh1R5V3aS6OGF9ZLvr
         IPoQZq/PkwUjMiGEGsQU9e/I+6SsRGbZDsREZJFZNY/Q5TeZbPtYGGgiWXlk8f5Tcohf
         ug9fGjCLhuY1k6Snd5s63f0DSwFkIYUIlwhLiS1+l3tnZlWPt51tLdp/fgFpVeeS+BDN
         MOLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=Sg499Tfb3mohA4p0m6z4rC8Gw18lzl843VQiZsEcJYk=;
        b=TPwk0OLbUN0ZDYnSauBZlANZyGGjeLqEqHTGCp+EgGueXhlSjxoqskj1wohQEIPCnf
         X5AwtBjEKgAjVfVqORL4bLX5NV/UBDfTb5DDp6Ol2fj9USOn5RQfQiHhCNT6YaVCMhSw
         mKI1cgQrxt1l0eVNKmP6wSj915YkLxCPBETnJDMRW9PCSmekhlrDkMgwdlHVQzR+2Jtt
         JQO0IdyyLKWCgnw2Ux1L0gWq5HxnOCP+8HRq6XDlEeZjhk03OHg7wgRPK7fhvisOBCbf
         v79L3zRk1DxYeDuE5npDUgLrP/COMH+AVa/j792T7r6luoyAB4WYyQicWd+YeIP8S0V6
         L3Sg==
X-Gm-Message-State: APjAAAVWZ3Ji4yoYNVynsxNexa83n0kH1L5Izg4b1BEtkRn+BKTtureW
        pEisTVT78ROITv/pY6M501U=
X-Google-Smtp-Source: APXvYqxLq5+2a/fDIqR8qQFe+R5NU9WyWT2LBE3BHKqfc/VYQFv7x8Qrw8QSq7Oj9w+//LR26z40Kw==
X-Received: by 2002:a17:90a:8a12:: with SMTP id w18mr3725137pjn.68.1579941850044;
        Sat, 25 Jan 2020 00:44:10 -0800 (PST)
Received: from google.com ([123.201.163.7])
        by smtp.gmail.com with ESMTPSA id w38sm9267986pgk.45.2020.01.25.00.44.07
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sat, 25 Jan 2020 00:44:09 -0800 (PST)
Date:   Sat, 25 Jan 2020 14:14:03 +0530
From:   Saurav Girepunje <saurav.girepunje@gmail.com>
To:     vireshk@kernel.org, johan@kernel.org, elder@kernel.org,
        gregkh@linuxfoundation.org, greybus-dev@lists.linaro.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Cc:     saurav.girepunje@hotmail.com
Subject: [PATCH] staging: greybus: bootrom: fix uninitialized variables
Message-ID: <20200125084403.GA3386@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
User-Agent: Mutt/1.6.2-neo (NetBSD/sparc64)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fix uninitialized variables issue found using static code analysis tool

(error) Uninitialized variable: offset
(error) Uninitialized variable: size

Signed-off-by: Saurav Girepunje <saurav.girepunje@gmail.com>
---
  drivers/staging/greybus/bootrom.c | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/greybus/bootrom.c b/drivers/staging/greybus/bootrom.c
index a8efb86..9eabeb3 100644
--- a/drivers/staging/greybus/bootrom.c
+++ b/drivers/staging/greybus/bootrom.c
@@ -245,7 +245,7 @@ static int gb_bootrom_get_firmware(struct gb_operation *op)
  	struct gb_bootrom_get_firmware_request *firmware_request;
  	struct gb_bootrom_get_firmware_response *firmware_response;
  	struct device *dev = &op->connection->bundle->dev;
-	unsigned int offset, size;
+	unsigned int offset = 0, size = 0;
  	enum next_request_type next_request;
  	int ret = 0;
  
-- 
1.9.1

