Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 235E4C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:41:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE85E20656
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:41:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593466864;
	bh=F9yc76dllBQnO/0SNt01rAhctcmIbR2BvDh67iPOI7Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ffMZWn8/b47ZfwgZPgUHmOWaaxFqYfXzFyZ2+zG+1yhlxmIajZd1s+Qi7N2+1W2LH
	 slBQwxAivCeKYLcLSJlubhpQi3wXTXicucZDzGmEqm7cYpQyAUgheZ5i7xIic5iR9F
	 8Dwb9QDL4g2uqTabU6YKxmNsIHNUjPKbV9YAphak=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403858AbgF2VlC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 17:41:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:60594 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728213AbgF2SkV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 14:40:21 -0400
Received: from localhost (unknown [122.182.251.219])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9026E239ED;
        Mon, 29 Jun 2020 10:59:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593428384;
        bh=F9yc76dllBQnO/0SNt01rAhctcmIbR2BvDh67iPOI7Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=u7i4gLoBFJh8FDswEs4uWCnzV8kp5cBaykYs9RrKg54vCoL3/C0EaOFpjx1DrhjfS
         4mNJ4glCP/jr3gLNi8kdWFWb1vABqEYXsI71Lc4tw/tmxGVS0uQm2WRHvx/eLCmk1m
         b/FFCTozE9w12rAUVRu6J6hMGYAE5c8rVRP+XLHc=
Date:   Mon, 29 Jun 2020 16:29:39 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Amadeusz =?utf-8?B?U8WCYXdpxYRza2k=?= 
        <amadeuszx.slawinski@linux.intel.com>
Cc:     alsa-devel@alsa-project.org,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        linux-kernel@vger.kernel.org,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Takashi Iwai <tiwai@suse.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH v4 1/3] ALSA: compress: document the compress audio state
 machine
Message-ID: <20200629105939.GK2599@vkoul-mobl>
References: <20200629075002.11436-1-vkoul@kernel.org>
 <20200629075002.11436-2-vkoul@kernel.org>
 <c29b3199-cebd-2153-5530-e75f76aa8b4b@linux.intel.com>
 <20200629093429.GA2599@vkoul-mobl>
 <3a43467a-5432-a3ef-2250-2ac1054539d0@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3a43467a-5432-a3ef-2250-2ac1054539d0@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29-06-20, 12:02, Amadeusz Sławiński wrote:
> On 6/29/2020 11:34 AM, Vinod Koul wrote:
> >
> > Not sure, this is not in the version I posted, arrow is from setup ->
> > prepare. See
> https://lore.kernel.org/alsa-devel/20200629075002.11436-2-vkoul@kernel.org/
> >
> > I don't know how it got reversed in your version, maybe the MUA messed
> > up??
> >
> Ah... I must have edited it myself when preparing edited version, sorry for
> noise ;)

No worries

> 
> > a compr_write() moves from SETUP -> PREPARE. Fixing that above looks
> > better version of mine..
> Yes, I feel it is easier to understand, A redirect confused me for a short
> bit when I first looked at graph and it can be easily avoided.

Thanks for the suggestion, it was a good one indeed, I will send the
update shortly

-- 
~Vinod
