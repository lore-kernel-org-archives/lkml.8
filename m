Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98D08C33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 23:27:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69AAA2082F
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 23:27:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579217241;
	bh=YY2vsOhOD5tx230oh8e2361TtBk7nItWViDntducFIg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=biDlTh6D0NC8LelgkfzU/QiK694RsNc2Xtes5HnuvhQhZFONyapJfWxJP0xoS6C+C
	 R7Zkb28OSxkU0vH+D/6jmkLfoUe6mSEj9c1FvvZ0JHCAQQd4LmjFhzy9ODXpp1OJ1l
	 eXGtdr07NOFWUXwXwswnLZBBm3EdqAoScJrwARsc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389297AbgAPX1T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 18:27:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:58376 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389786AbgAPX1E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 18:27:04 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CCA6B20684;
        Thu, 16 Jan 2020 23:27:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579217224;
        bh=YY2vsOhOD5tx230oh8e2361TtBk7nItWViDntducFIg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EcQPEDwOEQ7i2KoOiLEHsIeD0Z1v4n5Ks/Kx4NAefbhlaz6+ciBtVG/NppoVzh+5K
         u+STGlyWkWggy1lDBZSo897TSlEm+WMgGHQMrvHzyiPgiklCdPFI9Kg0yccpPCUH0W
         fIrFsfLo8cWFsqR9ZufYRQX2zF5hF6Yq6BS4LCA0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Bingbu Cao <bingbu.cao@intel.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 199/203] media: intel-ipu3: Align struct ipu3_uapi_awb_fr_config_s to 32 bytes
Date:   Fri, 17 Jan 2020 00:18:36 +0100
Message-Id: <20200116231801.506393848@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200116231745.218684830@linuxfoundation.org>
References: <20200116231745.218684830@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sakari Ailus <sakari.ailus@linux.intel.com>

[ Upstream commit ce644cf3fa06504c2c71ab1b794160d54aaccbc0 ]

A struct that needs to be aligned to 32 bytes has a size of 28. Increase
the size to 32.

This makes elements of arrays of this struct aligned to 32 as well, and
other structs where members are aligned to 32 mixing
ipu3_uapi_awb_fr_config_s as well as other types.

Fixes: commit dca5ef2aa1e6 ("media: staging/intel-ipu3: remove the unnecessary compiler flags")
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Tested-by: Bingbu Cao <bingbu.cao@intel.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/staging/media/ipu3/include/intel-ipu3.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/media/ipu3/include/intel-ipu3.h b/drivers/staging/media/ipu3/include/intel-ipu3.h
index c7cd27efac8a..0b1cb9f9cbd1 100644
--- a/drivers/staging/media/ipu3/include/intel-ipu3.h
+++ b/drivers/staging/media/ipu3/include/intel-ipu3.h
@@ -449,7 +449,7 @@ struct ipu3_uapi_awb_fr_config_s {
 	__u16 reserved1;
 	__u32 bayer_sign;
 	__u8 bayer_nf;
-	__u8 reserved2[3];
+	__u8 reserved2[7];
 } __attribute__((aligned(32))) __packed;
 
 /**
-- 
2.20.1



