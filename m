Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 107B6C2BA19
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 13:40:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DC38220644
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 13:40:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387859AbgDNNj6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 09:39:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2502758AbgDNNPE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 09:15:04 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68E25C061A0C
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 06:15:04 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id D468D2A1402
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Subject: Re: [PATCH 1/1] platform/chrome: chromeos_pstore: set user space log
 size
To:     Sarthak Kukreti <sarthakkukreti@chromium.org>, bleung@chromium.org
Cc:     keescook@chromium.org, anton@enomsg.org,
        linux-kernel@vger.kernel.org, ccross@android.com,
        tony.luck@intel.com, gwendal@chromium.org
References: <20200402001548.177025-1-sarthakkukreti@chromium.org>
Message-ID: <31fceb88-0d0d-083a-ce4d-3ebba1822a40@collabora.com>
Date:   Tue, 14 Apr 2020 15:14:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200402001548.177025-1-sarthakkukreti@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sarthak,

Thank you for your patch.

On 2/4/20 2:15, Sarthak Kukreti wrote:
> On x86 ChromiumOS devices, the pmsg_size is set to 0 (check
> /sys/module/ramoops/parameters/pmsg_size): this prevents use of
> pstore-pmsg, even if CONFIG_PSTORE_PMSG is enabled. Set pmsg_size
> to a value that is consistent with the size used on non-x86 ChromiumOS
> devices.
> 
> Signed-off-by: Sarthak Kukreti <sarthakkukreti@chromium.org>
> ---

Applied for 5.8

>  drivers/platform/chrome/chromeos_pstore.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/platform/chrome/chromeos_pstore.c b/drivers/platform/chrome/chromeos_pstore.c
> index d13770785fb5..82dea8cb5da1 100644
> --- a/drivers/platform/chrome/chromeos_pstore.c
> +++ b/drivers/platform/chrome/chromeos_pstore.c
> @@ -57,6 +57,7 @@ static struct ramoops_platform_data chromeos_ramoops_data = {
>  	.record_size	= 0x40000,
>  	.console_size	= 0x20000,
>  	.ftrace_size	= 0x20000,
> +	.pmsg_size	= 0x20000,
>  	.dump_oops	= 1,
>  };
>  
> 
