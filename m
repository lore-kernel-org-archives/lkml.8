Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBE4EC3F2D6
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 09:42:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E99A20866
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 09:42:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726251AbgCFJmN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 04:42:13 -0500
Received: from mga12.intel.com ([192.55.52.136]:52520 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726069AbgCFJmN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 04:42:13 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Mar 2020 01:42:12 -0800
X-IronPort-AV: E=Sophos;i="5.70,521,1574150400"; 
   d="scan'208";a="234747642"
Received: from jnikula-mobl3.fi.intel.com (HELO localhost) ([10.237.66.161])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Mar 2020 01:42:03 -0800
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Rajat Jain <rajatja@google.com>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Ville =?utf-8?B?U3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Imre Deak <imre.deak@intel.com>,
        =?utf-8?Q?Jo?= =?utf-8?Q?s=C3=A9?= Roberto de Souza 
        <jose.souza@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        intel-gfx@lists.freedesktop.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mat King <mathewk@google.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>, Pavel Machek <pavel@denx.de>,
        Sean Paul <seanpaul@google.com>,
        Duncan Laurie <dlaurie@google.com>,
        Jesse Barnes <jsbarnes@google.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Mark Pearson <mpearson@lenovo.com>,
        Nitin Joshi1 <njoshi1@lenovo.com>,
        Sugumaran Lacshiminarayanan <slacshiminar@lenovo.com>,
        Tomoki Maruichi <maruichit@lenovo.com>,
        Rajat Jain <rajatxjain@gmail.com>
Subject: Re: [PATCH v6 2/3] drm/i915: Lookup and attach ACPI device node for connectors
In-Reply-To: <CACK8Z6HRB9q1KeborGr7V-0Qp0AApHV6gBTkc6xD5NokH8gr0w@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20200305012338.219746-1-rajatja@google.com> <20200305012338.219746-3-rajatja@google.com> <87o8tbnnqa.fsf@intel.com> <CACK8Z6HRB9q1KeborGr7V-0Qp0AApHV6gBTkc6xD5NokH8gr0w@mail.gmail.com>
Date:   Fri, 06 Mar 2020 11:42:00 +0200
Message-ID: <87tv31om53.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 05 Mar 2020, Rajat Jain <rajatja@google.com> wrote:
> On Thu, Mar 5, 2020 at 1:41 AM Jani Nikula <jani.nikula@linux.intel.com> wrote:
>>
>> On Wed, 04 Mar 2020, Rajat Jain <rajatja@google.com> wrote:
>> 1) See if we can postpone creating and attaching properties to connector
>> ->late_register hook. (I didn't have the time to look into it yet, at
>> all.)
>
> Apparently not. The drm core doesn't like to add properties in
> late_register() callback. I just tried it and get this warning:

I kind of had a feeling this would be the case, thanks for checking.

>> 2) Provide a way to populate connector->acpi_device_id and
>> connector->acpi_handle on a per-connector basis. At least the device id
>> remains constant for the lifetime of the drm_device
>
> Are you confirming that the connector->acpi_device_id remains constant
> for the lifetime of the drm_device, as calculated in
> intel_acpi_device_id_update()?  Even in the face of external displays
> (monitors) being connected and disconnected during the lifetime of the
> system? If so, then I think we can have a solution.

First I thought so. Alas it does not hold for DP MST, where you can have
connectors added and removed dynamically. I think we could ensure they
stay the same for all other connectors though. I'm pretty sure this is
already the case; they get added/removed after all others.

Another thought, from the ACPI perspective, I'm not sure the dynamically
added/removed DP MST connectors should even have acpi handles. But
again, tying all this together with ACPI stuff is not something I am an
expert on.

>> (why do we keep
>> updating it at every resume?!) but can we be sure ->acpi_handle does
>> too? (I don't really know my way around ACPI.)
>
> I don't understand why this was being updated on every resume in that
> case (this existed even before my patchset). I believe we do not need
> it. Yes, the ->acpi_handle will not change if the ->acpi_device_id
> does not change. I believe the way forward should then be to populate
> connector->acpi_device_id and connector->acpi_handle ONE TIME at the
> time of connector init (and not update it on every resume). Does this
> sound ok?

If a DP MST connector gets removed, should the other ACPI display
indexes after that shift, or remain the same? I really don't know.

BR,
Jani.

-- 
Jani Nikula, Intel Open Source Graphics Center
