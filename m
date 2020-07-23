Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E868FC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 16:49:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B979E20714
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 16:49:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="Q+TYD5S7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729925AbgGWQtd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 12:49:33 -0400
Received: from gateway32.websitewelcome.com ([192.185.144.98]:19993 "EHLO
        gateway32.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726621AbgGWQtb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 12:49:31 -0400
Received: from cm13.websitewelcome.com (cm13.websitewelcome.com [100.42.49.6])
        by gateway32.websitewelcome.com (Postfix) with ESMTP id 090BA28E714
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jul 2020 11:49:28 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id yePPjNyXrwgQAyePQjObcs; Thu, 23 Jul 2020 11:49:28 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=mX9WbPR2A08lAhxlpv9nqKTZKz1fenNVDE+tR5xQ44Q=; b=Q+TYD5S7vFBz3TXmZyJys1Ag2u
        48HcHd05NsTizQ1KY8e5i23+ZGgg+3NcoaThhzQ+5Lh3XqshtM2AqgxKcRAG5N6xMooYoIKRQUT0W
        Ujcw1e+mxNNuw1XXqv0KSM5JEjHdSGoOUBW3emIV4izevVHPDYdvNaYP6jGngi+NNXYWpI58hQVqJ
        b8DkJBwmyq9SNz9m9D5n99EUDT2fo55vmYkZK39CXVJvV+IDdCvL+ztU2c1wgF+gU2GagPRO+64Bx
        hNNl+NHWA07Yt35hfzZhHWygWtsk0+TwE79YLPUic4etiAK1nFlzSeQO35W6b1FmnKUBqiSAmb8p/
        drKd4pGg==;
Received: from [201.162.245.27] (port=42558 helo=[192.168.43.132])
        by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <gustavo@embeddedor.com>)
        id 1jyePP-0040ek-GZ; Thu, 23 Jul 2020 11:49:27 -0500
Subject: Re: [char-misc-next 3/6] mei: bus: use sizeof of variable instead of
 struct type
To:     Tomas Winkler <tomas.winkler@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Alexander Usyskin <alexander.usyskin@intel.com>,
        linux-kernel@vger.kernel.org,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>
References: <20200723145927.882743-1-tomas.winkler@intel.com>
 <20200723145927.882743-4-tomas.winkler@intel.com>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Autocrypt: addr=gustavo@embeddedor.com; keydata=
 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
 AP7RWS474w==
Message-ID: <cab66bcc-6b48-772e-9f16-41c1c076c42d@embeddedor.com>
Date:   Thu, 23 Jul 2020 11:55:11 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200723145927.882743-4-tomas.winkler@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 201.162.245.27
X-Source-L: No
X-Exim-ID: 1jyePP-0040ek-GZ
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.43.132]) [201.162.245.27]:42558
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 22
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/23/20 09:59, Tomas Winkler wrote:
> There is a possibility of bug when variable type has changed but
> corresponding struct passed to the sizeof has not.
> 
> Cc: Gustavo A. R. Silva <gustavoars@kernel.org>
> Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>

Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks
--
Gustavo

