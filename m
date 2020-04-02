Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55755C43331
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 07:10:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2713D2078E
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 07:10:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ccdEGYY7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387632AbgDBHKt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 03:10:49 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:43627 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729087AbgDBHKt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 03:10:49 -0400
Received: by mail-pl1-f196.google.com with SMTP id v23so992949ply.10
        for <linux-kernel@vger.kernel.org>; Thu, 02 Apr 2020 00:10:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=zKRn3zcTNJyV8PBnDXrJTZEAx6lbDwDg6vuHoJdGe50=;
        b=ccdEGYY7m9DxxnEQAfv2xDOYJX2UE8xAEAmBZ38ynRXRPUoGYIOON2F9X2Qj6Hp4K/
         0lF1gksBI3QmHww33evoaEIJAiJVoMxdelERAUINZg1J7x6V8g09Id0mk0MCJXNVWYgy
         4yAgI91jDm7ouaWTzErStqChzkQDGOQIXUwzY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zKRn3zcTNJyV8PBnDXrJTZEAx6lbDwDg6vuHoJdGe50=;
        b=oU11VSkSCoZPKcaFxlfZpPkrGWo4CNvCFJndxvBetIXUeqHfNgbWdSvcpsPehGKjPk
         yjpHl1IMDOiMc9ttgRynW0qRRrjJoSwEx2bhr9LdE8mMVhnf5V9ZlM0ZvL/NUDvcfW41
         h1xzy9qcgblweECtwCk7SsLUNaDkqCDaex4Qxi7OZzfyz5mpyjM2haOW508NwhnVBu0G
         nRSyp7qV31UGHAHFmqKyVFmWhAuWx4Zm0Ea7tv/w6LgQrbr8c64Fk2RxprMKXkwFQCTC
         r9HrqTgdGBuJD8IP3+ooPcoQ1STBoompCXIGVTEwcV44VqKqMT49G+2CF4nKs5qJpGcO
         AxqA==
X-Gm-Message-State: AGi0PuYgZ0H0wZOXKJY9c8ZHS3IOWLlSeoAp4eFI9t1agfwddHBIee4+
        hDn23QLkopyKrI6bujesev8oWQ==
X-Google-Smtp-Source: APiQypKAPEvpcHgliMfni3z7kkGP0ckIL34i5j/4yf/fBPMc71Ws/MW8uXz/yRvQ2rDqG75Oo9VSXA==
X-Received: by 2002:a17:90a:30a9:: with SMTP id h38mr2042332pjb.184.1585811447928;
        Thu, 02 Apr 2020 00:10:47 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id d3sm3047926pfq.126.2020.04.02.00.10.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2020 00:10:47 -0700 (PDT)
Date:   Thu, 2 Apr 2020 00:10:46 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Sarthak Kukreti <sarthakkukreti@chromium.org>
Cc:     bleung@chromium.org, enric.balletbo@collabora.com,
        anton@enomsg.org, linux-kernel@vger.kernel.org, ccross@android.com,
        tony.luck@intel.com, gwendal@chromium.org
Subject: Re: [PATCH 1/1] platform/chrome: chromeos_pstore: set user space log
 size
Message-ID: <202004020010.E350EBE0B@keescook>
References: <20200402001548.177025-1-sarthakkukreti@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200402001548.177025-1-sarthakkukreti@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 01, 2020 at 05:15:48PM -0700, Sarthak Kukreti wrote:
> On x86 ChromiumOS devices, the pmsg_size is set to 0 (check
> /sys/module/ramoops/parameters/pmsg_size): this prevents use of
> pstore-pmsg, even if CONFIG_PSTORE_PMSG is enabled. Set pmsg_size
> to a value that is consistent with the size used on non-x86 ChromiumOS
> devices.
> 
> Signed-off-by: Sarthak Kukreti <sarthakkukreti@chromium.org>

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
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
> -- 
> 2.26.0.rc2.310.g2932bb562d-goog
> 

-- 
Kees Cook
