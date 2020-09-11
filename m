Return-Path: <SRS0=qBN/=CU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4BF1C433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 12:08:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 74FC821D40
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 12:08:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KBHsrKDu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725829AbgIKMIE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Sep 2020 08:08:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:35177 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725865AbgIKMGU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 08:06:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599825964;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tXnXExdfU/LgNFGqrEAIRqusTbjwtKOcyQ9t6Q3DukY=;
        b=KBHsrKDuZq/W8exCKiF8KsJ7tGIYneZ8Zcj/fudmpLUMNWc5HkIljjcBRXo6dlibAC6N1z
        vEn1xJJ3b3976URD+XT/LAMe2F+bzJJjLYa7xT7HE/9JXaWJIYe+bYgHUkNfYwuRB6syhZ
        hcqecGACUidnEWcR4ziIYYkTp7/dVoo=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-71-ziCIjw1_NRe2bBKq4cP44Q-1; Fri, 11 Sep 2020 08:06:02 -0400
X-MC-Unique: ziCIjw1_NRe2bBKq4cP44Q-1
Received: by mail-ej1-f70.google.com with SMTP id dc22so4437362ejb.21
        for <linux-kernel@vger.kernel.org>; Fri, 11 Sep 2020 05:06:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=tXnXExdfU/LgNFGqrEAIRqusTbjwtKOcyQ9t6Q3DukY=;
        b=SnrvmNvXdx1S+/SL1EZCjzzQE4PlKRg6GNR3PA/P7HR7GIuadUHKibNyzJPjbGqbvm
         Pq9TPd2d7xyy6OmtSUtLi0S8BhIo/fjcnj7uY22Lzwupjb2eA5pEmz4NYThebJeE9PgJ
         FEJ4M90fRDGfcnh61bJSPdDc5tnsoxJV2exGBiTbd0wI0x8wcxjC4dQRVRLPfQEeWovg
         zZwmhWqvNhQVsvPsi2mfyj/MKSp7MFtuLO5CCZwTaENEpAWnztxgFYvKcJYRiP69xtg6
         d8rjLHhh3pVTTGzH7FWeCZTLXNKFy61FyfA/abQlSf7xcLY1JMxeJ/ylBgK1SafJ3pTA
         Vzgw==
X-Gm-Message-State: AOAM531F0+IZwSzJItFeiq/fs5gt7CF28/tXYh2+Qj4j+0MsAxbnhOye
        BLp4h7HbIul5+9mn3M6lQW/TNeUkyVCgjcKImS+S99g7zpT/PsXREMU4tIhy1Qh6nhknPfsy/HC
        yWt4zDoymoNZIfwXd/avuJ7b/
X-Received: by 2002:aa7:cf05:: with SMTP id a5mr1618678edy.313.1599825961018;
        Fri, 11 Sep 2020 05:06:01 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyGeHcc3Seug1HpP+JhTlX1wxV4JWfVvs8nAUaaY4C2YTOgc5vpea65aMg/Gr3DPSBQwzpjEw==
X-Received: by 2002:aa7:cf05:: with SMTP id a5mr1618654edy.313.1599825960828;
        Fri, 11 Sep 2020 05:06:00 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-d2ea-f29d-118b-24dc.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:d2ea:f29d:118b:24dc])
        by smtp.gmail.com with ESMTPSA id y25sm1474481edv.15.2020.09.11.05.06.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Sep 2020 05:06:00 -0700 (PDT)
Subject: Re: [PATCH -next] fs: vboxsf: Fix a kernel-doc warning in
 vboxsf_wrappers.c
To:     Wang Hai <wanghai38@huawei.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200911114339.62308-1-wanghai38@huawei.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <03f07277-d80a-f652-1050-472124db5900@redhat.com>
Date:   Fri, 11 Sep 2020 14:05:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200911114339.62308-1-wanghai38@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 9/11/20 1:43 PM, Wang Hai wrote:
> Fixes the following W=1 kernel build warning(s):
> 
> fs/vboxsf/vboxsf_wrappers.c:132: warning: Excess function parameter 'param' description in 'vboxsf_create'
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Wang Hai <wanghai38@huawei.com>

Thank you, looks good to me:

Acked-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans


> ---
>   fs/vboxsf/vboxsf_wrappers.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/vboxsf/vboxsf_wrappers.c b/fs/vboxsf/vboxsf_wrappers.c
> index bfc78a097dae..3b6630e2847d 100644
> --- a/fs/vboxsf/vboxsf_wrappers.c
> +++ b/fs/vboxsf/vboxsf_wrappers.c
> @@ -114,7 +114,7 @@ int vboxsf_unmap_folder(u32 root)
>    * vboxsf_create - Create a new file or folder
>    * @root:         Root of the shared folder in which to create the file
>    * @parsed_path:  The path of the file or folder relative to the shared folder
> - * @param:        create_parms Parameters for file/folder creation.
> + * @create_parms: create_parms Parameters for file/folder creation.
>    *
>    * Create a new file or folder or open an existing one in a shared folder.
>    * Note this function always returns 0 / success unless an exceptional condition
> 

