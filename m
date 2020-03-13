Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA133C10DCE
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 10:45:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8102320724
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 10:45:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gZF2Cv2m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726593AbgCMKpU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 06:45:20 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:27465 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726414AbgCMKpU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 06:45:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584096318;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zctn6k2f5mixNGrxrLzyiam0TKHGTxDS/k1jN+OYlZ8=;
        b=gZF2Cv2m8VhflK0wpDOtLc182kXjTeKi1Urdk1c4yhuXq/FYGu4pKPJ6H/tv9n+UZXv1Lq
        WAZv/J7IPetJsYkxQIZCDLym5TTLMPWaV8xjZ7/XW3HhGGq+ZGRJ14PPBTSQIaHjbIrycK
        pIbSocl4w4fZwl3bCZQxtc4i4D8WMXk=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-152-oewnxbT6N0iM-5oIhaf0rg-1; Fri, 13 Mar 2020 06:45:17 -0400
X-MC-Unique: oewnxbT6N0iM-5oIhaf0rg-1
Received: by mail-wm1-f69.google.com with SMTP id 20so2778466wmk.1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Mar 2020 03:45:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zctn6k2f5mixNGrxrLzyiam0TKHGTxDS/k1jN+OYlZ8=;
        b=MoNvrltS6KGMJKgIHyosOOefzTDfiNmm16Q/3cjioZGk0kb0MHWAOuICzGG+bPxLH2
         A7tJEOcri3Xtpz2Xphm0XeYP6nqCugPg0FsIfPrXeyTipvWr5JjkXitEDVx3h/+bT8+y
         E1nuBLBBFCcj49to3bM81Xtb30DI0vS6+phbjp2dCZhl3OoxJATg7GnP44mgn1zTtHGk
         bUMoivyxOFRIN0wOW+GrPUqPkyso71Fx9ki8DX9m8Ef43HeKrP+/Qn/vU0KwnlSxu+wa
         5XuWY2EhQObzmd9tAvyRAFv+oJOJDUhcfvLLkMJ5mk8d14UwW8D74udZMJ4s7Bqevggd
         dSlg==
X-Gm-Message-State: ANhLgQ3/8+cQ4/NGrjsgaLZddSRCC9OVeGfTEUD9Ncv/ZcRtoEVkSxPc
        KLAzprIY1QhPg9zpN85FiD04yaZZgx68RBZ1UbuMTjfBRil8ksvbk20vH9nMNe9t8Ld0l94VD3N
        eiy9NKdSPBvyopDm3zBJa3zLm
X-Received: by 2002:a1c:9a45:: with SMTP id c66mr9834649wme.115.1584096316103;
        Fri, 13 Mar 2020 03:45:16 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vviKBLP6HiMs9SO8RNyYOgApRUQbugrPMiXiR6xqFNcz8q1Uphz7JwEuPG86DI5+Afewd8XZg==
X-Received: by 2002:a1c:9a45:: with SMTP id c66mr9834631wme.115.1584096315904;
        Fri, 13 Mar 2020 03:45:15 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-fc7e-fd47-85c1-1ab3.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:fc7e:fd47:85c1:1ab3])
        by smtp.gmail.com with ESMTPSA id o10sm5209579wrs.65.2020.03.13.03.45.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Mar 2020 03:45:15 -0700 (PDT)
Subject: Re: [PATCH] fs: Fix missing 'bit' in comment
To:     Chucheng Luo <luochucheng@vivo.com>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     wenhu.wang@vivo.com, trivial@kernel.org
References: <20200313014655.28967-1-luochucheng@vivo.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <dfd44b01-3d90-3923-2971-d8d5bce5db08@redhat.com>
Date:   Fri, 13 Mar 2020 11:45:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200313014655.28967-1-luochucheng@vivo.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 3/13/20 2:46 AM, Chucheng Luo wrote:
> The missing word may make it hard for other developers to
> understand it.
> 
> Signed-off-by: Chucheng Luo <luochucheng@vivo.com>

This new version also looks good to me:

Acked-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans

p.s.

In the future please mark new versions as such by using e.g.:

git send-email --subject-prefix="PATCH v2" ...

Actually, it would be good to resend this patch (with my
Acked-by added to the commit msg) this way because now there
is no way for the fs maintainers to figure out which one
of the 2 patches you've send out to apply.



> ---
>   fs/vboxsf/dir.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/vboxsf/dir.c b/fs/vboxsf/dir.c
> index dd147b490982..4d569f14a8d8 100644
> --- a/fs/vboxsf/dir.c
> +++ b/fs/vboxsf/dir.c
> @@ -134,7 +134,7 @@ static bool vboxsf_dir_emit(struct file *dir, struct dir_context *ctx)
>   		d_type = vboxsf_get_d_type(info->info.attr.mode);
>   
>   		/*
> -		 * On 32 bit systems pos is 64 signed, while ino is 32 bit
> +		 * On 32-bit systems pos is 64-bit signed, while ino is 32-bit
>   		 * unsigned so fake_ino may overflow, check for this.
>   		 */
>   		if ((ino_t)(ctx->pos + 1) != (u64)(ctx->pos + 1)) {
> 

