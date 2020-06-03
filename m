Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 759EFC433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 07:16:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B9B02077D
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 07:16:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N1Ua/0RH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726188AbgFCHQH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 03:16:07 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:58209 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725836AbgFCHQH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 03:16:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591168566;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=exf763iaQhedfc3bldxc9coywh4msA7jsItB1rYI+1c=;
        b=N1Ua/0RH7kwpaahXknjY7txWpoSAD2FLW4eqGsLhi59ymPG5vcl9GMJAGd/EFJ7l95sYIV
        ZJGOvFNgw+DMzIbZ6JiUb4Jt01js2UCg9zLssEWwekjlu7KKKjD231L29nsdJlUMzbH3Kq
        vpc/DCnsOOBOoZon6CmGNyapIGlAJig=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-350-K5_nyCUBMC-JhoimIte_3Q-1; Wed, 03 Jun 2020 03:16:04 -0400
X-MC-Unique: K5_nyCUBMC-JhoimIte_3Q-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5F8EB107ACCA;
        Wed,  3 Jun 2020 07:16:03 +0000 (UTC)
Received: from [10.72.12.214] (ovpn-12-214.pek2.redhat.com [10.72.12.214])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 33F8911A9F5;
        Wed,  3 Jun 2020 07:15:55 +0000 (UTC)
Subject: Re: [PATCH RFC 02/13] vhost: use batched version by default
To:     "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org
Cc:     =?UTF-8?Q?Eugenio_P=c3=a9rez?= <eperezma@redhat.com>,
        kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org
References: <20200602130543.578420-1-mst@redhat.com>
 <20200602130543.578420-3-mst@redhat.com>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <9dc9fb1b-c9d0-7c67-8297-f8a7dcc4c79e@redhat.com>
Date:   Wed, 3 Jun 2020 15:15:54 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200602130543.578420-3-mst@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2020/6/2 下午9:05, Michael S. Tsirkin wrote:
> As testing shows no performance change, switch to that now.
>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
> Link: https://lore.kernel.org/r/20200401183118.8334-3-eperezma@redhat.com
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>   drivers/vhost/vhost.c | 251 +-----------------------------------------
>   drivers/vhost/vhost.h |   4 -
>   2 files changed, 2 insertions(+), 253 deletions(-)


Since we don't have a way to switch back, it's better to remove "by 
default" in the title.

Thanks

