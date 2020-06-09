Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D29DC433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 08:04:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E1AB207F9
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 08:04:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591689872;
	bh=eQ84h80qnHYQCz+PHBIazFEj7hK6apL9pOKOZWqpegk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=K8uxlR8/OifggffJ9jFgMc72SxPGB4sl8oQ3Rbp9BS1YvwUlEDr8vk0q0v2ipqeZ3
	 cu7iGKoc3oFeoSXYxyFDKuuk2/5ygem9hnyNHNwzyl3TnDKw0POwjVIHJU6uimDajT
	 aldB/8rwoVPnmtXzGd5LAiFAd6XEODnGzohxgHUA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728001AbgFIIEb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 04:04:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:51698 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726404AbgFIIEb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 04:04:31 -0400
Received: from pali.im (pali.im [31.31.79.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 34C4D207ED;
        Tue,  9 Jun 2020 08:04:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591689870;
        bh=eQ84h80qnHYQCz+PHBIazFEj7hK6apL9pOKOZWqpegk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pw797fwDlRwyaRwai0Qz6E2N52c1s3GNh3UVQxAKo8JZm19fLk/q/iYE+RQuGUbZX
         Vf6bj8t2crYfcjpVwXI4YqvNy9CnlVvOv82/GnSfWynfYVxj049Jom4DFRODExE6Kq
         ZWoBlhBibfNP4Oma9SWVEONYF/fUuB+cMCPsOxaE=
Received: by pali.im (Postfix)
        id 36EC3884; Tue,  9 Jun 2020 10:04:28 +0200 (CEST)
Date:   Tue, 9 Jun 2020 10:04:28 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Mario.Limonciello@dell.com
Cc:     y.linux@paritcher.com, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, mjg59@srcf.ucam.org
Subject: Re: [PATCH 2/3] platform/x86: dell-wmi: add new keymap type 0x0012
Message-ID: <20200609080428.bjlimc2mfhn6hjbs@pali>
References: <cover.1591584631.git.y.linux@paritcher.com>
 <0dc191a3d16f0e114f6a8976433e248018e10c43.1591584631.git.y.linux@paritcher.com>
 <83fe431cacbc4708962767668ac8f06f@AUSX13MPC105.AMER.DELL.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <83fe431cacbc4708962767668ac8f06f@AUSX13MPC105.AMER.DELL.COM>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 08 June 2020 15:40:53 Mario.Limonciello@dell.com wrote:
> > dell_wmi: Unknown WMI event type 0x12
> > dell_wmi: Unknown key with type 0x0012 and code 0xe035 pressed
> 
> Event type 0x12 is for "System Events".  This is the type of events that
> you typically would see come in for things "like" the wrong power adapter
> being plugged in on Windows or stuff about plugging a Thunderbolt dock into
> a port that doesn't support Thunderbolt.
> 
> A message might look something like (paraphrased)
> "Your system requires a 180W power adapter to charge effectively, but you
> plugged in a 60W adapter."
> 
> There often is extended data with these events.  As such I don't believe all
> information in event type 0x0012 should be treated like scan codes like those in
> 0x10 or 0x11.
> 
> I would guess that Fn-lock on this machine probably has extended data in the next
> showing whether it was turned on and off.  If it does, perhaps it makes sense to
> send this information to userspace as an evdev switch instead.

Thank you for information!

Interesting is that I got this email only now, after all other emails in
this thread. But seems that you have wrote it prior I asked question
about documentation for these events. So probably some email delivery
problem / delay.
