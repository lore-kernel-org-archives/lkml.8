Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED749C2D0EA
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 12:05:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B865E20747
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 12:05:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586347547;
	bh=h5Rm4Z4HRl5tEkemhyFQt/1ada5sl6ktIG5BqGPe39U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Lzi3eVr0rZUQ2ba3wjx5ukWG+qfWCNAVDF3MMiqTDac/EOE6+2FECcnvqli2XK9Bo
	 wGBlZYPVrVIXWaKrLNEvPKn5BHBOe7XDVpuya/m9Y2NygWuhxBU/1J+lXnRGEi/2wm
	 ulwP9PI6yYPQ4P53h8FyJiuj9PJ60bxpiPNxg2mk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727769AbgDHMFq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 08:05:46 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:44916 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726534AbgDHMFq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 08:05:46 -0400
Received: by mail-pl1-f195.google.com with SMTP id h11so2421558plr.11
        for <linux-kernel@vger.kernel.org>; Wed, 08 Apr 2020 05:05:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4xbq6aIfltEeB3nQ+J87gRF2/OBnuvcF5a/mkz8lZa4=;
        b=hp/oakz6tmv6+rUD2lIcQadafWKfpErgxCZiUjOd9jrB8v7MwmbLIU1LPQY9wrRDbg
         2zF7tZ7CyUpyPlZZRHvaFURvnylulQASTh+KE7qUThz6BTbn2ANmFg1Th1au3LM7Gb6s
         Qqfsczs9Ycuyup50OfPVs6sF3aMovtPCTBoP6Yk6USFObR0KOWYxkBHpVC3EjX1NkFVm
         +PC1JkR7o30PdWbg5z0m3x6wZNAkYcK2ubIiZryA/M4kYphtXTtPmWJMyW1ldtYQT2fx
         GxVaOrzly87xHWvAjv4yhuWLE8y3DtMaQmMcuvo4B+XPEvC4+Hd4A4QgBaFfnYwJwf+H
         f8lQ==
X-Gm-Message-State: AGi0PuZPPWb/PYRJyci7UNgvrLViGPp9OCmPjS3r3rOI2QZEsAVuaxbk
        X6mKlL8PHWC/gRMhYXwh0Nh0PfbeU8I=
X-Google-Smtp-Source: APiQypLOJe4ASWMMJpSvgh6wwihJqRwnPIUKxKPbnv9yfu5tOSwGtjskNA8VtheoTEaZnPGr8NtnYQ==
X-Received: by 2002:a17:90a:8c07:: with SMTP id a7mr902002pjo.67.1586347545247;
        Wed, 08 Apr 2020 05:05:45 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id f11sm3695780pfa.149.2020.04.08.05.05.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2020 05:05:42 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id 9EEEE40246; Wed,  8 Apr 2020 12:05:41 +0000 (UTC)
Date:   Wed, 8 Apr 2020 12:05:41 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: Export fw_get_builtin_firmware()?
Message-ID: <20200408120541.GH11244@42.do-not-panic.com>
References: <20200408094526.GC24663@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200408094526.GC24663@zn.tnic>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 08, 2020 at 11:45:26AM +0200, Borislav Petkov wrote:
> Hi guys,
> 
> so I've come across this recently where the microcode loader
> has a trivial helper get_builtin_firmware() which scans through
> the builtin firmware to find microcode in there. Looking at
> fw_get_builtin_firmware(), that one does practically the same so how
> about I export it and have the microcode loader use it instead of
> homegrowing the same thing?
> 
> IOW, something like this below?
> 
> If you agree with the approach, I'll split it properly into patches,
> etc, of course.

> diff --git a/drivers/base/firmware_loader/main.c b/drivers/base/firmware_loader/main.c
> index 76f79913916d..d0ad1ff0ce6d 100644
> --- a/drivers/base/firmware_loader/main.c
> +++ b/drivers/base/firmware_loader/main.c
> @@ -106,8 +106,8 @@ static void fw_copy_to_prealloc_buf(struct firmware *fw,
>  	memcpy(buf, fw->data, fw->size);
>  }
>  
> -static bool fw_get_builtin_firmware(struct firmware *fw, const char *name,
> -				    void *buf, size_t size)
> +bool fw_get_builtin_firmware(struct firmware *fw, const char *name, void *buf,
> +			     size_t size)

Yes please! Just a few things while you're at it.

Can you rename this to firmware_request_builtin() to match
the new style? And those users, can never be moduels can they?

And lastly, bonus points if you can add a respective test to
lib/test_firmware.c and tools/testing/selftests/firmware/ You'd need to
add a test dummy built-in firmware.

  Luis
