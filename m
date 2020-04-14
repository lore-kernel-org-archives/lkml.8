Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5639C2BA19
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 11:21:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CAC93206B6
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 11:21:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438984AbgDNLVR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 07:21:17 -0400
Received: from mga11.intel.com ([192.55.52.93]:5622 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728758AbgDNLVN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 07:21:13 -0400
IronPort-SDR: fNMUvguwHjGPosPtqN7qT1OTZHVMJ7z+1V6Kse1SXGOrnLZT89CJTWWgz1T2mHNM7Rwu/bpwVO
 wcOL3B698itA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2020 04:21:12 -0700
IronPort-SDR: nBh+HDJOG1IQJScmUMIMFGy/LFqCdBemrRKIn7RuiyV93w4yPA5GwtKIR6yoVpjAtr89ryOHZW
 3VEk34ZEzXzw==
X-IronPort-AV: E=Sophos;i="5.72,382,1580803200"; 
   d="scan'208";a="399921309"
Received: from mdoerbec-mobl.ger.corp.intel.com (HELO localhost) ([10.252.38.76])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2020 04:21:09 -0700
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Simon Ser <contact@emersion.fr>, Yussuf Khalil <dev@pp3345.net>
Cc:     Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel\@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH 5/5] drm/i915: Replace "Broadcast RGB" with "RGB quantization range" property
In-Reply-To: <87ftd6mi3e.fsf@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20200413214024.46500-1-dev@pp3345.net> <20200413214024.46500-6-dev@pp3345.net> <daCvJk4O6rHOwEometGSPENJupb6adPr583_dLEetvftUQPbK4198VDijHGzM9uTm9bP3TEyGCZvxKe5PSvqWBg5xhXkL_7EiAQlmEPKWQI=@emersion.fr> <87ftd6mi3e.fsf@intel.com>
Date:   Tue, 14 Apr 2020 14:21:06 +0300
Message-ID: <87d08amhy5.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Apr 2020, Jani Nikula <jani.nikula@linux.intel.com> wrote:
> On Mon, 13 Apr 2020, Simon Ser <contact@emersion.fr> wrote:
>> On Monday, April 13, 2020 11:40 PM, Yussuf Khalil <dev@pp3345.net> wrote:
>>
>>> DRM now has a globally available "RGB quantization range" connector
>>> property. i915's "Broadcast RGB" that fulfils the same purpose is now
>>> considered deprecated, so drop it in favor of the DRM property.
>>
>> For a UAPI point-of-view, I'm not sure this is fine. Some user-space
>> might depend on this property, dropping it would break such user-space.
>
> Agreed.
>
>> Can we make this property deprecated but still keep it for backwards
>> compatibility?
>
> Would be nice to make the i915 specific property an "alias" for the new
> property, however I'm not sure how you'd make that happen. Otherwise
> juggling between the two properties is going to be a nightmare.

Ah, the obvious easy choice is to use the property and enum names
already being used by i915 and gma500, and you have no problem. Perhaps
they're not the names you'd like, but then looking at the total lack of
consistency across property naming makes them fit right in. ;)

BR,
Jani.


-- 
Jani Nikula, Intel Open Source Graphics Center
