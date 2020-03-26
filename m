Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2AE8C43331
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 22:15:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E5C220658
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 22:15:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727682AbgCZWPS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 18:15:18 -0400
Received: from mga06.intel.com ([134.134.136.31]:26250 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727495AbgCZWPS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 18:15:18 -0400
IronPort-SDR: nSLRfP7HexFyQknZJOfNDHV0KVVlceNf2I4HZdaHO51wL1adztofcCfwXpak8BFV6XqnH50/mZ
 U6Unn+7CkmqQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2020 15:15:16 -0700
IronPort-SDR: CKUk0FCouSsk7al6Cj8rQPk+zMLDVT1BC0SFC1EzauelJhK0bySNnImENlWjDo4/4SL+s6i+Y7
 qWoql0QiJ4nw==
X-IronPort-AV: E=Sophos;i="5.72,309,1580803200"; 
   d="scan'208";a="420877850"
Received: from mschuste-mobl3.ger.corp.intel.com (HELO localhost) ([10.252.32.130])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2020 15:15:12 -0700
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc:     Michel =?utf-8?Q?D=C3=A4nzer?= <michel@daenzer.net>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        intel-gfx@lists.freedesktop.org,
        LKML <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Subject: Re: [PATCH] drm/i915: Cast remain to unsigned long in eb_relocate_vma
In-Reply-To: <20200326201158.GA30083@ubuntu-m2-xlarge-x86>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20200214054706.33870-1-natechancellor@gmail.com> <87v9o965gg.fsf@intel.com> <158166913989.4660.10674824117292988120@skylake-alporthouse-com> <87o8u1wfqs.fsf@intel.com> <ff302c03-d012-a80d-b818-b7feababb86b@daenzer.net> <CAKwvOdnaRG=7mib9vtWX4wkjQXHeUiioonTaZLStMVXfOOSUfw@mail.gmail.com> <20200326201158.GA30083@ubuntu-m2-xlarge-x86>
Date:   Fri, 27 Mar 2020 00:15:09 +0200
Message-ID: <87r1xehifm.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Mar 2020, Nathan Chancellor <natechancellor@gmail.com> wrote:
> This is the only warning on an x86_64 defconfig build. Apologies if we
> are being too persistent or nagging but we need guidance from the i915
> maintainers on which solution they would prefer so it can be picked up.
> I understand you all are busy and I appreciate the work you all do but
> I do not want this to fall between the cracks because it is annoying to
> constantly see this warning.

Apologies for the delay. As I replied first thing in this thread, this
works for me. Thanks for the patch, pushed to drm-intel-next-queued.

BR,
Jani.


-- 
Jani Nikula, Intel Open Source Graphics Center
