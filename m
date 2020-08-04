Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCDACC433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 02:14:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA99E20792
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 02:14:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PLdUNGvt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727977AbgHDCOM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 22:14:12 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:43556 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725975AbgHDCOM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 22:14:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596507251;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dinaWVnkMHZ+VIU43BHevlr8tggRrHlhVfqluBTGxHE=;
        b=PLdUNGvtJhWeW0jt2oif4pkOHeFprHC1GAznY6HBrh5aQdNDxZYaon6qUGr8Gefn162ASs
        dPzgeTxHgJPvk9+Cp6zbyDMY70adLuGDTOm9Wu6IDBD2XrUsGjgHgoAzLyOQl0WUXBcA5a
        k6+8Ttj/jAMQ2AxZp/HBp86qQ0YvMPw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-144-KpE0kHG8NU2ucALeTek8wA-1; Mon, 03 Aug 2020 22:14:07 -0400
X-MC-Unique: KpE0kHG8NU2ucALeTek8wA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 27836106B246;
        Tue,  4 Aug 2020 02:14:06 +0000 (UTC)
Received: from [10.72.13.197] (ovpn-13-197.pek2.redhat.com [10.72.13.197])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 07A5C5C6DD;
        Tue,  4 Aug 2020 02:13:51 +0000 (UTC)
Subject: Re: [PATCH] virtio_pci_modern: Fix the comment of
 virtio_pci_find_capability()
To:     Yi Wang <wang.yi59@zte.com.cn>, mst@redhat.com
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, xue.zhihong@zte.com.cn,
        wang.liang82@zte.com.cn, Liao Pingfang <liao.pingfang@zte.com.cn>
References: <1596455545-43556-1-git-send-email-wang.yi59@zte.com.cn>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <75b74fe2-a025-7f31-cc14-61605e00aad5@redhat.com>
Date:   Tue, 4 Aug 2020 10:13:50 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1596455545-43556-1-git-send-email-wang.yi59@zte.com.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2020/8/3 下午7:52, Yi Wang wrote:
> From: Liao Pingfang <liao.pingfang@zte.com.cn>
>
> Fix the comment of virtio_pci_find_capability() by adding missing comment
> for the last parameter: bars.
>
> Fixes: 59a5b0f7bf74 ("virtio-pci: alloc only resources actually used.")
> Signed-off-by: Liao Pingfang <liao.pingfang@zte.com.cn>
> Signed-off-by: Yi Wang <wang.yi59@zte.com.cn>


Acked-by: Jason Wang <jasowang@redhat.com>


> ---
>   drivers/virtio/virtio_pci_modern.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_pci_modern.c
> index db93cedd262f..9bdc6f68221f 100644
> --- a/drivers/virtio/virtio_pci_modern.c
> +++ b/drivers/virtio/virtio_pci_modern.c
> @@ -481,6 +481,7 @@ static const struct virtio_config_ops virtio_pci_config_ops = {
>    * @dev: the pci device
>    * @cfg_type: the VIRTIO_PCI_CAP_* value we seek
>    * @ioresource_types: IORESOURCE_MEM and/or IORESOURCE_IO.
> + * @bars: the bitmask of BARs
>    *
>    * Returns offset of the capability, or 0.
>    */

