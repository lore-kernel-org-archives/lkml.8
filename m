Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB389C2BA19
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 09:07:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D152D206E9
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 09:07:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408278AbgDOJH6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 05:07:58 -0400
Received: from mga03.intel.com ([134.134.136.65]:25045 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2408269AbgDOJHx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 05:07:53 -0400
IronPort-SDR: mcDPuQ8ZC2YWJwiaZaEe7oX4/W6f0bJCaPwY07F8R+QzbMd1Dw/VHInAhiX6l0P3VB4u1DZfHT
 Z2dzdWN3riqg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2020 02:07:52 -0700
IronPort-SDR: dIcvUqmm8vkltmzBbRt7swG9EIHcpliBK18dHSes44YOxPl9GSHu+CpHbMxzexYHs+shu+VVQy
 da/XylUQ7VEQ==
X-IronPort-AV: E=Sophos;i="5.72,386,1580803200"; 
   d="scan'208";a="427370602"
Received: from ssolodk-mobl1.ccr.corp.intel.com (HELO localhost) ([10.252.48.37])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2020 02:07:47 -0700
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Colin Ian King <colin.king@canonical.com>,
        Dan Carpenter <dan.carpenter@oracle.com>, kbuild@lists.01.org
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/i915/gt: remove redundant assignment to variable x
In-Reply-To: <43eb0cbb-9bf0-c99a-470d-8121c3108a5e@canonical.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20200414092359.GC1163@kadam> <43eb0cbb-9bf0-c99a-470d-8121c3108a5e@canonical.com>
Date:   Wed, 15 Apr 2020 12:07:44 +0300
Message-ID: <87blnt5d7j.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Apr 2020, Colin Ian King <colin.king@canonical.com> wrote:
> Hi Dan,
>
> I'd post a revert, but I don't seem to see an upstream commit for this
> this to revert against. What's the revert policy in these cases? Or can
> the patch be just ignored by the maintainers so it's not applied?

It has not been applied, and will be ignored, in part thanks to the
report.

However I think Dan's report is misleading in that it looks like it's
about a commit while I think it should emphasize that it's a pre-merge
report on the patch on the mailing list.

BR,
Jani.



>
> Colin
>
>
> On 14/04/2020 10:23, Dan Carpenter wrote:
>> Hi Colin,
>> 
>> url:    https://github.com/0day-ci/linux/commits/Colin-King/drm-i915-gt-remove-redundant-assignment-to-variable-x/20200411-032731
>> base:   git://anongit.freedesktop.org/drm-intel for-linux-next
>> 
>> If you fix the issue, kindly add following tag as appropriate
>> Reported-by: kbuild test robot <lkp@intel.com>
>> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
>> 
>> smatch warnings:
>> drivers/gpu/drm/i915/gt/intel_engine_cs.c:1210 print_request() error: uninitialized symbol 'x'.
>> 
>> # https://github.com/0day-ci/linux/commit/6ee08d455bba0066e8f5f276dcd43d9e3e594dc5
>> git remote add linux-review https://github.com/0day-ci/linux
>> git remote update linux-review
>> git checkout 6ee08d455bba0066e8f5f276dcd43d9e3e594dc5
>> vim +/x +1210 drivers/gpu/drm/i915/gt/intel_engine_cs.c
>> 
>> f636edb214a5ff drivers/gpu/drm/i915/intel_engine_cs.c    Chris Wilson   2017-10-09  1202  static void print_request(struct drm_printer *m,
>> e61e0f51ba7974 drivers/gpu/drm/i915/intel_engine_cs.c    Chris Wilson   2018-02-21  1203  			  struct i915_request *rq,
>> f636edb214a5ff drivers/gpu/drm/i915/intel_engine_cs.c    Chris Wilson   2017-10-09  1204  			  const char *prefix)
>> f636edb214a5ff drivers/gpu/drm/i915/intel_engine_cs.c    Chris Wilson   2017-10-09  1205  {
>> ab2681512b4c10 drivers/gpu/drm/i915/intel_engine_cs.c    Chris Wilson   2018-03-14  1206  	const char *name = rq->fence.ops->get_timeline_name(&rq->fence);
>> 96d4f03c20d04c drivers/gpu/drm/i915/intel_engine_cs.c    Chris Wilson   2018-05-17  1207  	char buf[80] = "";
>> 6ee08d455bba00 drivers/gpu/drm/i915/gt/intel_engine_cs.c Colin Ian King 2020-04-10  1208  	int x;
>>                                                                                                 ^^^^^
>> 
>> 247870ac8ea729 drivers/gpu/drm/i915/intel_engine_cs.c    Chris Wilson   2018-04-24  1209  
>> 247870ac8ea729 drivers/gpu/drm/i915/intel_engine_cs.c    Chris Wilson   2018-04-24 @1210  	x = print_sched_attr(rq->i915, &rq->sched.attr, buf, x, sizeof(buf));
>>                                                                                                                                                      ^
>> Uninitialized variable
>> 
>> ab2681512b4c10 drivers/gpu/drm/i915/intel_engine_cs.c    Chris Wilson   2018-03-14  1211  
>> b300fde8965fdd drivers/gpu/drm/i915/intel_engine_cs.c    Chris Wilson   2019-02-26  1212  	drm_printf(m, "%s %llx:%llx%s%s %s @ %dms: %s\n",
>> b7268c5eed0ab4 drivers/gpu/drm/i915/intel_engine_cs.c    Chris Wilson   2018-04-18  1213  		   prefix,
>> b300fde8965fdd drivers/gpu/drm/i915/intel_engine_cs.c    Chris Wilson   2019-02-26  1214  		   rq->fence.context, rq->fence.seqno,
>> 8547444137ec61 drivers/gpu/drm/i915/intel_engine_cs.c    Chris Wilson   2019-01-29  1215  		   i915_request_completed(rq) ? "!" :
>> 8547444137ec61 drivers/gpu/drm/i915/intel_engine_cs.c    Chris Wilson   2019-01-29  1216  		   i915_request_started(rq) ? "*" :
>> 8547444137ec61 drivers/gpu/drm/i915/intel_engine_cs.c    Chris Wilson   2019-01-29  1217  		   "",
>> 8c334f24e3b448 drivers/gpu/drm/i915/gt/intel_engine_cs.c Chris Wilson   2019-05-01  1218  		   test_bit(DMA_FENCE_FLAG_SIGNALED_BIT,
>> 8c334f24e3b448 drivers/gpu/drm/i915/gt/intel_engine_cs.c Chris Wilson   2019-05-01  1219  			    &rq->fence.flags) ? "+" :
>> 52c0fdb25c7c91 drivers/gpu/drm/i915/intel_engine_cs.c    Chris Wilson   2019-01-29  1220  		   test_bit(DMA_FENCE_FLAG_ENABLE_SIGNAL_BIT,
>> 8c334f24e3b448 drivers/gpu/drm/i915/gt/intel_engine_cs.c Chris Wilson   2019-05-01  1221  			    &rq->fence.flags) ? "-" :
>> 8c334f24e3b448 drivers/gpu/drm/i915/gt/intel_engine_cs.c Chris Wilson   2019-05-01  1222  		   "",
>> 247870ac8ea729 drivers/gpu/drm/i915/intel_engine_cs.c    Chris Wilson   2018-04-24  1223  		   buf,
>> f636edb214a5ff drivers/gpu/drm/i915/intel_engine_cs.c    Chris Wilson   2017-10-09  1224  		   jiffies_to_msecs(jiffies - rq->emitted_jiffies),
>> ab2681512b4c10 drivers/gpu/drm/i915/intel_engine_cs.c    Chris Wilson   2018-03-14  1225  		   name);
>> f636edb214a5ff drivers/gpu/drm/i915/intel_engine_cs.c    Chris Wilson   2017-10-09  1226  }
>> 
>> ---
>> 0-DAY CI Kernel Test Service, Intel Corporation
>> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
>> 
>

-- 
Jani Nikula, Intel Open Source Graphics Center
