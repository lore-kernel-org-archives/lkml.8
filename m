Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43458C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 20:34:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1251F2072E
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 20:34:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592944486;
	bh=pFXEvju9z9D8rdyGtRTIXOPyC6GXMau4+AzkXnLzDUs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ftaSS71OYnfzG5R04DjfVn82CJUYOQNzF8Y3gex92mpEQu1uDlF0RCB2TiI3eaegp
	 ZMGqqJvQ3x1H/GbbDxO/7rtkUmyQAgsm1WNZqN2r22tbiJdg+mXBt3UEPgn04cNsjH
	 YRnl6/2Fs8HJ8zY1Mi7wxkQsz1ZjSoi05yhitZa8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403793AbgFWUen (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 16:34:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:56696 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391032AbgFWUei (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 16:34:38 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2F9D3214DB;
        Tue, 23 Jun 2020 20:34:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592944478;
        bh=pFXEvju9z9D8rdyGtRTIXOPyC6GXMau4+AzkXnLzDUs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=paeLWQKA9h/jOWqcCOBh+XEXSl6+1e6KECG+SDG+gTBGOSVtD67cFdD0D0/ajCAUJ
         yufeOQKWNLngPR1wT5m7Peb0C/HZdEyV93ckLgIK2K387Yii4WKwAlcHJopwE58X2e
         QAyWehaBQLbWMdfP+psdaHKSm9vSZWLDxk1TTfOQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Denis Efremov <efremov@linux.com>,
        Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 5.4 302/314] drm/amd/display: Use kvfree() to free coeff in build_regamma()
Date:   Tue, 23 Jun 2020 21:58:17 +0200
Message-Id: <20200623195353.402481021@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200623195338.770401005@linuxfoundation.org>
References: <20200623195338.770401005@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Denis Efremov <efremov@linux.com>

commit 81921a828b94ce2816932c19a5ec74d302972833 upstream.

Use kvfree() instead of kfree() to free coeff in build_regamma()
because the memory is allocated with kvzalloc().

Fixes: e752058b8671 ("drm/amd/display: Optimize gamma calculations")
Cc: stable@vger.kernel.org
Signed-off-by: Denis Efremov <efremov@linux.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/amd/display/modules/color/color_gamma.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/gpu/drm/amd/display/modules/color/color_gamma.c
+++ b/drivers/gpu/drm/amd/display/modules/color/color_gamma.c
@@ -799,7 +799,7 @@ static bool build_regamma(struct pwl_flo
 	pow_buffer_ptr = -1; // reset back to no optimize
 	ret = true;
 release:
-	kfree(coeff);
+	kvfree(coeff);
 	return ret;
 }
 


