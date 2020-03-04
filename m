Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BA9DC3F2D7
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 11:02:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4300C21739
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 11:02:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388028AbgCDLCm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 06:02:42 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:44526 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729118AbgCDLCm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 06:02:42 -0500
Received: from 79.184.237.41.ipv4.supernova.orange.pl (79.184.237.41) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.341)
 id 9e78e012dbbd93a1; Wed, 4 Mar 2020 12:02:39 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Colin King <colin.king@canonical.com>
Cc:     Zhang Rui <rui.zhang@intel.com>, Len Brown <lenb@kernel.org>,
        linux-acpi@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ACPI: video: remove redundant assignments to variable result
Date:   Wed, 04 Mar 2020 12:02:39 +0100
Message-ID: <1811882.qudN6vFfLL@kreacher>
In-Reply-To: <20200229001243.113176-1-colin.king@canonical.com>
References: <20200229001243.113176-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday, February 29, 2020 1:12:43 AM CET Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> The variable result is being initialized with a value that is never
> read and it is being updated later with a new value. The initialization
> is redundant and can be removed.
> 
> Addresses-Coverity: ("Unused value")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/acpi/acpi_video.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/acpi_video.c b/drivers/acpi/acpi_video.c
> index 15c5b272e698..bc96457c9e25 100644
> --- a/drivers/acpi/acpi_video.c
> +++ b/drivers/acpi/acpi_video.c
> @@ -943,7 +943,7 @@ acpi_video_init_brightness(struct acpi_video_device *device)
>  	int i, max_level = 0;
>  	unsigned long long level, level_old;
>  	struct acpi_video_device_brightness *br = NULL;
> -	int result = -EINVAL;
> +	int result;
>  
>  	result = acpi_video_get_levels(device->dev, &br, &max_level);
>  	if (result)
> 

Applied as 5.7 material, thanks!