> ---
>  drivers/misc/mei/bus-fixup.c | 23 +++++++++++------------
>  drivers/misc/mei/bus.c       |  2 +-
>  2 files changed, 12 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/misc/mei/bus-fixup.c b/drivers/misc/mei/bus-fixup.c
> index 910f059b3384..07ba16d46690 100644
> --- a/drivers/misc/mei/bus-fixup.c
> +++ b/drivers/misc/mei/bus-fixup.c
> @@ -1,6 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0
>  /*
> - * Copyright (c) 2013-2019, Intel Corporation. All rights reserved.
> + * Copyright (c) 2013-2020, Intel Corporation. All rights reserved.
>   * Intel Management Engine Interface (Intel MEI) Linux driver
>   */
>  
> @@ -159,17 +159,17 @@ static int mei_osver(struct mei_cl_device *cldev)
>  static int mei_fwver(struct mei_cl_device *cldev)
>  {
>  	char buf[MKHI_FWVER_BUF_LEN];
> -	struct mkhi_msg *req;
> +	struct mkhi_msg req;
> +	struct mkhi_msg *rsp;
>  	struct mkhi_fw_ver *fwver;
>  	int bytes_recv, ret, i;
>  
>  	memset(buf, 0, sizeof(buf));
>  
> -	req = (struct mkhi_msg *)buf;
> -	req->hdr.group_id = MKHI_GEN_GROUP_ID;
> -	req->hdr.command = MKHI_GEN_GET_FW_VERSION_CMD;
> +	req.hdr.group_id = MKHI_GEN_GROUP_ID;
> +	req.hdr.command = MKHI_GEN_GET_FW_VERSION_CMD;
>  
> -	ret = __mei_cl_send(cldev->cl, buf, sizeof(struct mkhi_msg_hdr),
> +	ret = __mei_cl_send(cldev->cl, (u8 *)&req, sizeof(req),
>  			    MEI_CL_IO_TX_BLOCKING);
>  	if (ret < 0) {
>  		dev_err(&cldev->dev, "Could not send ReqFWVersion cmd\n");
> @@ -188,7 +188,8 @@ static int mei_fwver(struct mei_cl_device *cldev)
>  		return -EIO;
>  	}
>  
> -	fwver = (struct mkhi_fw_ver *)req->data;
> +	rsp = (struct mkhi_msg *)buf;
> +	fwver = (struct mkhi_fw_ver *)rsp->data;
>  	memset(cldev->bus->fw_ver, 0, sizeof(cldev->bus->fw_ver));
>  	for (i = 0; i < MEI_MAX_FW_VER_BLOCKS; i++) {
>  		if ((size_t)bytes_recv < MKHI_FWVER_LEN(i + 1))
> @@ -329,16 +330,14 @@ static int mei_nfc_if_version(struct mei_cl *cl,
>  
>  	WARN_ON(mutex_is_locked(&bus->device_lock));
>  
> -	ret = __mei_cl_send(cl, (u8 *)&cmd, sizeof(struct mei_nfc_cmd),
> -			    MEI_CL_IO_TX_BLOCKING);
> +	ret = __mei_cl_send(cl, (u8 *)&cmd, sizeof(cmd), MEI_CL_IO_TX_BLOCKING);
>  	if (ret < 0) {
>  		dev_err(bus->dev, "Could not send IF version cmd\n");
>  		return ret;
>  	}
>  
>  	/* to be sure on the stack we alloc memory */
> -	if_version_length = sizeof(struct mei_nfc_reply) +
> -		sizeof(struct mei_nfc_if_version);
> +	if_version_length = sizeof(*reply) + sizeof(*ver);
>  
>  	reply = kzalloc(if_version_length, GFP_KERNEL);
>  	if (!reply)
> @@ -352,7 +351,7 @@ static int mei_nfc_if_version(struct mei_cl *cl,
>  		goto err;
>  	}
>  
> -	memcpy(ver, reply->data, sizeof(struct mei_nfc_if_version));
> +	memcpy(ver, reply->data, sizeof(*ver));
>  
>  	dev_info(bus->dev, "NFC MEI VERSION: IVN 0x%x Vendor ID 0x%x Type 0x%x\n",
>  		ver->fw_ivn, ver->vendor_id, ver->radio_type);
> diff --git a/drivers/misc/mei/bus.c b/drivers/misc/mei/bus.c
> index f476dbc7252b..a6dfc3ce1db2 100644
> --- a/drivers/misc/mei/bus.c
> +++ b/drivers/misc/mei/bus.c
> @@ -931,7 +931,7 @@ static struct mei_cl_device *mei_cl_bus_dev_alloc(struct mei_device *bus,
>  	struct mei_cl_device *cldev;
>  	struct mei_cl *cl;
>  
> -	cldev = kzalloc(sizeof(struct mei_cl_device), GFP_KERNEL);
> +	cldev = kzalloc(sizeof(*cldev), GFP_KERNEL);
>  	if (!cldev)
>  		return NULL;
>  
> 
