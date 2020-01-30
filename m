Return-Path: <SRS0=4zup=3T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5D69C2D0DB
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 18:44:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC3192082E
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 18:44:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580409847;
	bh=G4eHylNNoWcu/YjzldYF8NNdD8vwCF+1PoFgw3DSM/8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=VeorGc8cXmwfoFBEKLpo2NEOXB8Iit2dJToZCiUCTqCF9jW99iSYmLo8Tu7WEdYLk
	 jwLBm1G0IvBz/WSfoetqB0Jz69byQb18HHEMgwQ/kaiTQtU2AD7iaXbJZk54EeND4t
	 sXp2iSwvw+1aYAyC9UcQMsGsYjb4sdsYF+LBKM64=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730768AbgA3SoG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jan 2020 13:44:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:52974 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730747AbgA3SoC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 13:44:02 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 39C362082E;
        Thu, 30 Jan 2020 18:44:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580409841;
        bh=G4eHylNNoWcu/YjzldYF8NNdD8vwCF+1PoFgw3DSM/8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IpNW0dbNamr2nmgO2eaBuFpr5ANuEXa6xVcTLAhkkidn5yldPx6OL41jhwxpT36y0
         Snss2mZPUQeFjfFaC3ubp5Cm0wfetcU6JZJq/T59KCfTiSuBcZCQ6KRpCD+8MONv05
         eCwaJYlzWyP5qCID9ZyvM4iDQC61lgB52DsIeIN4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Colin Ian King <colin.king@canonical.com>
Subject: [PATCH 5.4 013/110] staging: wlan-ng: ensure error return is actually returned
Date:   Thu, 30 Jan 2020 19:37:49 +0100
Message-Id: <20200130183616.003124505@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200130183613.810054545@linuxfoundation.org>
References: <20200130183613.810054545@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

commit 4cc41cbce536876678b35e03c4a8a7bb72c78fa9 upstream.

Currently when the call to prism2sta_ifst fails a netdev_err error
is reported, error return variable result is set to -1 but the
function always returns 0 for success.  Fix this by returning
the error value in variable result rather than 0.

Addresses-Coverity: ("Unused value")
Fixes: 00b3ed168508 ("Staging: add wlan-ng prism2 usb driver")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
Cc: stable <stable@vger.kernel.org>
Link: https://lore.kernel.org/r/20200114181604.390235-1-colin.king@canonical.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/staging/wlan-ng/prism2mgmt.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/staging/wlan-ng/prism2mgmt.c
+++ b/drivers/staging/wlan-ng/prism2mgmt.c
@@ -959,7 +959,7 @@ int prism2mgmt_flashdl_state(struct wlan
 		}
 	}
 
-	return 0;
+	return result;
 }
 
 /*----------------------------------------------------------------


