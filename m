Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E90BC47255
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 23:16:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F71F20675
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 23:16:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JHg/0IjD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727969AbgEKXQ6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 19:16:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725828AbgEKXQ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 19:16:57 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8764C061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 16:16:57 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id fu13so8481741pjb.5
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 16:16:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=TyQ+88CfrBEczIT0Dd6n6ZbeE4ol8PzNiSvfm5+kLJU=;
        b=JHg/0IjD7o3QPrAqxokoSFbk/QwW4JofsG45d+APkRNW/YJJedD1NIj4FJBSZWSEvw
         wok+avpYAAXxcqo0SoeTraia5guUYkdGPtH71Yzl9rnbfdF5X6E71jswAIkrKuEIehzQ
         pvmZuSFh/oQLZ1A5h9owaBTTgWB89Agkdsuf0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=TyQ+88CfrBEczIT0Dd6n6ZbeE4ol8PzNiSvfm5+kLJU=;
        b=AXIzbjA/Z+bSSjViEhMCDPjsZAxbhmy6WQPGl5zjkpppVF/kmzvGqs692NuA8YK0tF
         g/NpgJ+vgK5xLF+kbuu/kbIX6A61M4joUKKSLrc1bmETAxE3UVQXeXhRDxKpUmsFAGVS
         pxUtSVZOIUAqmlAbWuD9a1fh8QACMczPfdK6qBeKflIf/IelwUjWj6mx/ZD1awqLvbP2
         VSm3j6rzrzhmZY/jmrK+HO3wVg2GZ00VyPkQE81fMp9xiE8LS7Dj3TQfETjy1eBl+iHG
         3q04vQqBSafZV5i3I0bNXyHQiiycVftrfXCgaBAGTT/6rFJSE9VCyuYqOYZpXzlpySKO
         goyQ==
X-Gm-Message-State: AGi0PuYDUc4XV+I4Zfncl8Hx8C8VAeeuR1CInGQexvmsqUd6Lh6dWIrd
        aKwXKrERJ664b0j1nF+dnMqR+w==
X-Google-Smtp-Source: APiQypJbYkw3p9y1o6N+5NhKARjk7xl5lEcqdm0v+m00BfXaZfzyPSUnPFzAd1fH1+muoyFt2kCyaQ==
X-Received: by 2002:a17:902:a40e:: with SMTP id p14mr14257516plq.0.1589239017355;
        Mon, 11 May 2020 16:16:57 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id v10sm8920337pjy.48.2020.05.11.16.16.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2020 16:16:56 -0700 (PDT)
Date:   Mon, 11 May 2020 16:16:55 -0700
From:   Kees Cook <keescook@chromium.org>
To:     WeiXiong Liao <liaoweixiong@allwinnertech.com>
Cc:     Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Rob Herring <robh@kernel.org>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org
Subject: Re: [PATCH v7 17/18] mtd: Support kmsg dumper based on pstore/blk
Message-ID: <202005111616.CA0264F876@keescook>
References: <20200510202436.63222-1-keescook@chromium.org>
 <20200510202436.63222-18-keescook@chromium.org>
 <59ef2812-93ad-9f8c-81cc-458128a6fb46@allwinnertech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <59ef2812-93ad-9f8c-81cc-458128a6fb46@allwinnertech.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 11, 2020 at 05:01:26PM +0800, WeiXiong Liao wrote:
> On 2020/5/11 AM 4:24, Kees Cook wrote:
> > [...]
> > +	if (strlen(info->device) == 0) {
> > +		dev_err(&mtd->dev, "mtd device must be supplied\n");
> 
> mtd is NULL here, "mtd->dev" leads to error.
> 
> > +		return -EINVAL;
> > +	}
> > +	if (!info->kmsg_size) {
> > +		dev_err(&mtd->dev, "no backend enabled\n");
> 
> Also here.

Thanks! Fixed.

-- 
Kees Cook
