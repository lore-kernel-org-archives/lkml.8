Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EED0FC352A3
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 20:28:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7E7A217F4
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 20:28:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727926AbgBMU2L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 15:28:11 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:56521 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727722AbgBMU2K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 15:28:10 -0500
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1j2L5h-0008Qn-El; Thu, 13 Feb 2020 21:28:05 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1j2L5g-0005dL-RL; Thu, 13 Feb 2020 21:28:04 +0100
Date:   Thu, 13 Feb 2020 21:28:04 +0100
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Guru Das Srinagesh <gurus@codeaurora.org>
Cc:     linux-pwm@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Subbaraman Narayanamurthy <subbaram@codeaurora.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [RESEND v5 2/2] pwm: core: Convert period and duty cycle to u64
Message-ID: <20200213202804.pqgbqtphuboqo6af@pengutronix.de>
References: <cover.1581533161.git.gurus@codeaurora.org>
 <f7986df5d54b2bb84ee14e80d0c1225444608f32.1581533161.git.gurus@codeaurora.org>
 <20200213101802.owpluhixtpor3qi3@pengutronix.de>
 <20200213193926.GA20183@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200213193926.GA20183@codeaurora.org>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Thu, Feb 13, 2020 at 11:39:26AM -0800, Guru Das Srinagesh wrote:
> On Thu, Feb 13, 2020 at 11:18:02AM +0100, Uwe Kleine-König wrote:
> > Hello,
> > 
> > On Wed, Feb 12, 2020 at 10:54:08AM -0800, Guru Das Srinagesh wrote:
> > > @@ -305,8 +305,8 @@ struct pwm_chip {
> > >   * @duty_cycle: duty cycle of the PWM signal (in nanoseconds)
> > >   */
> > >  struct pwm_capture {
> > > -	unsigned int period;
> > > -	unsigned int duty_cycle;
> > > +	u64 period;
> > > +	u64 duty_cycle;
> > >  };
> > 
> > Is this last hunk a separate change?
> > 
> > Otherwise looks fine.
> 
> No, this is very much a part of the change and not a separate one.

Not sure we understand each other. I wondered if conversion of the
pwm_capture stuff should be done separately. (OTOH I wonder if this is
used at all and already considered deleting it.)

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |
