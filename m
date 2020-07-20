Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58D82C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 19:52:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2ABCA2080D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 19:52:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZJgoG2v9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729501AbgGTTwk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 15:52:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726619AbgGTTwk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 15:52:40 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F334C061794
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 12:52:40 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id k6so15286221oij.11
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 12:52:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:reply-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=atKBBWcnU++49tmxsg8oq4hs4l/FvwBwr9+f5kHrPQE=;
        b=ZJgoG2v9a3cZM4UqmYfn++N0kaA7KzoYlCD9aks8VYOBn6rR2+oadW4WeaetOwqXtK
         9wtVNkYUeRNpdgZdpD+4e+Mag6dOG1iYFX6G23w8cUWbC4x9lIkJXTKEcABwlW9RoBta
         cveGXS4ay5iUd+m/7R2K4Ua8LV51xZIjRokaakCsIUNSsba1YZzoXl5gD1PMqOvCC1Dc
         r3vPcnm9E+/TXxURYhySdwQtwm4D6sJxEsJgc8i8nDHRhKYeLQbSk/rBHS2MNcl3pujD
         hPHIV/HsqNZTwXWDJYKxAx8bnhhzRuLkzkCDoyVOKtqrIdVIuO7wAzcKwn0/dCVo5Pc8
         Bg2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :reply-to:references:mime-version:content-disposition:in-reply-to
         :user-agent;
        bh=atKBBWcnU++49tmxsg8oq4hs4l/FvwBwr9+f5kHrPQE=;
        b=XGZcun6a1ZxWXIgbRlCwYZ+3cgqmq1Iuzuzr+cEeyKcapbdAzjq2d0vBmpPop3GapQ
         rsgyGmkRcgD2oTPRTmItOVjAcNDcF72fkYSFbTRU5qJzm50hB0xRzgABoIp/6YXCrvkI
         0QBcCwpAx0jIvOOKulXCaH89+9JNbu8LGwff82l5za90f/NgUybuK3NRFtn9h9vAiv04
         KaFz9pasf9kIfYaZOgmnZRp40e6iDac7aUSufNvRsc0kYIKB2hlree9KoJ8/9+50j81u
         AN+WPMdjRgZrokYVdH9OzKhU2G1w3HM56LnMEbNAFEKzJsMBFABihFZNqOyrUaQS3Y1c
         kG/Q==
X-Gm-Message-State: AOAM531zRaQxj3BxNB+a3sA2511h/yZGhPKpmQUie+puhXrlIzFNx1uW
        l2UdgyGqDfulgVW5fVxloQ==
X-Google-Smtp-Source: ABdhPJxqM6pg5Fv/HsBONDNbtH4Msu1sRLXaPLyToL/8sGazJJtntFelMODQ9A/uOG96DKl0XKiNrA==
X-Received: by 2002:aca:57c5:: with SMTP id l188mr725424oib.154.1595274759308;
        Mon, 20 Jul 2020 12:52:39 -0700 (PDT)
Received: from serve.minyard.net ([47.184.146.204])
        by smtp.gmail.com with ESMTPSA id s4sm4573610oom.15.2020.07.20.12.52.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2020 12:52:38 -0700 (PDT)
Received: from minyard.net (unknown [IPv6:2001:470:b8f6:1b:70d6:b947:41f4:6e7e])
        by serve.minyard.net (Postfix) with ESMTPSA id 1B9E5180050;
        Mon, 20 Jul 2020 19:52:36 +0000 (UTC)
Date:   Mon, 20 Jul 2020 14:52:34 -0500
From:   Corey Minyard <minyard@acm.org>
To:     Xiongfeng Wang <wangxiongfeng2@huawei.com>
Cc:     arnd@arndb.de, gregkh@linuxfoundation.org,
        openipmi-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, guohanjun@huawei.com
Subject: Re: [PATCH] ipmi/watchdog: add missing newlines when printing
 parameters by sysfs
Message-ID: <20200720195234.GC2952@minyard.net>
Reply-To: minyard@acm.org
References: <1595210605-27888-1-git-send-email-wangxiongfeng2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1595210605-27888-1-git-send-email-wangxiongfeng2@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 20, 2020 at 10:03:25AM +0800, Xiongfeng Wang wrote:
> When I cat some ipmi_watchdog parameters by sysfs, it displays as
> follows. It's better to add a newline for easy reading.
> 
> root@(none):/# cat /sys/module/ipmi_watchdog/parameters/action
> resetroot@(none):/# cat /sys/module/ipmi_watchdog/parameters/preaction
> pre_noneroot@(none):/# cat /sys/module/ipmi_watchdog/parameters/preop
> preop_noneroot@(none):/#

Yeah, that's not consistent with other things displayed in the kernel.

> 
> Signed-off-by: Xiongfeng Wang <wangxiongfeng2@huawei.com>
> ---
>  drivers/char/ipmi/ipmi_watchdog.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/char/ipmi/ipmi_watchdog.c b/drivers/char/ipmi/ipmi_watchdog.c
> index 55986e1..3e05a1d 100644
> --- a/drivers/char/ipmi/ipmi_watchdog.c
> +++ b/drivers/char/ipmi/ipmi_watchdog.c
> @@ -232,12 +232,16 @@ static int set_param_str(const char *val, const struct kernel_param *kp)
>  static int get_param_str(char *buffer, const struct kernel_param *kp)
>  {
>  	action_fn fn = (action_fn) kp->arg;
> -	int       rv;
> +	int rv, len;
>  
>  	rv = fn(NULL, buffer);
>  	if (rv)
>  		return rv;
> -	return strlen(buffer);
> +
> +	len = strlen(buffer);
> +	len += sprintf(buffer + len, "\n");

sprintf is kind of overkill to stick a \n on the end of a line.  How
about:

	buffer[len++] = '\n';

Since you are returning the length, you shouldn't need to nil terminate
the string.

An unrelated question: Are you using any of the special functions of the
IPMI watchdog, like the pretimeout?

-corey

> +
> +	return len;
>  }
>  
>  
> -- 
> 1.7.12.4
> 
