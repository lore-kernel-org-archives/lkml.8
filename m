Return-Path: <SRS0=dFdc=BX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B50E5C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 07:05:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E17320716
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 07:05:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726564AbgHMHFe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Aug 2020 03:05:34 -0400
Received: from mx2.suse.de ([195.135.220.15]:40818 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725982AbgHMHFa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Aug 2020 03:05:30 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id A22C1B163;
        Thu, 13 Aug 2020 07:05:50 +0000 (UTC)
Subject: Re: [PATCH v2 0/5] Fixes and improvements for Xen pvdrm
To:     Oleksandr Andrushchenko <Oleksandr_Andrushchenko@epam.com>,
        "boris.ostrovsky@oracle.com" <boris.ostrovsky@oracle.com>
Cc:     Oleksandr Andrushchenko <andr2000@gmail.com>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        "sstabellini@kernel.org" <sstabellini@kernel.org>,
        "dan.carpenter@oracle.com" <dan.carpenter@oracle.com>,
        "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>
References: <20200813062113.11030-1-andr2000@gmail.com>
 <7c8cb6e9-8270-d27a-6480-793ef5599d09@epam.com>
From:   =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
Message-ID: <231ee1e7-c2fa-3c2a-f444-f9f813fc906d@suse.com>
Date:   Thu, 13 Aug 2020 09:05:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <7c8cb6e9-8270-d27a-6480-793ef5599d09@epam.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13.08.20 08:32, Oleksandr Andrushchenko wrote:
> Juergen, Boris,
> 
> can we please merge these via Xen Linux tree as I have collected enough Ack/R-b?
> 
> The series has DRM patches, but those anyway are Xen related, so I think
> 
> this should be fine from DRI point of view.

Yes, fine with me.


Juergen

> 
> Thank you,
> 
> Oleksandr
> 
> On 8/13/20 9:21 AM, Oleksandr Andrushchenko wrote:
>> From: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
>>
>> Hello,
>>
>> This series contains an assorted set of fixes and improvements for
>> the Xen para-virtualized display driver and grant device driver which
>> I have collected over the last couple of months:
>>
>> 1. Minor fixes to grant device driver and drm/xen-front.
>>
>> 2. New format (YUYV) added to the list of the PV DRM supported formats
>> which allows the driver to be used in zero-copying use-cases when
>> a camera device is the source of the dma-bufs.
>>
>> 3. Synchronization with the latest para-virtualized protocol definition
>> in Xen [1].
>>
>> 4. SGT offset is now propagated to the backend: while importing a dmabuf
>> it is possible that the data of the buffer is put with offset which is
>> indicated by the SGT offset. This is needed for some GPUs which have
>> non-zero offset.
>>
>> Thank you,
>> Oleksandr Andrushchenko
>>
>> [1] https://urldefense.com/v3/__https://xenbits.xen.org/gitweb/?p=xen.git;a=commit;h=c27a184225eab54d20435c8cab5ad0ef384dc2c0__;!!GF_29dbcQIUBPA!iAHOdk4M167VNM1AypMGVmyKJu-iqC9e5cXyu6N595Np3iyIZDnZl0MIBX3IROJSD1GSMX_GfQ$ [xenbits[.]xen[.]org]
>>
>> Changes since v1:
>> =================
>>
>> 1. Removed patch which adds EDID to PV DRM as it needs more time for review:
>> "5. Version 2 of the Xen displif protocol adds XENDISPL_OP_GET_EDID
>> request which allows frontends to request EDID structure per
>> connector. This request is optional and if not supported by the
>> backend then visible area is still defined by the relevant
>> XenStore's "resolution" property.
>> If backend provides EDID with XENDISPL_OP_GET_EDID request then
>> its values must take precedence over the resolutions defined in
>> XenStore."
>> I will send this as a dedicated patch.
>>
>> 2. Added missing CC stable for the patches with fixes
>>
>> Oleksandr Andrushchenko (5):
>>     xen/gntdev: Fix dmabuf import with non-zero sgt offset
>>     drm/xen-front: Fix misused IS_ERR_OR_NULL checks
>>     drm/xen-front: Add YUYV to supported formats
>>     xen: Sync up with the canonical protocol definition in Xen
>>     drm/xen-front: Pass dumb buffer data offset to the backend
>>
>>    drivers/gpu/drm/xen/xen_drm_front.c      | 10 +--
>>    drivers/gpu/drm/xen/xen_drm_front.h      |  2 +-
>>    drivers/gpu/drm/xen/xen_drm_front_conn.c |  1 +
>>    drivers/gpu/drm/xen/xen_drm_front_gem.c  | 11 +--
>>    drivers/gpu/drm/xen/xen_drm_front_kms.c  |  2 +-
>>    drivers/xen/gntdev-dmabuf.c              |  8 +++
>>    include/xen/interface/io/displif.h       | 91 +++++++++++++++++++++++-
>>    7 files changed, 111 insertions(+), 14 deletions(-)
>>
> 

