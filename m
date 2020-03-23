Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 689DFC10F26
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 05:38:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3338420732
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 05:38:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727234AbgCWFiR convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 01:38:17 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:43636 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726142AbgCWFiQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 01:38:16 -0400
Received: from mail-pj1-f72.google.com ([209.85.216.72])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1jGFmw-0006F3-2t
        for linux-kernel@vger.kernel.org; Mon, 23 Mar 2020 05:38:14 +0000
Received: by mail-pj1-f72.google.com with SMTP id r42so9703541pjb.8
        for <linux-kernel@vger.kernel.org>; Sun, 22 Mar 2020 22:38:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=EDzKju/OPsqw3AjvZmw+YrycxupmTQRJ//NFxktKcVs=;
        b=Z9I4xCuLXZiW/0w0xTeskLiK/eMiQTxC4Scjye74hkcZkoHrm2tCf6f01ZUxIkQ5AS
         VpckRz8bkTrnNcJD22RO7p2G5RUqvWnKX3yuShylEqE7gkfr3n/OfClSwbeazbxhc/va
         mWFCzC/Hbhez9+LFILgI/nCDlLxXwjf+VNuZZR1r+yl9/FHyTmCCcdNZo++GiPrDdua4
         y8EBPBYgGGMPl7wBqGJo1WxEIH6yWg6qUvcQXrfGABWWZIP96+L8+15BtMIanb2vfVSr
         PmQ9yTQdWcUYCCX0TpWiKevHbCd+Pvb14yn/TCjhQPKO3GL5w3/EaW9f8z6aLBSYOmlY
         eJLw==
X-Gm-Message-State: ANhLgQ2LhIuIy2iAW4wuZSzCnlgeVEZOfcNPs+0pHV/yMDAQQFohBdcl
        kNGk75W+AaO5ofzAA1bK5X7Q7tDBk1TJOg72QADoKyWYVWV45GhwqtubMKiGQ53Z9QRvVtLnqAL
        bOjRFGU70o6TmOj9uWwOBkxGxGCwZywcak/YEoig/bA==
X-Received: by 2002:a63:1e57:: with SMTP id p23mr20953108pgm.316.1584941892498;
        Sun, 22 Mar 2020 22:38:12 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vuNc1eFtXeGYwkxDS7Mj734qj1dg0O0cuTtgzQ7v+E0W5HQjcXzrqZ2B+d9F7+1mWnkiw8YnQ==
X-Received: by 2002:a63:1e57:: with SMTP id p23mr20953093pgm.316.1584941892154;
        Sun, 22 Mar 2020 22:38:12 -0700 (PDT)
Received: from [192.168.1.208] (220-133-187-190.HINET-IP.hinet.net. [220.133.187.190])
        by smtp.gmail.com with ESMTPSA id y9sm10976793pjj.17.2020.03.22.22.38.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 22 Mar 2020 22:38:11 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.60.0.2.5\))
Subject: Re: [PATCH] i2c: nvidia-gpu: Handle timeout correctly in
 gpu_i2c_check_status()
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <20200311165806.12365-1-kai.heng.feng@canonical.com>
Date:   Mon, 23 Mar 2020 13:38:09 +0800
Cc:     Wolfram Sang <wsa@the-dreams.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "open list:I2C CONTROLLER DRIVER FOR NVIDIA GPU" 
        <linux-i2c@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <DA56E103-CAA7-4C28-9528-9EAFF2C717CD@canonical.com>
References: <20200311165806.12365-1-kai.heng.feng@canonical.com>
To:     ajayg@nvidia.com
X-Mailer: Apple Mail (2.3608.60.0.2.5)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On Mar 12, 2020, at 00:58, Kai-Heng Feng <kai.heng.feng@canonical.com> wrote:
> 
> Nvidia card may come with a "phantom" UCSI device, and its driver gets
> stuck in probe routine, prevents any system PM operations like suspend.
> 
> Let's handle the unaccounted case that the target time equals to jiffies
> in gpu_i2c_check_status(), so the UCSI driver can let the probe fail as
> it should.
> 
> Fixes: c71bcdcb42a7 ("i2c: add i2c bus driver for NVIDIA GPU")
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>

A gentle ping...

> ---
> drivers/i2c/busses/i2c-nvidia-gpu.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/i2c/busses/i2c-nvidia-gpu.c b/drivers/i2c/busses/i2c-nvidia-gpu.c
> index 62e18b4db0ed..1988e93c7925 100644
> --- a/drivers/i2c/busses/i2c-nvidia-gpu.c
> +++ b/drivers/i2c/busses/i2c-nvidia-gpu.c
> @@ -88,7 +88,7 @@ static int gpu_i2c_check_status(struct gpu_i2c_dev *i2cd)
> 		usleep_range(500, 600);
> 	} while (time_is_after_jiffies(target));
> 
> -	if (time_is_before_jiffies(target)) {
> +	if (time_is_before_eq_jiffies(target)) {
> 		dev_err(i2cd->dev, "i2c timeout error %x\n", val);
> 		return -ETIMEDOUT;
> 	}
> -- 
> 2.17.1
> 

