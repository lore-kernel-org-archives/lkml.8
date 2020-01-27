Return-Path: <SRS0=1cir=3Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1135EC32771
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 09:17:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D922E21569
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 09:17:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729188AbgA0JRj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jan 2020 04:17:39 -0500
Received: from mga04.intel.com ([192.55.52.120]:23622 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727306AbgA0JRj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jan 2020 04:17:39 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Jan 2020 01:17:39 -0800
X-IronPort-AV: E=Sophos;i="5.70,369,1574150400"; 
   d="scan'208";a="221679165"
Received: from jpanina-mobl.ger.corp.intel.com (HELO localhost) ([10.252.52.12])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Jan 2020 01:17:35 -0800
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Chris Wilson <chris@chris-wilson.co.uk>,
        Wambui Karuga <wambui.karugax@gmail.com>, airlied@linux.ie,
        daniel@ffwll.ch, dri-devel@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, joonas.lahtinen@linux.intel.com,
        linux-kernel@vger.kernel.org, rodrigo.vivi@intel.com
Subject: Re: [PATCH 0/2] drm/i915/gem: conversion to new drm logging macros
In-Reply-To: <157996851987.2524.2577321446102599250@skylake-alporthouse-com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20200122125750.9737-1-wambui.karugax@gmail.com> <157996851987.2524.2577321446102599250@skylake-alporthouse-com>
Date:   Mon, 27 Jan 2020 11:17:37 +0200
Message-ID: <871rrlcl72.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 25 Jan 2020, Chris Wilson <chris@chris-wilson.co.uk> wrote:
> Quoting Wambui Karuga (2020-01-22 12:57:48)
>> This series is a part of the conversion to  the new struct drm_device
>> based logging macros in drm/i915.
>> This series focuses on the drm/i915/gem directory and converts all
>> straightforward instances of the printk based logging macros to the new
>> macros.
>
> Overall, I'm not keen on this as it perpetuates the mistake of putting
> client debug message in dmesg and now gives them even more an air of
> being device driver debug messages. We need a mechanism by which we
> report the details of what a client did wrong back to that client
> (tracefs + context/client getparam to return an isolated debug fd is my
> idea).

I don't disagree, but I also don't think this makes things (much) worse
in that regard.

>
>> Wambui Karuga (2):
>>   drm/i915/gem: initial conversion to new logging macros using
>>     coccinelle.
>>   drm/i915/gem: manual conversion to struct drm_device logging macros.
>
> Still this is a necessary evil for the current situation,
> Acked-by: Chris Wilson <chris@chris-wilson.co.uk>

Thanks, pushed both.

BR,
Jani.


-- 
Jani Nikula, Intel Open Source Graphics Center
