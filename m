Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 123AEC10DCE
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 10:40:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0F7A206BE
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 10:40:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aMq35+Ej"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726871AbgCLKkp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 06:40:45 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:30418 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725978AbgCLKko (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 06:40:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584009643;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Tq0ulOygpiuzF7J6PhCS00wRKj0wnRcrsFL7zpzSoFk=;
        b=aMq35+EjHODEHuXXxrVIiRi23cvwhqnVfpojLYLZZwcxEuu5Pj5xgiGWj1TGK4U1U5e9F2
        Ege44mgk2wN9SVtpNZ+OXSJHsve0uzorIEGonBDEJ43wBOQI26FeZ+f/3V8od5JfZFN/bj
        i8bz+pu6vU07kHMA+v9ARdjXkuQfiB8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-182-Viv-ozaEMl2zNiQ8Mfl8ww-1; Thu, 12 Mar 2020 06:40:42 -0400
X-MC-Unique: Viv-ozaEMl2zNiQ8Mfl8ww-1
Received: by mail-wr1-f69.google.com with SMTP id i7so2414838wru.3
        for <linux-kernel@vger.kernel.org>; Thu, 12 Mar 2020 03:40:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Tq0ulOygpiuzF7J6PhCS00wRKj0wnRcrsFL7zpzSoFk=;
        b=qc5rgCHrusyOQfQ15F3DFTSUV+3A1FIkSmvbQ2y/n1rnhr+hsSNPN869eQcse8YHAk
         IxG0YjYGOAzqyznRJ5zVh71RdQu3CpgiH/U/bYBKwiy3+AQofE1WMJJeLM2/QP4ya6P3
         R9eN2dtShoT4qoINfh38Vg7l25kj2OnDvPFdM/IhO5ztqIKP1iarD7/OoxRRIYZVDf7p
         EnCdpdGO4hzmCy38Mzo+JHf6GBjPLHv9FhAJnChEH8EW6I0LWrmR/Eeat3nBkoFoi0Gh
         DWAyRKq0OdAKuZ1I79cD43Edc0/SusJUyeE4jI/tDF/8l0zQcG0gDaTSppPsHnFYl7vv
         BNiw==
X-Gm-Message-State: ANhLgQ1KhJBPufyRrUQ+TqZEE1b1zYCOk0ufNbEoXEjfZ9D837+i+jPy
        bblQP90IfNJhBI6YxnAjxIwH9zcdDjZHqCoLAupIVhGHlb6MBcdITM0XuqEf9t1RxkE7PrHAd9U
        edD920eDU97aNTJAjI/zXItbO
X-Received: by 2002:a1c:7e08:: with SMTP id z8mr4041247wmc.166.1584009640758;
        Thu, 12 Mar 2020 03:40:40 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vu6ccLDIECUJ4QzcC0ZWPgWFXvbh19qItJSE4oK0axsizvLpMS3bxMwAA/uv2s0UwqJY6ijRw==
X-Received: by 2002:a1c:7e08:: with SMTP id z8mr4041227wmc.166.1584009640532;
        Thu, 12 Mar 2020 03:40:40 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-fc7e-fd47-85c1-1ab3.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:fc7e:fd47:85c1:1ab3])
        by smtp.gmail.com with ESMTPSA id o26sm11337897wmc.33.2020.03.12.03.40.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Mar 2020 03:40:39 -0700 (PDT)
Subject: Re: [PATCH] fs: Fix missing 'bit' in comment
To:     Chucheng Luo <luochucheng@vivo.com>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     wenhu.wang@vivo.com, trivial@kernel.org
References: <20200312074037.25829-1-luochucheng@vivo.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <ed0f14ce-25f8-7ef7-54a6-6b3f9fa4bdfc@redhat.com>
Date:   Thu, 12 Mar 2020 11:40:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200312074037.25829-1-luochucheng@vivo.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 3/12/20 8:40 AM, Chucheng Luo wrote:
> The missing word may make it hard for other developers to
> understand it.
> 
> Signed-off-by: Chucheng Luo <luochucheng@vivo.com>

Thanks for catching this:

Acked-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans


> ---
>   fs/vboxsf/dir.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/vboxsf/dir.c b/fs/vboxsf/dir.c
> index dd147b490982..be4f72625d36 100644
> --- a/fs/vboxsf/dir.c
> +++ b/fs/vboxsf/dir.c
> @@ -134,7 +134,7 @@ static bool vboxsf_dir_emit(struct file *dir, struct dir_context *ctx)
>   		d_type = vboxsf_get_d_type(info->info.attr.mode);
>   
>   		/*
> -		 * On 32 bit systems pos is 64 signed, while ino is 32 bit
> +		 * On 32 bit systems pos is 64 bit signed, while ino is 32 bit
>   		 * unsigned so fake_ino may overflow, check for this.
>   		 */
>   		if ((ino_t)(ctx->pos + 1) != (u64)(ctx->pos + 1)) {
> 

