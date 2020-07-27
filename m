Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7121FC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 19:01:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4FBF620719
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 19:01:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595876467;
	bh=wE3Hk8CMHkU55vqjbAKTJHngtyL/i64i2M08p+ucCCg=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=OwBOVP/Jwzf0Jfz65S0SLUCwML/OK4hz/Je83jSgNMD759DNT2P//dubKaCnu/Svu
	 /J9WmYQIZWg9YohvhEj+ijkjv8ty9Lr6QPtL82NfTMOl0/KXEGMiSdGAFLUImh/U09
	 7fXZSdSQ4Ro2ogiXFM1Y7NPR6hIoVbm6ug8SHUDI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728032AbgG0TBF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 15:01:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:49834 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726967AbgG0TBF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 15:01:05 -0400
Received: from embeddedor (187-162-31-110.static.axtel.net [187.162.31.110])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 380B120719;
        Mon, 27 Jul 2020 19:01:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595876464;
        bh=wE3Hk8CMHkU55vqjbAKTJHngtyL/i64i2M08p+ucCCg=;
        h=Date:From:To:Cc:Subject:From;
        b=xKDBU0DsWSgwr5Y5+1q0LlpvFBKp+1F5cqcfIbfydCYmYd8sbBRjzDg/SfgaWe2vZ
         lcD8zn4gRwxIS8GjvbtaAMPw3iVyNqSxwrxn5b9uBZIbmMfrmWMgLkc2fHyQha7zOT
         7DvCR2nYc107Up5gskkI0+v6L5dc3gho2/5zJmPU=
Date:   Mon, 27 Jul 2020 14:06:57 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: [PATCH][next] staging: rtl8723bs: Use fallthrough pseudo-keyword
Message-ID: <20200727190657.GA30194@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace the existing /* fall through */ comments and its variants with
the new pseudo-keyword macro fallthrough[1].

[1] https://www.kernel.org/doc/html/v5.7/process/deprecated.html?highlight=fallthrough#implicit-switch-case-fall-through

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/staging/rtl8723bs/core/rtw_mlme_ext.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
index d6d7198dfe45..6db637701063 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
@@ -568,7 +568,7 @@ void mgt_dispatcher(struct adapter *padapter, union recv_frame *precv_frame)
 			ptable->func = &OnAuth;
 		else
 			ptable->func = &OnAuthClient;
-		/* fall through */
+		fallthrough;
 	case WIFI_ASSOCREQ:
 	case WIFI_REASSOCREQ:
 		_mgt_dispatcher(padapter, ptable, precv_frame);
-- 
2.27.0

