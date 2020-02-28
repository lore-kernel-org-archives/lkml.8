Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7CC9C3F2D1
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 09:26:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9493524695
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 09:26:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726809AbgB1J0E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 04:26:04 -0500
Received: from mga04.intel.com ([192.55.52.120]:10624 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726063AbgB1J0E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 04:26:04 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Feb 2020 01:26:03 -0800
X-IronPort-AV: E=Sophos;i="5.70,495,1574150400"; 
   d="scan'208";a="411350937"
Received: from jnikula-mobl3.fi.intel.com (HELO localhost) ([10.237.66.161])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Feb 2020 01:26:01 -0800
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Randy Dunlap <rdunlap@infradead.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     intel-gfx <intel-gfx@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
Subject: Re: [Intel-gfx] linux-next: Tree for Feb 28 (gpu/drm/i915/display/intel_display.c)
In-Reply-To: <01c2a164-7165-e48f-6972-8fd6517f548b@infradead.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20200228154214.78523ad7@canb.auug.org.au> <01c2a164-7165-e48f-6972-8fd6517f548b@infradead.org>
Date:   Fri, 28 Feb 2020 11:25:58 +0200
Message-ID: <871rqfqd09.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Feb 2020, Randy Dunlap <rdunlap@infradead.org> wrote:
> On 2/27/20 8:42 PM, Stephen Rothwell wrote:
>> Hi all,
>> 
>> Changes since 20200227:
>> 
>
> on i386:
>
> ../drivers/gpu/drm/i915/display/intel_display.c:252:1: error: 'has_transcoder' defined but not used [-Werror=unused-function]
>  has_transcoder(struct drm_i915_private *dev_priv, enum transcoder cpu_transcoder)
>  ^~~~~~~~~~~~~~
>
>
> Full randconfig file is attached.

Fix is:

http://patchwork.freedesktop.org/patch/msgid/20200227175147.11362-1-anshuman.gupta@intel.com

BR,
Jani.

-- 
Jani Nikula, Intel Open Source Graphics Center
