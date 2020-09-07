Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 306C2C43461
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 14:07:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E02F22064B
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 14:07:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599487671;
	bh=SkYkCjky5bPQ4GQiZR4hOe5NZBf2aRKEeVAAgfB2Foo=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:List-ID:From;
	b=ctG4KcJpsW6P/15EGqCNfUQSvLB+m5vRYmRU7bhDkuuaSy0ch1U5kGsF0MuSR413U
	 2yfJYjUxErCTsG9FfOeCJDwJSi2itLCGNxnt6MKYHdVF6AngzEQh982rPObZR57RXI
	 bDwo5Kw5EwSPPLteI1/p4iscOvpt5/e77/la9Sfo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729781AbgIGOHo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 10:07:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:45710 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729686AbgIGOFV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 10:05:21 -0400
Received: from pobox.suse.cz (nat1.prg.suse.com [195.250.132.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4324921775;
        Mon,  7 Sep 2020 14:05:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599487521;
        bh=SkYkCjky5bPQ4GQiZR4hOe5NZBf2aRKEeVAAgfB2Foo=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=EvLq49AU2NOISeHmAjD8AS1blfK9dSOES9C5uUKh0gQ2JtIvCUKuCeHX5F2BX7jUP
         HqpLnxEXQ3doxLAW2Uad5HAheF1I3WnYnjsGMUfwxXTBzEncOQanwhbHoRJNUEJcml
         P76rrAAyS0tRl4mh8A8c/CxxTaGYqGUIi6JxLSUU=
Date:   Mon, 7 Sep 2020 16:05:18 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Ian Abbott <abbotti@mev.co.uk>
cc:     linux-input@vger.kernel.org,
        David Rheinsberg <david.rheinsberg@gmail.com>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: {PATCH 0/2] HID: wiimote: Minor change to spinlock usage
In-Reply-To: <20200904132143.9496-1-abbotti@mev.co.uk>
Message-ID: <nycvar.YFH.7.76.2009071605080.4671@cbobk.fhfr.pm>
References: <20200904132143.9496-1-abbotti@mev.co.uk>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Sep 2020, Ian Abbott wrote:

> [I have posted these patches previously, but that was over a year ago.
> --IA]
> 
> A couple of minor changes to the wiimote core module.  They do not
> change functionality of the driver:
> 
> 1) HID: wiimote: make handlers[] const
> 2) HID: wiimote: narrow spinlock range in wiimote_hid_event()
> 
>  drivers/hid/hid-wiimote-core.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)

Applied to for-5.10/wiimote. Thanks,

-- 
Jiri Kosina
SUSE Labs

