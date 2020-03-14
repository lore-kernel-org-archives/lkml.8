Return-Path: <SRS0=iqK9=5A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B235C0044D
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Mar 2020 01:44:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DD1E206D5
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Mar 2020 01:44:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726783AbgCOBok (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Mar 2020 21:44:40 -0400
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:15378 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726248AbgCOBoj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Mar 2020 21:44:39 -0400
X-IronPort-AV: E=Sophos;i="5.70,554,1574118000"; 
   d="scan'208";a="440346552"
Received: from lfbn-bor-1-797-11.w86-234.abo.wanadoo.fr (HELO function.home) ([86.234.239.11])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Mar 2020 23:21:29 +0100
Received: from samy by function.home with local (Exim 4.93)
        (envelope-from <samuel.thibault@ens-lyon.org>)
        id 1jDF9s-004ML5-HH; Sat, 14 Mar 2020 23:21:28 +0100
Date:   Sat, 14 Mar 2020 23:21:28 +0100
From:   Samuel Thibault <samuel.thibault@ens-lyon.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Zhenzhong Duan <zhenzhong.duan@gmail.com>,
        linux-kernel@vger.kernel.org, jdike@addtoit.com, richard@nod.at,
        anton.ivanov@cambridgegreys.com, miguel.ojeda.sandonis@gmail.com,
        willy@haproxy.com, ksenija.stanojevic@gmail.com, arnd@arndb.de,
        mpm@selenic.com, herbert@gondor.apana.org.au,
        jonathan@buzzard.org.uk, benh@kernel.crashing.org,
        davem@davemloft.net, b.zolnierkie@samsung.com, rjw@rjwysocki.net,
        pavel@ucw.cz, len.brown@intel.com,
        William Hubbs <w.d.hubbs@gmail.com>,
        Chris Brannon <chris@the-brannons.com>,
        Kirk Reiser <kirk@reisers.ca>
Subject: Re: [PATCH RFC 3/3] speakup: misc: Use dynamic minor numbers for
 speakup devices
Message-ID: <20200314222128.mo4q3m72qoy76ayx@function>
Mail-Followup-To: Samuel Thibault <samuel.thibault@ens-lyon.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Zhenzhong Duan <zhenzhong.duan@gmail.com>,
        linux-kernel@vger.kernel.org, jdike@addtoit.com, richard@nod.at,
        anton.ivanov@cambridgegreys.com, miguel.ojeda.sandonis@gmail.com,
        willy@haproxy.com, ksenija.stanojevic@gmail.com, arnd@arndb.de,
        mpm@selenic.com, herbert@gondor.apana.org.au,
        jonathan@buzzard.org.uk, benh@kernel.crashing.org,
        davem@davemloft.net, b.zolnierkie@samsung.com, rjw@rjwysocki.net,
        pavel@ucw.cz, len.brown@intel.com,
        William Hubbs <w.d.hubbs@gmail.com>,
        Chris Brannon <chris@the-brannons.com>,
        Kirk Reiser <kirk@reisers.ca>
References: <20200309021747.626-1-zhenzhong.duan@gmail.com>
 <20200309021747.626-4-zhenzhong.duan@gmail.com>
 <20200309071506.GB4095204@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200309071506.GB4095204@kroah.com>
Organization: I am not organized
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Greg KH, le lun. 09 mars 2020 08:15:06 +0100, a ecrit:
> On Mon, Mar 09, 2020 at 10:17:47AM +0800, Zhenzhong Duan wrote:
> > Arnd notes in the link:
> >    | To clarify: the only numbers that I think should be changed to dynamic
> >    | allocation are for drivers/staging/speakup. While this is a fairly old
> >    | subsystem, I would expect that it being staging means we can be a
> >    | little more progressive with the changes.
> > 
> > This releases misc device minor numbers 25-27 for dynamic usage.
> > 
> > Link: https://lore.kernel.org/lkml/20200120221323.GJ15860@mit.edu/t/
> > Suggested-by: Arnd Bergmann <arnd@arndb.de>
> > Signed-off-by: Zhenzhong Duan <zhenzhong.duan@gmail.com>

Acked-by: Samuel Thibault <samuel.thibault@ens-lyon.org>

> > Cc: William Hubbs <w.d.hubbs@gmail.com>
> > Cc: Chris Brannon <chris@the-brannons.com>
> > Cc: Kirk Reiser <kirk@reisers.ca>
> > Cc: Samuel Thibault <samuel.thibault@ens-lyon.org>
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > ---
> >  drivers/staging/speakup/devsynth.c     | 10 +++-------
> >  drivers/staging/speakup/speakup_soft.c | 14 +++++++-------
> >  2 files changed, 10 insertions(+), 14 deletions(-)
> 
> speakup, while being in staging, has been around for a very long time,
> so we might break things if we change their minor numbers.
> 
> I'd need an ACK from the speakup maintainers/developers before I can
> take this as I don't have any way to verify what their systems look
> like.

I believe it will be fine to use dynamic minor numbers, since the /dev
entries are autocreated nowadays, and the espeakup and speechd-up don't
use hardcoded minor values.

Thanks for making sure,
Samuel
