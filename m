Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B316C43331
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 13:09:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E51920737
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 13:09:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tFcfXjdR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727656AbgCZNJE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 09:09:04 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33526 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725994AbgCZNJD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 09:09:03 -0400
Received: by mail-wr1-f65.google.com with SMTP id a25so7754238wrd.0
        for <linux-kernel@vger.kernel.org>; Thu, 26 Mar 2020 06:09:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=nesUQSo9Vy5oi7lhwsgMDQiIGSwXYZh1lt04KTBMkDM=;
        b=tFcfXjdRVhPsDI+TBYBqK0xDPMuNUggKrctOuYnFzJJtwQp2ffy8uQKhBM8w7ozTe9
         5t5EFj8nU1rqY/4HmIBU8oJ9snyrAxrTDpEt8ioxutKT008f0/RIp7CF2uJ0lQK/iBed
         7nc0OZFSOtUuzC0HJ1dGpPtz1/gTGK3CBRZ/PpshpDh3i8o/F8N4Q5uEjfHsAJXNEQsf
         rnTCUjbGngL22dpjlHz7ykw+sallnQutRtIsJnjgy1+U9ysEex7ldEDbp4LulE29B8iw
         G07DiyJDrSOCZB4I/8ZyAhNFIyYwkBhQfV8Ug0GS1n5R65M9xU2AR2EAGXbPRR0iWl+5
         XA9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nesUQSo9Vy5oi7lhwsgMDQiIGSwXYZh1lt04KTBMkDM=;
        b=XFvxMR2OOkewzw85CynbD2JWO+YM31Rm4x5fgzwyK58vFG7KT/Knh0HFB5iwJb8wKA
         R566MZiJVSSWR8lr3fQowY9TyE94+jbIv1WUAYpp85gyzMcprYrCIRtfcQdtq/74QwjO
         dfoKQZ33D6awpeVgqYS3pG77WeKAvDH/CGPe+OiQbhT+D8hY/HUdawHOUPpeimSJ9tot
         o+o0c114Yi1Q4oOa+xJMsK2DFFEHRMVDG2SHvc4A3+Ys2PL0Z/LHszMxaMjoJaOzM6sQ
         alVoVuT0EgB8ozo5O8olUlnX6atu4PPCJ/lgxUsXoRUG23ZvVfAAYNqnb2zLbfXHPc37
         9ong==
X-Gm-Message-State: ANhLgQ2fjt4RgO23VWkQ9WFfVwRWqTo7vL28NPD72/XTYKoriUsma+JI
        85bktRVt2Ak07TvCo3idlJXOG8UePTk=
X-Google-Smtp-Source: ADFU+vuiRdwL7ByDiPYmrvKBbOq29uYwlV7UlDd4ZcEJ8oqWH61S0lpU7HC3vUP+I31uRwLraXF5oQ==
X-Received: by 2002:a5d:4c87:: with SMTP id z7mr9987504wrs.39.1585228141513;
        Thu, 26 Mar 2020 06:09:01 -0700 (PDT)
Received: from [192.168.86.34] (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.googlemail.com with ESMTPSA id b80sm3657335wme.24.2020.03.26.06.08.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Mar 2020 06:09:00 -0700 (PDT)
Subject: Re: [PATCH v1] slimbus: core: Set fwnode for a device when setting
 of_node
To:     Saravana Kannan <saravanak@google.com>
Cc:     John Stultz <john.stultz@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        kernel-team@android.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
References: <20200326061648.78914-1-saravanak@google.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <dfeacd9d-fed6-10fb-0b9d-9a1fceb075f5@linaro.org>
Date:   Thu, 26 Mar 2020 13:08:59 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200326061648.78914-1-saravanak@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for doing this!

On 26/03/2020 06:16, Saravana Kannan wrote:
> When setting the of_node for a newly created device, also set the
> fwnode. This allows fw_devlink to work for slimbus devices.
> 
> Signed-off-by: Saravana Kannan <saravanak@google.com>
> Change-Id: I5505213f8ecca908860a1ad6bbc275ec0f78e4a6

Once Change-Id is removed as Greg suggested!

Reviewed-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

--srini

> ---
>   drivers/slimbus/core.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/slimbus/core.c b/drivers/slimbus/core.c
> index 526e3215d8fe..44228a5b246d 100644
> --- a/drivers/slimbus/core.c
> +++ b/drivers/slimbus/core.c
> @@ -163,8 +163,10 @@ static int slim_add_device(struct slim_controller *ctrl,
>   	INIT_LIST_HEAD(&sbdev->stream_list);
>   	spin_lock_init(&sbdev->stream_list_lock);
>   
> -	if (node)
> +	if (node) {
>   		sbdev->dev.of_node = of_node_get(node);
> +		sbdev->dev.fwnode = of_fwnode_handle(node);
> +	}
>   
>   	dev_set_name(&sbdev->dev, "%x:%x:%x:%x",
>   				  sbdev->e_addr.manf_id,
> 
