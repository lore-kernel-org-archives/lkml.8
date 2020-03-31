Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0652C2D0F0
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 22:40:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9391720787
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 22:40:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="VDiCMTXy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731420AbgCaWk1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 18:40:27 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:44554 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729153AbgCaWk1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 18:40:27 -0400
Received: by mail-wr1-f67.google.com with SMTP id m17so28186423wrw.11
        for <linux-kernel@vger.kernel.org>; Tue, 31 Mar 2020 15:40:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=jY5b0DeIGw0kq+dmH/vJgCrU2SOoRk0fZBuTs/xmVo0=;
        b=VDiCMTXyKUNt4iheUBH8m+6xsiIx/rgJTGicdZ/BWJF7GmTfsrCY7g+447EMzve3aq
         Y+ldUezP4BlAWoR5IQfLpc6iFnWWr1G6v9bb02zEQLrKSg4qsJ4HrBuw7+exNKd9bAfU
         jdqJY5s8D3nIc5Tz5vqTofy5j8BNQJ7duYeCA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jY5b0DeIGw0kq+dmH/vJgCrU2SOoRk0fZBuTs/xmVo0=;
        b=p/zNUrASDXHcKTw9Xgda9GvHn0El3yimMO9O9w1l4fQOXYjwUYj1O+nRM7hlr1GC0D
         R1bsPOfQk/jtSYdTSMLe9JZmWtVncB+4H4R1JYMw3YcP/r3uWXqpXJELQIrvLBBctFpp
         gA6rDggdRq6Ia8DqmtUNBF4yd5u3DkNDx9RJVtXSdihU4S5l+ge9TJrmpf6Iw2JVGOg7
         9azPZ+G8chc7iMH/OcfHN3Jhe47qacwj+t8RlQL89Ym6Orus9rOiZ3Ux4H1Klf/DwlcP
         RheWiEHQcZvEsjvME9ZgpWRIxpOc7wb27MP7cKWHaA8a0IzdZBlMVqRiJNRLf4+9+CtJ
         7DIg==
X-Gm-Message-State: AGi0PuZ6SJ3SS7ytRd1wcsjbh+P5NMEp6dqwwyAkFJqzZWejTER1joRR
        NhRtV723P4h3EqqbPT8r2zTOUCr9CuM=
X-Google-Smtp-Source: APiQypLOGvUileQhr35EVvXv/b90kFXVu0uzau9TlILC3ZUR48htnauWq/BaHsz4upygp1gntHv0QA==
X-Received: by 2002:adf:fe52:: with SMTP id m18mr976140wrs.162.1585694424872;
        Tue, 31 Mar 2020 15:40:24 -0700 (PDT)
Received: from google.com ([2a00:79e0:42:204:8a21:ba0c:bb42:75ec])
        by smtp.gmail.com with ESMTPSA id 138sm79981wmb.21.2020.03.31.15.40.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2020 15:40:24 -0700 (PDT)
From:   KP Singh <kpsingh@chromium.org>
X-Google-Original-From: KP Singh <kpsingh>
Date:   Wed, 1 Apr 2020 00:40:22 +0200
To:     Slava Bacherikov <slava@bacher09.org>
Cc:     andriin@fb.com, keescook@chromium.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, jannh@google.com,
        alexei.starovoitov@gmail.com, daniel@iogearbox.net,
        kernel-hardening@lists.openwall.com,
        Liu Yiding <liuyd.fnst@cn.fujitsu.com>
Subject: Re: [PATCH v2 bpf] kbuild: fix dependencies for DEBUG_INFO_BTF
Message-ID: <20200331224022.GA23586@google.com>
References: <20200331215536.34162-1-slava@bacher09.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200331215536.34162-1-slava@bacher09.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01-Apr 00:55, Slava Bacherikov wrote:
> Currently turning on DEBUG_INFO_SPLIT when DEBUG_INFO_BTF is also
> enabled will produce invalid btf file, since gen_btf function in
> link-vmlinux.sh script doesn't handle *.dwo files.
> 
> Enabling DEBUG_INFO_REDUCED will also produce invalid btf file, and
> using GCC_PLUGIN_RANDSTRUCT with BTF makes no sense.
> 
> Signed-off-by: Slava Bacherikov <slava@bacher09.org>
> Reported-by: Jann Horn <jannh@google.com>
> Reported-by: Liu Yiding <liuyd.fnst@cn.fujitsu.com>
> Fixes: e83b9f55448a ("kbuild: add ability to generate BTF type info for vmlinux")

I can say that I also got invalid BTF when I tried using
DEBUG_INFO_REDUCED.

So here's a first one from of these from me :)

Acked-by: KP Singh <kpsingh@google.com>

> ---
>  lib/Kconfig.debug | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index f61d834e02fe..9ae288e2a6c0 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -223,6 +223,7 @@ config DEBUG_INFO_DWARF4
>  config DEBUG_INFO_BTF
>  	bool "Generate BTF typeinfo"
>  	depends on DEBUG_INFO
> +	depends on !DEBUG_INFO_SPLIT && !DEBUG_INFO_REDUCED && !GCC_PLUGIN_RANDSTRUCT
>  	help
>  	  Generate deduplicated BTF type information from DWARF debug info.
>  	  Turning this on expects presence of pahole tool, which will convert
> -- 
> 2.24.1
> 
