Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF00FC433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 18:01:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8FF7F20775
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 18:01:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NpBWWMz4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726736AbgGISBc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 14:01:32 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:22363 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726649AbgGISBb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 14:01:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594317690;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RMDjyEYcFI6gdBDQideBKxDS0JZBtvUdaUYhw9E2e5k=;
        b=NpBWWMz4WjtY4x9hDfADJQLgaHk4NCyu1os8Ne/tUIbfsiO6Q26ES7VOt5B46+v69tMjZ2
        bhw4kIv0qxCt6QGipxbMyuZK7SjFw0kzTgUegzWtYy4i1mqRAoXMm7RnyiJjnDWAs0Tw0B
        zlwXHRxntSjrFRX+bKPqWjJG3VnUyWg=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-69-yOW7uibQN6--UuoOM_lurQ-1; Thu, 09 Jul 2020 14:01:28 -0400
X-MC-Unique: yOW7uibQN6--UuoOM_lurQ-1
Received: by mail-wm1-f71.google.com with SMTP id v11so2953596wmb.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jul 2020 11:01:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=RMDjyEYcFI6gdBDQideBKxDS0JZBtvUdaUYhw9E2e5k=;
        b=n5GiosLER38S8ma0qOrIB0XEt92jbGunybGDfpz7PNg9bMm6R/HqGlVwbn49KqPzmx
         uCEtqykrxcOuzST+I0FmYm4UKDwcJE0G+SxXphRJOhJAVAmyGUMdhLIeoev98EI1XXKs
         w1P7PTVAkvX7Bj5AawFPNuAZg3nz0VFcup+cPpl3XWgSo5L+CowHh2864kkuVdV9/7k4
         jVriNlkeiIqeykjrrUnCDyePqGeRGae5qhhyWwYaZe+4u8g218eGJfpjfv2waeTHvzFt
         +/4Ebuu5fgYuggPx1L5I05iivcpp/fsh43JpQcwx5naKH23/5XLsbWeLyG5eqTn6r6Tr
         WrCA==
X-Gm-Message-State: AOAM531N1KHBJ5/EGCSH58lyjIqKiiRnuP7DOiRJz+jukmos8Tvp3Ejo
        Uy4H+kU5pIDWSjYtGVqK1vchcZMtN1IhVCnDgQ8PBNFT9RHjMnwTgWrqwsL8erIPKjhmj9QdQce
        MsMV/NvQs5aja01xoip5mipcO
X-Received: by 2002:adf:efc9:: with SMTP id i9mr68299606wrp.77.1594317687695;
        Thu, 09 Jul 2020 11:01:27 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzry8iHdlGY/tXFHdCmrjjNroFcuFEkfGZh1gKUcbnkdVacPAMWf+y7WZrotWreuoms1y+FXg==
X-Received: by 2002:adf:efc9:: with SMTP id i9mr68299581wrp.77.1594317687435;
        Thu, 09 Jul 2020 11:01:27 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:9541:9439:cb0f:89c? ([2001:b07:6468:f312:9541:9439:cb0f:89c])
        by smtp.gmail.com with ESMTPSA id w17sm6397333wra.42.2020.07.09.11.01.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jul 2020 11:01:26 -0700 (PDT)
Subject: Re: [PATCH 12/24] scsi: virtio_scsi: Demote seemingly unintentional
 kerneldoc header
To:     Lee Jones <lee.jones@linaro.org>, jejb@linux.ibm.com,
        martin.petersen@oracle.com, linux-scsi@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        virtualization@lists.linux-foundation.org
References: <20200709174556.7651-1-lee.jones@linaro.org>
 <20200709174556.7651-13-lee.jones@linaro.org>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <ab85392c-2095-4023-4e20-503ee248a538@redhat.com>
Date:   Thu, 9 Jul 2020 20:01:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200709174556.7651-13-lee.jones@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/07/20 19:45, Lee Jones wrote:
> This is the only use of kerneldoc in the sourcefile and no
> descriptions are provided.
> 
> Fixes the following W=1 kernel build warning(s):
> 
>  drivers/scsi/virtio_scsi.c:109: warning: Function parameter or member 'vscsi' not described in 'virtscsi_complete_cmd'
>  drivers/scsi/virtio_scsi.c:109: warning: Function parameter or member 'buf' not described in 'virtscsi_complete_cmd'
> 
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Jason Wang <jasowang@redhat.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Stefan Hajnoczi <stefanha@redhat.com>
> Cc: virtualization@lists.linux-foundation.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  drivers/scsi/virtio_scsi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/scsi/virtio_scsi.c b/drivers/scsi/virtio_scsi.c
> index 0e0910c5b9424..56875467e4984 100644
> --- a/drivers/scsi/virtio_scsi.c
> +++ b/drivers/scsi/virtio_scsi.c
> @@ -100,7 +100,7 @@ static void virtscsi_compute_resid(struct scsi_cmnd *sc, u32 resid)
>  		scsi_set_resid(sc, resid);
>  }
>  
> -/**
> +/*
>   * virtscsi_complete_cmd - finish a scsi_cmd and invoke scsi_done
>   *
>   * Called with vq_lock held.
> 

Acked-by: Paolo Bonzini <pbonzini@redhat.com>

