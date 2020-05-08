Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 221BCC38A2A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 12:38:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F36FF2496D
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 12:38:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588941514;
	bh=XC88n2lCSjqDfXenb2OH6ECcKqlTqc7gKZ8QBN0TmCA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Ih4BlO3+jqs9gYZVm3d3/OnqK5gW/gwsRolm9mEbiIGQ7eqeIlyPImcxGGfm8t+P+
	 mh9OgV6+tMnm+UnczPK4JHpjbkIpfooM7y1JiX8M+sQKkAmXDRJrwwDcVBAew8VUSZ
	 uoWm8GncRJp6T3sItCGyYzEJDjCBLY6DlQO4L+ck=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728408AbgEHMid (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 08:38:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:53556 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726951AbgEHMiT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 08:38:19 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9D412215A4;
        Fri,  8 May 2020 12:38:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588941499;
        bh=XC88n2lCSjqDfXenb2OH6ECcKqlTqc7gKZ8QBN0TmCA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=w8uE3rKMK5TupiOZRipY+cg/T8qxJJmmHjKZIPKXYnxo36KmgLFbWpPKtW3vnKA9/
         AoZ/ww/d9h+U9V/Akf+kAHJon9xqU8r+AtAge3fyjsLM5/JVMBFMukKBB+2dXVXSKe
         0z6oQQN2cCcCCCqrHsaLWiWtUVcjh50A8wUTxlpM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH 4.4 055/312] iwlwifi: set max firmware version of 7265 to 17
Date:   Fri,  8 May 2020 14:30:46 +0200
Message-Id: <20200508123128.424635957@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200508123124.574959822@linuxfoundation.org>
References: <20200508123124.574959822@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

commit ed0450cef00d2c76bcb8778721df947ba7ff4147 upstream.

Just like 7260, 7265 will not have firmware releases newer
than iwlwifi-7265-17.ucode. 7265D is still supported in
latest firmware releases.

Fixes: 628a2918afe4 ("iwlwifi: separate firmware version for 7260 devices")
Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/wireless/iwlwifi/iwl-7000.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/wireless/iwlwifi/iwl-7000.c
+++ b/drivers/net/wireless/iwlwifi/iwl-7000.c
@@ -70,7 +70,7 @@
 
 /* Highest firmware API version supported */
 #define IWL7260_UCODE_API_MAX	17
-#define IWL7265_UCODE_API_MAX	19
+#define IWL7265_UCODE_API_MAX	17
 #define IWL7265D_UCODE_API_MAX	19
 
 /* Oldest version we won't warn about */


