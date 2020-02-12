Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 711A7C2BA83
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 09:03:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34921206ED
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 09:03:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RdDPGoTE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728606AbgBLJD0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 04:03:26 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:28387 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728353AbgBLJD0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 04:03:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581498204;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5IoPBqo+Oel8z/CspcuRSyjTueKzrK71W8q6WEn9u3o=;
        b=RdDPGoTE4Fd793VKwIWsGayqeLIFAH8r1S+EnVVjFuLUCEWKLk+RlaBqMig1JfvLZFaJkf
        9acgsnAE/7DEgYdOVYznfv1P2HnAj9xvHu8B9Ha3iXF0u9JJPe1UETRn8GEVK+51aNPrxc
        0m7z3wqg0ewQx4850qBOiJDBDbnlCzs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-109-uaTa3GGBMNuPjnow_DvAgA-1; Wed, 12 Feb 2020 04:03:22 -0500
X-MC-Unique: uaTa3GGBMNuPjnow_DvAgA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2E9BE100551C;
        Wed, 12 Feb 2020 09:03:19 +0000 (UTC)
Received: from [10.72.13.111] (ovpn-13-111.pek2.redhat.com [10.72.13.111])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6BA2526FDB;
        Wed, 12 Feb 2020 09:03:03 +0000 (UTC)
Subject: Re: [virtio-dev] Re: [PATCH v2 4/5] virtio-mmio: add MSI interrupt
 feature support
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     virtio-dev@lists.oasis-open.org,
        Zha Bin <zhabin@linux.alibaba.com>, slp@redhat.com,
        "Liu, Jing2" <jing2.liu@linux.intel.com>,
        linux-kernel@vger.kernel.org, qemu-devel@nongnu.org,
        chao.p.peng@linux.intel.com, gerry@linux.alibaba.com
References: <4c3d13be5a391b1fc50416838de57d903cbf8038.1581305609.git.zhabin@linux.alibaba.com>
 <0c71ff9d-1a7f-cfd2-e682-71b181bdeae4@redhat.com>
 <c42c8b49-5357-f341-2942-ba84afc25437@linux.intel.com>
 <ad96269f-753d-54b8-a4ae-59d1595dd3b2@redhat.com>
 <5522f205-207b-b012-6631-3cc77dde3bfe@linux.intel.com>
 <45e22435-08d3-08fe-8843-d8db02fcb8e3@redhat.com>
 <20200211065319-mutt-send-email-mst@kernel.org>
 <c4a78a15-c889-df3f-3e1e-7df1a4d67838@redhat.com>
 <20200211070523-mutt-send-email-mst@kernel.org>
 <fdb19ef4-2003-6c6f-5c6f-c757a6320130@redhat.com>
 <20200211090003-mutt-send-email-mst@kernel.org>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <4557a5e8-74eb-f238-1579-b7b558cb2969@redhat.com>
Date:   Wed, 12 Feb 2020 17:03:00 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200211090003-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2020/2/11 =E4=B8=8B=E5=8D=8810:00, Michael S. Tsirkin wrote:
>> Yes, it can work but it may bring extra effort when you want to mask a
>> vector which is was shared by a lot of queues.
>>
>> Thanks
>>
> masking should be per vq too.
>
> --=20


Yes, but if the vector is shard by e.g 16 queues, then all those=20
virtqueues needs to be masked which is expensive.

Thanks


