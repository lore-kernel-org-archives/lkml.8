Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AACF3C2BA19
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 11:09:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 840572072D
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 11:09:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438964AbgDNLJB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 07:09:01 -0400
Received: from mga18.intel.com ([134.134.136.126]:24384 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2438931AbgDNLIz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 07:08:55 -0400
IronPort-SDR: u6kdNmN5TsRggkMkk5mTZVz+NJX9HfZcMeoz9KWu6SCGjvq/c4WiU2hSTl4D7jsx3w5dEDPW17
 34yKdSA62AEQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2020 04:08:53 -0700
IronPort-SDR: L9wwlBfNleH1/PNFWLrfG8Jz/cNseahXJi07CLOpQvdthm6csrngaZnL+xYYyhWKxND8O6vUIl
 /JKfUAQ1HUJQ==
X-IronPort-AV: E=Sophos;i="5.72,382,1580803200"; 
   d="scan'208";a="427025903"
Received: from mdoerbec-mobl.ger.corp.intel.com (HELO localhost) ([10.252.38.76])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2020 04:08:51 -0700
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Alex Deucher <alexdeucher@gmail.com>,
        Tang Bin <tangbin@cmss.chinamobile.com>
Cc:     Dave Airlie <airlied@linux.ie>,
        LKML <linux-kernel@vger.kernel.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        Shengju Zhang <zhangshengju@cmss.chinamobile.com>
Subject: Re: [PATCH] drm/dp_mst: Fix drm_dp_mst_topology.c selftest compilation warning
In-Reply-To: <CADnq5_MD6LkOEJC-hKKQSAmFAHY7LMZ2WU_ER-ttNrP20AxoQA@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20200411141740.14584-1-tangbin@cmss.chinamobile.com> <CADnq5_MD6LkOEJC-hKKQSAmFAHY7LMZ2WU_ER-ttNrP20AxoQA@mail.gmail.com>
Date:   Tue, 14 Apr 2020 14:08:48 +0300
Message-ID: <87imi2miin.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Apr 2020, Alex Deucher <alexdeucher@gmail.com> wrote:
> On Mon, Apr 13, 2020 at 5:29 AM Tang Bin <tangbin@cmss.chinamobile.com> wrote:
>>
>> The struct drm_dp_desc contains struct drm_dp_dpcd_ident, and the struct
>> drm_dp_dpcd_ident contains the array, so zero-initialization requires a
>> more couple of braces. In the ARM compiler environment, the compile
>> warning pointing it out:
>>     drivers/gpu/drm/drm_dp_mst_topology.c: In function 'drm_dp_mst_dsc_aux_for_port':
>>     drivers/gpu/drm/drm_dp_mst_topology.c:5494:9: warning: missing braces around initializer [-Wmissing-braces]
>>       struct drm_dp_desc desc = { 0 };
>>
>
> This seems to vary based on compilers.  Maybe a memset would be better.

= {}; will do the trick.

BR,
Jani.


>
> Alex
>
>> Signed-off-by: Tang Bin <tangbin@cmss.chinamobile.com>
>> Signed-off-by: Shengju Zhang <zhangshengju@cmss.chinamobile.com>
>> ---
>>  drivers/gpu/drm/drm_dp_mst_topology.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/drm_dp_mst_topology.c b/drivers/gpu/drm/drm_dp_mst_topology.c
>> index 70c4b7a..4d8d1fd 100644
>> --- a/drivers/gpu/drm/drm_dp_mst_topology.c
>> +++ b/drivers/gpu/drm/drm_dp_mst_topology.c
>> @@ -5494,7 +5494,7 @@ struct drm_dp_aux *drm_dp_mst_dsc_aux_for_port(struct drm_dp_mst_port *port)
>>  {
>>         struct drm_dp_mst_port *immediate_upstream_port;
>>         struct drm_dp_mst_port *fec_port;
>> -       struct drm_dp_desc desc = { 0 };
>> +       struct drm_dp_desc desc = { { { 0 } } };
>>         u8 endpoint_fec;
>>         u8 endpoint_dsc;
>>
>> --
>> 2.7.4
>>
>>
>>
>> _______________________________________________
>> dri-devel mailing list
>> dri-devel@lists.freedesktop.org
>> https://lists.freedesktop.org/mailman/listinfo/dri-devel
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Jani Nikula, Intel Open Source Graphics Center
