Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3787C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 06:39:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B44B322B40
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 06:39:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726210AbgHDGjo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 02:39:44 -0400
Received: from mx2.suse.de ([195.135.220.15]:42806 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725300AbgHDGjo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 02:39:44 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 2CA57AC20;
        Tue,  4 Aug 2020 06:39:58 +0000 (UTC)
Subject: Re: [PATCH 2/6] drm/xen-front: Fix misused IS_ERR_OR_NULL checks
To:     Oleksandr Andrushchenko <Oleksandr_Andrushchenko@epam.com>,
        Oleksandr Andrushchenko <andr2000@gmail.com>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "boris.ostrovsky@oracle.com" <boris.ostrovsky@oracle.com>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>
Cc:     "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
        "sstabellini@kernel.org" <sstabellini@kernel.org>,
        "dan.carpenter@oracle.com" <dan.carpenter@oracle.com>
References: <20200731125109.18666-1-andr2000@gmail.com>
 <20200731125109.18666-3-andr2000@gmail.com>
 <6d719ab2-d9f6-2c3c-8979-b12a4d10b96d@suse.com>
 <0ed5082f-0280-16c0-7410-f6a90262bcee@epam.com>
From:   =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
Message-ID: <1ae2e8b4-eea3-e68b-2897-5e376a688881@suse.com>
Date:   Tue, 4 Aug 2020 08:39:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <0ed5082f-0280-16c0-7410-f6a90262bcee@epam.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04.08.20 08:35, Oleksandr Andrushchenko wrote:
> 
> On 8/4/20 9:12 AM, Jürgen Groß wrote:
>> On 31.07.20 14:51, Oleksandr Andrushchenko wrote:
>>> From: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
>>>
>>> The patch c575b7eeb89f: "drm/xen-front: Add support for Xen PV
>>> display frontend" from Apr 3, 2018, leads to the following static
>>> checker warning:
>>>
>>>      drivers/gpu/drm/xen/xen_drm_front_gem.c:140 xen_drm_front_gem_create()
>>>      warn: passing zero to 'ERR_CAST'
>>>
>>> drivers/gpu/drm/xen/xen_drm_front_gem.c
>>>      133  struct drm_gem_object *xen_drm_front_gem_create(struct drm_device *dev,
>>>      134                                                  size_t size)
>>>      135  {
>>>      136          struct xen_gem_object *xen_obj;
>>>      137
>>>      138          xen_obj = gem_create(dev, size);
>>>      139          if (IS_ERR_OR_NULL(xen_obj))
>>>      140                  return ERR_CAST(xen_obj);
>>>
>>> Fix this and the rest of misused places with IS_ERR_OR_NULL in the
>>> driver.
>>>
>>> Fixes:  c575b7eeb89f: "drm/xen-front: Add support for Xen PV display frontend"
>>
>> Again forgot to Cc stable?
> 
> I was just not sure if these minor fixes need to go the stable, but I will add

I'm fine both ways.

Its just a reflex when I'm seeing a Fixes: tag but no Cc: stable. :-)


Juergen
