Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 177F2C2D0F8
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 19:44:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E476A206DD
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 19:44:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="PXb1v9IS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731082AbgELTo3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 15:44:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728081AbgELTo2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 15:44:28 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74F74C061A0E
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 12:44:28 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id u35so3653632pgk.6
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 12:44:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=DBhE+bHXP5zrV91t92AV1x7apzTWyzN424aYc5YNfWg=;
        b=PXb1v9IS/OL5cX7Bsw8OKUXEAAg3UGRT+IO9saYbsZLXygtycRHvu1AmhWYJuN5SnN
         HMv2wzHcr7yAYKt4zrainQLFXtdP3FUj0XgbE24JTleE5ovZKHgPTv9fRRNS2lsADErm
         9FFpr88LUFS4jkmqQRpZPl9/IwzQSn+YH2YEE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=DBhE+bHXP5zrV91t92AV1x7apzTWyzN424aYc5YNfWg=;
        b=Q7utJkscrwzXdP4umEOWuukagCEN2iU9Tmxc383hl+/w5C8wthjMJr2IqghqGWhXxg
         rNBTGU44JbkJp4mO0bKHCiKQGv9yqcSRCyj/cjOSbwNhbLloVllqKhWassO0zHO9JCee
         lD/1NgwUjwJB6CgssjOzlG0KQphxiOAVsEGapBm6smiKKv1ymngppwNCl2NW7jgAk/ya
         tAsuUq9n6x6SKXYYINTCrzn+qLJ2ZxSP5cQYEFN5xYuRQi8Mj+OT9jgTxYxwXzxG03Z2
         y64qixaJCk6rDw7ZaE+acZQ0LU3YMvZ1XuzHIcb+igh8g1vBTF8hO+HN4OA5PUZN9SXa
         Kn6A==
X-Gm-Message-State: AOAM53331c25/HMaybAG10fMyasi4bhecefSX9oD+F4eGRm7SRf4oY0q
        +IBwJT0JW2cpNtGJUpbiOF+KHg==
X-Google-Smtp-Source: ABdhPJwpe3nOv6RiywTAma2C9/wcHumGJ8VS3qWE7oUMdxQmXUNg5rmOFCYxnJjbkKS69HE+a0AWZg==
X-Received: by 2002:aa7:8ad0:: with SMTP id b16mr3033296pfd.129.1589312668034;
        Tue, 12 May 2020 12:44:28 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id fu12sm13524369pjb.20.2020.05.12.12.44.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2020 12:44:27 -0700 (PDT)
Date:   Tue, 12 May 2020 12:44:26 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Petr Mladek <pmladek@suse.com>
Cc:     WeiXiong Liao <liaoweixiong@allwinnertech.com>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Rob Herring <robh@kernel.org>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org
Subject: Re: [PATCH v7 07/18] printk: Introduce kmsg_dump_reason_str()
Message-ID: <202005121244.874D7C52@keescook>
References: <20200510202436.63222-1-keescook@chromium.org>
 <20200510202436.63222-8-keescook@chromium.org>
 <20200512084441.GD17734@linux-b0ei>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200512084441.GD17734@linux-b0ei>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 12, 2020 at 10:44:42AM +0200, Petr Mladek wrote:
> On Sun 2020-05-10 13:24:25, Kees Cook wrote:
> > The pstore subsystem already had a private version of this function.
> > With the coming addition of the pstore/zone driver, this needs to be
> > shared. As it really should live with printk, move it there instead.
> > 
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> 
> I looked only at this printk part and it looks good to me ;-)
> 
> Acked-by: Petr Mladek <pmladek@suse.com>

Excellent; thanks!

-- 
Kees Cook
