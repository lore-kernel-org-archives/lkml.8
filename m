Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1A5CC3F2CD
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 12:58:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 766C52072D
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 12:58:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="td74DyrH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726220AbgCEM6t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 07:58:49 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:51556 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726079AbgCEM6t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 07:58:49 -0500
Received: by mail-wm1-f68.google.com with SMTP id a132so6196780wme.1
        for <linux-kernel@vger.kernel.org>; Thu, 05 Mar 2020 04:58:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=DYfkE0ncKgeiIEFcrfqOPuwYh3P/dXWNU13hXGL/1nY=;
        b=td74DyrH81gxnb6eV9aGEpFkClWOS9/E+DhX4rcZqxxw/u7t8bmRV2m0tnCtDXIDV4
         /O3OXSBn4Z4zRBeft/Fc/rMkp5jnrL0fAppkzdX3pQVeivMpfko0jiM3or+kS2KO6mh5
         rQOagr5n5erjIDwLKOUPCkljc1R562YO3a3qM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=DYfkE0ncKgeiIEFcrfqOPuwYh3P/dXWNU13hXGL/1nY=;
        b=p3KZvbbVVyQAlS2fZ3J4kYh6vGxQRiYLGZ3tYZxLVaGTp8OHHJLMpd/oZkcGm2hGjl
         ICebrUpQB5bpuiTHd3EseJyulkltBFd5JzvNHo8u9GQcxTKt/VGZBfLcyjp+3hTuvZKG
         59n/JLMcBWhWCA2MLK3bqf+KgxDyWRrjkiyGfuXyNBtxbNDrMGG1EHlh/9llEMoiV1Gg
         FLLKo3OsR8s1rZv+Bs2d+qb6n78hWYVq686Ive3u5yh7lbWE1JXUWFhjIW+ZTGCI+xsh
         ZFCMmmze9Sv1S2bsGCgxDVyCnvsmqFM9i45Dz1q1lrZZrPib6PiUvSqwjQpZW/FqAWei
         r3og==
X-Gm-Message-State: ANhLgQ1JlEv/fvyXl7GmQYoTWfoyTd5bTuRCf1fxnyE3dHF5UvI4CHyM
        /VXlgq0L4MSsuJawOe1t5aEeDA==
X-Google-Smtp-Source: ADFU+vt55nZ9BZ8YtU7c3+AI5KJ0LWKvjV0O6TS2oAfk+AP4ij4qmtEllGiuHScjABOTfyVX66gJyg==
X-Received: by 2002:a7b:c414:: with SMTP id k20mr9064848wmi.182.1583413126033;
        Thu, 05 Mar 2020 04:58:46 -0800 (PST)
Received: from cloudflare.com ([176.221.114.230])
        by smtp.gmail.com with ESMTPSA id o5sm9674246wmb.8.2020.03.05.04.58.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2020 04:58:45 -0800 (PST)
References: <20200304101318.5225-1-lmb@cloudflare.com> <20200304101318.5225-13-lmb@cloudflare.com>
User-agent: mu4e 1.1.0; emacs 26.3
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     Lorenz Bauer <lmb@cloudflare.com>
Cc:     john.fastabend@gmail.com, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        kernel-team@cloudflare.com, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH bpf-next v3 12/12] bpf, doc: update maintainers for L7 BPF
In-reply-to: <20200304101318.5225-13-lmb@cloudflare.com>
Date:   Thu, 05 Mar 2020 13:58:44 +0100
Message-ID: <875zfjyn3v.fsf@cloudflare.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 04, 2020 at 11:13 AM CET, Lorenz Bauer wrote:
> Add Jakub and myself as maintainers for sockmap related code.
>
> Signed-off-by: Lorenz Bauer <lmb@cloudflare.com>
> Acked-by: John Fastabend <john.fastabend@gmail.com>
> ---
>  MAINTAINERS | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index b2fae56dca9f..0b570b3b46d1 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -9352,6 +9352,8 @@ F:	include/net/l3mdev.h
>  L7 BPF FRAMEWORK
>  M:	John Fastabend <john.fastabend@gmail.com>
>  M:	Daniel Borkmann <daniel@iogearbox.net>
> +M:	Jakub Sitnicki <jakub@cloudflare.com>
> +M:	Lorenz Bauer <lmb@cloudflare.com>
>  L:	netdev@vger.kernel.org
>  L:	bpf@vger.kernel.org
>  S:	Maintained

Reviewed-by: Jakub Sitnicki <jakub@cloudflare.com>
