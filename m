Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 692B7C83004
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 10:56:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 42C092072A
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 10:56:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726746AbgD2K41 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 06:56:27 -0400
Received: from david.siemens.de ([192.35.17.14]:49909 "EHLO david.siemens.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726556AbgD2K41 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 06:56:27 -0400
Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
        by david.siemens.de (8.15.2/8.15.2) with ESMTPS id 03TAtvj5019413
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 29 Apr 2020 12:55:57 +0200
Received: from [167.87.241.229] ([167.87.241.229])
        by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 03TAtuRB023743;
        Wed, 29 Apr 2020 12:55:56 +0200
Subject: Re: [virtio-dev] Re: [PATCH 5/5] virtio: Add bounce DMA ops
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Srivatsa Vaddagiri <vatsa@codeaurora.org>,
        Lu Baolu <baolu.lu@linux.intel.com>, tsoni@codeaurora.org,
        virtio-dev@lists.oasis-open.org, konrad.wilk@oracle.com,
        jasowang@redhat.com, christoffer.dall@arm.com,
        virtualization@lists.linux-foundation.org, alex.bennee@linaro.org,
        iommu@lists.linux-foundation.org, stefano.stabellini@xilinx.com,
        will@kernel.org, linux-kernel@vger.kernel.org,
        pratikp@codeaurora.org
References: <20200428163448-mutt-send-email-mst@kernel.org>
 <275eba4b-dd35-aa95-b2e3-9c5cbf7c6d71@linux.intel.com>
 <20200429004531-mutt-send-email-mst@kernel.org>
 <b676430c-65b3-096e-ca48-ceebf10f4b28@linux.intel.com>
 <20200429023842-mutt-send-email-mst@kernel.org>
 <20200429094410.GD5097@quicinc.com>
 <20200429055125-mutt-send-email-mst@kernel.org>
 <20200429100953.GE5097@quicinc.com>
 <20200429061621-mutt-send-email-mst@kernel.org>
 <f52556e2-253e-2dbc-cb7a-a7991e3bcfde@siemens.com>
 <20200429064458-mutt-send-email-mst@kernel.org>
From:   Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <303ace66-950c-955d-d750-74de5054788a@siemens.com>
Date:   Wed, 29 Apr 2020 12:55:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200429064458-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29.04.20 12:45, Michael S. Tsirkin wrote:
> On Wed, Apr 29, 2020 at 12:26:43PM +0200, Jan Kiszka wrote:
>> On 29.04.20 12:20, Michael S. Tsirkin wrote:
>>> On Wed, Apr 29, 2020 at 03:39:53PM +0530, Srivatsa Vaddagiri wrote:
>>>> That would still not work I think where swiotlb is used for pass-thr devices
>>>> (when private memory is fine) as well as virtio devices (when shared memory is
>>>> required).
>>>
>>> So that is a separate question. When there are multiple untrusted
>>> devices, at the moment it looks like a single bounce buffer is used.
>>>
>>> Which to me seems like a security problem, I think we should protect
>>> untrusted devices from each other.
>>>
>>
>> Definitely. That's the model we have for ivshmem-virtio as well.
>>
>> Jan
> 
> Want to try implementing that?
> 

The desire is definitely there, currently "just" not the time.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux
