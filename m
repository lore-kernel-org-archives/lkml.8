Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F8C0C3F2D2
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 04:31:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0716A246B6
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 04:31:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G97pH1vV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726973AbgCBEbn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Mar 2020 23:31:43 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:40732 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726872AbgCBEbm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Mar 2020 23:31:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583123502;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QOMQ5ASXj6ruD2o2CVhyt5419oX3mFIKgmuBXuhfitE=;
        b=G97pH1vVsR+DsHX8PGmAzeiEDdvGQdNCkN2tEa+RDkMzCnoDXKILAbse0AZV0KqGacZoJx
        3mQQ8Xc1YNhy0hlFpX+GIuoL414oFoy6jTCNgqw97ghkkX897t4WevqYgFIBGGYnz2BTeJ
        2ytcJstJ6pe+XMoaoAT7YEvt3Di7i1c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-401-0jVEAForNo-OwsYwTRmq5g-1; Sun, 01 Mar 2020 23:31:40 -0500
X-MC-Unique: 0jVEAForNo-OwsYwTRmq5g-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 03811107ACC4;
        Mon,  2 Mar 2020 04:31:39 +0000 (UTC)
Received: from [10.72.13.131] (ovpn-13-131.pek2.redhat.com [10.72.13.131])
        by smtp.corp.redhat.com (Postfix) with ESMTP id ECEE127183;
        Mon,  2 Mar 2020 04:31:30 +0000 (UTC)
Subject: Re: [PATCH v3 0/3] virtio-net: introduce features defined in the spec
To:     "Michael S. Tsirkin" <mst@redhat.com>,
        Yuri Benditovich <yuri.benditovich@daynix.com>
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, yan@daynix.com,
        virtio-dev@lists.oasis-open.org
References: <20200301143302.8556-1-yuri.benditovich@daynix.com>
 <20200301150625-mutt-send-email-mst@kernel.org>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <70ddcfd3-c388-1d5d-0728-4dbb434c619c@redhat.com>
Date:   Mon, 2 Mar 2020 12:31:28 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200301150625-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2020/3/2 =E4=B8=8A=E5=8D=884:06, Michael S. Tsirkin wrote:
> On Sun, Mar 01, 2020 at 04:32:59PM +0200, Yuri Benditovich wrote:
>> This series introduce virtio-net features VIRTIO_NET_F_RSC_EXT,
>> VIRTIO_NET_F_RSS and VIRTIO_NET_F_HASH_REPORT.
>>
>> Changes from v2: reformatted structure in patch 1
>
> Looks good but I cound a couple more nits. Sorry I missed them
> on the previous read.


Do we want to merge this without the actual users in kernel?

Thanks


>
>> Yuri Benditovich (3):
>>    virtio-net: Introduce extended RSC feature
>>    virtio-net: Introduce RSS receive steering feature
>>    virtio-net: Introduce hash report feature
>>
>>   include/uapi/linux/virtio_net.h | 100 ++++++++++++++++++++++++++++++=
--
>>   1 file changed, 96 insertions(+), 4 deletions(-)
>>
>> --=20
>> 2.17.1

