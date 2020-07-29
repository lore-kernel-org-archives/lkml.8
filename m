Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B6C6C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 22:10:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 580652075D
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 22:10:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NfJc6fhJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727807AbgG2WK2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 18:10:28 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:58375 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726365AbgG2WK1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 18:10:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596060626;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bJ9gcg8hgg+gXoaDiJiCDnUPl9TBTNe9dHQAX/u98cA=;
        b=NfJc6fhJMFCaY5oRowKUHCYUZ+QGeq3C8hOa4ZuwDUog/wYm4YyduxF4FbMs980P+ibfG4
        t2scvXQAtl17oKKtWGAdttHtOpnhoieUMZGCtL2bahIhcS0xOc8lkbWwe/E+BgDO5/LEr8
        X/y77+8VbWXG7jQUU/VEdPovyo1kaVM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-487-1TI-AtecNaia7EBWdtHkog-1; Wed, 29 Jul 2020 18:10:21 -0400
X-MC-Unique: 1TI-AtecNaia7EBWdtHkog-1
Received: by mail-wm1-f69.google.com with SMTP id v8so943621wma.6
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jul 2020 15:10:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=bJ9gcg8hgg+gXoaDiJiCDnUPl9TBTNe9dHQAX/u98cA=;
        b=EDLT2DLhheUkeWRHVpmTRvKzB7q3fpMHcB3pBaKmk4KBX8jWa/9JthyoTdUCdHS4BE
         B9fqQol5O9L0rf0zNpKPH6r6787dwDc4voGT3SlY4xNA6HdIwRckZudZOyoE8EH5r8ur
         T+WfvaSpwpoMy4jbCOHs1RWLAduk3K7gkr4X9cFllQvGrNk5gfFjUo0X3a+orltYmWHG
         A0Iyqfsc8BVUUQbJJb8EPRf3CwLAJ1CauvFr4wno832E0Dm+Tjan718SVE8WMRoAo0kP
         uM70ZrLzZXyc+vnoYbspPx4geYl9Bj6FEBr0iYCohffrzdnO2umGC8l8YTJCoNi/lThj
         mrvQ==
X-Gm-Message-State: AOAM533MrjuFR8UWub0JUr34wSA6UNfqof1MMQhfou4qCRWce0h5p9y1
        +EJa4a3OOPDzSdhXgkfZuhcsiPJfdTsaxrCjEJJ22CBaNjSK/SBgfm1xWDrdya5tsbXpABMzSkV
        tlNRVfwf86s6pl0+8CLlASX+Y
X-Received: by 2002:adf:de09:: with SMTP id b9mr18976055wrm.409.1596060620639;
        Wed, 29 Jul 2020 15:10:20 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwAVkmT45/6AHu0ZMgIzc+okxTAhaZCPNqOlK4XLAY29yq9rtl6Quhri6cx4tDK9mKXNiWkKA==
X-Received: by 2002:adf:de09:: with SMTP id b9mr18976036wrm.409.1596060620367;
        Wed, 29 Jul 2020 15:10:20 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:101f:6e7:e073:454c? ([2001:b07:6468:f312:101f:6e7:e073:454c])
        by smtp.gmail.com with ESMTPSA id z8sm6490516wmf.42.2020.07.29.15.10.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jul 2020 15:10:19 -0700 (PDT)
Subject: Re: [PATCH 1/1] scsi: virtio-scsi: handle correctly case when all
 LUNs were unplugged
To:     Maxim Levitsky <mlevitsk@redhat.com>, linux-kernel@vger.kernel.org
Cc:     "open list:SCSI SUBSYSTEM" <linux-scsi@vger.kernel.org>,
        "open list:VIRTIO BLOCK AND SCSI DRIVERS" 
        <virtualization@lists.linux-foundation.org>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Jason Wang <jasowang@redhat.com>
References: <20200729194806.4933-1-mlevitsk@redhat.com>
 <20200729194806.4933-2-mlevitsk@redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <e56b2e4c-6dcd-1ec5-dde6-ef81c1f98e2a@redhat.com>
Date:   Thu, 30 Jul 2020 00:10:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200729194806.4933-2-mlevitsk@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/07/20 21:48, Maxim Levitsky wrote:
> Commit 5ff843721467 ("scsi: virtio_scsi: unplug LUNs when events missed"),
> almost fixed the case of mass unpluging of LUNs, but it missed a
> corner case in which all the LUNs are unplugged at the same time.
> 
> In this case INQUIRY ends with DID_BAD_TARGET.
> Detect this and unplug the LUN.
> 
> Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> ---
>  drivers/scsi/virtio_scsi.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/scsi/virtio_scsi.c b/drivers/scsi/virtio_scsi.c
> index 0e0910c5b9424..c7f0c22b6f11d 100644
> --- a/drivers/scsi/virtio_scsi.c
> +++ b/drivers/scsi/virtio_scsi.c
> @@ -351,6 +351,16 @@ static void virtscsi_rescan_hotunplug(struct virtio_scsi *vscsi)
>  			/* PQ indicates the LUN is not attached */
>  			scsi_remove_device(sdev);
>  		}
> +
> +		else if (host_byte(result) == DID_BAD_TARGET) {
> +			/*
> +			 * if all LUNs of a virtio-scsi device are unplugged,
> +			 * it will respond with BAD TARGET on any INQUIRY
> +			 * command.
> +			 * Remove the device in this case as well
> +			 */
> +			scsi_remove_device(sdev);
> +		}
>  	}
>  
>  	kfree(inq_result);
> 

Acked-by: Paolo Bonzini <pbonzini@redhat.com>

