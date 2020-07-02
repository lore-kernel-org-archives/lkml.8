Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62422C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 03:06:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 334A220720
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 03:06:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z8kwD0sC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728129AbgGBDGX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 23:06:23 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:50133 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726094AbgGBDGX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 23:06:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593659181;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qeIaIEJc94t9oaVvAhehA4A3clx6kWGL/yNP4QpP1wc=;
        b=Z8kwD0sCmFQLJ8g6Ljk4s9YvmFCSEoQe7qAWygGTCnl2+yaGx5rsZnfgvaIGo2XKKppWTT
        y4w+MDkSg3fvveVmCss5s/V8UFZm1+n+C18MDVeI1caHNSSneOzy6fk50gnClTpR2NlZKO
        L0H4lWdgmYCP8CVD4+sKGxwHT3k2kL0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-506-5_ARSzpKPziJDyNbg8kvtA-1; Wed, 01 Jul 2020 23:06:18 -0400
X-MC-Unique: 5_ARSzpKPziJDyNbg8kvtA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B8C5B800D5C;
        Thu,  2 Jul 2020 03:06:17 +0000 (UTC)
Received: from [10.72.13.248] (ovpn-13-248.pek2.redhat.com [10.72.13.248])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B237079233;
        Thu,  2 Jul 2020 03:06:12 +0000 (UTC)
Subject: Re: [PATCH 2/2] virtio-mmio: Reject invalid IRQ 0 command line
 argument
To:     Bjorn Helgaas <helgaas@kernel.org>, linux-kernel@vger.kernel.org
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        virtualization@lists.linux-foundation.org
References: <20200701221040.3667868-1-helgaas@kernel.org>
 <20200701221040.3667868-3-helgaas@kernel.org>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <032d0424-4876-6322-76d2-d733db28addb@redhat.com>
Date:   Thu, 2 Jul 2020 11:06:11 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200701221040.3667868-3-helgaas@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2020/7/2 上午6:10, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
>
> The "virtio_mmio.device=" command line argument allows a user to specify
> the size, address, and IRQ of a virtio device.  Previously the only
> requirement for the IRQ was that it be an unsigned integer.
>
> Zero is an unsigned integer but an invalid IRQ number, and after
> a85a6c86c25be ("driver core: platform: Clarify that IRQ 0 is invalid"),
> attempts to use IRQ 0 cause warnings.
>
> If the user specifies IRQ 0, return failure instead of registering a device
> with IRQ 0.
>
> Fixes: a85a6c86c25be ("driver core: platform: Clarify that IRQ 0 is invalid")
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Michael S. Tsirkin <mst@redhat.com>
> Cc: Jason Wang <jasowang@redhat.com>
> Cc: virtualization@lists.linux-foundation.org
> ---
>   drivers/virtio/virtio_mmio.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/virtio/virtio_mmio.c b/drivers/virtio/virtio_mmio.c
> index 9d16aaffca9d..627ac0487494 100644
> --- a/drivers/virtio/virtio_mmio.c
> +++ b/drivers/virtio/virtio_mmio.c
> @@ -641,11 +641,11 @@ static int vm_cmdline_set(const char *device,
>   			&vm_cmdline_id, &consumed);
>   
>   	/*
> -	 * sscanf() must processes at least 2 chunks; also there
> +	 * sscanf() must process at least 2 chunks; also there
>   	 * must be no extra characters after the last chunk, so
>   	 * str[consumed] must be '\0'
>   	 */
> -	if (processed < 2 || str[consumed])
> +	if (processed < 2 || str[consumed] || irq == 0)
>   		return -EINVAL;
>   
>   	resources[0].flags = IORESOURCE_MEM;


Acked-by: Jason Wang <jasowang@redhat.com>


