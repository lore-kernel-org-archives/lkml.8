Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F6BEC47255
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 07:16:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C75F207FF
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 07:16:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ARv0i9td"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728283AbgEKHNn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 03:13:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725790AbgEKHNn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 03:13:43 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF749C061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 00:13:41 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id w7so9478241wre.13
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 00:13:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=Y+m1+88vta6t6T1bNmdonazRxtCTnn6KS1AKX4CzntQ=;
        b=ARv0i9tdIXTUc/sI7bd/zEPKnRNVNV7vH5x83ejR9lG62qT6YTHudPH4qqBR87HtWd
         fPTdzJ8zhes261ta3+/GhykOlOcnn3SXZnx5RhR9bxuxNYc0/QEuOKzbKAdMwr6A5dRQ
         hfRE3c9quaQjZ9yw9GV138xpAt3RAlXERLGKqJhFBywAiTKtgbSGQrR4PJQyZbNTJcaI
         tQ48EJsRmyDdTDuiTCUYDCtyCyDzj/OGbEZdQTu+myY3NhXATfCu7KcNCnTDmV7TjCBA
         aC1hdIrZ3R4ig4PEeK56Xrxmp+Azl63tBPNRpHhfSSlb8XgDmz8gfpTLNB1A14nevVgc
         s2/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=Y+m1+88vta6t6T1bNmdonazRxtCTnn6KS1AKX4CzntQ=;
        b=LrTdJK4n8cdyoXjm6oZc//5mcMovSD4NVf9OOhBfb1+IPagsPEXHQjg4wQUTv4zbMY
         BZlRJjNapdSULqXPayfmrdqCI0fGHbFzuiIlVvrRQ35JgT3zEwfoKlMnoBdoqg9UYtSR
         qyxwdf3HiSED+LMBJZiKKccPP1zSFN/anJJ3JvBzgfSeWKhfiPxTDyiLW+uWXw1yU3sA
         fv7EXkyJ2cHkqA3nLEc2kmZfUKsqmZHubZ8gxq3QqctMl/eGkwQDBR9oeXWgvhzu3e+e
         1MpcEBXp/QNZ10bFQMlcTOqCd9fArGMzgwxn+U3uUBeJG4e8L9r7T+mrffKYZSWrWEty
         2FNg==
X-Gm-Message-State: AGi0Pua2vjfWNT4vE6XLtn4Rf+7/6zCsgroUMYCdvvj+VUYq4lqjsYeZ
        pcowd6nqh+QhprJV9GdBLnyADmyB
X-Google-Smtp-Source: APiQypI+mVuTDIlldwCA8VYde10V3aXrvi+qtZPtYn8oZz3vMBHjweMr3wC+fEETG78OPTOp5P/71w==
X-Received: by 2002:a5d:53c7:: with SMTP id a7mr2066825wrw.334.1589181220319;
        Mon, 11 May 2020 00:13:40 -0700 (PDT)
Received: from akira-laptop.home ([2a01:cb19:8b28:7600:a0b9:1c6f:cfba:2b21])
        by smtp.gmail.com with ESMTPSA id c16sm15553540wrv.62.2020.05.11.00.13.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2020 00:13:39 -0700 (PDT)
Message-ID: <6ad0616ecc6ec6ecf4622eca878ba7e7c52c475e.camel@gmail.com>
Subject: Re: [PATCH v6 5/9] w1_therm: adding resolution sysfs entry
From:   Akira shimahara <akira215corp@gmail.com>
To:     Randy Dunlap <rdunlap@infradead.org>, greg@kroah.com
Cc:     zbr@ioremap.net, linux-kernel@vger.kernel.org
Date:   Mon, 11 May 2020 09:13:38 +0200
In-Reply-To: <7eb90dc8-2924-4c24-e305-5424c5953164@infradead.org>
References: <20200510141707.173273-1-akira215corp@gmail.com>
         <7eb90dc8-2924-4c24-e305-5424c5953164@infradead.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.2 (3.36.2-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Le dimanche 10 mai 2020 à 20:25 -0700, Randy Dunlap a écrit :
> Hi,
> 
> 
> 
> The kernel-doc comment changes look good.  Thanks for doing that.
> 
> 
> 
> 
> 
> On 5/10/20 7:17 AM, Akira Shimahara wrote:
> 
> 
> 
> > diff --git a/drivers/w1/slaves/w1_therm.c
> > b/drivers/w1/slaves/w1_therm.c
> > index 08579dc..b1734ae 100644
> > --- a/drivers/w1/slaves/w1_therm.c
> > +++ b/drivers/w1/slaves/w1_therm.c
> > @@ -50,12 +50,24 @@ module_param_named(strong_pullup,
> > w1_strong_pullup, int, 0);
> >   
> >   /* Helpers Macros */
> >   
> > +/* return a pointer on the slave w1_therm_family_converter struct:
> > + * always test family data existence before
> > + */
> 
> 
> /*
> 
>  * Kernel multi-line comment coding style (except for networking
> source code)
> 
>  * is like this.
> 
>  */
> 
> 
> 
> (in multiple places)
> 
> 
> 
> > +/**
> > + * write_scratchpad() - write nb_bytes in the device RAM
> > + * @sl: pointer to the slave to write in
> > + * @data: pointer to an array of 3 bytes, as 3 bytes MUST be
> > written
> > + * @nb_bytes: Nb bytes to be written (2 for DS18S20, 3 for other
> > devices)
> 
> 
> If Nb means Number, please spell it out.
> 
> 
> 
> > + *
> > + * Return: 0 if success, -kernel error code otherwise
> > + */
> > +static int write_scratchpad(struct w1_slave *sl, const u8 *data,
> > u8 nb_bytes);
> > +
> >   /**
> >    * read_powermode() - Query the power mode of the slave
> >    * @sl: slave to retrieve the power mode
> 
> 
> 
> 
> thanks.
> 
> --
> 
> ~Randy

Thanks for your comments and your time,
well noted, I will do
accordingly.

Akira Shimahara

