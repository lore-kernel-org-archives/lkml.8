Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72CACC47257
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 21:17:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5234E2075A
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 21:17:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YYwwgrSQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729798AbgEFVRb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 17:17:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728888AbgEFVRb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 17:17:31 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30AFEC061A41
        for <linux-kernel@vger.kernel.org>; Wed,  6 May 2020 14:17:31 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id b8so991213plm.11
        for <linux-kernel@vger.kernel.org>; Wed, 06 May 2020 14:17:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=bHL3TCbZSVY2fY8pK4XpL92L8KHu3Q1pRXqDpleq+io=;
        b=YYwwgrSQvQ9dTd1lotXO8pdQekhEC2A1cd0Sx4H5u9eyKmscleQOuRfvk8MoYW80cU
         0Ch/u9M3kotYkExS+646CjlVMuQYoUSUZNUfJ2mmRvudHnmG9c2neAaeLpSB5c74ZjbF
         LADPNADiw6WfWiGIUGy8MgNcS6UTYgRNw4nrs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bHL3TCbZSVY2fY8pK4XpL92L8KHu3Q1pRXqDpleq+io=;
        b=jncDLOjQ9td0FKw5gxZJ11WDCXXjRE8RZGzn/LIm7etakxggxDY512jIwj/lX1o/VG
         +0SlEFgi+D9hJsEMkNJmZ1GpXzedi2E2XnfTDgPu+IwlqdpOuffCPNETOiRtTNSHyK+g
         /oW7qSoTk2rLvWssrgNYUgWlHzxIY8Nwc7qUbc+T1Ed11DERy9HXpd8ABgBK1RyJK7Y0
         Qk3wkSeBp4sAHHRyHOIzoMcCWbKmqpq09Pl0qZdKiric1Qj3dn1LCJCzVZETx0EQLV6j
         UmhoguZ+R/habsHLsuCNHJNXepcNQPFyxniGykqnkivP3+OKxauo++VTgIeMb5kRS/Is
         /j7A==
X-Gm-Message-State: AGi0PuZb4tXju01JPzK0hCwlfPEUX3JFdQ3k6ImCQkKqnrI8/5gpkvy7
        nXIe5RwvFIeU34SINRUmYXG8zA==
X-Google-Smtp-Source: APiQypIO+MV5rfj61rKq9gZ6jFXrGGOrTEad7gG6HHHLb2+aMV1Qk523+Rt+BnExFpt2ko7aQbfPSQ==
X-Received: by 2002:a17:90b:19d6:: with SMTP id nm22mr8651002pjb.225.1588799850551;
        Wed, 06 May 2020 14:17:30 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id g184sm2667391pfb.80.2020.05.06.14.17.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2020 14:17:29 -0700 (PDT)
Date:   Wed, 6 May 2020 14:17:28 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Pavel Tatashin <pasha.tatashin@soleen.com>
Cc:     Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Rob Herring <robh+dt@kernel.org>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>, jmorris@namei.org,
        sashal@kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 4/6] pstore/ram: Introduce max_reason and convert
 dump_oops
Message-ID: <202005061416.4A6114910@keescook>
References: <20200506211523.15077-1-keescook@chromium.org>
 <20200506211523.15077-5-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200506211523.15077-5-keescook@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 06, 2020 at 02:15:21PM -0700, Kees Cook wrote:
