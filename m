Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC64DC352A3
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 13:22:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92EFD20715
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 13:22:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581340934;
	bh=HoMHbtbOrBm2LgfG24633FywPA+dHpw7bVzGwSr2CFA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=I0W+b51FgTtIuTHgKArLnwKovrfBvzXJDVoBs9rJExlX8dxlNzBbaobxwz5w+W0LF
	 ooAM19wLYdO7o4fd1nCF6gtSllVda/Q2W6/urmFXIgfpoh2UNLf5xGkFkncp5r13kB
	 /uQRzYqjOb34BelGH2L4baZyMySLhcnMVBomGUJ0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731129AbgBJNWN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 08:22:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:58926 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728750AbgBJMh0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 07:37:26 -0500
Received: from localhost (unknown [209.37.97.194])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 103BD20838;
        Mon, 10 Feb 2020 12:37:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581338246;
        bh=HoMHbtbOrBm2LgfG24633FywPA+dHpw7bVzGwSr2CFA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WyqS72Z7/vil1UY2YNnTxRhpMabQ7Z6aJTZ7Mm2ty4PQakjTuaIk6ZXcA0r0mI433
         r/KTxbBEMvicdq3gmGk1IIRtNO9Kn2Ig4vqv3po5O4CKLwAi6R0LKmxUS9aUhIA0vz
         6b90juBEIIT8IdmfEqqCLo5KS2i0HXUUnWnXwxoY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Gilad Ben-Yossef <gilad@benyossef.com>,
        Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 5.4 104/309] crypto: ccree - fix pm wrongful error reporting
Date:   Mon, 10 Feb 2020 04:31:00 -0800
Message-Id: <20200210122416.286214405@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200210122406.106356946@linuxfoundation.org>
References: <20200210122406.106356946@linuxfoundation.org>
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


