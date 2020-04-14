Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34625C2BB86
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 11:18:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 137C220644
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 11:18:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438997AbgDNLSK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 07:18:10 -0400
Received: from mga03.intel.com ([134.134.136.65]:10775 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728734AbgDNLSD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 07:18:03 -0400
IronPort-SDR: svRA+yTn53LwaZbY5y/PuGL2RpUfEsOLOfT86lsRFDglgwu1bwOQQdR3x5TVgvw6cJA9/BnKus
 oH+bVJ4HW3HQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2020 04:18:03 -0700
IronPort-SDR: ja267ebaQ9w4t55QmJPranFoVXx+4cvcrpwcVGbI8B0YFKIgy+eSJqoJfG4sOiZogYLjr/HyON
 pRcKinROhUmQ==
X-IronPort-AV: E=Sophos;i="5.72,382,1580803200"; 
   d="scan'208";a="427028399"
Received: from mdoerbec-mobl.ger.corp.intel.com (HELO localhost) ([10.252.38.76])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2020 04:18:00 -0700
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Simon Ser <contact@emersion.fr>, Yussuf Khalil <dev@pp3345.net>
Cc:     Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel\@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH 5/5] drm/i915: Replace "Broadcast RGB" with "RGB quantization range" property
In-Reply-To: <daCvJk4O6rHOwEometGSPENJupb6adPr583_dLEetvftUQPbK4198VDijHGzM9uTm9bP3TEyGCZvxKe5PSvqWBg5xhXkL_7EiAQlmEPKWQI=@emersion.fr>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20200413214024.46500-1-dev@pp3345.net> <20200413214024.46500-6-dev@pp3345.net> <daCvJk4O6rHOwEometGSPENJupb6adPr583_dLEetvftUQPbK4198VDijHGzM9uTm9bP3TEyGCZvxKe5PSvqWBg5xhXkL_7EiAQlmEPKWQI=@emersion.fr>
Date:   Tue, 14 Apr 2020 14:17:57 +0300
Message-ID: <87ftd6mi3e.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Apr 2020, Simon Ser <contact@emersion.fr> wrote:
> On Monday, April 13, 2020 11:40 PM, Yussuf Khalil <dev@pp3345.net> wrote:
>
>> DRM now has a globally available "RGB quantization range" connector
>> property. i915's "Broadcast RGB" that fulfils the same purpose is now
>> considered deprecated, so drop it in favor of the DRM property.
>
> For a UAPI point-of-view, I'm not sure this is fine. Some user-space
> might depend on this property, dropping it would break such user-space.

Agreed.

> Can we make this property deprecated but still keep it for backwards
> compatibility?

Would be nice to make the i915 specific property an "alias" for the new
property, however I'm not sure how you'd make that happen. Otherwise
juggling between the two properties is going to be a nightmare.

BR,
Jani.


-- 
Jani Nikula, Intel Open Source Graphics Center
