Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EE82C33CA2
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 08:37:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FDDE206ED
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 08:37:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SsdeZHku"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727145AbgAJIh2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 03:37:28 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:29286 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726927AbgAJIh2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 03:37:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578645446;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SEGdNnuJMmxq2nRffYFL3avciJRwxghn7a6DuxkSNjc=;
        b=SsdeZHkuH/WTZ+iwBibfIeCvJtl9owD4Jr+KBqHPRSI9YlW4oJvBBVXp8/+1Xh4ln1pmm5
        4rdK9P+9JfUXot00iTslu6N+cAHZ+ClozkDSbFxc0DlY9DA2kq61zrWmamyZO/yCE89h+2
        gqQ9m214X2lSGRkI4HbMnRQ9fBRmLH4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-350-1Hhibq09NKSGSuiB0AkAYg-1; Fri, 10 Jan 2020 03:37:23 -0500
X-MC-Unique: 1Hhibq09NKSGSuiB0AkAYg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 89BF01800D6B;
        Fri, 10 Jan 2020 08:37:21 +0000 (UTC)
Received: from [10.36.117.108] (ovpn-117-108.ams2.redhat.com [10.36.117.108])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id AA64560FA2;
        Fri, 10 Jan 2020 08:37:19 +0000 (UTC)
Subject: Re: [PATCH] KVM: arm/arm64: vgic-its: Check hopefully the last
 DISCARD command error
To:     Zenghui Yu <yuzenghui@huawei.com>, maz@kernel.org
Cc:     andre.przywara@arm.com, linux-arm-kernel@lists.infradead.org,
        kvmarm@lists.cs.columbia.edu, linux-kernel@vger.kernel.org,
        wanghaibin.wang@huawei.com
References: <20191225133014.1825-1-yuzenghui@huawei.com>
From:   Auger Eric <eric.auger@redhat.com>
Message-ID: <f9997198-c990-d638-24d0-41d6280a9d8a@redhat.com>
Date:   Fri, 10 Jan 2020 09:37:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20191225133014.1825-1-yuzenghui@huawei.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Zenghui,

On 12/25/19 2:30 PM, Zenghui Yu wrote:
> DISCARD command error occurs if any of the following apply:
> 
>  - [ ... (those which we have already handled) ]
nit: I would remove the above and simply say the discard is supposed to
fail if the collection is not mapped to any target redistributor. If an
ITE exists then the ite->collection is non NULL. What needs to be
checked is its_is_collection_mapped().

By the way update_affinity_collection() also tests ite->collection. I
think this is useless or do I miss something?

Reviewed-by: Eric Auger <eric.auger@redhat.com>

Thanks

Eric

>  - The EventID for the device is mapped to a collection that
>    has not been mapped to an RDbase using MAPC.
> 
> Let's take the unmapped collection case into account and report
> a DISCARD command error if it really happens.
> 
> Signed-off-by: Zenghui Yu <yuzenghui@huawei.com>
> ---
>  virt/kvm/arm/vgic/vgic-its.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/virt/kvm/arm/vgic/vgic-its.c b/virt/kvm/arm/vgic/vgic-its.c
> index 17920d1b350a..d53d34a33e35 100644
> --- a/virt/kvm/arm/vgic/vgic-its.c
> +++ b/virt/kvm/arm/vgic/vgic-its.c
> @@ -839,9 +839,8 @@ static int vgic_its_cmd_handle_discard(struct kvm *kvm, struct vgic_its *its,
>  	u32 event_id = its_cmd_get_id(its_cmd);
>  	struct its_ite *ite;
>  
> -
>  	ite = find_ite(its, device_id, event_id);
> -	if (ite && ite->collection) {
> +	if (ite && its_is_collection_mapped(ite->collection)) {
>  		/*
>  		 * Though the spec talks about removing the pending state, we
>  		 * don't bother here since we clear the ITTE anyway and the
> 

