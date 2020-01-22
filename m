Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22BE2C33CAF
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 01:54:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECFCD2253D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 01:54:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="lUi4mdfg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728809AbgAVByR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 20:54:17 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:41254 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726396AbgAVByQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 20:54:16 -0500
Received: by mail-pg1-f196.google.com with SMTP id x8so2541421pgk.8
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jan 2020 17:54:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=1XK4Ony62q0qYCnmXBgxpfnUcnSnUtNFwu//NBpHxT4=;
        b=lUi4mdfgEh6SrLHZeN6m78Vcslz6pj9bZ2sQ97+imdXSrxlCUfAqG/IUH4+u9gsNWm
         +T0PisZcqv8v/pyXOCWR5sIIf9cwBFXnHhi6ABzhld1+WTWUEJTI/4+oo2t25Kmd7Nzb
         PDkWFhMk3szstmlduOoko+QJclNvx4quL/rqbkHMdciWp5iqb5bZtmIHEYIGKWxK3WlB
         P/dONJXy8T+NCMvrgD/HsdegKjrIcdv44fVedH/8DAIUwFIWlu/23GRgQleAvTCwq6PK
         eEbRNbp8zp6CB1BPQfHedLnWl3W7sJY/5Wr5jSdAguuolCY8O9ta/8WcpTgorMtu7EbU
         ukpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1XK4Ony62q0qYCnmXBgxpfnUcnSnUtNFwu//NBpHxT4=;
        b=Uj3quEWptf31i49mdjU9dxR4AxAJjvWuWWxST4S6/+gPlbMekpYgQeO4n6MrwN/tcV
         wFKjt/uF3/KhBr3ly8V+A1Yy1NGGcudmhc2JLjtZpht0sTBvC/JkXLNo4TyYWMD8B2yg
         5M1S6anmaN2NiGiESHM2fazjV3+W9oYLnJ5OjagH1ybqXA4vp+giCcUT/87dEC8k/B7g
         plwdkPaYmScHCsp3KNPN+1I+INPCGZ08emxX2+niYw2nsf6WNTek3adW0tyfBAlK/D8X
         FTlYDUakdLg63gFpg5TGwlhjuBPIxJXbS1tx5diA/TYPi6rdVaWJ6IpYPm0x5IHUgj7w
         oekA==
X-Gm-Message-State: APjAAAVlWwrLiuzMXQNfxpcnbpDsse18j8Ozb0E4x6dWWTxnUa86bRLN
        dAHd7GlwZ1Mbp3ypcUA0Hv89yg==
X-Google-Smtp-Source: APXvYqyHPZGoI0DOJX188jpo4oSvQ7q0zhBrnRPd+20XuSAAKqHU+Ag8LXQUVUpyVPb6gNP1OuIwwg==
X-Received: by 2002:a62:6805:: with SMTP id d5mr414576pfc.125.1579658056278;
        Tue, 21 Jan 2020 17:54:16 -0800 (PST)
Received: from [192.168.1.188] ([66.219.217.145])
        by smtp.gmail.com with ESMTPSA id x18sm45635790pfr.26.2020.01.21.17.54.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jan 2020 17:54:15 -0800 (PST)
Subject: Re: [PATCH 2/3] io_uring: add interface for getting files
To:     Pavel Begunkov <asml.silence@gmail.com>, io-uring@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>
References: <cover.1579649589.git.asml.silence@gmail.com>
 <96dc9d5a58450f462a62679e67db85850370a9f6.1579649589.git.asml.silence@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <74320473-6f9f-7b10-4d5c-850c6f3af5ae@kernel.dk>
Date:   Tue, 21 Jan 2020 18:54:14 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <96dc9d5a58450f462a62679e67db85850370a9f6.1579649589.git.asml.silence@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/21/20 5:05 PM, Pavel Begunkov wrote:
> Preparation without functional changes. Adds io_get_file(), that allows
> to grab files not only into req->file.
> 
> Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
> ---
>  fs/io_uring.c | 66 ++++++++++++++++++++++++++++++++-------------------
>  1 file changed, 41 insertions(+), 25 deletions(-)
> 
> diff --git a/fs/io_uring.c b/fs/io_uring.c
> index 8f7846cb1ebf..e9e4aee0fb99 100644
> --- a/fs/io_uring.c
> +++ b/fs/io_uring.c
> @@ -1161,6 +1161,15 @@ static struct io_kiocb *io_get_req(struct io_ring_ctx *ctx,
>  	return NULL;
>  }
>  
> +static inline void io_put_file(struct io_ring_ctx *ctx, struct file *file,
> +			  bool fixed)
> +{
> +	if (fixed)
> +		percpu_ref_put(&ctx->file_data->refs);
> +	else
> +		fput(file);
> +}

Just make this take struct io_kiocb?

Apart from that, looks fine to me.

-- 
Jens Axboe

