Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CBCBC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 16:25:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B59620739
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 16:25:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="A5HC3Uku"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729284AbgGPQZ2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 12:25:28 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:54266 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729249AbgGPQZ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 12:25:27 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1594916727; h=Message-ID: Subject: Cc: To: From: Date:
 Content-Transfer-Encoding: Content-Type: MIME-Version: Sender;
 bh=OmL2KI53czE52TZ8+f9g2m5kzP3WpYA0NVG5N/4LwQ4=; b=A5HC3UkucmQB3RuyQOUSPAaavt81okTW5cV2lk9Vpzd7kJCTab6v8ND8CqZaBqqCDjzer/Gf
 rnoAK36Q+DgGYq7/+rmPRtZctG+y0YOwCa8av1k4yb6uOM9DGXcYuv9rDpBV9ST36Y2+LXIS
 2ElhOdoGmUcxZTJfPhGaxRs85nM=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n18.prod.us-west-2.postgun.com with SMTP id
 5f107f70c9bd2efa2effe879 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 16 Jul 2020 16:25:20
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 3C60DC43395; Thu, 16 Jul 2020 16:25:20 +0000 (UTC)
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bgodavar)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id D70DEC433C6;
        Thu, 16 Jul 2020 16:25:19 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 16 Jul 2020 21:55:19 +0530
From:   bgodavar@codeaurora.org
List-Id: <linux-firmware.lore.kernel.org>
To:     linux-firmware@kernel.org, jwboyer@kernel.org
Cc:     mka@chromium.org, linux-kernel@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, hemantg@codeaurora.org,
        linux-arm-msm@vger.kernel.org, gubbaven@codeaurora.org,
        abhishekpandit@chromium.org
Subject: QCA: Add correct bin file for WCN3991
Message-ID: <6abd991d5d7d5175f5b7c6b168af770b@codeaurora.org>
X-Sender: bgodavar@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 
3d3a06f720856cb897a8541951edd0b8f6f54a98:

   linux-firmware: Update firmware file for Intel Bluetooth AX201 
(2020-07-13 07:51:54 -0400)

are available in the git repository at:

   https://github.com/bgodavar/qca_bt_fw/tree/qca_0714

for you to fetch changes up to 3882702815e4b88bfd2f20b7eb66a3e85cbbb9b9:

   QCA: Add correct bin file for WCN3991 (2020-07-14 11:00:13 +0530)

----------------------------------------------------------------
Balakrishna Godavarthi (1):
       QCA: Add correct bin file for WCN3991

  qca/crnv32.bin | Bin 5299 -> 5299 bytes
  1 file changed, 0 insertions(+), 0 deletions(-)
