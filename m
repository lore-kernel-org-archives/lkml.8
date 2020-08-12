Return-Path: <SRS0=ZArZ=BW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNWANTED_LANGUAGE_BODY autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70480C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 16:21:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4850320829
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 16:21:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726558AbgHLQV6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Aug 2020 12:21:58 -0400
Received: from smtprelay0135.hostedemail.com ([216.40.44.135]:35168 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725872AbgHLQV6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Aug 2020 12:21:58 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id 1B41A8378BB9;
        Wed, 12 Aug 2020 16:21:57 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: spot60_1a07ad626fec
X-Filterd-Recvd-Size: 3696
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf05.hostedemail.com (Postfix) with ESMTPA;
        Wed, 12 Aug 2020 16:21:55 +0000 (UTC)
Message-ID: <fa2d01411982f3f0873a895f4790ce65d9d6d185.camel@perches.com>
Subject: Re: [PATCH 06/44] staging: spmi: hisi-spmi-controller: use le32
 macros where needed
From:   Joe Perches <joe@perches.com>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org
Date:   Wed, 12 Aug 2020 09:21:54 -0700
In-Reply-To: <910eeee38f1a13b5dc1d423aed3f7dc74bc48029.1597247164.git.mchehab+huawei@kernel.org>
References: <cover.1597247164.git.mchehab+huawei@kernel.org>
         <910eeee38f1a13b5dc1d423aed3f7dc74bc48029.1597247164.git.mchehab+huawei@kernel.org>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2020-08-12 at 17:56 +0200, Mauro Carvalho Chehab wrote:
> Instead of manually using bswap_32(), just use the
> le32 macros.

Are you certain this code will now work on any endian cpu?

Maybe just use __swab32 instead

> diff --git a/drivers/staging/hikey9xx/hisi-spmi-controller.c b/drivers/staging/hikey9xx/hisi-spmi-controller.c
[]
> @@ -43,11 +42,6 @@
>  #define SPMI_APB_SPMI_CMD_TYPE_OFFSET			24
>  #define SPMI_APB_SPMI_CMD_LENGTH_OFFSET			20
>  
> -#define bswap_32(X)   \
> -    ((((u32)(X) & 0xff000000) >> 24) | \
> -     (((u32)(X) & 0x00ff0000) >> 8) | \
> -     (((u32)(X) & 0x0000ff00) << 8) | \
> -     (((u32)(X) & 0x000000ff) << 24))
>  #define SPMI_APB_SPMI_CMD_SLAVEID_OFFSET		16
>  #define SPMI_APB_SPMI_CMD_ADDR_OFFSET			0
>  
> @@ -179,14 +173,15 @@ static int spmi_read_cmd(struct spmi_controller *ctrl,
>  
>  	writel(cmd, spmi_controller->base + chnl_ofst + SPMI_APB_SPMI_CMD_BASE_ADDR);
>  
> -	rc = spmi_controller_wait_for_done(spmi_controller, spmi_controller->base, sid, addr);
> +	rc = spmi_controller_wait_for_done(spmi_controller,
> +					   spmi_controller->base, sid, addr);
>  	if (rc)
>  		goto done;
>  
>  	i = 0;
>  	do {
>  		data = readl(spmi_controller->base + chnl_ofst + SPMI_SLAVE_OFFSET * sid + SPMI_APB_SPMI_RDATA0_BASE_ADDR + i * SPMI_PER_DATAREG_BYTE);
> -		data = bswap_32(data);
> +		data = be32_to_cpu((__be32)data);
>  		if ((bc - i * SPMI_PER_DATAREG_BYTE) >> 2) {
>  			memcpy(buf, &data, sizeof(data));
>  			buf += sizeof(data);
> @@ -210,8 +205,7 @@ static int spmi_write_cmd(struct spmi_controller *ctrl,
>  {
>  	struct spmi_controller_dev *spmi_controller = dev_get_drvdata(&ctrl->dev);
>  	unsigned long flags;
> -	u32 cmd;
> -	u32 data = 0;
> +	u32 cmd, data;
>  	int rc;
>  	u32 chnl_ofst = SPMI_CHANNEL_OFFSET * spmi_controller->channel;
>  	u8 op_code, i;
> @@ -246,7 +240,7 @@ static int spmi_write_cmd(struct spmi_controller *ctrl,
>  
>  	i = 0;
>  	do {
> -		memset(&data, 0, sizeof(data));
> +		data = 0;
>  		if ((bc - i * SPMI_PER_DATAREG_BYTE) >> 2) {
>  			memcpy(&data, buf, sizeof(data));
>  			buf += sizeof(data);
> @@ -255,8 +249,8 @@ static int spmi_write_cmd(struct spmi_controller *ctrl,
>  			buf += (bc % SPMI_PER_DATAREG_BYTE);
>  		}
>  
> -		data = bswap_32(data);
> -		writel(data, spmi_controller->base + chnl_ofst + SPMI_APB_SPMI_WDATA0_BASE_ADDR + SPMI_PER_DATAREG_BYTE * i);
> +		writel((u32)cpu_to_be32(data),
> +		       spmi_controller->base + chnl_ofst + SPMI_APB_SPMI_WDATA0_BASE_ADDR + SPMI_PER_DATAREG_BYTE * i);
>  		i++;
>  	} while (bc > i * SPMI_PER_DATAREG_BYTE);
>  

