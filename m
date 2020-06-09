Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8271AC433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 15:42:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B221207ED
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 15:42:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="EFmTQSNt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730889AbgFIPmQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 11:42:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728533AbgFIPmO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 11:42:14 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FCB2C05BD1E
        for <linux-kernel@vger.kernel.org>; Tue,  9 Jun 2020 08:42:14 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id w20so10463614pga.6
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jun 2020 08:42:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=UdPQIe/td55auw0us8ClJOZgo9JTMMfzqiY2jJ/gIzc=;
        b=EFmTQSNt9rLVA8xD54R57r9jXkmFaC5/q4b+aIlVZIb91XKe2mP5sZ6tYEG5sJ9uov
         W1Juv+IBPMmRFXmqwHDmkjUZYFUcv2dP3Y6dulatZ/E8P4wdrfh4dZOzRvC0xRVQcj1S
         LambSOcbc3AikwJg2p1+iCtNppzABU12NinqQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UdPQIe/td55auw0us8ClJOZgo9JTMMfzqiY2jJ/gIzc=;
        b=N/xIcbgHN8vCBVJfZxpZ2xrPfn+qzD2X630ldIj8gEPp13VjVpa30W4vu2zvQ6ll2D
         +LupersHo3PVRhJslFb+8SElnlJ5nrKJxFdz7Jm8FRRfiYjJUOeus2g+G/JO4y5UATPG
         b0DKqEx05b25Pf9G2tfRPUTzpJM7B+Fa8bDjzxSrnGlxeYQdNEYx52r8aiJaXhxrpoEF
         Y8141TzyV8WiIdl4RItFjFFKimfoWqI3JFMpU7pnXoHKDiABRuXZVnPnJhXrcJIIEulu
         HV6D1k8IsaXhnmWxggevjrM+tsM7XvJb1VOyWR8bbvOASbbx+Us1c1NW3lwEJuYJhLC2
         xiWw==
X-Gm-Message-State: AOAM533CHZbnPOe4fqv3BZigjc/Idjn8gdYYm1ttj7Om+Dm730fJnEBU
        WlPRFdZxOfydbFYxqMc5sVHaZQ==
X-Google-Smtp-Source: ABdhPJwDLPLgRwX/5YiOAWiSwfAnQNixgv/Z2SNb1uOLQRZJdt/7e9WNPMwlJCtPpMCSpJdfNnZybw==
X-Received: by 2002:a63:6dc9:: with SMTP id i192mr22610589pgc.402.1591717333630;
        Tue, 09 Jun 2020 08:42:13 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id t2sm8929682pgh.89.2020.06.09.08.42.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2020 08:42:12 -0700 (PDT)
Date:   Tue, 9 Jun 2020 08:42:11 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Joe Perches <joe@perches.com>
Cc:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: Re: [PATCH v2] overflow.h: Add flex_array_size() helper
Message-ID: <202006090841.83B5989A9@keescook>
References: <20200609012233.GA3371@embeddedor>
 <e32b0a42aa00c20ef3868edd987c39a95ba68e95.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e32b0a42aa00c20ef3868edd987c39a95ba68e95.camel@perches.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 08, 2020 at 11:47:03PM -0700, Joe Perches wrote:
> On Mon, 2020-06-08 at 20:22 -0500, Gustavo A. R. Silva wrote:
> > Add flex_array_size() helper for the calculation of the size, in bytes,
> > of a flexible array member contained within an enclosing structure.
> []
> > diff --git a/include/linux/overflow.h b/include/linux/overflow.h
> []
> > +/**
> > + * flex_array_size() - Calculate size, in bytes, of a flexible array member
> > + * within an enclosing structure. Read on for more details.
> 
> IMO: "Read on for more details" isn't useful here.
> Perhaps better would be something like:
> 
>  * flex_array_size() - size of a flexible array (sizeof(typeof(member)) * count)
> 
> > + *
> > + * @p: Pointer to the structure.
> > + * @member: Name of the flexible array member.
> > + * @count: Number of elements in the array.
> > + *
> > + * Calculates size, in bytes, of a flexible array @member of @count elements
> 
> IMO: "in bytes, " is redundant.  size is always bytes.

While yes, that's the expected unit, I don't mind the clarification
given that we want to be distinct from "count" and the size of an
individual array element.

-- 
Kees Cook
