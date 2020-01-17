Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A40CEC33CB1
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 10:46:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79A2C2073A
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 10:46:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579257976;
	bh=2e9+N0hqL/50u6+X//maOUo2iUMLlVxVXjZBsTZFcCg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=W+fzqJd0MEpKmqtPoOYOFioFEimD4sXd/tcDzPZ2S7Z5TTb//+8XmDCs/n1APMymR
	 MAzmSOrCRpVOTn4RHO3XMz6MnO+1+sgnJgXvkTGLfi5z0THuyuYEOx7nqpNMo5FaDN
	 KHGgLPPPAQoX0L8NUNIu7KhMtaaFyutyM6KniyR8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726903AbgAQKqP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jan 2020 05:46:15 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:44420 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726196AbgAQKqP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 05:46:15 -0500
Received: by mail-lf1-f66.google.com with SMTP id v201so17957652lfa.11;
        Fri, 17 Jan 2020 02:46:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8jgHsmJwPHMIlC0HcDCT8ZD+TRcaXxlZELNYlF3LKZY=;
        b=pj0drvNwtZsKmxGu1XWnkVg0SV0yMeEnYeOdHirOL0/qsgDrfMEfbrLRDqNfQG8M2Z
         rySvklceeBcLvLdtczBvdxRcve4zX0M7WG1NLrG04tcQfwIWMuGewrCB9QW6qpbJkfOn
         SRyUNc/h9jePw+Wbp7EyDoCludOEGNAbIy/CYlZb2D/SYm/AWtoI/MEaWpRXrGELk6Ow
         QxEDt01C/rDD2NvvvHSoVweL3pF7xxhdsDAtjgl3/xlb1JWN+YHt4SrbXPHqJC3xVX9C
         2C8RdhSzTwByO1tk4vudDXHPl+m70bOL/jIn3xxyN8Y7pKctZAm8mpwhDZuVIRsr4w8r
         RFVg==
X-Gm-Message-State: APjAAAX0KJekWh6GI3OIRzCHZ+Cl0NN519WXd8WwrM5UCrJYaKJZ3kbp
        Rdoou/u9zOXjPqhsD+UeD23veozw
X-Google-Smtp-Source: APXvYqxi/K6htkK284Rv6M81KJynrrAskgHoyO/TVif8r0RPYjT4Zw4f1JU7qDM5J4LbQ3cBAca4gQ==
X-Received: by 2002:a19:7015:: with SMTP id h21mr4988560lfc.68.1579257973228;
        Fri, 17 Jan 2020 02:46:13 -0800 (PST)
Received: from xi.terra (c-14b8e655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.184.20])
        by smtp.gmail.com with ESMTPSA id t10sm12066002lji.61.2020.01.17.02.46.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2020 02:46:12 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.92.3)
        (envelope-from <johan@kernel.org>)
        id 1isP8m-0001ib-2d; Fri, 17 Jan 2020 11:46:12 +0100
Date:   Fri, 17 Jan 2020 11:46:12 +0100
From:   Johan Hovold <johan@kernel.org>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] USB: serial: garmin_gps: Use flexible-array member
Message-ID: <20200117104612.GT2301@localhost>
References: <20200116220327.GA12537@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200116220327.GA12537@embeddedor.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 16, 2020 at 04:03:27PM -0600, Gustavo A. R. Silva wrote:
> Old code in the kernel uses 1-byte and 0-byte arrays to indicate the
> presence of a "variable length array":
> 
> struct something {
>     int length;
>     u8 data[1];
> };
> 
> struct something *instance;
> 
> instance = kmalloc(sizeof(*instance) + size, GFP_KERNEL);
> instance->length = size;
> memcpy(instance->data, source, size);
> 
> There is also 0-byte arrays. Both cases pose confusion for things like
> sizeof(), CONFIG_FORTIFY_SOURCE, etc.[1] Instead, the preferred mechanism
> to declare variable-length types such as the one above is a flexible array
> member[2] which need to be the last member of a structure and empty-sized:
> 
> struct something {
>         int stuff;
>         u8 data[];
> };
> 
> Also, by making use of the mechanism above, we will get a compiler warning
> in case the flexible array does not occur last in the structure, which
> will help us prevent some kind of undefined behavior bugs from being
> unadvertenly introduced[3] to the codebase from now on.
> 
> [1] https://github.com/KSPP/linux/issues/21
> [2] https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
> [3] commit 76497732932f ("cxgb3/l2t: Fix undefined behaviour")
> 
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Applied, thanks.

Johan
