Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10F51C35E04
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 15:31:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAD5021744
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 15:31:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="SKyrGUWa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731128AbgBYPbR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 10:31:17 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:40366 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731033AbgBYPbQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 10:31:16 -0500
Received: by mail-pf1-f196.google.com with SMTP id b185so7349995pfb.7
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2020 07:31:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=VzT+Bi9aRcIzHGw33ls7K4ic9gdRd2ue48AE8Ckn9dY=;
        b=SKyrGUWa4UMK4lem3L5ao7gm5EwFg8zzQVwz4lVhuLmNLxggYbFhFp+9qvKw7Ocr4u
         eefBfQiK6VRs3kwbcGZxGik+foeRG2TkAWl28VLy8mOVivZWNOp+nmLcypOw2W3t7wS1
         Pc9+lfTQiqYNKJKNMfkCGUCUckJAoj+10idh8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VzT+Bi9aRcIzHGw33ls7K4ic9gdRd2ue48AE8Ckn9dY=;
        b=m9/n0d5fBggIy6vKv6Nswpyaizz13WWUtICfv5HCZgF9NSxYYSVh0vT/DrNGFNlwsO
         yJN1DPUNHdJ3P63CdJllTPHC1k4IUN98EVlKgHxrfR/69nR6nV2weXWZO/YrZa063423
         mq2PEm0gEWphfKwZIDEDHafgHPd8t6hdW5Q4yrPb/gnk5yl4AoyDu55AxKkW/IbcjBzj
         6H6F8ZrwhcV83m21g3jdZcn0EJmPoo6a5A3KqSh/c6HG6JFXczFRtYVZJflWIYIXI8BF
         vJTDeOAUryMYKKvYmpubKmjYwg6UbSx8ktoF8ZjhVxLjulok4MP56Acsud0AgN6jwcRx
         bw2w==
X-Gm-Message-State: APjAAAXB4MJxt+Q1GQPRjtgfqLDk3uRCk1XQi62BnvgL9jRXom1Z2cLS
        ukGRjSAvXbjxXFuUy8vhLNvPew==
X-Google-Smtp-Source: APXvYqz96aCOZJnivHeAhI3DTYBvj8Uq0Ew8+dU6teoDezYVy2LVzhSaLWTs/qKzU1bEWOQ1dEE9Dg==
X-Received: by 2002:a63:8c18:: with SMTP id m24mr60402523pgd.70.1582644675177;
        Tue, 25 Feb 2020 07:31:15 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id r62sm17947322pfc.89.2020.02.25.07.31.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2020 07:31:14 -0800 (PST)
Date:   Tue, 25 Feb 2020 07:31:13 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Casey Schaufler <casey@schaufler-ca.com>,
        KP Singh <kpsingh@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        James Morris <jmorris@namei.org>, bpf@vger.kernel.org,
        netdev@vger.kernel.org
Subject: Re: [PATCH bpf-next v4 3/8] bpf: lsm: provide attachment points for
 BPF LSM programs
Message-ID: <202002250730.62F9BD642A@keescook>
References: <20200220175250.10795-1-kpsingh@chromium.org>
 <20200220175250.10795-4-kpsingh@chromium.org>
 <0ef26943-9619-3736-4452-fec536a8d169@schaufler-ca.com>
 <202002211946.A23A987@keescook>
 <20200223220833.wdhonzvven7payaw@ast-mbp>
 <c5c67ece-e5c1-9e8f-3a2b-60d8d002c894@schaufler-ca.com>
 <20200224171305.GA21886@chromium.org>
 <00c216e1-bcfd-b7b1-5444-2a2dfa69190b@schaufler-ca.com>
 <202002241136.C4F9F7DFF@keescook>
 <20200225054125.dttrc3fvllzu4mx5@ast-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200225054125.dttrc3fvllzu4mx5@ast-mbp>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 24, 2020 at 09:41:27PM -0800, Alexei Starovoitov wrote:
> I'm proposing to rename BPF_PROG_TYPE_LSM into BPF_PROG_TYPE_OVERRIDE_RETURN.

Isn't the type used to decide which validator to use?

-- 
Kees Cook
