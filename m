Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33D14C43331
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 16:03:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08FE120737
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 16:03:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zl5mMF/H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728350AbgCZQDV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 12:03:21 -0400
Received: from mail-wr1-f46.google.com ([209.85.221.46]:46183 "EHLO
        mail-wr1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727670AbgCZQDU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 12:03:20 -0400
Received: by mail-wr1-f46.google.com with SMTP id j17so8397152wru.13;
        Thu, 26 Mar 2020 09:03:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=PuNByyv3siGkvbhEPycVCa/IKpHpjzZf/6rC1PXvGxA=;
        b=Zl5mMF/H1oqVlonG48JjLmrvN45dZOEwKZ01kOHvwsp/yg33B0FUmVnoNLfJXM25qJ
         wld3dnY6W3aTGLDFJl5pixXabyDddwsdLYl+jGK41vBDqdK0CVpocHANQJYtfeNMjn/c
         bKwt54lFgo7UuXf1TeFA0HC139CArdNXqlLd/gY+j724Bal5tBefdTFZ8lzAhJb+2Kkp
         Ox0KU2Z4CeFjzVcKvWTpub89N7gsZ4TGGeZbBZDZVvLDf0g0UBOJauNuKxtSBfHe43/L
         EW+2AIYeFrBzQnoLgo5rwOCXknuTPtDGI2Mss0q9HQlNra1VdgWlb5GcEwQh7abd9Lkb
         3wkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=PuNByyv3siGkvbhEPycVCa/IKpHpjzZf/6rC1PXvGxA=;
        b=IrnoVfXd59+CJnOnrYkD7nDICRLkUCcaCDSsszdUolzE1sYDYgbRx7dxu/HK3ESEFL
         o+nXRiQ+f3XcE+I7mHHBU4CA+LWOyxL3/hPRTJXFinBpTl9rzvO1OypBFA0kTdOnNtCL
         rXbgbErm1duelmWjUv4ZKUL34XjysqDtKOxf3AJFg811s1uvxSZwQtk3POZu4JjJ+z7M
         qUKhn5yxfctpG6t+7m9vzt4dXCFhs8tu34bRKVqG8OC/zwEKaDwl2v7tjH5hWkXTGwmb
         DiSzsYyFIanzsywx8TmAPF2HqialUbeEBPlTEYHNArnTVnTRDIVR02f2s0gI3pRwtj1j
         2WxQ==
X-Gm-Message-State: ANhLgQ3Es1vooS9JEgt5WtdRGqVB+csBDl1UBJkepokT3F+TnhWS9wXx
        UriO4V1rLILQAf7Hg4xK/biupCoc
X-Google-Smtp-Source: ADFU+vst6w9oQGmN5Epfx6vNxd+NzIylAwdJtZNvAk9/eq53r+Xok4rbrZH9juCGZr/2xuU+dI09Lg==
X-Received: by 2002:adf:b3d4:: with SMTP id x20mr9851913wrd.269.1585238598438;
        Thu, 26 Mar 2020 09:03:18 -0700 (PDT)
Received: from [192.168.1.125] (46-126-183-173.dynamic.hispeed.ch. [46.126.183.173])
        by smtp.gmail.com with ESMTPSA id h5sm4116253wro.83.2020.03.26.09.03.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Mar 2020 09:03:17 -0700 (PDT)
Subject: Re: [PATCH][next] drm/vmwgfx: fix spelling mistake "Cound" -> "Could"
To:     Colin King <colin.king@canonical.com>,
        VMware Graphics <linux-graphics-maintainer@vmware.com>,
        Thomas Hellstrom <thellstrom@vmware.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200326101911.241233-1-colin.king@canonical.com>
From:   Roland Scheidegger <rscheidegger.oss@gmail.com>
Message-ID: <d9ee5ec4-7341-decd-a382-3004fd367beb@gmail.com>
Date:   Thu, 26 Mar 2020 17:03:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Firefox/68.0 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <20200326101911.241233-1-colin.king@canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Am 26.03.20 um 11:19 schrieb Colin King:
> From: Colin Ian King <colin.king@canonical.com>
> 
> There is a spelling mistake in a DRM_ERROR error message. Fix it.
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c b/drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c
> index 367d5b87ee6a..2e61a4ecd8ef 100644
> --- a/drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c
> +++ b/drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c
> @@ -3037,7 +3037,7 @@ static int vmw_cmd_dx_bind_streamoutput(struct vmw_private *dev_priv,
>  	res = vmw_dx_streamoutput_lookup(vmw_context_res_man(ctx_node->ctx),
>  					 cmd->body.soid);
>  	if (IS_ERR(res)) {
> -		DRM_ERROR("Cound not find streamoutput to bind.\n");
> +		DRM_ERROR("Could not find streamoutput to bind.\n");
>  		return PTR_ERR(res);
>  	}
>  
> 

Reviewed-by: Roland Scheidegger <sroland@vmware.com>
