Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B7DEC2BA19
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 06:51:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 737272072D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 06:51:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727079AbgDUGvr convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 02:51:47 -0400
Received: from mga09.intel.com ([134.134.136.24]:56330 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726600AbgDUGvr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 02:51:47 -0400
IronPort-SDR: VGkyqPwC7Lj4Do6p+U16IR/8OMc79MLfGzzDhvn8ApFL1s+mE9irLCs0/bwe/cgHZw54b9lBwo
 kpnB6xg2boMA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2020 23:51:46 -0700
IronPort-SDR: dJgnj9LtJxS9ebZ/S0njP5sYfexPvZ4NgMfEfFHz5F0bZkUuEcdzxlgfKs8wSnygkqF4emsbFK
 jkm+0153uf8w==
X-IronPort-AV: E=Sophos;i="5.72,409,1580803200"; 
   d="scan'208";a="429422153"
Received: from jlahtine-desk.ger.corp.intel.com (HELO localhost) ([10.214.210.219])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2020 23:51:41 -0700
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20200420161514.GB1963@sultan-box.localdomain>
References: <20200404024156.GA10382@sultan-box.localdomain> <20200407064007.7599-1-sultan@kerneltoast.com> <20200414061312.GA90768@sultan-box.localdomain> <158685263618.16269.9317893477736764675@build.alporthouse.com> <20200414144309.GB2082@sultan-box.localdomain> <20200420052419.GA40250@sultan-box.localdomain> <158737090265.8380.6644489879531344891@jlahtine-desk.ger.corp.intel.com> <20200420161514.GB1963@sultan-box.localdomain>
Subject: Re: [PATCH v4] drm/i915: Synchronize active and retire callbacks
From:   Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Cc:     Chris Wilson <chris@chris-wilson.co.uk>, stable@vger.kernel.org,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthew Auld <matthew.auld@intel.com>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
To:     Sultan Alsawaf <sultan@kerneltoast.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Date:   Tue, 21 Apr 2020 09:51:37 +0300
Message-ID: <158745189706.5265.10618964185012452715@saswiest-mobl.ger.corp.intel.com>
User-Agent: alot/0.8.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Sultan Alsawaf (2020-04-20 19:15:14)
> On Mon, Apr 20, 2020 at 11:21:42AM +0300, Joonas Lahtinen wrote:
> > So it seems that the patch got pulled into v5.6 and has been backported
> > to v5.5 but not v5.4.
> 
> You're right, that's my mistake.

Did applying the patch to v5.4 fix the issue at hand?

Regards, Joonas
