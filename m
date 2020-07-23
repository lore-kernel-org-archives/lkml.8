Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2589BC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 17:43:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D1E1D207BB
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 17:43:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="isKDbIeH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730047AbgGWRnA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 13:43:00 -0400
Received: from gateway36.websitewelcome.com ([192.185.200.11]:35203 "EHLO
        gateway36.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726717AbgGWRnA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 13:43:00 -0400
X-Greylist: delayed 1500 seconds by postgrey-1.27 at vger.kernel.org; Thu, 23 Jul 2020 13:42:58 EDT
Received: from cm11.websitewelcome.com (cm11.websitewelcome.com [100.42.49.5])
        by gateway36.websitewelcome.com (Postfix) with ESMTP id B1AB24029A5A9
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jul 2020 11:19:15 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id yeVujCIHO4KQcyeVujPQA0; Thu, 23 Jul 2020 11:56:10 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=FbOBPOrtrhzckoBQOXQVzNMP6N3AZGeiD5JVDxt0FYI=; b=isKDbIeH1OINdXHU69/ltQxMW3
        uPM8/KzIBgpE1KSARekJUijQvAp0Y8ooVdfmJPHaLUziY0bktsU0GghZZr3zK4O1t/YWUwurIi8Sh
        HcboVFMnjqlpikmG2X55uahI4n1z8ERENEd485yiN0+bZUh+dFEHr/r08ZrX8WAvLfKBNm2KyzZ5m
        8oRyiGxxtPdlJZyypxCgPh3ZPcBkM/Byl+4Ax47T1ZZrXjB7XkX8Y6K3/k1/QcP1qfA9vrESDvG2s
        8nA5OQfYL26QNvfLToulMzBcx+hZFnp8XisxIkgxrElQmsrr2Jk5x8oOLF8S/4YQsaf/6fiqU8k7v
        2hgPf5ag==;
Received: from [201.162.245.27] (port=42606 helo=[192.168.43.132])
        by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <gustavo@embeddedor.com>)
        id 1jyeVt-0044AM-T2; Thu, 23 Jul 2020 11:56:10 -0500
Subject: Re: [char-misc-next 1/6] mei: hbm: use sizeof of variable instead of
 struct type
To:     Tomas Winkler <tomas.winkler@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Alexander Usyskin <alexander.usyskin@intel.com>,
        linux-kernel@vger.kernel.org,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>
References: <20200723145927.882743-1-tomas.winkler@intel.com>
 <20200723145927.882743-2-tomas.winkler@intel.com>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Autocrypt: addr=gustavo@embeddedor.com; keydata=
 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
 AP7RWS474w==
