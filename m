Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BFCEC2BA19
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 11:29:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07FDF206C3
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 11:29:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727354AbgDFL31 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 07:29:27 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:39391 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726858AbgDFL31 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 07:29:27 -0400
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=[127.0.0.1])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <a.fatoum@pengutronix.de>)
        id 1jLPwU-0002IQ-AV; Mon, 06 Apr 2020 13:29:26 +0200
Subject: Re: [PATCH v2] nvmem: core: don't consider subnodes not matching
 binding
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     kernel@pengutronix.de, Christian Eggers <CEggers@arri.de>,
        linux-kernel@vger.kernel.org
References: <20200323152850.32657-1-a.fatoum@pengutronix.de>
From:   Ahmad Fatoum <a.fatoum@pengutronix.de>
Message-ID: <11227ab7-9f8e-ae6c-45a7-8c13fa16ebbb@pengutronix.de>
Date:   Mon, 6 Apr 2020 13:29:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200323152850.32657-1-a.fatoum@pengutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: a.fatoum@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Srinivas,

On 3/23/20 4:28 PM, Ahmad Fatoum wrote:
> The nvmem cell binding applies to objects which match "^.*@[0-9a-f]+$",
> but so far the driver has matched all objects and failed if they didn't
> have the expected properties.
> 
> The driver's behavior in this regard precludes future extension of
> EEPROMs by child nodes other than nvmem and clashes with the barebox
> bootloader binding that extends the fixed-partitions MTD binding to
> EEPROMs as it tries to interpret the "fixed-partitions"-compatible
> partitions node as a nvmem cell.
> 
> Solve this issue by skipping all subnodes that don't contain an @.
> 
> This still allows for cell names like `partitions@0,0', but this
> is much less likely to cause future collisions.
> 
> Signed-off-by: Ahmad Fatoum <a.fatoum@pengutronix.de>
> ---
> v1 -> v2:
>   use ->full_name instead of ->name as to not break existing correct
>   cells (Christian)
> ---
>  drivers/nvmem/core.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
> index ef326f243f36..f051051fb1a8 100644
> --- a/drivers/nvmem/core.c
> +++ b/drivers/nvmem/core.c
> @@ -278,6 +278,8 @@ static int nvmem_add_cells_from_of(struct nvmem_device *nvmem)
>  	parent = dev->of_node;
>  
>  	for_each_child_of_node(parent, child) {
> +		if (!strchr(kbasename(child->full_name), '@'))
> +			continue;
>  		addr = of_get_property(child, "reg", &len);
>  		if (!addr || (len < 2 * sizeof(u32))) {
>  			dev_err(dev, "nvmem: invalid reg on %pOF\n", child);
> 

gentle ping. I'd also appreciate pointers if you wish to have this addressed
differently.

Cheers
Ahmad

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
