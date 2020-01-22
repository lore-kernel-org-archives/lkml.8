Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DATE_IN_PAST_03_06,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A87E6C2D0DB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 13:17:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AB4A2071E
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 13:17:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579699062;
	bh=WQaJF2syDMlQj8XPY5gV2vYZsl8ylFPtqD3oy2TLVdU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=uxE0DHBo6ws/DVrICwM+uKvZ16/7PRSU5vuNXwVjy+YqS16ORXTqETR65+Vf22YFD
	 iRZFDgP4cHihP12CxVtbjwYxGy0VMbJ3jWBuA9Hv6eqXU1nrR54Sou3Pi4r/H8FxYn
	 acJNNqQSpC62OwHZZWkRKn4HXB6Llt2zQhucoRO4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728057AbgAVNRl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 08:17:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:33134 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725790AbgAVNRl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 08:17:41 -0500
Received: from localhost (unknown [84.241.205.26])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AEC94205F4;
        Wed, 22 Jan 2020 13:17:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579699060;
        bh=WQaJF2syDMlQj8XPY5gV2vYZsl8ylFPtqD3oy2TLVdU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qWcMORU0zbsjXcAdxnGtO+Cu3cvkk+tnQCNdL1MQbZHP0g+XsK3xISPkGMHG/Cj10
         o+FqMf5LcLkliSdCWKS6yONqhDtnVB/ECkdP4CnwAHkkqB2IdgvLT/9eKvdylvLIYb
         GxlesCZG1Ql+OWBZyQJuM3TWXJc9e1ysbgaLvxfk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Kevin Hilman <khilman@baylibre.com>
Subject: [PATCH 5.4 003/222] soc: amlogic: meson-ee-pwrc: propagate PD provider registration errors
Date:   Wed, 22 Jan 2020 10:26:29 +0100
Message-Id: <20200122092833.584400329@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200122092833.339495161@linuxfoundation.org>
References: <20200122092833.339495161@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

commit 0766d65e6afaea8b80205a468207de9f18cd7ec8 upstream.

of_genpd_add_provider_onecell() can return an error. Propagate the error
so the driver registration fails when of_genpd_add_provider_onecell()
did not work.

Fixes: eef3c2ba0a42a6 ("soc: amlogic: Add support for Everything-Else power domains controller")
Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Signed-off-by: Kevin Hilman <khilman@baylibre.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/soc/amlogic/meson-ee-pwrc.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

--- a/drivers/soc/amlogic/meson-ee-pwrc.c
+++ b/drivers/soc/amlogic/meson-ee-pwrc.c
@@ -441,9 +441,7 @@ static int meson_ee_pwrc_probe(struct pl
 		pwrc->xlate.domains[i] = &dom->base;
 	}
 
-	of_genpd_add_provider_onecell(pdev->dev.of_node, &pwrc->xlate);
-
-	return 0;
+	return of_genpd_add_provider_onecell(pdev->dev.of_node, &pwrc->xlate);
 }
 
 static void meson_ee_pwrc_shutdown(struct platform_device *pdev)


