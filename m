Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 795F6C433E2
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 11:54:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5AAA320760
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 11:54:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728708AbgFJLyk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 07:54:40 -0400
Received: from mga17.intel.com ([192.55.52.151]:65355 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728497AbgFJLyk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 07:54:40 -0400
IronPort-SDR: 2MRKQAZ3kXeCLFeWfTD9OcsqIWnwTc+jyWzaeEstTFDSJR5O6hkm47IZGHbaSXux36cq08e4Zi
 o0K29WegxCcg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2020 04:54:39 -0700
IronPort-SDR: eujbGGjUvEK+OG9icJk8rb0nYxZTbfgTnDh6vpJrPCrNc8twtIVUVp+GHTSoO4zjykoHRG3kUV
 hduoBlw+5nNw==
X-IronPort-AV: E=Sophos;i="5.73,495,1583222400"; 
   d="scan'208";a="447475792"
Received: from ksagi-mobl.amr.corp.intel.com (HELO localhost) ([10.249.33.22])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2020 04:54:35 -0700
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     David Howells <dhowells@redhat.com>
Cc:     dhowells@redhat.com, "Saarinen\, Jani" <jani.saarinen@intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        "Vivi\, Rodrigo" <rodrigo.vivi@intel.com>,
        "intel-gfx\@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel\@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "airlied\@redhat.com" <airlied@redhat.com>
Subject: Re: [Intel-gfx] A panic and a hang in the i915 drm driver
In-Reply-To: <2715545.1591635126@warthog.procyon.org.uk>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <87ftb6x7em.fsf@intel.com> <2136072.1591491984@warthog.procyon.org.uk> <87o8puxak1.fsf@intel.com> <4ff2445aff8d44c5961a6d194a8f4663@intel.com> <2715545.1591635126@warthog.procyon.org.uk>
Date:   Wed, 10 Jun 2020 14:54:32 +0300
Message-ID: <87pna7w2yv.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 08 Jun 2020, David Howells <dhowells@redhat.com> wrote:
> Jani Nikula <jani.nikula@linux.intel.com> wrote:
>
>> David, please try [1].
>
> Assuming you mean this:
>
>     https://patchwork.freedesktop.org/patch/366958/?series=77635&rev=1
>
> yes, that works.
>
> Tested-by: David Howells <dhowells@redhat.com>

Many thanks,
Jani.

-- 
Jani Nikula, Intel Open Source Graphics Center
