Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 805FEC433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 20:30:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 594952076A
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 20:30:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591648252;
	bh=M22wq4mLPBHx5chMjVGb8ZcsfJkm7gYcfu0EsTwHtEE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=atZYKl7o2thNx2UVD259KvadAqVcXfuGMe6JzDIh7Zt0n1+iy25HoGpksLo726lxI
	 gEerL1Yrmas33m+QPh+tl11OXkh/pPgBPtD2dEVMOAJ6mcX9/2edrfacYolgLrvgKQ
	 K0lhaaDn5OglmbdaJKlKwpJOzdwcpFthmGArzE2Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726789AbgFHUav (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 16:30:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:54582 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726753AbgFHUau (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 16:30:50 -0400
Received: from pali.im (pali.im [31.31.79.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BDA6D2074B;
        Mon,  8 Jun 2020 20:30:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591648249;
        bh=M22wq4mLPBHx5chMjVGb8ZcsfJkm7gYcfu0EsTwHtEE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=X07BPsfPcrvK/xSZPg2g6xwpahDYiXSq9cUKy69c1Pdq3raaQdMCmWs85mFk/TuLq
         lSVPgzOJZAdp/Rw99W5IezK5ylEdy0+XTS2/d7hCW3IoXLmn3ShaasrSGcsUibqWZV
         j7aKefH6EdhefVdlzBf8XjM3Mvn82P1f45dbbTp0=
Received: by pali.im (Postfix)
        id 6F943FB6; Mon,  8 Jun 2020 22:30:47 +0200 (CEST)
Date:   Mon, 8 Jun 2020 22:30:47 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Y Paritcher <y.linux@paritcher.com>
Cc:     Mario.Limonciello@dell.com, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, mjg59@srcf.ucam.org
Subject: Re: [PATCH 2/3] platform/x86: dell-wmi: add new keymap type 0x0012
Message-ID: <20200608203047.u4ewb3tyfmatyrsz@pali>
References: <cover.1591584631.git.y.linux@paritcher.com>
 <0dc191a3d16f0e114f6a8976433e248018e10c43.1591584631.git.y.linux@paritcher.com>
 <83fe431cacbc4708962767668ac8f06f@AUSX13MPC105.AMER.DELL.COM>
 <79bd59ee-dd37-bdc5-f6b4-00f2c33fdcff@paritcher.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <79bd59ee-dd37-bdc5-f6b4-00f2c33fdcff@paritcher.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Monday 08 June 2020 16:12:52 Y Paritcher wrote:
> You are right.
> I had assumed (incorrectly) the were the same.
> I turned on dyndbg and got the events with the extended data.
> 
> Fn lock key switched to multimedia keys
> dell_wmi: Received WMI event (02 00 12 00 35 e0 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00)
> the extended data is e0 01
> 
> Fn-lock switched to function keys
> dell_wmi: Received WMI event (02 00 12 00 35 e0 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00)
> the extended data is e0 00

That is why I asked if buffer is really sequence of events. From your
log can be seen that it is not a sequence, but rather just one event.

> Therefore i agree this should have it's own case in `dell_wmi_process_key` but i am
> not sure yet how to deal with it. any suggestion are helpful.

I guess you could handle it like for event type 0x0000 which also
process one event where can be additional information in buffer.
See relevant code for 0x0000:

		case 0x0000: /* One key pressed or event occurred */
			if (len > 2)
				dell_wmi_process_key(wdev, 0x0000,
						     buffer_entry[2]);
			/* Other entries could contain additional information */
			break;

Just processing of additional information from buffer is not implemented
yet, probably nobody needed it yet.

> About sending it to userspace, I just followed what was already done, if that is not
> desired we should change it for all the models.

Main question if we need to send this event to userspace. Or if we
should drop this event as it is duplicate which was already processed by
other layer. This is something which we do not know and it needs to be
investigated and documented/explained. So in future when will do some
changes in that code, we would know how to handle it without breaking
existing systems.

I would suggest to not describe changes in commit message, but rather
describe explanation of those changes in commit message. E.g. what was
decision and why you are doing it in that way.

It would help in future to know why such code is needed.

E.g. "event XYZ needs to be ignored as kernel receive its duplicate also
via keyboard controller". Or e.g. "event needs to be processed by wmi
driver because notebook's embedded controller sends it only via wmi".
