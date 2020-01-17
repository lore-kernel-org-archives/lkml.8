Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4C00C33CB1
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 05:29:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8057D2083E
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 05:29:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579238955;
	bh=/clOrGLn8OAp1OI6m5X00wsw+u3Jo3xhtsfAEOlmqMY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=myE7Z7JWgAvbyO6bFcbxEBedZmHexlyE9gV3xl0Gbgkd016uRWHCuZ94fZtKifW+h
	 LRBvboZrYg17u/fGs4gSQdK9Gzo6z9IqtXIr0FqZ/6jgvdHO8SS1p/b1ZNEGTEeDTd
	 I1iQjppPeV91tlI4oOTlByhkH8gon55F9jwH65lY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726406AbgAQF3O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jan 2020 00:29:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:55668 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725834AbgAQF3O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 00:29:14 -0500
Received: from localhost (unknown [122.182.218.15])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F37342072E;
        Fri, 17 Jan 2020 05:29:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579238953;
        bh=/clOrGLn8OAp1OI6m5X00wsw+u3Jo3xhtsfAEOlmqMY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nldw1FKn8NYMiMI0PeNeTNHGuNAZjOY3u9nlRhXuBzjE3j69A/60TQD3j1xoq6P23
         7Wlj6W/WTPPJoDR4gIKC/1lVunYwMx10NrxFqlT3iSRm7h11X9JptdMf14LSusRiub
         etVheOkx6KhLwn0tT0jbzMvuHDxdr6eX6QZdPwok=
Date:   Fri, 17 Jan 2020 10:59:07 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     santosh.shilimkar@oracle.com, Olof Johansson <olof@lixom.net>
Cc:     Peter Ujfalusi <peter.ujfalusi@ti.com>, soc@kernel.org,
        arm@kernel.org, linux-arm-kernel@lists.infradead.org,
        khilman@kernel.org, arnd@arndb.de, linux-kernel@vger.kernel.org
Subject: Re: [GIT_PULL] SOC: TI Keystone Ring Accelerator driver for v5.6
Message-ID: <20200117052907.GT2818@vkoul-mobl>
References: <1579205259-4845-1-git-send-email-santosh.shilimkar@oracle.com>
 <20200117000358.fe7ew4vvnz4yxbzj@localhost>
 <148b6ec3-6a8e-ced8-41b3-3dffd5528ed6@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <148b6ec3-6a8e-ced8-41b3-3dffd5528ed6@oracle.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Add Peter

On 16-01-20, 21:05, santosh.shilimkar@oracle.com wrote:
> On 1/16/20 4:03 PM, Olof Johansson wrote:
> > Hi,
> > 
> > On Thu, Jan 16, 2020 at 12:07:39PM -0800, Santosh Shilimkar wrote:
> > > Its bit late for pull request, but if possible, please pull it to
> > > soc drivers tree.
> > > 
> > > The following changes since commit e42617b825f8073569da76dc4510bfa019b1c35a:
> > > 
> > >    Linux 5.5-rc1 (2019-12-08 14:57:55 -0800)
> > > 
> > > are available in the git repository at:
> > > 
> > >    git://git.kernel.org/pub/scm/linux/kernel/git/ssantosh/linux-keystone.git tags/drivers_soc_for_5.6
> > > 
> > > for you to fetch changes up to 3277e8aa2504d97e022ecb9777d784ac1a439d36:
> > > 
> > >    soc: ti: k3: add navss ringacc driver (2020-01-15 10:07:27 -0800)
> > > 
> > > ----------------------------------------------------------------
> > > SOC: TI Keystone Ring Accelerator driver
> > > 
> > > The Ring Accelerator (RINGACC or RA) provides hardware acceleration to
> > > enable straightforward passing of work between a producer and a consumer.
> > > There is one RINGACC module per NAVSS on TI AM65x SoCs.
> > 
> > This driver doesn't seem to have exported symbols, and no in-kernel
> > users. So how will it be used?
> > 
> > Usually we ask to hold off until the consuming side/drivers are also ready.
> > 
> The other patches getting merged via Vinod's tree. The combined series
> is split into couple of series. Vinod is going to pull this branch
> and apply rest of the patchset. And then couple of additional consumer
> drivers will get posted.

Yeah the TI driver series has been reviewed and was 'waiting' for
dependency to be resolved before I could apply them
FWIW here is the series under consideration: https://lore.kernel.org/dmaengine/20191223110458.30766-1-peter.ujfalusi@ti.com/

> > Also, is there a reason this is under drivers/soc/ instead of somewhere more
> > suitable in the drivers subsystem? It's not "soc glue code" in the same way as
> > drivers/soc was intended originally.
> > 
> These kind of SOC IP drivers, we put into drivers/soc/ because of lack
> of specific subsystem where they fit in. Navigator was also similar example.
> 
> Regards,
> Santosh

-- 
~Vinod
