Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10E4DC33CAD
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 12:08:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0A04207FD
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 12:08:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728777AbgAMMI3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 07:08:29 -0500
Received: from mga01.intel.com ([192.55.52.88]:53741 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726934AbgAMMI2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 07:08:28 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Jan 2020 04:08:28 -0800
X-IronPort-AV: E=Sophos;i="5.69,428,1571727600"; 
   d="scan'208";a="217387846"
Received: from jnikula-mobl3.fi.intel.com (HELO localhost) ([10.237.66.161])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Jan 2020 04:08:25 -0800
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Chris Wilson <chris@chris-wilson.co.uk>,
        Wambui Karuga <wambui.karugax@gmail.com>, airlied@linux.ie,
        daniel@ffwll.ch, joonas.lahtinen@linux.intel.com,
        rodrigo.vivi@intel.com
Cc:     sean@poorly.run, intel-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/i915: convert to new logging macros based on struct intel_engine_cs.
In-Reply-To: <157891427231.27314.12398974277241668021@skylake-alporthouse-com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20200113111025.2048-1-wambui.karugax@gmail.com> <157891427231.27314.12398974277241668021@skylake-alporthouse-com>
Date:   Mon, 13 Jan 2020 14:08:22 +0200
Message-ID: <87lfqbmudl.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Jan 2020, Chris Wilson <chris@chris-wilson.co.uk> wrote:
> Quoting Wambui Karuga (2020-01-13 11:10:25)
>> fn(...) {
>> ...
>> struct intel_engine_cs *E = ...;
>> +struct drm_i915_private *dev_priv = E->i915;
>
> No new dev_priv.

Wambui, we're gradually converting all dev_priv variable and parameter
names to i915.

> There should be no reason for drm_dbg here, as the rest of the debug is
> behind ENGINE_TRACE and so the vestigial debug should be moved over, or
> deleted as not being useful.
>
> The error messages look unhelpful.

I don't think you can expect any meaninful improvements on the debug
message contents from Wambui without detailed help at this point.

>
>>                 if ((batch_end - cmd) < length) {
>> -                       DRM_DEBUG("CMD: Command length exceeds batch length: 0x%08X length=%u batchlen=%td\n",
>> -                                 *cmd,
>> -                                 length,
>> -                                 batch_end - cmd);
>> +                       drm_dbg(&dev_priv->drm,
>> +                               "CMD: Command length exceeds batch length: 0x%08X length=%u batchlen=%td\n",
>
> No. This is not driver debug. If anything this should be pr_debug, or
> some over user centric channel.

I'm sorry, I still don't understand your reasoning here.

BR,
Jani.

-- 
Jani Nikula, Intel Open Source Graphics Center
