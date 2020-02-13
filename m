Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D240C352A3
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 03:40:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 383782168B
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 03:40:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ahgdcYN4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729594AbgBMDkv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 22:40:51 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:54330 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729432AbgBMDkv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 22:40:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581565250;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rLoANijvRLORZWmUnjUSah1ms3I1fKun4Z6zhHRZ0bE=;
        b=ahgdcYN4ddpDEIHNXTXDRq1J5Zt2CRF9vhiy9eD6o49TUkCHvlR+wge9gMK6Gc+MlKPaM9
        97R4ZLsmIMdRjDWbzue6/V+w4u+jtkEwxBICuLoHy2pp2nFgYK+Zv+b4FItMsTR8vS+xO+
        ZiLsXaQejLrRr7eVOx83PzKC2+6Q+WI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-301-kbzM4A79OCOj7Zb202X7AA-1; Wed, 12 Feb 2020 22:40:49 -0500
X-MC-Unique: kbzM4A79OCOj7Zb202X7AA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6C33F1857345;
        Thu, 13 Feb 2020 03:40:47 +0000 (UTC)
Received: from [10.72.13.212] (ovpn-13-212.pek2.redhat.com [10.72.13.212])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 044085C132;
        Thu, 13 Feb 2020 03:40:38 +0000 (UTC)
Subject: Re: [virtio-dev] Re: [PATCH v2 4/5] virtio-mmio: add MSI interrupt
 feature support
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     "Liu, Jing2" <jing2.liu@linux.intel.com>,
        Zha Bin <zhabin@linux.alibaba.com>,
        linux-kernel@vger.kernel.org, virtio-dev@lists.oasis-open.org,
        slp@redhat.com, qemu-devel@nongnu.org, chao.p.peng@linux.intel.com,
        gerry@linux.alibaba.com
References: <cover.1581305609.git.zhabin@linux.alibaba.com>
 <4c3d13be5a391b1fc50416838de57d903cbf8038.1581305609.git.zhabin@linux.alibaba.com>
 <0c71ff9d-1a7f-cfd2-e682-71b181bdeae4@redhat.com>
 <c42c8b49-5357-f341-2942-ba84afc25437@linux.intel.com>
 <ad96269f-753d-54b8-a4ae-59d1595dd3b2@redhat.com>
 <5522f205-207b-b012-6631-3cc77dde3bfe@linux.intel.com>
 <45e22435-08d3-08fe-8843-d8db02fcb8e3@redhat.com>
 <4c19292f-9d25-a859-3dde-6dd5a03fdf0b@linux.intel.com>
 <44209f3c-613c-3766-ca83-321b77b0f0dd@redhat.com>
 <20200212041554-mutt-send-email-mst@kernel.org>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <d4123292-88e8-0879-7474-ca5f7f9f801f@redhat.com>
Date:   Thu, 13 Feb 2020 11:40:37 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200212041554-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2020/2/12 =E4=B8=8B=E5=8D=885:16, Michael S. Tsirkin wrote:
>>> Thanks for the advice.:)
>>>
>>> Actually when looking into pci, the queue_msix_vector/msix_config is =
the
>>> msi vector index, which is the same as the mmio register MsiVecSel
>>> (0x0d0).
>>>
>>> So we don't introduce two extra registers for mapping even in sharing
>>> mode.
>>>
>>> What do you think?
>>>
>> I'm not sure I get the point, but I still prefer the separate vector_s=
el
>> from queue_msix_vector.
>>
>> Btw, Michael propose per vq registers which could also work.
>>
>> Thanks
>>
> Right and I'd even ask a question: do we need shared MSI at all?


I guess it is still needed at least for the current virtio code.=20
Technically we may have thousands queues.

Thanks


> Is it somehow better than legacy interrupt? And why?
> Performance numbers please.
>

