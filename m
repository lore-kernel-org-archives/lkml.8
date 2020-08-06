Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A3ABC38151
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 11:04:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E56C22CAE
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 11:04:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bE+CXWiq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728573AbgHFH1t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 03:27:49 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:55886 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728168AbgHFH1r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 03:27:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596698866;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cSEgSN8jfUJDf4nQ15dUO0iKrtDrvU+69JPCGlGa9N4=;
        b=bE+CXWiq/VwxRHjFRl5qersoCmrMbrwYYSLnajsE5F1vADViBfeBfU8nRift2W8G34zbbE
        sctk1G9hanhXsCI0tR35J6FJNytoHn2va3bPr5pnCjJBY3fgvIQ0g4LUh5vjS08iQsDyFS
        ff+Xhl/8nYlaYImQOsoVBnBnO3WklZ0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-24-ZgpqMcwWNTKyEtlSpoDpBg-1; Thu, 06 Aug 2020 03:27:44 -0400
X-MC-Unique: ZgpqMcwWNTKyEtlSpoDpBg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DB0DD8015F3;
        Thu,  6 Aug 2020 07:27:43 +0000 (UTC)
Received: from [10.72.13.107] (ovpn-13-107.pek2.redhat.com [10.72.13.107])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D846D87A58;
        Thu,  6 Aug 2020 07:27:39 +0000 (UTC)
Subject: Re: [PATCH v2 19/24] vdpa: make sure set_features in invoked for
 legacy
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org
References: <20200803205814.540410-1-mst@redhat.com>
 <20200803205814.540410-20-mst@redhat.com>
 <9e47d227-f220-4651-dcb9-7a11f059a715@redhat.com>
 <20200805073929-mutt-send-email-mst@kernel.org>
 <bd915b30-0604-da1b-343f-e228bce4d1d8@redhat.com>
 <20200806015112-mutt-send-email-mst@kernel.org>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <cc5cb366-be79-908d-edc6-4aebb488cc59@redhat.com>
Date:   Thu, 6 Aug 2020 15:27:38 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200806015112-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2020/8/6 下午1:53, Michael S. Tsirkin wrote:
> On Thu, Aug 06, 2020 at 11:23:05AM +0800, Jason Wang wrote:
>> On 2020/8/5 下午7:40, Michael S. Tsirkin wrote:
>>> On Wed, Aug 05, 2020 at 02:14:07PM +0800, Jason Wang wrote:
>>>> On 2020/8/4 上午5:00, Michael S. Tsirkin wrote:
>>>>> Some legacy guests just assume features are 0 after reset.
>>>>> We detect that config space is accessed before features are
>>>>> set and set features to 0 automatically.
>>>>> Note: some legacy guests might not even access config space, if this is
>>>>> reported in the field we might need to catch a kick to handle these.
>>>> I wonder whether it's easier to just support modern device?
>>>>
>>>> Thanks
>>> Well hardware vendors are I think interested in supporting legacy
>>> guests. Limiting vdpa to modern only would make it uncompetitive.
>>
>> My understanding is that, IOMMU_PLATFORM is mandatory for hardware vDPA to
>> work.
> Hmm I don't really see why. Assume host maps guest memory properly,
> VM does not have an IOMMU, legacy guest can just work.


Yes, guest may not set IOMMU_PLATFORM.


>
> Care explaining what's wrong with this picture?


The problem is virtio_vdpa, without IOMMU_PLATFORM it uses PA which can 
not work if IOMMU is enabled.

Thanks


>
>
>> So it can only work for modern device ...
>>
>> Thanks
>>
>>
>>>
>>>

