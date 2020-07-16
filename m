Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 220C4C433E3
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 09:35:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F243F20656
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 09:35:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RD67+ys1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726809AbgGPJfb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 05:35:31 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:38269 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726080AbgGPJfb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 05:35:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594892130;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IJFxd0jLmfzMQe2B9WNqDr2oh3ke3LZeNfHLfAyP12M=;
        b=RD67+ys1TUuu8QrLchyEvQ97UfCNMF1ukS+t9KMYJjXvgjBejkXa0lIl7saGdE1wfLfT2q
        sb7quTd/0msd9P0eJlz1Mj45+WtXiYs5H6B3OiWenkFrN7sI/+3NB7L57tiqnJccw2ADnu
        uT68gO5wHDDf9JtPhP32VysPm79BWJc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-27-OiUrh0QhPKywNJPooNFGRQ-1; Thu, 16 Jul 2020 05:35:26 -0400
X-MC-Unique: OiUrh0QhPKywNJPooNFGRQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F25961005269;
        Thu, 16 Jul 2020 09:35:24 +0000 (UTC)
Received: from [10.72.12.131] (ovpn-12-131.pek2.redhat.com [10.72.12.131])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DACCD5D9DC;
        Thu, 16 Jul 2020 09:35:19 +0000 (UTC)
Subject: Re: [PATCH vhost next 06/10] vdpa: Add means to communicate vq status
 on get_vq_state
To:     Eli Cohen <eli@mellanox.com>
Cc:     mst@redhat.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, shahafs@mellanox.com,
        saeedm@mellanox.com, Parav Pandit <parav@mellanox.com>
References: <20200716072327.5359-1-eli@mellanox.com>
 <20200716072327.5359-7-eli@mellanox.com>
 <cb9bced7-1a7e-150a-875c-1b75f77ee853@redhat.com>
 <20200716082116.GA182860@mtl-vdi-166.wap.labs.mlnx>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <296e6fcb-946c-f577-2e22-46528f78fda9@redhat.com>
Date:   Thu, 16 Jul 2020 17:35:18 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200716082116.GA182860@mtl-vdi-166.wap.labs.mlnx>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2020/7/16 下午4:21, Eli Cohen wrote:
> On Thu, Jul 16, 2020 at 04:11:00PM +0800, Jason Wang wrote:
>> On 2020/7/16 下午3:23, Eli Cohen wrote:
>>> Currently, get_vq_state() is used only to pass the available index value
>>> of a vq. Extend the struct to return status on the VQ to the caller.
>>> For now, define VQ_STATE_NOT_READY. In the future it will be extended to
>>> include other infomration.
>>>
>>> Modify current vdpa driver to update this field.
>>>
>>> Reviewed-by: Parav Pandit<parav@mellanox.com>
>>> Signed-off-by: Eli Cohen<eli@mellanox.com>
>> What's the difference between this and get_vq_ready()?
>>
>> Thanks
>>
> There is no difference. It is just a way to communicate a problem to
> with the state of the VQ back to the caller. This is not available now.
> I think an asynchronous is preferred but that is not available
> currently.


I still don't see the reason, maybe you can give me an example?

Thanks

