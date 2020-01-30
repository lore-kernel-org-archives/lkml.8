Return-Path: <SRS0=4zup=3T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37975C33CB3
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 18:39:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0699620CC7
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 18:39:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580409594;
	bh=UGgShfD6ZVGUoofdDk7TTAKKPgJ/LDgem8dtriwzlOY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ME/OY/1thUF5cpFph5Ror2cN/vTBNeWTl5K2yC0OZa/cKFm14MxPJbxO8LIYraPvB
	 2l+5rXzeJnZEQKPrRQB6MmXRUr4/P3cuKqm8/o3S5LzjWJs4HJauywVAY8UJaoCjIA
	 3nJfbT3ooqv3OSSEy+vwAKoGaZTSaz1w3297VsaQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727933AbgA3Sjx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jan 2020 13:39:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:47184 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727285AbgA3Sjv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 13:39:51 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 22E3D20702;
        Thu, 30 Jan 2020 18:39:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580409589;
        bh=UGgShfD6ZVGUoofdDk7TTAKKPgJ/LDgem8dtriwzlOY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=W4dnOFUNiO5xa1S+NJDkaggUTm9WYPXyNMSRuTZoSdbNLqeOuNdk+x13bRlclpdSQ
         NRlmUzgJRr+sZMXvz0ZNZXuAI4cIA7NThB/xw3j+k5ksEmIYx86/88sI1wpzXimkps
         QzwzTnKykUNDg8wzMTFmEzvUTmyiaAyAgn5VleZs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Thomas Hebb <tommyhebb@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 5.5 11/56] usb: typec: fusb302: fix "op-sink-microwatt" default that was in mW
Date:   Thu, 30 Jan 2020 19:38:28 +0100
Message-Id: <20200130183611.245141241@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200130183608.849023566@linuxfoundation.org>
References: <20200130183608.849023566@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Hebb <tommyhebb@gmail.com>

commit eb7a3bb8c955b3694e0e0998413ce1563c02f90c upstream.

commit 8f6244055bd3 ("usb: typec: fusb302: Always provide fwnode for the
port") didn't convert this value from mW to uW when migrating to a new
specification format like it should have.

Fixes: 8f6244055bd3 ("usb: typec: fusb302: Always provide fwnode for the port")
Cc: stable@vger.kernel.org
Signed-off-by: Thomas Hebb <tommyhebb@gmail.com>
Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Link: https://lore.kernel.org/r/0da564559af75ec829c6c7e3aa4024f857c91bee.1579529334.git.tommyhebb@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/typec/tcpm/fusb302.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/usb/typec/tcpm/fusb302.c
+++ b/drivers/usb/typec/tcpm/fusb302.c
@@ -1666,7 +1666,7 @@ static const struct property_entry port_
 	PROPERTY_ENTRY_STRING("try-power-role", "sink"),
 	PROPERTY_ENTRY_U32_ARRAY("source-pdos", src_pdo),
 	PROPERTY_ENTRY_U32_ARRAY("sink-pdos", snk_pdo),
-	PROPERTY_ENTRY_U32("op-sink-microwatt", 2500),
+	PROPERTY_ENTRY_U32("op-sink-microwatt", 2500000),
 	{ }
 };
 


