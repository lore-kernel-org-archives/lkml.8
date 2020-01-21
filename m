Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C5D8C2D0CE
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 09:32:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7FB022522
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 09:32:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729140AbgAUJcf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 04:32:35 -0500
Received: from vuizook.err.no ([178.255.151.162]:47280 "EHLO vuizook.err.no"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727220AbgAUJce (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 04:32:34 -0500
Received: from p576124-ipngn200707tokaisakaetozai.aichi.ocn.ne.jp ([122.31.139.124] helo=glandium.org)
        by vuizook.err.no with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mh@glandium.org>)
        id 1itpta-0005ba-3I
        for linux-kernel@vger.kernel.org; Tue, 21 Jan 2020 09:32:32 +0000
Received: from glandium by goemon.lan with local (Exim 4.92)
        (envelope-from <mh@glandium.org>)
        id 1itptX-0005ZD-3e
        for linux-kernel@vger.kernel.org; Tue, 21 Jan 2020 18:32:23 +0900
Date:   Tue, 21 Jan 2020 18:32:23 +0900
From:   Mike Hommey <mh@glandium.org>
To:     linux-kernel@vger.kernel.org
Subject: Re: Uptime completely off after resume from suspend
Message-ID: <20200121093223.cvvlzlpadsyqiemb@glandium.org>
References: <20200110040603.3lxanijleog6tfl6@glandium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200110040603.3lxanijleog6tfl6@glandium.org>
X-GPG-Fingerprint: 182E 161D 1130 B9FC CD7D  B167 E42A A04F A6AA 8C72
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 10, 2020 at 01:06:03PM +0900, Mike Hommey wrote:
> Hi,
> 
> I have a one month old machine, and was surprised to notice an uptime of
> several hundreds of days in top. Since I had been suspending the machine
> on many occasions, I was wondering if that could be related, so I put
> the machine to sleep, came back 30 minutes later, and uptime had
> advanced 35 days!
> 
> The actual boot time, according to journald was a week ago. And the
> "timestamp" for the suspend exit in dmesg is 312967, which is about 86
> hours, which is about half, which seems about right considering the
> suspends.
> 
> The wall clock time and date is right too at the time of resume in the
> journald logs, assuming systemd-timesyncd doesn't synchronize with NTP
> before systemd logs "Started Suspend" after resuming.
> 
> This is all with 5.5rc4 + the patches from the Debian kernel packages,
> on a Threadripper 3970X, in case that matters.
> 
> Any hints where I should be looking to find out what's going wrong?

FWIW, it doesn't seem to have happened in 8 days of running 5.5rc6.

Cheers,

Mike
