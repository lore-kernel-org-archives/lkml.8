Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52D6DC433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 03:23:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 22FC820792
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 03:23:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XX6JaTbD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730450AbgHFDXQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 23:23:16 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:30386 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726817AbgHFDXQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 23:23:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596684194;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JcQQIKoEvShj7Nz7KJ7jpLfenb6dvm9IOTqVH0VUY/E=;
        b=XX6JaTbDQvA7AZafGqAJQTyYjpl55bYh7lCzEA0IzlG79g/WHUK7r7lxpIPEX0uf9HjT2Z
        2/rgV5cot5XxmYXtcYrDMm1tj8rvUuMGgwsOXBPmFw+NVYRsXBStiNpFNJfhOTUNnunBxY
        JdJ/Npa64QKotmTd8KTFmcLL3TeQLI4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-378-JY9jGRHGNOugXsQyM-D3lg-1; Wed, 05 Aug 2020 23:23:12 -0400
X-MC-Unique: JY9jGRHGNOugXsQyM-D3lg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BDE4F8017FB;
        Thu,  6 Aug 2020 03:23:11 +0000 (UTC)
Received: from [10.72.13.140] (ovpn-13-140.pek2.redhat.com [10.72.13.140])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BB56D7B92E;
        Thu,  6 Aug 2020 03:23:07 +0000 (UTC)
Subject: Re: [PATCH v2 19/24] vdpa: make sure set_features in invoked for
 legacy
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org
References: <20200803205814.540410-1-mst@redhat.com>
 <20200803205814.540410-20-mst@redhat.com>
 <9e47d227-f220-4651-dcb9-7a11f059a715@redhat.com>
 <20200805073929-mutt-send-email-mst@kernel.org>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <bd915b30-0604-da1b-343f-e228bce4d1d8@redhat.com>
Date:   Thu, 6 Aug 2020 11:23:05 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200805073929-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2020/8/5 下午7:40, Michael S. Tsirkin wrote:
> On Wed, Aug 05, 2020 at 02:14:07PM +0800, Jason Wang wrote:
>> On 2020/8/4 上午5:00, Michael S. Tsirkin wrote:
>>> Some legacy guests just assume features are 0 after reset.
>>> We detect that config space is accessed before features are
>>> set and set features to 0 automatically.
>>> Note: some legacy guests might not even access config space, if this is
>>> reported in the field we might need to catch a kick to handle these.
>> I wonder whether it's easier to just support modern device?
>>
>> Thanks
> Well hardware vendors are I think interested in supporting legacy
> guests. Limiting vdpa to modern only would make it uncompetitive.


My understanding is that, IOMMU_PLATFORM is mandatory for hardware vDPA 
to work. So it can only work for modern device ...

Thanks


>
>
>

