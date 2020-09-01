Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23F7DC433E6
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 11:37:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC6DC206EF
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 11:37:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598960268;
	bh=T0xnxr/y4YBmhu4WiqlJbSgMNsEzKd25ycCTi2mkHEc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=lYcEBP9E67ym+xZ0VmLYBID5aYvzQGLiDhKkd6dUd6a8K9m91jj5AsicQzIGuzV5o
	 lmz3pEg814dEe399q1V5XWE/o+/qPXMQque7wN7BG5T+xG+EwyQF92gS66R+1JhxcX
	 yIR1RlJpxPm0YDRiiY9OBHy0usAKN3HjqqoNg05Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726102AbgIALhl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 07:37:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:45200 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726755AbgIALbB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 07:31:01 -0400
Received: from localhost (unknown [122.172.190.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4B7DF207BC;
        Tue,  1 Sep 2020 11:07:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598958441;
        bh=T0xnxr/y4YBmhu4WiqlJbSgMNsEzKd25ycCTi2mkHEc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZRA07ah7oA3Z+zd0ktM3bt0M5XKPWhxnpzJMQOHXOduHfaZN28YoDJGPUnBzi0E+v
         AyngVMf5h4GNdW6sl4hTtnb9k26Bv4i5HriLMbiLPB4WHVW5SDO2Xoz+D4zXbciTUW
         Kso17d+9HqbCZur7G+ClfcGC078yftNnkzmVjEEk=
Date:   Tue, 1 Sep 2020 16:37:16 +0530
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
Message-ID: <20200901110716.GA2639@vkoul-mobl>
References: <20200829110047.GC2639@vkoul-mobl>
 <051afb2d-dd2e-0ea4-d8a9-980f5df136b7@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <051afb2d-dd2e-0ea4-d8a9-980f5df136b7@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31-08-20, 10:15, Pierre-Louis Bossart wrote:
> 
> > > > > > > Detect cases where the clock is assumed to be stopped but the IP is
> > > > > > > not in the relevant state, and add a dynamic debug trace.
> > > > > > 
> > > > > > you meant a debug print..and it looks like error print below (also in title).
> > > > > 
> > > > > I don't understand the comment. Is the 'trace' confusing and are you asking
> > > > > to e.g. change the commit message to 'add dynamic debug log'?
> > > > 
> > > > Question is what is dynamic about this?
> > > dev_dbg() is part of the kernel dynamic debug capability...
> > > 
> > > https://www.kernel.org/doc/html/latest/admin-guide/dynamic-debug-howto.html
> > > 
> > > Not sure what you are asking here?
> > 
> > :-| where is dev_dbg() ?
> > 
> > See [1]
> 
> > 
> > [1]
> > 
> > > +			dev_err(dev, "%s invalid configuration, clock was not stopped", __func__);
> > 
> >                          ^^^^^^^
> 
> it's still a log using the "dynamic debug" framework.
> 
> Again, what are you asking us to fix?

Ah you are really testing my patience!

The title says "dynamic debug" and then you use a dev_err which is *not*
part of dynamic debug as it is printed always and cannot be dynamically
enabled and disabled!

See Documentation/admin-guide/dynamic-debug-howto.rst:

"Dynamic debug is designed to allow you to dynamically enable/disable
kernel code to obtain additional kernel information.  Currently, if
``CONFIG_DYNAMIC_DEBUG`` is set, then all ``pr_debug()``/``dev_dbg()`` and
``print_hex_dump_debug()``/``print_hex_dump_bytes()`` calls can be dynamically
enabled per-callsite."

No dev_err here!

-- 
~Vinod