Message-ID: <ef9c1c27-b643-94b7-9f06-27e86f0a35ef@embeddedor.com>
Date:   Thu, 23 Jul 2020 12:01:54 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200723145927.882743-2-tomas.winkler@intel.com>
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
X-Exim-ID: 1jyeVt-0044AM-T2
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.43.132]) [201.162.245.27]:42606
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 34
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
>  drivers/misc/mei/hbm.c | 74 ++++++++++++++++++------------------------
>  1 file changed, 32 insertions(+), 42 deletions(-)
> 
> diff --git a/drivers/misc/mei/hbm.c b/drivers/misc/mei/hbm.c
> index a44094cdbc36..308caee86920 100644
> --- a/drivers/misc/mei/hbm.c
> +++ b/drivers/misc/mei/hbm.c
> @@ -1,6 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0
>  /*
> - * Copyright (c) 2003-2019, Intel Corporation. All rights reserved.
> + * Copyright (c) 2003-2020, Intel Corporation. All rights reserved.
>   * Intel Management Engine Interface (Intel MEI) Linux driver
>   */
>  #include <linux/export.h>
> @@ -257,22 +257,21 @@ int mei_hbm_start_wait(struct mei_device *dev)
>  int mei_hbm_start_req(struct mei_device *dev)
>  {
>  	struct mei_msg_hdr mei_hdr;
> -	struct hbm_host_version_request start_req;
> -	const size_t len = sizeof(struct hbm_host_version_request);
> +	struct hbm_host_version_request req;
>  	int ret;
>  
>  	mei_hbm_reset(dev);
>  
> -	mei_hbm_hdr(&mei_hdr, len);
> +	mei_hbm_hdr(&mei_hdr, sizeof(req));
>  
>  	/* host start message */
> -	memset(&start_req, 0, len);
> -	start_req.hbm_cmd = HOST_START_REQ_CMD;
> -	start_req.host_version.major_version = HBM_MAJOR_VERSION;
> -	start_req.host_version.minor_version = HBM_MINOR_VERSION;
> +	memset(&req, 0, sizeof(req));
> +	req.hbm_cmd = HOST_START_REQ_CMD;
> +	req.host_version.major_version = HBM_MAJOR_VERSION;
> +	req.host_version.minor_version = HBM_MINOR_VERSION;
>  
>  	dev->hbm_state = MEI_HBM_IDLE;
> -	ret = mei_hbm_write_message(dev, &mei_hdr, &start_req);
> +	ret = mei_hbm_write_message(dev, &mei_hdr, &req);
>  	if (ret) {
>  		dev_err(dev->dev, "version message write failed: ret = %d\n",
>  			ret);
> @@ -295,13 +294,12 @@ static int mei_hbm_dma_setup_req(struct mei_device *dev)
>  {
>  	struct mei_msg_hdr mei_hdr;
>  	struct hbm_dma_setup_request req;
> -	const size_t len = sizeof(struct hbm_dma_setup_request);
>  	unsigned int i;
>  	int ret;
>  
> -	mei_hbm_hdr(&mei_hdr, len);
> +	mei_hbm_hdr(&mei_hdr, sizeof(req));
>  
> -	memset(&req, 0, len);
> +	memset(&req, 0, sizeof(req));
>  	req.hbm_cmd = MEI_HBM_DMA_SETUP_REQ_CMD;
>  	for (i = 0; i < DMA_DSCR_NUM; i++) {
>  		phys_addr_t paddr;
> @@ -337,21 +335,19 @@ static int mei_hbm_dma_setup_req(struct mei_device *dev)
>  static int mei_hbm_enum_clients_req(struct mei_device *dev)
>  {
>  	struct mei_msg_hdr mei_hdr;
> -	struct hbm_host_enum_request enum_req;
> -	const size_t len = sizeof(struct hbm_host_enum_request);
> +	struct hbm_host_enum_request req;
>  	int ret;
>  
>  	/* enumerate clients */
> -	mei_hbm_hdr(&mei_hdr, len);
> +	mei_hbm_hdr(&mei_hdr, sizeof(req));
>  
> -	memset(&enum_req, 0, len);
> -	enum_req.hbm_cmd = HOST_ENUM_REQ_CMD;
> -	enum_req.flags |= dev->hbm_f_dc_supported ?
> -			  MEI_HBM_ENUM_F_ALLOW_ADD : 0;
> -	enum_req.flags |= dev->hbm_f_ie_supported ?
> +	memset(&req, 0, sizeof(req));
> +	req.hbm_cmd = HOST_ENUM_REQ_CMD;
> +	req.flags |= dev->hbm_f_dc_supported ? MEI_HBM_ENUM_F_ALLOW_ADD : 0;
> +	req.flags |= dev->hbm_f_ie_supported ?
>  			  MEI_HBM_ENUM_F_IMMEDIATE_ENUM : 0;
>  
> -	ret = mei_hbm_write_message(dev, &mei_hdr, &enum_req);
> +	ret = mei_hbm_write_message(dev, &mei_hdr, &req);
>  	if (ret) {
>  		dev_err(dev->dev, "enumeration request write failed: ret = %d.\n",
>  			ret);
> @@ -380,7 +376,7 @@ static int mei_hbm_me_cl_add(struct mei_device *dev,
>  
>  	mei_me_cl_rm_by_uuid(dev, uuid);
>  
> -	me_cl = kzalloc(sizeof(struct mei_me_client), GFP_KERNEL);
> +	me_cl = kzalloc(sizeof(*me_cl), GFP_KERNEL);
>  	if (!me_cl)
>  		return -ENOMEM;
>  
> @@ -408,14 +404,13 @@ static int mei_hbm_add_cl_resp(struct mei_device *dev, u8 addr, u8 status)
>  {
>  	struct mei_msg_hdr mei_hdr;
>  	struct hbm_add_client_response resp;
> -	const size_t len = sizeof(struct hbm_add_client_response);
>  	int ret;
>  
>  	dev_dbg(dev->dev, "adding client response\n");
>  
> -	mei_hbm_hdr(&mei_hdr, len);
> +	mei_hbm_hdr(&mei_hdr, sizeof(resp));
>  
> -	memset(&resp, 0, sizeof(struct hbm_add_client_response));
> +	memset(&resp, 0, sizeof(resp));
>  	resp.hbm_cmd = MEI_HBM_ADD_CLIENT_RES_CMD;
>  	resp.me_addr = addr;
>  	resp.status  = status;
> @@ -469,11 +464,10 @@ int mei_hbm_cl_notify_req(struct mei_device *dev,
>  
>  	struct mei_msg_hdr mei_hdr;
>  	struct hbm_notification_request req;
> -	const size_t len = sizeof(struct hbm_notification_request);
>  	int ret;
>  
> -	mei_hbm_hdr(&mei_hdr, len);
> -	mei_hbm_cl_hdr(cl, MEI_HBM_NOTIFY_REQ_CMD, &req, len);
> +	mei_hbm_hdr(&mei_hdr, sizeof(req));
> +	mei_hbm_cl_hdr(cl, MEI_HBM_NOTIFY_REQ_CMD, &req, sizeof(req));
>  
>  	req.start = start;
>  
> @@ -580,8 +574,7 @@ static void mei_hbm_cl_notify(struct mei_device *dev,
>  static int mei_hbm_prop_req(struct mei_device *dev, unsigned long start_idx)
>  {
>  	struct mei_msg_hdr mei_hdr;
> -	struct hbm_props_request prop_req;
> -	const size_t len = sizeof(struct hbm_props_request);
> +	struct hbm_props_request req;
>  	unsigned long addr;
>  	int ret;
>  
> @@ -591,18 +584,17 @@ static int mei_hbm_prop_req(struct mei_device *dev, unsigned long start_idx)
>  	if (addr == MEI_CLIENTS_MAX) {
>  		dev->hbm_state = MEI_HBM_STARTED;
>  		mei_host_client_init(dev);
> -
>  		return 0;
>  	}
>  
> -	mei_hbm_hdr(&mei_hdr, len);
> +	mei_hbm_hdr(&mei_hdr, sizeof(req));
>  
> -	memset(&prop_req, 0, sizeof(struct hbm_props_request));
> +	memset(&req, 0, sizeof(req));
>  
> -	prop_req.hbm_cmd = HOST_CLIENT_PROPERTIES_REQ_CMD;
> -	prop_req.me_addr = addr;
> +	req.hbm_cmd = HOST_CLIENT_PROPERTIES_REQ_CMD;
> +	req.me_addr = addr;
>  
> -	ret = mei_hbm_write_message(dev, &mei_hdr, &prop_req);
> +	ret = mei_hbm_write_message(dev, &mei_hdr, &req);
>  	if (ret) {
>  		dev_err(dev->dev, "properties request write failed: ret = %d\n",
>  			ret);
> @@ -628,15 +620,14 @@ int mei_hbm_pg(struct mei_device *dev, u8 pg_cmd)
>  {
>  	struct mei_msg_hdr mei_hdr;
>  	struct hbm_power_gate req;
> -	const size_t len = sizeof(struct hbm_power_gate);
>  	int ret;
>  
>  	if (!dev->hbm_f_pg_supported)
>  		return -EOPNOTSUPP;
>  
> -	mei_hbm_hdr(&mei_hdr, len);
> +	mei_hbm_hdr(&mei_hdr, sizeof(req));
>  
> -	memset(&req, 0, len);
> +	memset(&req, 0, sizeof(req));
>  	req.hbm_cmd = pg_cmd;
>  
>  	ret = mei_hbm_write_message(dev, &mei_hdr, &req);
> @@ -657,11 +648,10 @@ static int mei_hbm_stop_req(struct mei_device *dev)
>  {
>  	struct mei_msg_hdr mei_hdr;
>  	struct hbm_host_stop_request req;
> -	const size_t len = sizeof(struct hbm_host_stop_request);
>  
> -	mei_hbm_hdr(&mei_hdr, len);
> +	mei_hbm_hdr(&mei_hdr, sizeof(req));
>  
> -	memset(&req, 0, len);
> +	memset(&req, 0, sizeof(req));
>  	req.hbm_cmd = HOST_STOP_REQ_CMD;
>  	req.reason = DRIVER_STOP_REQUEST;
>  
> 