> From: Pavel Tatashin <pasha.tatashin@soleen.com>
> 
> Now that pstore_register() can correctly pass max_reason to the kmesg
> dump facility, introduce a new "max_reason" module parameter and
> "max-reason" Device Tree field.
> 
> The "dump_oops" module parameter and "dump-oops" Device
> Tree field are now considered deprecated, but are now automatically
> converted to their corresponding max_reason values when present, though
> the new max_reason setting has precedence.
> 
> For struct ramoops_platform_data, the "dump_oops" member is entirely
> replaced by a new "max_reason" member, with the only existing user
> updated in place.
> 
> Additionally remove the "reason" filter logic from ramoops_pstore_write(),
> as that is not specifically needed anymore, though technically
> this is a change in behavior for any ramoops users also setting the
> printk.always_kmsg_dump boot param, which will cause ramoops to behave as
> if max_reason was set to KMSG_DUMP_MAX.
> 
> Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
> Link: https://lore.kernel.org/r/20200505154510.93506-4-pasha.tatashin@soleen.com
> Link: https://lore.kernel.org/r/20200505154510.93506-5-pasha.tatashin@soleen.com
> Co-developed-by: Kees Cook <keescook@chromium.org>
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  Documentation/admin-guide/ramoops.rst     | 14 +++++--
>  drivers/platform/chrome/chromeos_pstore.c |  2 +-
>  fs/pstore/ram.c                           | 51 +++++++++++++++--------
>  include/linux/pstore_ram.h                |  2 +-
>  4 files changed, 45 insertions(+), 24 deletions(-)
> 
> diff --git a/Documentation/admin-guide/ramoops.rst b/Documentation/admin-guide/ramoops.rst
> index 6dbcc5481000..a60a96218ba9 100644
> --- a/Documentation/admin-guide/ramoops.rst
> +++ b/Documentation/admin-guide/ramoops.rst
> @@ -32,11 +32,17 @@ memory to be mapped strongly ordered, and atomic operations on strongly ordered
>  memory are implementation defined, and won't work on many ARMs such as omaps.
>  
>  The memory area is divided into ``record_size`` chunks (also rounded down to
> -power of two) and each oops/panic writes a ``record_size`` chunk of
> +power of two) and each kmesg dump writes a ``record_size`` chunk of
>  information.
>  
> -Dumping both oopses and panics can be done by setting 1 in the ``dump_oops``
> -variable while setting 0 in that variable dumps only the panics.
> +Limiting which kinds of kmsg dumps are stored can be controlled via
> +the ``max_reason`` value, as defined in include/linux/kmsg_dump.h's
> +``enum kmsg_dump_reason``. For example, to store both Oopses and Panics,
> +``max_reason`` should be set to 2 (KMSG_DUMP_OOPS), to store only Panics
> +``max_reason`` should be set to 1 (KMSG_DUMP_PANIC). Setting this to 0
> +(KMSG_DUMP_UNDEF), means the reason filtering will be controlled by the
> +``printk.always_kmsg_dump`` boot param: if unset, it'll be KMSG_DUMP_OOPS,
> +otherwise KMSG_DUMP_MAX.
>  
>  The module uses a counter to record multiple dumps but the counter gets reset
>  on restart (i.e. new dumps after the restart will overwrite old ones).
> @@ -90,7 +96,7 @@ Setting the ramoops parameters can be done in several different manners:
>          .mem_address            = <...>,
>          .mem_type               = <...>,
>          .record_size            = <...>,
> -        .dump_oops              = <...>,
> +        .max_reason             = <...>,
>          .ecc                    = <...>,
>    };
>  
> diff --git a/drivers/platform/chrome/chromeos_pstore.c b/drivers/platform/chrome/chromeos_pstore.c
> index d13770785fb5..fa51153688b4 100644
> --- a/drivers/platform/chrome/chromeos_pstore.c
> +++ b/drivers/platform/chrome/chromeos_pstore.c
> @@ -57,7 +57,7 @@ static struct ramoops_platform_data chromeos_ramoops_data = {
>  	.record_size	= 0x40000,
>  	.console_size	= 0x20000,
>  	.ftrace_size	= 0x20000,
> -	.dump_oops	= 1,
> +	.max_reason	= KMSG_DUMP_OOPS,
>  };
>  
>  static struct platform_device chromeos_ramoops = {
> diff --git a/fs/pstore/ram.c b/fs/pstore/ram.c
> index c2f76b650f91..b8dac1d04e96 100644
> --- a/fs/pstore/ram.c
> +++ b/fs/pstore/ram.c
> @@ -57,10 +57,15 @@ module_param(mem_type, uint, 0600);
>  MODULE_PARM_DESC(mem_type,
>  		"set to 1 to try to use unbuffered memory (default 0)");
>  
> -static int dump_oops = 1;
> -module_param(dump_oops, int, 0600);
> +static int ramoops_dump_oops = -1;
> +module_param_named(dump_oops, ramoops_dump_oops, int, 0400);
>  MODULE_PARM_DESC(dump_oops,
> -		"set to 1 to dump oopses, 0 to only dump panics (default 1)");
> +		 "set to 1 to dump oopses & panics, 0 to only dump panics (deprecated: use max_reason instead)");
> +
> +static int ramoops_max_reason = KMESG_DUMP_OOPS;

This is what I get for a "quick change right before sending". This
is a typo and should be KMSG_DUMP_OOPS. :|

-- 
Kees Cook
