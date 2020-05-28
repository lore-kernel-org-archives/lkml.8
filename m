Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E1D8C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 08:16:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E243A2088E
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 08:16:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726844AbgE1IQ6 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 04:16:58 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:38542 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726612AbgE1IQ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 04:16:58 -0400
Received: from marcel-macpro.fritz.box (p4fefc5a7.dip0.t-ipconnect.de [79.239.197.167])
        by mail.holtmann.org (Postfix) with ESMTPSA id 10920CECB0;
        Thu, 28 May 2020 10:26:43 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [PATCH v2] Bluetooth: hci_qca: Improve controller ID info log
 level
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1590548229-17812-1-git-send-email-zijuhu@codeaurora.org>
Date:   Thu, 28 May 2020 10:16:56 +0200
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-bluetooth@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        bgodavar@codeaurora.org, c-hbandi@codeaurora.org,
        hemantg@codeaurora.org, mka@chromium.org, rjliao@codeaurora.org
Content-Transfer-Encoding: 8BIT
Message-Id: <A9C9A8F9-01AA-40D9-A0CA-25BA18B74BDA@holtmann.org>
References: <1590548229-17812-1-git-send-email-zijuhu@codeaurora.org>
To:     Zijun Hu <zijuhu@codeaurora.org>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Zijun,

> Controller ID info got by VSC EDL_PATCH_GETVER is very
> important, so improve its log level from DEBUG to INFO.
> 
> Signed-off-by: Zijun Hu <zijuhu@codeaurora.org>
> ---
> drivers/bluetooth/btqca.c | 12 ++++++++----
> 1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/bluetooth/btqca.c b/drivers/bluetooth/btqca.c
> index 3ea866d..94d8e15 100644
> --- a/drivers/bluetooth/btqca.c
> +++ b/drivers/bluetooth/btqca.c
> @@ -74,10 +74,14 @@ int qca_read_soc_version(struct hci_dev *hdev, u32 *soc_version,
> 
> 	ver = (struct qca_btsoc_version *)(edl->data);
> 
> -	BT_DBG("%s: Product:0x%08x", hdev->name, le32_to_cpu(ver->product_id));
> -	BT_DBG("%s: Patch  :0x%08x", hdev->name, le16_to_cpu(ver->patch_ver));
> -	BT_DBG("%s: ROM    :0x%08x", hdev->name, le16_to_cpu(ver->rom_ver));
> -	BT_DBG("%s: SOC    :0x%08x", hdev->name, le32_to_cpu(ver->soc_id));
> +	bt_dev_info(hdev, "QCA Product ID   :0x%08x",
> +			le32_to_cpu(ver->product_id));
> +	bt_dev_info(hdev, "QCA SOC Version  :0x%08x",
> +			le32_to_cpu(ver->soc_id));
> +	bt_dev_info(hdev, "QCA ROM Version  :0x%08x",
> +			le16_to_cpu(ver->rom_ver));
> +	bt_dev_info(hdev, "QCA Patch Version:0x%08x",
> +			le16_to_cpu(ver->patch_ver));

please align correctly according to the coding style.

Regards

Marcel

