Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE37EC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 05:52:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 86D5A207DD
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 05:52:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CUUfkrqe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726680AbgGUFwG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 01:52:06 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:45867 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726003AbgGUFwG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 01:52:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1595310724;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aLjkj/NtDRd3xkfHAYuSB+hneYUy009qM+qF11a/0w8=;
        b=CUUfkrqevHLtn5YJBMPCZaYKdGDM6U2Vy/ByEcDArD6G9nK5sGPJf5/ohCXfqEVUWpmJvB
        sFcvdUt08E3/ZKxzD0eTSupMo91loNpOsr+xD0FDltOheCbIgSkdes5JkPmPUnHfolMppJ
        7ORA+SELD43PhpYsLdtsTYlGhCpVxZA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-316-OuMNqS5uP7OfxFt7hiEfjA-1; Tue, 21 Jul 2020 01:52:02 -0400
X-MC-Unique: OuMNqS5uP7OfxFt7hiEfjA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 445A118C63C2;
        Tue, 21 Jul 2020 05:52:01 +0000 (UTC)
Received: from [10.72.12.202] (ovpn-12-202.pek2.redhat.com [10.72.12.202])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 07D1619C66;
        Tue, 21 Jul 2020 05:51:55 +0000 (UTC)
Subject: Re: [PATCH V2 vhost next 10/10] vdpa/mlx5: Add VDPA driver for
 supported mlx5 devices
To:     Eli Cohen <eli@mellanox.com>, mst@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Cc:     shahafs@mellanox.com, saeedm@mellanox.com, parav@mellanox.com
References: <20200720071416.32112-1-eli@mellanox.com>
 <20200720071416.32112-11-eli@mellanox.com>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <73209efd-f513-fec2-e4f7-51e71f08c9fe@redhat.com>
Date:   Tue, 21 Jul 2020 13:51:54 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200720071416.32112-11-eli@mellanox.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2020/7/20 下午3:14, Eli Cohen wrote:
> Add a front end VDPA driver that registers in the VDPA bus and provides
> networking to a guest. The VDPA driver creates the necessary resources
> on the VF it is driving such that data path will be offloaded.
>
> Notifications are being communicated through the driver.
>
> Currently, only VFs are supported. In subsequent patches we will have
> devlink support to control which VF is used for VDPA and which function
> is used for regular networking.
>
> Reviewed-by: Parav Pandit<parav@mellanox.com>
> Signed-off-by: Eli Cohen<eli@mellanox.com>
> ---
> Changes from V0:
> 1. Fix include path usage
> 2. Fix use after free in qp_create()
> 3. Consistently use mvq->initialized to check if a vq was initialized.
> 4. Remove unused local variable.
> 5. Defer modifyig vq to ready to driver ok
> 6. suspend hardware vq in set_vq_ready(0)
> 7. Remove reservation for control VQ since it multi queue is not supported in this version
> 8. Avoid call put_device() since this is not a pci device driver.


Looks good to me.

Acked-by: Jason Wang <jasowang@redhat.com>


