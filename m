Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43AD4C33CA9
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 15:18:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 201AF21734
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 15:18:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729148AbgAMPSp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 10:18:45 -0500
Received: from bout01.mta.xmission.com ([166.70.11.15]:34966 "EHLO
        bout01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729159AbgAMPSo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 10:18:44 -0500
X-Greylist: delayed 1224 seconds by postgrey-1.27 at vger.kernel.org; Mon, 13 Jan 2020 10:18:44 EST
Received: from mx01.mta.xmission.com ([166.70.13.211])
        by bout01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.86_2)
        (envelope-from <sbauer@plzdonthack.me>)
        id 1ir1AZ-0002H6-B6; Mon, 13 Jan 2020 07:58:19 -0700
Received: from plesk14-shared.xmission.com ([166.70.198.161] helo=plesk14.xmission.com)
        by mx01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.90_1)
        (envelope-from <sbauer@plzdonthack.me>)
        id 1ir1AY-0003LR-Ud; Mon, 13 Jan 2020 07:58:19 -0700
Received: from hacktheplanet (c-68-50-34-150.hsd1.in.comcast.net [68.50.34.150])
        by plesk14.xmission.com (Postfix) with ESMTPSA id 46CFF21B2BC;
        Mon, 13 Jan 2020 14:58:18 +0000 (UTC)
Date:   Mon, 13 Jan 2020 09:57:55 -0500
From:   Scott Bauer <sbauer@plzdonthack.me>
To:     Jon Derrick <jonathan.derrick@intel.com>
Cc:     Jens Axboe <axboe@fb.com>, linux-kernel@vger.kernel.org,
        Revanth Rajashekar <revanth.rajashekar@intel.com>
Message-ID: <20200113145755.GA3846@hacktheplanet>
References: <20200110215646.15930-1-jonathan.derrick@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200110215646.15930-1-jonathan.derrick@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-XM-SPF: eid=1ir1AY-0003LR-Ud;;;mid=<20200113145755.GA3846@hacktheplanet>;;;hst=mx01.mta.xmission.com;;;ip=166.70.198.161;;;frm=sbauer@plzdonthack.me;;;spf=none
X-SA-Exim-Connect-IP: 166.70.198.161
X-SA-Exim-Mail-From: sbauer@plzdonthack.me
Subject: Re: [PATCH] MAINTAINERS: Add Revanth Rajashekar as a SED-Opal
 maintainer
X-SA-Exim-Version: 4.2.1 (built Mon, 03 Jun 2019 09:49:16 -0600)
X-SA-Exim-Scanned: Yes (on mx01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 10, 2020 at 02:56:46PM -0700, Jon Derrick wrote:
> Scott hasn't worked for Intel for some time and has already given us his
> blessing.
> 
> CC: Scott Bauer <sbauer@plzdonthack.me>
> Signed-off-by: Revanth Rajashekar <revanth.rajashekar@intel.com>
> Signed-off-by: Jon Derrick <jonathan.derrick@intel.com>

This is fine.  Jens can you take this into your tree this week please?

As always I'll be around to look at patches but will become more and
more useless as the spec evolves.
