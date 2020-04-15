Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6A49C2BB1D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 03:11:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B69B52072D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 03:11:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WReb3Foo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389267AbgDODK6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 23:10:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731048AbgDODKp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 23:10:45 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87A97C061A10
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 20:10:45 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id r4so868373pgg.4
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 20:10:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=rl9PWj3uTfyqXygouG7eBzkOuRR3ht3SlSVZEdS5vi4=;
        b=WReb3FooecG/mGVKk7KoTDNmzBB8JA07kS8Wlt7cGOj1b+24cYEuDDpfQIYT19Pgq3
         D6Lmumf0FVKLo2Mq50BPVQcRiaZfDl6vC92/MGZX/r0LfWfPWUejG4s92xqamybetQPm
         UmeEt0q1UUwCZuMGpM5Q2JjGxrKiO51WcBNsI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rl9PWj3uTfyqXygouG7eBzkOuRR3ht3SlSVZEdS5vi4=;
        b=dPzPzwiH38nALXYY/YuLTGbGmAc7UnyLFpWFHl0KdudEu7YQWYcM3rBLIxIaxwuikj
         1a/UeeVHFsESttMJqpUQvzvSXW71LiP35c5bRcKCmVkrGNk9Ul3cAp69NM+cRyZ2Adbj
         yrmhtgHwtItuzbuB7MSvcKCOXzMO7hpa2ICRCkRJ3KkNhW8zmE2Rflv+fy9vtODCSmak
         35/3kODlwvxon+K+4ZWmwCNYyCS/zzzXdH+13wC/v0ooMJjRgUyiemlwEkawpaq9J2o1
         raLlJqDH3E1W41JOShsMclRz6v2OyKe7KD4GQSNeM9L+ZTxB+tfBk0r4e2mLg21kO0Dy
         Fymw==
X-Gm-Message-State: AGi0PuYU4DV6hsrjYwgRZHK5yzpiJd/RWopTLMfRvueGzfRR9vFxBcZk
        mHpwe6xxEHv1FwGml5PD7wLgUQ==
X-Google-Smtp-Source: APiQypLN7j/9XXU0t6HBqN7MgkhuUOzn37VdNDeJBnJniYxDkolOenYFHYWHDRbtpX384Nu0Yk81cA==
X-Received: by 2002:a62:e213:: with SMTP id a19mr11074202pfi.180.1586920245009;
        Tue, 14 Apr 2020 20:10:45 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 189sm12161684pfg.170.2020.04.14.20.10.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2020 20:10:44 -0700 (PDT)
Date:   Tue, 14 Apr 2020 20:10:43 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Scott Branden <scott.branden@broadcom.com>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        David Brown <david.brown@linaro.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Shuah Khan <shuah@kernel.org>, bjorn.andersson@linaro.org,
        Shuah Khan <skhan@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        Olof Johansson <olof@lixom.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Colin Ian King <colin.king@canonical.com>,
        Takashi Iwai <tiwai@suse.de>, linux-kselftest@vger.kernel.org,
        Andy Gross <agross@kernel.org>
Subject: Re: [PATCH] test_firmware: remove unnecessary test_fw_mutex in
 test_dev_config_show_xxx
Message-ID: <202004142010.C0847F5@keescook>
References: <20200415002517.4328-1-scott.branden@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200415002517.4328-1-scott.branden@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 14, 2020 at 05:25:17PM -0700, Scott Branden wrote:
> Remove unnecessary use of test_fw_mutex in test_dev_config_show_xxx
> functions that show simple bool, int, and u8.

I would expect at least a READ_ONCE(), yes?

> 
> Signed-off-by: Scott Branden <scott.branden@broadcom.com>
> ---
>  lib/test_firmware.c | 26 +++-----------------------
>  1 file changed, 3 insertions(+), 23 deletions(-)
> 
> diff --git a/lib/test_firmware.c b/lib/test_firmware.c
> index 0c7fbcf07ac5..9fee2b93a8d1 100644
> --- a/lib/test_firmware.c
> +++ b/lib/test_firmware.c
> @@ -310,27 +310,13 @@ static int test_dev_config_update_bool(const char *buf, size_t size,
>  	return ret;
>  }
>  
> -static ssize_t
> -test_dev_config_show_bool(char *buf,
> -			  bool config)
> +static ssize_t test_dev_config_show_bool(char *buf, bool val)
>  {
> -	bool val;
> -
> -	mutex_lock(&test_fw_mutex);
> -	val = config;
> -	mutex_unlock(&test_fw_mutex);
> -
>  	return snprintf(buf, PAGE_SIZE, "%d\n", val);
>  }
>  
> -static ssize_t test_dev_config_show_int(char *buf, int cfg)
> +static ssize_t test_dev_config_show_int(char *buf, int val)
>  {
> -	int val;
> -
> -	mutex_lock(&test_fw_mutex);
> -	val = cfg;
> -	mutex_unlock(&test_fw_mutex);
> -
>  	return snprintf(buf, PAGE_SIZE, "%d\n", val);
>  }
>  
> @@ -354,14 +340,8 @@ static int test_dev_config_update_u8(const char *buf, size_t size, u8 *cfg)
>  	return size;
>  }
>  
> -static ssize_t test_dev_config_show_u8(char *buf, u8 cfg)
> +static ssize_t test_dev_config_show_u8(char *buf, u8 val)
>  {
> -	u8 val;
> -
> -	mutex_lock(&test_fw_mutex);
> -	val = cfg;
> -	mutex_unlock(&test_fw_mutex);
> -
>  	return snprintf(buf, PAGE_SIZE, "%u\n", val);
>  }
>  
> -- 
> 2.17.1
> 

-- 
Kees Cook
