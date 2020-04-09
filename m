Return-Path: <SRS0=n+Ub=5Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD6A6C2BA19
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 19:20:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6C62206F5
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 19:20:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726789AbgDITUM convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 15:20:12 -0400
Received: from mail.fireflyinternet.com ([109.228.58.192]:57517 "EHLO
        fireflyinternet.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726632AbgDITUM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 15:20:12 -0400
X-Default-Received-SPF: pass (skip=forwardok (res=PASS)) x-ip-name=78.156.65.138;
Received: from localhost (unverified [78.156.65.138]) 
        by fireflyinternet.com (Firefly Internet (M1)) with ESMTP (TLS) id 20856328-1500050 
        for multiple; Thu, 09 Apr 2020 20:19:27 +0100
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20200409133107.415812-1-colin.king@canonical.com>
References: <20200409133107.415812-1-colin.king@canonical.com>
From:   Chris Wilson <chris@chris-wilson.co.uk>
Subject: Re: [PATCH] drm/i915: remove redundant assignment to variable err
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
To:     Colin King <colin.king@canonical.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org
Message-ID: <158645996713.23161.4368543521925428819@build.alporthouse.com>
User-Agent: alot/0.8.1
Date:   Thu, 09 Apr 2020 20:19:27 +0100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Colin King (2020-04-09 14:31:07)
> From: Colin Ian King <colin.king@canonical.com>
> 
> The variable err is being initialized with a value that is never read
> and it is being updated later with a new value.  The initialization is
> redundant and can be removed.
> 
> Addresses-Coverity: ("Unused value")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Could be useful... No, let's not look at that function again.
Reviewed-by: Chris Wilson <chris@chris-wilson.co.uk>
-Chris
