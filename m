Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EBFEC433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 03:59:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 787C62177B
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 03:59:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C1Wf1Kia"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726609AbgHGD7k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 23:59:40 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:44780 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726078AbgHGD7j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 23:59:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596772778;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8ur7u+L4AiUpxBUHlNLWgY5xdw+Rt8MUvqmC6sx75eg=;
        b=C1Wf1KiawA0CklZxFa+RSXGSeJFePmsb17Oukj7RqAlZ+FpouLdfPFWQTsgtW0FTda+doW
        OvOfW6zIl9ktjrdOFgzd1J06FokfVbWeyLw3gpPZz+Ez0nIZvInkTMKe7g/QKTFmiL6aR5
        Bj9H3iQCwQkDIL7li9BtpU7pVFq4UQM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-299-eu1zuceKMwaHilGdVSy2Hg-1; Thu, 06 Aug 2020 23:59:36 -0400
X-MC-Unique: eu1zuceKMwaHilGdVSy2Hg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8A64318C63DE;
        Fri,  7 Aug 2020 03:59:35 +0000 (UTC)
Received: from [10.72.13.215] (ovpn-13-215.pek2.redhat.com [10.72.13.215])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9829187A5A;
        Fri,  7 Aug 2020 03:59:30 +0000 (UTC)
Subject: Re: [PATCH] vdpa/mlx5: Fix erroneous null pointer checks
From:   Jason Wang <jasowang@redhat.com>
To:     Alex Dewar <alex.dewar90@gmail.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Parav Pandit <parav@mellanox.com>,
        Eli Cohen <eli@mellanox.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
References: <20200806191849.82189-1-alex.dewar90@gmail.com>
 <a1fb552a-bd5c-d7a2-7eae-d787cc61ec73@redhat.com>
Message-ID: <59bf7e04-a834-2728-dd2a-a2cd62a724a8@redhat.com>
Date:   Fri, 7 Aug 2020 11:59:29 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <a1fb552a-bd5c-d7a2-7eae-d787cc61ec73@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2020/8/7 上午11:37, Jason Wang wrote:
>
> On 2020/8/7 上午3:18, Alex Dewar wrote:
>> In alloc_inout() in net/mlx5_vnet.c, there are a few places where memory
>> is allocated to *in and *out, but only the values of in and out are
>> null-checked (i.e. there is a missing dereference). Fix this.
>>
>> Addresses-Coverity: ("CID 1496603: (REVERSE_INULL)")
>> Fixes: 1a86b377aa21 ("vdpa/mlx5: Add VDPA driver for supported mlx5 
>> devices")
>> Signed-off-by: Alex Dewar <alex.dewar90@gmail.com>
>
>
> Acked-by: Jason Wang <jasowang@redhat.com>


Colin posted something similar: [PATCH][next] vdpa/mlx5: fix memory 
allocation failure checks

And I think his fix is better since it prevent raw pointers to be freed.

Thanks

