Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35FD3C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 17:23:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1392A20748
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 17:23:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KRp3sTQH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728751AbgHURXC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 13:23:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728943AbgHURWg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 13:22:36 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B10BDC061573
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 10:22:35 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id si26so3153341ejb.12
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 10:22:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=AdW4l4y+iM1qKY++z28/TOIdzKNyMZQl4ooaFmGHdfc=;
        b=KRp3sTQHUTn6VAQ4BNL2lYvDISsV0luB2w+t0clnejjXB0YBFEK5VoHLhoNohVByJ6
         rSE35q3h8yr78ks8vROz/Wnb0SSB8d1tYO+rzl7YqYYluBsK+UmIlU2D96Zm9yCQLmSb
         RcJynxEFjJfbW+WLozBNUTvUceq/2SrFSCAQXb/sKX9YdQ1o5IO5V8HEX6dKq018y0Jk
         xKfKNrDhhYgFhxmmdVFyhsLEBJ2Lujzb2UH1pk7ncfzPnLmHzMgE5arUhJL5Ewxs5wN3
         m4Nkg8JMA6ZQ8mbNazc9QkeVvM51/epDt0MxYY75HQ5hBwDMT3+J1PEyfpFbxKkRKGas
         YLLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=AdW4l4y+iM1qKY++z28/TOIdzKNyMZQl4ooaFmGHdfc=;
        b=LK1S+71W5v6mecrBLbakITHjpJpcaW3nytA/3iqYAoiW8SXnY5odxz/A6HWpqJGrI+
         OjXaobmn1u7uFE7Ma4fsJQc9jIXIIODXSYBSfLKKXpSHyQ3Uv+aHNps52L9jgiQa3Loc
         obiWGMeXoYu9ZYUQpZ04AHMroACFF3gVRHWtEDs+ETjnnTFIjrbhsA9g1Lodj39rL0G8
         X6x0qcNdY8ttLo5SigcdYH5X9w0GDVz5DvnfOTKE4ZCSxLOCTFF+xQIIbgFhobfY6qNy
         pvMCmF0VokjhqifiGeH0qvL6N1bdIGCZtRPhfl2kkJf/jw1cS+m+Bj46LtS6GXGgYSO6
         TXBg==
X-Gm-Message-State: AOAM533gZkJlgfq3+9sXLAoW0FAxRC6sFMqz3RTbPZOJDHHdEATgQbNp
        wgZlM3uXiEhxq8kyuV5jOCvbkxk6qQ==
X-Google-Smtp-Source: ABdhPJyitTVZvaquw76+P6PTIMJyeM7VTts9kg+6BWDyKkhRHM5MxsqtNJhTTZq+qtea9tZSYZY96w==
X-Received: by 2002:a17:906:a45:: with SMTP id x5mr3795801ejf.146.1598030554158;
        Fri, 21 Aug 2020 10:22:34 -0700 (PDT)
Received: from localhost.localdomain ([46.53.251.41])
        by smtp.gmail.com with ESMTPSA id a19sm1595830ejg.116.2020.08.21.10.22.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2020 10:22:33 -0700 (PDT)
Date:   Fri, 21 Aug 2020 20:22:31 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     daniel.diaz@linaro.org, linux-kernel@vger.kernel.org,
        rdunlap@infradead.org, sedat.dilek@gmail.com
Subject: make defconfig (Re: +
 x86-defconfigs-explicitly-unset-config_64bit-in-i386_defconfig.patch added
 to -mm tree)
Message-ID: <20200821172231.GA1444408@localhost.localdomain>
References: <20200820212940.Kq1ky-JHH%akpm@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200820212940.Kq1ky-JHH%akpm@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 20, 2020 at 02:29:40PM -0700, akpm@linux-foundation.org wrote:
> Subject: x86/defconfigs: Explicitly unset CONFIG_64BIT in i386_defconfig
> 
> A recent refresh of the defconfigs got rid of the following (unset)
> config:
> 
>   # CONFIG_64BIT is not set
> 
> Innocuous as it seems, when the config file is saved again the
> behavior is changed so that CONFIG_64BIT=y.
> 
> Currently,
> 
>   $ make i386_defconfig
>   $ grep CONFIG_64BIT .config
>   CONFIG_64BIT=y
> 
> whereas previously (and with this patch):
> 
>   $ make i386_defconfig
>   $ grep CONFIG_64BIT .config
>   # CONFIG_64BIT is not set

It is highly, highly, highly advisable to always pass ARCH when dealing
with 32/64-bit archs:

	+---------------------------------------+
	|	make ARCH=x86_64 defconfig	|
	|	make ARCH=i386 defconfig	|
	+---------------------------------------+

The reason is that long ago ARCH was deduced from bitness of the system
make was run on, so that

	make allnoconfig

gave 32-bit config on 32-but system and 64-bit on 64-bit system which is
natural thing to do.

During i386/x86_64 merge CONFIG_64BIT became user visible option!
" make allnoconfig" started giving 32-bit config even on x86_64 and 64-bit
defconfig and allmodconfig which it does to this day.

Always passing ARCH is the only way to maintain sanity. I have shell
alias to always pass ARCH=x86_64 so that bitness is both deterministic
and can be overridden.
