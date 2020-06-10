Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0A41C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 05:44:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A3122081A
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 05:44:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L0Tl9bBd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726097AbgFJFor (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 01:44:47 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:54936 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725270AbgFJFop (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 01:44:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591767884;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UfSVmrCHCCa+bGByZwONkn+ZSARIgzp8QM/tmIKlltk=;
        b=L0Tl9bBdV/GU4pFpdzCVBqeToqzg6BcioCYX8J6eW/sqQOueepjMj6p60kXwFwb4vtBa4p
        /fNYOAgpI5INgHsTRthtVnQuBwaX4Eou50UdqkvXqAKQQum+fC3S9UPXN3dXPHUV/EQga7
        y6afWkZFZaX2Fvf+OAzz1IoEtI+9ccc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-17-CJp_Q_ANOWW3kkcFEqoNuA-1; Wed, 10 Jun 2020 01:44:42 -0400
X-MC-Unique: CJp_Q_ANOWW3kkcFEqoNuA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3203B1005510;
        Wed, 10 Jun 2020 05:44:40 +0000 (UTC)
Received: from [10.72.13.194] (ovpn-13-194.pek2.redhat.com [10.72.13.194])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2D8621001B2B;
        Wed, 10 Jun 2020 05:44:31 +0000 (UTC)
Subject: Re: [PATCH V2] vdpa: introduce virtio pci driver
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, rob.miller@broadcom.com,
        lingshan.zhu@intel.com, eperezma@redhat.com, lulu@redhat.com,
        shahafs@mellanox.com, hanand@xilinx.com, mhabets@solarflare.com,
        gdawar@xilinx.com, saugatm@xilinx.com, vmireyno@marvell.com,
        zhangweining@ruijie.com.cn, eli@mellanox.com
References: <20200610035920.12078-1-jasowang@redhat.com>
 <20200610004641-mutt-send-email-mst@kernel.org>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <eaa0739f-4c4b-3ca5-c57d-5962b3c3dbc0@redhat.com>
Date:   Wed, 10 Jun 2020 13:44:30 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200610004641-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2020/6/10 下午12:47, Michael S. Tsirkin wrote:
> On Wed, Jun 10, 2020 at 11:59:20AM +0800, Jason Wang wrote:
>> This patch introduce a vDPA driver for virtio-pci device. It bridges
>> the virtio-pci control command to the vDPA bus. This will be used for
>> developing new features for both software vDPA framework and hardware
>> vDPA feature.
> The mail headers are mailformed here:
>
> Content-Type: text/plain; charset=a
>
> so git am can't parse it:
>
> error: cannot convert from a to UTF-8
> fatal: could not parse patch


My bad, let me repost.

Thanks

