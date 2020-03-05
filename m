Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A81DC3F2CD
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 10:06:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59F3D2072D
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 10:06:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727023AbgCEKGM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 05:06:12 -0500
Received: from mga05.intel.com ([192.55.52.43]:50767 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725946AbgCEKGL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 05:06:11 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Mar 2020 02:06:11 -0800
X-IronPort-AV: E=Sophos;i="5.70,517,1574150400"; 
   d="scan'208";a="229647700"
Received: from bennur-mobl1.ger.corp.intel.com (HELO localhost) ([10.249.38.13])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Mar 2020 02:06:01 -0800
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Rajat Jain <rajatja@google.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Ville =?utf-8?B?U3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Imre Deak <imre.deak@intel.com>,
        =?utf-8?Q?Jo?= =?utf-8?Q?s=C3=A9?= Roberto de Souza 
        <jose.souza@intel.com>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        gregkh@linuxfoundation.org, mathewk@google.com,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>, Pavel Machek <pavel@denx.de>,
        seanpaul@google.com, Duncan Laurie <dlaurie@google.com>,
        jsbarnes@google.com, Thierry Reding <thierry.reding@gmail.com>,
        mpearson@lenovo.com, Nitin Joshi1 <njoshi1@lenovo.com>,
        Sugumaran Lacshiminarayanan <slacshiminar@lenovo.com>,
        Tomoki Maruichi <maruichit@lenovo.com>
Cc:     Rajat Jain <rajatja@google.com>, rajatxjain@gmail.com
Subject: Re: [PATCH v6 1/3] intel_acpi: Rename drm_dev local variable to dev
In-Reply-To: <20200305011943.214146-1-rajatja@google.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20200305011943.214146-1-rajatja@google.com>
Date:   Thu, 05 Mar 2020 12:06:01 +0200
Message-ID: <87h7z3nmk6.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 04 Mar 2020, Rajat Jain <rajatja@google.com> wrote:
> Change the struct drm_device * local variable from drm_dev to dev
> per the feedback received here:
> https://lkml.org/lkml/2020/1/24/1143

I don't know what's up with the two identical (or similar) threads here,
but I replied in the thread starting at [1]. Please let's keep the
discussion there.

BR,
Jani.

[1] http://patchwork.freedesktop.org/patch/msgid/20200305012338.219746-2-rajatja@google.com

-- 
Jani Nikula, Intel Open Source Graphics Center
