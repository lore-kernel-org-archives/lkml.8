Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6785C352A3
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 13:03:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E4AC2070A
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 13:03:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581339812;
	bh=HoMHbtbOrBm2LgfG24633FywPA+dHpw7bVzGwSr2CFA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=gg5aUh5om5G+Zj4FlHbVJ4se+PEwATBSpn7gl4nsSluwyh7jLGXtIANq6wGLC9Lnm
	 q2UGeDoTyLznm/HUIAx1BgbwCUFPbjTMHd2rPJA1kOecydRMzfazMokfGgullTKOMA
	 MNSlmOLGb848zgpfChP+LLOYqzvb9QW+cXba3MjM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729152AbgBJNDb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 08:03:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:40296 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729719AbgBJMkX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 07:40:23 -0500
Received: from localhost (unknown [209.37.97.194])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 67ADC20661;
        Mon, 10 Feb 2020 12:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581338423;
        bh=HoMHbtbOrBm2LgfG24633FywPA+dHpw7bVzGwSr2CFA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xLt5eOT4fnbkdQOT3KWD3CLggILXWbJ9CT2KVtkjMf2Ty7wB/5Xr4o0lRqYmO/9M+
         9FXxaw/JuaJevat6Wb3H0uPjE7s94h/VIWBvMXUhvxKtoZdxYDsq2BplnxQTtdwMXH
         tzETCCfQOxsLbHsZPgzPBwdS/Eu+LO2i3V6xDYGs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Gilad Ben-Yossef <gilad@benyossef.com>,
        Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 5.5 117/367] crypto: ccree - fix pm wrongful error reporting
Date:   Mon, 10 Feb 2020 04:30:30 -0800
Message-Id: <20200210122435.441599103@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200210122423.695146547@linuxfoundation.org>
References: <20200210122423.695146547@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gilad Ben-Yossef <gilad@benyossef.com>

commit cedca59fae5834af8445b403c66c9953754375d7 upstream.

pm_runtime_get_sync() can return 1 as a valid (none error) return
code. Treat it as such.

Signed-off-by: Gilad Ben-Yossef <gilad@benyossef.com>
Cc: stable@vger.kernel.org # v4.19+
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/crypto/ccree/cc_pm.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/crypto/ccree/cc_pm.c
+++ b/drivers/crypto/ccree/cc_pm.c
@@ -85,7 +85,7 @@ int cc_pm_get(struct device *dev)
 	else
 		pm_runtime_get_noresume(dev);
 
-	return rc;
+	return (rc == 1 ? 0 : rc);
 }
 
 int cc_pm_put_suspend(struct device *dev)


