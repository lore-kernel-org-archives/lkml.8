Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D52B0C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 11:28:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 924B1206E9
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 11:28:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731171AbgF3L2z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 07:28:55 -0400
Received: from mga17.intel.com ([192.55.52.151]:35428 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727108AbgF3L2y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 07:28:54 -0400
IronPort-SDR: 42fqf3TZudVnPWsI4Mmb4scvv1Ss5Ggl4/YKScFT5AB12zq9zbIR8JVtIIORvwT8WdwYaMo6ax
 q9dtUeZbVqXw==
X-IronPort-AV: E=McAfee;i="6000,8403,9666"; a="126328317"
X-IronPort-AV: E=Sophos;i="5.75,297,1589266800"; 
   d="scan'208";a="126328317"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2020 04:28:54 -0700
IronPort-SDR: 8FsIScqUd6XybB4TwPoVe8ouT1DyWB0gS+2ZZaba3IiTPySeeIJ6mL1Cf72uTSXvRhBPL4oqws
 3hpPziN9TlAw==
X-IronPort-AV: E=Sophos;i="5.75,297,1589266800"; 
   d="scan'208";a="454578729"
Received: from rgrotewx-mobl.ger.corp.intel.com (HELO localhost) ([10.252.38.12])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2020 04:28:49 -0700
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Colin Ian King <colin.king@canonical.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Animesh Manna <animesh.manna@intel.com>,
        Maarten Lankhorst <maarten.lankhorst@intel.com>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/i915/display: fix missing null check on allocated dsb object
In-Reply-To: <45e8594c-14e5-ba67-9708-1b72fa2c51d3@canonical.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20200616114221.73971-1-colin.king@canonical.com> <20200616115459.GN4151@kadam> <45e8594c-14e5-ba67-9708-1b72fa2c51d3@canonical.com>
Date:   Tue, 30 Jun 2020 14:28:47 +0300
Message-ID: <877dvon66o.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Jun 2020, Colin Ian King <colin.king@canonical.com> wrote:
> On 16/06/2020 12:54, Dan Carpenter wrote:
>> On Tue, Jun 16, 2020 at 12:42:21PM +0100, Colin King wrote:
>>> From: Colin Ian King <colin.king@canonical.com>
>>>
>>> Currently there is no null check for a failed memory allocation
>>> on the dsb object and without this a null pointer dereference
>>> error can occur. Fix this by adding a null check.
>>>
>>> Note: added a drm_err message in keeping with the error message style
>>> in the function.
>> 
>> Don't give in to peer pressure!  That's like being a lemming when Disney
>> film makers come to push you off the cliff to create the 1958 nature
>> film "White Wilderness".
>
> :-)

Pushed, thanks for the patch and smile.

BR,
Jani.


>
>> 
>> regards,
>> dan carpenter
>> 
>

-- 
Jani Nikula, Intel Open Source Graphics Center
