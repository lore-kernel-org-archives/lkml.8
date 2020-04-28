Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89F90C83000
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 18:38:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D1D320B1F
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 18:38:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588099088;
	bh=xv6Xa/NTH0AM12nexRMkvIfuY4SCnsO9x8Wyz9bb3W4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=yhArb37ai9OfLSONRQQ7rkYVJxmoueGpJhnhRxbQFGcbR+QuLePpb/41dAzF8PQhy
	 cDZc47HRxii7Krp6Sezw9dJ+LPeOTNvPT5KoS1cWAMiOUiLLCp8965rWBkb7yEz3Y4
	 AJ3EHMGigFqb4IquACvdtKxx+XXaOfe298I+VQ3E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730590AbgD1SiG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 14:38:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:56248 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730564AbgD1Sh5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 14:37:57 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 052E920575;
        Tue, 28 Apr 2020 18:37:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588099077;
        bh=xv6Xa/NTH0AM12nexRMkvIfuY4SCnsO9x8Wyz9bb3W4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rVF8dx87nikiFIAC7O7uDKSRXl60C23os4ULMy9cF4BkVl6VmSAVwb8MEf3PeYlFw
         bjMVAU1iE/mLtUMMKseX+W/AaDGiP23jeZ3frowD+adBgyuCTmR67MdajF4YuH9nO8
         NhpJ3k+roA8ONFc5I8WhJPvQtNtt+B1ONvYc4o1E=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Naoki Kiryu <naonaokiryu2@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 5.6 152/167] usb: typec: altmode: Fix typec_altmode_get_partner sometimes returning an invalid pointer
Date:   Tue, 28 Apr 2020 20:25:28 +0200
Message-Id: <20200428182244.800972270@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200428182225.451225420@linuxfoundation.org>
References: <20200428182225.451225420@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Naoki Kiryu <naonaokiryu2@gmail.com>

commit 0df9433fcae02215c8fd79690c134d535c7bb905 upstream.

Before this commit, typec_altmode_get_partner would return a
const struct typec_altmode * pointing to address 0x08 when
to_altmode(adev)->partner was NULL.

Add a check for to_altmode(adev)->partner being NULL to fix this.

BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=206365
BugLink: https://bugzilla.redhat.com/show_bug.cgi?id=1785972
Fixes: 5f54a85db5df ("usb: typec: Make sure an alt mode exist before getting its partner")
Cc: stable@vger.kernel.org
Signed-off-by: Naoki Kiryu <naonaokiryu2@gmail.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Link: https://lore.kernel.org/r/20200422144345.43262-1-hdegoede@redhat.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/typec/bus.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- a/drivers/usb/typec/bus.c
+++ b/drivers/usb/typec/bus.c
@@ -208,7 +208,10 @@ EXPORT_SYMBOL_GPL(typec_altmode_vdm);
 const struct typec_altmode *
 typec_altmode_get_partner(struct typec_altmode *adev)
 {
-	return adev ? &to_altmode(adev)->partner->adev : NULL;
+	if (!adev || !to_altmode(adev)->partner)
+		return NULL;
+
+	return &to_altmode(adev)->partner->adev;
 }
 EXPORT_SYMBOL_GPL(typec_altmode_get_partner);
 


