Return-Path: <SRS0=GvTR=3A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EEEFC33CA3
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jan 2020 10:01:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFA202077C
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jan 2020 10:01:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578736875;
	bh=3WK0oIKseIdJBhhcDj5MvEQFhrbomsZXfcbffUOPnCI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Sk5sT+UC2imm6kYKT1frjFFp4bmR1VnPEiXdK6mEjE8hTmvEFMHF8f0UL14beikwM
	 lO/2jvuQDSBsxV2pcSSLReMl+9+FfmKEPs6wTgo83Lzb0WNLtB25BLnkIGs0Nxky7D
	 97JRY/ZRXxTVhpg2gtVXItEraa5XvGWH60mmALQA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729453AbgAKKBO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Jan 2020 05:01:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:58380 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729106AbgAKKBM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jan 2020 05:01:12 -0500
Received: from localhost (unknown [62.119.166.9])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D3DB92077C;
        Sat, 11 Jan 2020 10:01:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578736872;
        bh=3WK0oIKseIdJBhhcDj5MvEQFhrbomsZXfcbffUOPnCI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2TG8mkgwR5XY4Ym0YkwfRKERICZKoDL2c3TMbNxaxCd6HvVGSK3XMRjvhYJXsENGU
         lsOwDZ9Wf+l29lzoWvLB7leBwzeenLMxAABAYyk3MNFJY8Nlz4ybMMNHcu1LV3uzpN
         0a4B6uvLfUFzD/dJj2CXBTmK5YnH3EFsLYPqyMOQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Colin Ian King <colin.king@canonical.com>,
        Sean Young <sean@mess.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Subject: [PATCH 4.9 40/91] media: flexcop-usb: ensure -EIO is returned on error condition
Date:   Sat, 11 Jan 2020 10:49:33 +0100
Message-Id: <20200111094900.180958529@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200111094844.748507863@linuxfoundation.org>
References: <20200111094844.748507863@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

commit 74a96b51a36de4d86660fbc56b05d86668162d6b upstream.

An earlier commit hard coded a return 0 to function flexcop_usb_i2c_req
even though the an -EIO was intended to be returned in the case where
ret != buflen.  Fix this by replacing the return 0 with the return of
ret to return the error return code.

Addresses-Coverity: ("Unused value")

Fixes: b430eaba0be5 ("[media] flexcop-usb: don't use stack for DMA")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
Signed-off-by: Sean Young <sean@mess.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/media/usb/b2c2/flexcop-usb.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/media/usb/b2c2/flexcop-usb.c
+++ b/drivers/media/usb/b2c2/flexcop-usb.c
@@ -295,7 +295,7 @@ static int flexcop_usb_i2c_req(struct fl
 
 	mutex_unlock(&fc_usb->data_mutex);
 
-	return 0;
+	return ret;
 }
 
 /* actual bus specific access functions,


