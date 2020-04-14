Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EE5FC352B6
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 13:15:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E3572063A
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 13:15:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502778AbgDNNPN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 09:15:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2502707AbgDNNOn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 09:14:43 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44445C061A0C
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 06:14:43 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id B1A152A1894
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Subject: Re: [PATCH v2] platform/chrome: wilco_ec: Provide correct output
 format to 'h1_gpio' file
To:     Bernardo Perez Priego <bernardo.perez.priego@intel.com>,
        Benson Leung <bleung@chromium.org>,
        Nick Crews <ncrews@chromium.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Daniel Campello <campello@chromium.org>,
        linux-kernel@vger.kernel.org
References: <20200313232720.22364-1-bernardo.perez.priego@intel.com>
 <20200402223331.28300-1-bernardo.perez.priego@intel.com>
Message-ID: <735ded63-099e-cd5c-1264-52899dc050ae@collabora.com>
Date:   Tue, 14 Apr 2020 15:14:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200402223331.28300-1-bernardo.perez.priego@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bernardo,

Thank you for your patch.

On 3/4/20 0:33, Bernardo Perez Priego wrote:
> Function 'h1_gpio_get' is receiving 'val' parameter of type u64,
> this is being passed to 'send_ec_cmd' as type u8, thus, result
> is stored in least significant byte. Due to output format,
> the whole 'val' value was being displayed when any of the most
> significant bytes are different than zero.
> 
> This fix will make sure only least significant byte is displayed
> regardless of remaining bytes value.
> 
> Signed-off-by: Bernardo Perez Priego <bernardo.perez.priego@intel.com>
> ---

Applied for 5.8

> Changes in v2:
> - Keep original format and apply mask instead to resolve warning
> 
>  drivers/platform/chrome/wilco_ec/debugfs.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/platform/chrome/wilco_ec/debugfs.c b/drivers/platform/chrome/wilco_ec/debugfs.c
> index df5a5f6c3ec6..a812788a0bdc 100644
> --- a/drivers/platform/chrome/wilco_ec/debugfs.c
> +++ b/drivers/platform/chrome/wilco_ec/debugfs.c
> @@ -208,7 +208,12 @@ static int send_ec_cmd(struct wilco_ec_device *ec, u8 sub_cmd, u8 *out_val)
>   */
>  static int h1_gpio_get(void *arg, u64 *val)
>  {
> -	return send_ec_cmd(arg, SUB_CMD_H1_GPIO, (u8 *)val);
> +	int ret;
> +
> +	ret = send_ec_cmd(arg, SUB_CMD_H1_GPIO, (u8 *)val);
> +	if (ret == 0)
> +		*val &= 0xFF;
> +	return ret;
>  }
>  
>  DEFINE_DEBUGFS_ATTRIBUTE(fops_h1_gpio, h1_gpio_get, NULL, "0x%02llx\n");
> 
