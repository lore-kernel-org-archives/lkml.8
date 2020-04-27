Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96B7EC54FD0
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 14:36:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6963720656
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 14:36:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tSK15hxK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727961AbgD0OgY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 10:36:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727022AbgD0OgY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 10:36:24 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED6B7C0610D5
        for <linux-kernel@vger.kernel.org>; Mon, 27 Apr 2020 07:36:23 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id h4so4262332ljg.12
        for <linux-kernel@vger.kernel.org>; Mon, 27 Apr 2020 07:36:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ofbG8gc4Nzs/4YiHPYPjCVYUGwH80aotO0Gf3R7rnV4=;
        b=tSK15hxKYTufO3oP2SLE7GvyorRyQlM54WZTMgDg0t5ClnnPTXceIm3JUQXJSGJFAn
         sOMUjeIpSboBmoMDpcmgBuKT9SebC5/C05+RlakPfsi/uctXEEPtBtD+UVMmDAc5V+TU
         uQ5l6RQve9WfnPjsZ4q8lud+eVPHoKQO234DGE3yUBdoQnwJsSI3dnKzTEbQ4Xt14PbB
         NxKwQDobbAMRwT5tmRutw7KNSGhzKLhK97ojKkqJWGulUBFvvtf1iDbpH9ceZsUQu9F4
         hGA1vTlykhtwcSPh9U4qWDj9OHXn87WsXVtp/61ki52oS57oEXn4AlJc3cXrRCRjIGt0
         VXPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ofbG8gc4Nzs/4YiHPYPjCVYUGwH80aotO0Gf3R7rnV4=;
        b=iVVW/GvEMMfi82txLqLzlcbBhkCTvipcW2TpgdTnof0WXQZruGrdLw81N0/yOrxxfG
         F7mRICKmY3DBiXeZbOxz+NM0D9YwNnWtI9hRDROaa50m2NyG95UNykbCMuk4Mh8oM8pR
         ehxlJcPOrcslUFGKU1KX3p9IrZV9unlagE7GOAiugoiPUnjoSSPwfNJECmJLC7TeY1F3
         hIXQr9iQC9WXvZsWT/lJwgTnTrEQexFvFStNKQGE0nZwOhprk9o14pJ362FUOCpMO8Dd
         qTJ9rk4/kv+gMpJPokSPNqjwqpMWH4hx0ZP/m7Zji4Xc/4wkMWdyhIP5j9oHLYg8Bq4i
         wwRA==
X-Gm-Message-State: AGi0PuaQvJTxC12g4G0pbaQKM1km1ppAyG5XRntZwrMaH2DPJYpHCJsa
        BRA4R8SAdZtVfCfjgCdtCPUCy/IL0mRoA0RycpI=
X-Google-Smtp-Source: APiQypJqnIrZ7O/Q4z+Bms9TIWKs6oY2gjlTnc1H3MSU/May5rE2oZjahQk0GpKaH/p92G09ok0EpryG0f6cOajnIoA=
X-Received: by 2002:a2e:b4d0:: with SMTP id r16mr14630057ljm.129.1587998182138;
 Mon, 27 Apr 2020 07:36:22 -0700 (PDT)
MIME-Version: 1.0
References: <20200426013521.43087-1-lb.workbox@gmail.com> <875zdls2bi.fsf@nanos.tec.linutronix.de>
In-Reply-To: <875zdls2bi.fsf@nanos.tec.linutronix.de>
From:   Leonid Bloch <lb.workbox@gmail.com>
Date:   Mon, 27 Apr 2020 17:36:11 +0300
Message-ID: <CAOwCge2cjzAYeR_oAt6t3RN-fndN8xWS7=3-AWsXS6TPtnpvGg@mail.gmail.com>
Subject: Re: [PATCH] rtc: Do not sync CMOS clock when CONFIG_RTC_SYSTOHC is
 not set
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, John Stultz <john.stultz@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 27, 2020 at 12:30 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> Leonid Bloch <lb.workbox@gmail.com> writes:
> > According to documentation in 'drivers/rtc/Kconfig', if
> > 'CONFIG_RTC_SYSTOHC' is set, then:
> >
> > '''
> > The system time (wall clock) will be stored in the RTC specified by
> > RTC_HCTOSYS_DEVICE approximately every 11 minutes if userspace reports
> > synchronized NTP status.
> > '''
> >
> > However in reality, even if 'CONFIG_RTC_SYSTOHC' is not set, the RTC
> > is still sometimes synced with the system time: at least when the RTC
> > driver is 'rtc_cmos', in certain situations. This commit prevents
> > that.
>
> But in reality sync_cmos_clock() depends on CONFIG_GENERIC_CMOS_UPDATE
> and has nothing to do with CONFIG_RTC_SYSTOHC.
>
> That's a historical leftover from the days where RTCs were strictly a
> platform/architecture specific issue.
>
> Your change would break all architectures which still depend on that.

Thanks for your clarification, Thomas!

Then maybe it's worth to reword the help string in
drivers/rtc/Kconfig? Because one can unset 'CONFIG_RTC_SYSTOHC' and
expect that the RTC clock will not be updated by NTP syncs, while in
reality it will be, unless 'CONFIG_GENERIC_CMOS_UPDATE' is unset, and
it is selected automatically by X86.

Regards,
Leonid.
___

>
>
> Thanks,
>
>         tglx
