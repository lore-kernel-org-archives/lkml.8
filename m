Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B092C33CB1
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 14:11:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E054624672
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 14:11:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728884AbgANOLt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 09:11:49 -0500
Received: from mga09.intel.com ([134.134.136.24]:30864 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725904AbgANOLs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 09:11:48 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Jan 2020 06:11:48 -0800
X-IronPort-AV: E=Sophos;i="5.69,433,1571727600"; 
   d="scan'208";a="213344121"
Received: from jnikula-mobl3.fi.intel.com (HELO localhost) ([10.237.66.161])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Jan 2020 06:11:43 -0800
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        joonas.lahtinen@linux.intel.com, rodrigo.vivi@intel.com,
        airlied@linux.ie, daniel@ffwll.ch
Cc:     ville.syrjala@linux.intel.com, swati2.sharma@intel.com,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] drm/i915: Re-init lspcon after HPD if lspcon probe failed
In-Reply-To: <85235F00-7FBA-46E4-B7A5-45294DE1B824@canonical.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20191224084251.28414-1-kai.heng.feng@canonical.com> <85235F00-7FBA-46E4-B7A5-45294DE1B824@canonical.com>
Date:   Tue, 14 Jan 2020 16:11:40 +0200
Message-ID: <87ftgiku03.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 06 Jan 2020, Kai-Heng Feng <kai.heng.feng@canonical.com> wrote:
> Hi Jani,
>
>> On Dec 24, 2019, at 16:42, Kai-Heng Feng <kai.heng.feng@canonical.com> wrote:
>> 
>> On HP 800 G4 DM, if HDMI cable isn't plugged before boot, the HDMI port
>> becomes useless and never responds to cable hotplugging:
>> [    3.031904] [drm:lspcon_init [i915]] *ERROR* Failed to probe lspcon
>> [    3.031945] [drm:intel_ddi_init [i915]] *ERROR* LSPCON init failed on port D
>> 
>> Seems like the lspcon chip on the system in question only gets powered
>> after the cable is plugged.
>> 
>> So let's call lspcon_init() dynamically to properly initialize the
>> lspcon chip and make HDMI port work.
>
> Do you have any further suggestion for this patch?

Sorry for taking so long. Comments inline.

>
> Kai-Heng
>
>> 
>> Closes: https://gitlab.freedesktop.org/drm/intel/issues/203
>> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
>> ---
>> v3:
>> - Make sure it's handled under long HPD case.
>> 
>> v2: 
>> - Move lspcon_init() inside of intel_dp_hpd_pulse().
>> 
>> drivers/gpu/drm/i915/display/intel_dp.c | 8 +++++++-
>> 1 file changed, 7 insertions(+), 1 deletion(-)
>> 
>> diff --git a/drivers/gpu/drm/i915/display/intel_dp.c b/drivers/gpu/drm/i915/display/intel_dp.c
>> index fe31bbfd6c62..a72c9c041c60 100644
>> --- a/drivers/gpu/drm/i915/display/intel_dp.c
>> +++ b/drivers/gpu/drm/i915/display/intel_dp.c
>> @@ -6573,6 +6573,7 @@ enum irqreturn
>> intel_dp_hpd_pulse(struct intel_digital_port *intel_dig_port, bool long_hpd)
>> {
>> 	struct intel_dp *intel_dp = &intel_dig_port->dp;
>> +	struct drm_i915_private *dev_priv = dp_to_i915(intel_dp);
>> 
>> 	if (long_hpd && intel_dig_port->base.type == INTEL_OUTPUT_EDP) {
>> 		/*
>> @@ -6593,7 +6594,12 @@ intel_dp_hpd_pulse(struct intel_digital_port *intel_dig_port, bool long_hpd)
>> 		      long_hpd ? "long" : "short");
>> 
>> 	if (long_hpd) {
>> -		intel_dp->reset_link_params = true;
>> +		if (intel_dig_port->base.type == INTEL_OUTPUT_DDI &&
>> +		    HAS_LSPCON(dev_priv) && !intel_dig_port->lspcon.active)
>> +			lspcon_init(intel_dig_port);
>> +		else
>> +			intel_dp->reset_link_params = true;
>> +

Hmm, I think this will try to init lspcon on ports that do not have
lspcon. Also, why wouldn't we reset the params?

I think this boils down to just adding the following lines:

	if (intel_bios_is_lspcon_present(dev_priv, intel_dig_port->base.port) &&
            !intel_dig_port->lspcon.active)
		lspcon_init(intel_dig_port);


Ville?

BR,
Jani.

>> 		return IRQ_NONE;
>> 	}
>> 
>> -- 
>> 2.17.1
>> 
>

-- 
Jani Nikula, Intel Open Source Graphics Center
