Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77650C10F25
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 07:19:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E39B208C3
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 07:19:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583911179;
	bh=pxFN/y4Pn78eg6K3072OBGZVdP4QYE8XIDVNfrexXig=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=cdZrR/lt6KspZjPVJPxBuc4imtrQxDf0echRpha2JaASYdlRLzMmhwIiCVwpmTzVg
	 aHDWgFgRzYQd5iUvCMangHtSUsIMKkmUc011o+9wOY9F4hB/0GJKSlQDWf7RHIZPYJ
	 4KW6UmfgtfXtS/GC41osHDqpo84bktTg8diJ54mc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728526AbgCKHTi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 03:19:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:41218 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726672AbgCKHTh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 03:19:37 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0C4F4208C3;
        Wed, 11 Mar 2020 07:19:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583911177;
        bh=pxFN/y4Pn78eg6K3072OBGZVdP4QYE8XIDVNfrexXig=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EBkW98m04XtashojyPW85zQbJVSKdAEFmMP9TyrDNT/STUbGvVwmZtVQlqTOoUtoD
         v6IiTSwil6doa+TmdPxOoGLJEpycmFHVJ2qsjcb0i4tQLZsqRswGFzcEUy2hIptDqt
         UtFeNCDQzF3lIWNuiA9JITbXY9WeL3fCq5tvpdrM=
Date:   Wed, 11 Mar 2020 08:19:35 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers/base/cpu: Use scnprintf() for avoiding potential
 buffer overflow
Message-ID: <20200311071935.GA3656396@kroah.com>
References: <20200311071200.4024-1-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200311071200.4024-1-tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 11, 2020 at 08:12:00AM +0100, Takashi Iwai wrote:
> Since snprintf() returns the would-be-output size instead of the
> actual output size, the succeeding calls may go beyond the given
> buffer limit.  Fix it by replacing with scnprintf().
> 
> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> ---
>  drivers/base/cpu.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/base/cpu.c b/drivers/base/cpu.c
> index 6265871a4af2..0abcd9d68714 100644
> --- a/drivers/base/cpu.c
> +++ b/drivers/base/cpu.c
> @@ -231,7 +231,7 @@ static struct cpu_attr cpu_attrs[] = {
>  static ssize_t print_cpus_kernel_max(struct device *dev,
>  				     struct device_attribute *attr, char *buf)
>  {
> -	int n = snprintf(buf, PAGE_SIZE-2, "%d\n", NR_CPUS - 1);
> +	int n = scnprintf(buf, PAGE_SIZE-2, "%d\n", NR_CPUS - 1);

This should just be "sprintf()" as we "know" that fitting a single
number will work.

>  	return n;
>  }
>  static DEVICE_ATTR(kernel_max, 0444, print_cpus_kernel_max, NULL);
> @@ -258,13 +258,13 @@ static ssize_t print_cpus_offline(struct device *dev,
>  			buf[n++] = ',';
>  
>  		if (nr_cpu_ids == total_cpus-1)
> -			n += snprintf(&buf[n], len - n, "%u", nr_cpu_ids);
> +			n += scnprintf(&buf[n], len - n, "%u", nr_cpu_ids);
>  		else
> -			n += snprintf(&buf[n], len - n, "%u-%d",
> +			n += scnprintf(&buf[n], len - n, "%u-%d",
>  						      nr_cpu_ids, total_cpus-1);
>  	}
>  
> -	n += snprintf(&buf[n], len - n, "\n");
> +	n += scnprintf(&buf[n], len - n, "\n");

this part looks sane, can you respin this?

thanks,

greg k-h
