Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1FD0C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 02:51:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 92FF520EDD
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 02:51:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592967100;
	bh=jvZa+2rBHSyCXMiDZ8ktCel23EW/OJugQWSsjHUz3ro=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=MUOsh6xFXzfYJN3Z99KOyoOW9NzJ/2qj8LTFYmZm2zoxh16OXnTDzsO1k26dtlPl8
	 LKz5EDmkVgtvNSzsKey74p79o/9REftV8y7RUsU+AlwSMPjlMArneHUb0SORsh5dYp
	 hepIhEg5mlgzkcwhvL+CDecwWzHIXCFOjrwn/CDg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388607AbgFXCvj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 22:51:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:57958 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388565AbgFXCvi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 22:51:38 -0400
Received: from dhcp-10-100-145-180.wdl.wdc.com (unknown [199.255.45.60])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C79BB20874;
        Wed, 24 Jun 2020 02:51:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592967098;
        bh=jvZa+2rBHSyCXMiDZ8ktCel23EW/OJugQWSsjHUz3ro=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cutbL0CcHkkg+4b6NpuS2PGm23TKRP7oEHx3sltDDa/FVKLuZBqHcIqYNpFO5RjX8
         msWggVCSkOhG9pHSSnbuY0LW7GGaiDggMGY0JiVaVhJbr+sXTb6cbYeMOL32Bae90i
         Cp6qzO9aa4lcXwbyhxXho+TSZz9oI8dHtbUxMIks=
Date:   Tue, 23 Jun 2020 19:51:35 -0700
From:   Keith Busch <kbusch@kernel.org>
To:     Baolin Wang <baolin.wang@linux.alibaba.com>
Cc:     Sagi Grimberg <sagi@grimberg.me>, axboe@fb.com, hch@lst.de,
        baolin.wang7@gmail.com, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] nvme: Add Arbitration Burst support
Message-ID: <20200624025135.GA1291930@dhcp-10-100-145-180.wdl.wdc.com>
References: <cover.1592916850.git.baolin.wang@linux.alibaba.com>
 <bf3f47ba50f72d0b775ca4bd098f183056d964ba.1592916850.git.baolin.wang@linux.alibaba.com>
 <20200623144014.GB1288900@dhcp-10-100-145-180.wdl.wdc.com>
 <38482b1b-b1c7-bb41-b086-6ce00f6a9d1d@grimberg.me>
 <20200623180108.GA1291100@dhcp-10-100-145-180.wdl.wdc.com>
 <20200624013408.GA40094@VM20190228-100.tbsite.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200624013408.GA40094@VM20190228-100.tbsite.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 24, 2020 at 09:34:08AM +0800, Baolin Wang wrote:
> OK, I understaood your concern. Now we will select the RR arbitration as default
> in nvme_enable_ctrl(), but for some cases, we will not set the arbitration burst
> values from userspace, and we still want to use the defaut arbitration burst that
> recommended by the controller, taking into consideration any latency requirements.
> 
> So I'd like to add a parameter to decide if we can use the default arbitration
> burst like below, how do yo think? Thanks.

I wouldn't call this the 'default' arbitration since it usually is not
the default. This is the 'recommended' arbitration value.
 
> static bool use_default_arb;
> module_param(use_default_arb, bool, 0444);
> MODULE_PARM_DESC(use_default_arb, "use default arbitration burst that
> recommended by the controller");

"use controller's recommended arbitration burst"
