Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0D53C433E6
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 07:49:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C3F020E65
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 07:49:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598600999;
	bh=NNuyrQlMojjJklrBvWVr2Dpn4uxkjEtV2E5JBA+oGWU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=F8bYtwDNE5hsjnMYymyDJRr3EhY1W2ioPQ7CsaoT9v5AwH/PcWl4zeBGpx23ECjE4
	 ki3cpZ92DtHTzrQolCAjxWjjIooFUiR4xQL2IPg2dE2yNWOqZV6kcxyndSnzG3Ros0
	 BxM7c7JuyniIBd/hkKRz06bCLf5qT9oGjPM8S+9s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728531AbgH1Ht5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 03:49:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:42966 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726571AbgH1Ht4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 03:49:56 -0400
Received: from localhost (unknown [122.171.38.130])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 69DFB2078A;
        Fri, 28 Aug 2020 07:49:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598600996;
        bh=NNuyrQlMojjJklrBvWVr2Dpn4uxkjEtV2E5JBA+oGWU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nFQEiSEUytCjWefRFRgUjJQ2NVOhkve6dF106PTG/snvexkpMSDQaVsy1f652YuNP
         L0Gf7X/f2LeYVV1xscapD0lUYVbMJeiFrmTvi/mvdATGE2eXcP0jRBliufZqV+pCUy
         B2NEZmjDnXNMSRKLO8Em4aSntiwBewOH/eUSLVnk=
Date:   Fri, 28 Aug 2020 13:19:52 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     Bard Liao <yung-chuan.liao@linux.intel.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        tiwai@suse.de, broonie@kernel.org, gregkh@linuxfoundation.org,
        jank@cadence.com, srinivas.kandagatla@linaro.org,
        rander.wang@linux.intel.com, ranjani.sridharan@linux.intel.com,
        hui.wang@canonical.com, sanyog.r.kale@intel.com,
        mengdong.lin@intel.com, bard.liao@intel.com
Subject: Re: [PATCH 09/11] soundwire: intel: add dynamic debug trace for
 clock-stop invalid configs
Message-ID: <20200828074952.GO2639@vkoul-mobl>
References: <20200818024120.20721-1-yung-chuan.liao@linux.intel.com>
 <20200818024120.20721-10-yung-chuan.liao@linux.intel.com>
 <20200826094817.GC2639@vkoul-mobl>
 <21038e8d-dbd9-76c7-c758-9933fb45024a@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <21038e8d-dbd9-76c7-c758-9933fb45024a@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26-08-20, 09:38, Pierre-Louis Bossart wrote:
> 
> 
> On 8/26/20 4:48 AM, Vinod Koul wrote:
> > On 18-08-20, 10:41, Bard Liao wrote:
> > > From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> > > 
> > > Detect cases where the clock is assumed to be stopped but the IP is
> > > not in the relevant state, and add a dynamic debug trace.
> > 
> > you meant a debug print..and it looks like error print below (also in title).
> 
> I don't understand the comment. Is the 'trace' confusing and are you asking
> to e.g. change the commit message to 'add dynamic debug log'?

Question is what is dynamic about this?

-- 
~Vinod
