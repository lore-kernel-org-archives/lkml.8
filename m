Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22926C3F2D1
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 15:36:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E088321739
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 15:36:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g7PhMTDH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727111AbgCBPgG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 10:36:06 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:41857 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726751AbgCBPgG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 10:36:06 -0500
Received: by mail-oi1-f193.google.com with SMTP id i1so10660078oie.8
        for <linux-kernel@vger.kernel.org>; Mon, 02 Mar 2020 07:36:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:reply-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZUOEGdn5h6v06IPczIi66UOyLvx1Bz0z6upuBzYIOrQ=;
        b=g7PhMTDH9NxeJ06pUQIIg/RkeIilz5nkHwax+23u/zcZ+SEG2prhes2Aq3p2Unr8T7
         yasbJl0DlDjV/n6HcXhlsgbuZ12HmfRj+ZwYdYSEzIsmPq4XTHA9Q9bTriZI2vU7nciW
         nEj6bG4pwltZRKDv36fmhhN+HLnJ+7smuky6IJEyQVlW3dVuB/4Qk7b7y1f6NUcppFDW
         hTwip+u3og3WpnhBAfPhwG+gz+G70S2updwrUTXfOUsmo6xobx/epO+biYMEC208jJKO
         bgxqWuYCU4mA2ykKs1oQ1i5atKD1hCJrY9Pgpat2vintzygSbiW3x0IwE4ODTv/xDm7f
         9hZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :reply-to:references:mime-version:content-disposition:in-reply-to
         :user-agent;
        bh=ZUOEGdn5h6v06IPczIi66UOyLvx1Bz0z6upuBzYIOrQ=;
        b=IjOM73GkZEUH9u0irKBdG0QwgmVtXowTKigfvr+6ZkwP9NKsP8ZH/twbrav+1Jc93B
         JCqzAVtmh6EkVZkJNWxGLEYHnlmzEKitTVuSgXwaaG6Fdvp5n1Q5sGrfs4/uT4RCumRe
         PcfC6tegHFeqJkkC+wkbhg4ufOzedMcBtKs/2ftRGNBOLxJ+R0AczSwg4iAuPMvtZip3
         5C9+XpJhCpEJV3s1GtCYyBnV63gCav6mu7AGeK0jpJ+VCPldkYffknOBsnm2hGUGnnkg
         Bbon6DVzP18Y6NQWy8UXBIddTd0wgtXXJ0uY1G3qqFiEgpcGkVW1mOr13BmcZxURL1UZ
         T1nw==
X-Gm-Message-State: ANhLgQ0M/5aAFT5Su7VwMDjpPHxhpYLHeaX8IfoUNuEtY/JOHCbYgTNg
        8NIg6hTs4C8Dx4NActiaFw==
X-Google-Smtp-Source: ADFU+vus2EJmJvBstGS2lEYVuazQ4+UpqrUrmYQEBHAnujMK6z7RGN/mLW7f94F63q9V9d/hufoILw==
X-Received: by 2002:a05:6808:b22:: with SMTP id t2mr71712oij.40.1583163365360;
        Mon, 02 Mar 2020 07:36:05 -0800 (PST)
Received: from serve.minyard.net ([47.184.164.37])
        by smtp.gmail.com with ESMTPSA id h15sm6659601otq.67.2020.03.02.07.36.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2020 07:36:04 -0800 (PST)
Received: from minyard.net (unknown [IPv6:2001:470:b8f6:1b:9dde:2776:ee08:1ad1])
        by serve.minyard.net (Postfix) with ESMTPSA id 80D35180002;
        Mon,  2 Mar 2020 15:36:04 +0000 (UTC)
Date:   Mon, 2 Mar 2020 09:36:03 -0600
From:   Corey Minyard <minyard@acm.org>
To:     John Donnelly <john.p.donnelly@oracle.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 ] ipmi_si: Fix false error about IRQ registration
Message-ID: <20200302153603.GD3878@minyard.net>
Reply-To: minyard@acm.org
References: <95A6B0CD-9C09-4165-AF60-A2789C53E926@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <95A6B0CD-9C09-4165-AF60-A2789C53E926@oracle.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 28, 2020 at 03:28:04PM -0600, John Donnelly wrote:
> Since commit 7723f4c5ecdb ("driver core: platform: Add an error message
> to platform_get_irq()"), platform_get_irq() will call dev_err() on an
> error,  even though the IRQ usage in the ipmi_si driver is optional.
> 
> Use the platform_get_irq_optional() call to avoid the message from
> alerting users with false alarms.
> 
> cc: stable@vger.kernel.org # 5.4.x

This looks good to me:

Acked-by: Corey Minyard <cminyard@mvista.com>

I've included in my tree for 5.7

-corey

> 
> Signed-off-by: John Donnelly <john.p.donnelly@oracle.com>
> ---
>  drivers/char/ipmi/ipmi_si_platform.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/char/ipmi/ipmi_si_platform.c b/drivers/char/ipmi/ipmi_si_platform.c
> index c78127ccbc0d..638c693e17ad 100644
> --- a/drivers/char/ipmi/ipmi_si_platform.c
> +++ b/drivers/char/ipmi/ipmi_si_platform.c
> @@ -194,7 +194,7 @@ static int platform_ipmi_probe(struct platform_device *pdev)
>  	else
>  		io.slave_addr = slave_addr;
>  
> -	io.irq = platform_get_irq(pdev, 0);
> +	io.irq = platform_get_irq_optional(pdev, 0);
>  	if (io.irq > 0)
>  		io.irq_setup = ipmi_std_irq_setup;
>  	else
> @@ -378,7 +378,7 @@ static int acpi_ipmi_probe(struct platform_device *pdev)
>  		io.irq = tmp;
>  		io.irq_setup = acpi_gpe_irq_setup;
>  	} else {
> -		int irq = platform_get_irq(pdev, 0);
> +		int irq = platform_get_irq_optional(pdev, 0);
>  
>  		if (irq > 0) {
>  			io.irq = irq;
> -- 
> 2.20.1
> 
