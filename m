Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0C14C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 11:51:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E01BA2086A
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 11:51:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730295AbgHDLvO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 07:51:14 -0400
Received: from hera.aquilenet.fr ([185.233.100.1]:46904 "EHLO
        hera.aquilenet.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730371AbgHDLtz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 07:49:55 -0400
Received: from localhost (localhost [127.0.0.1])
        by hera.aquilenet.fr (Postfix) with ESMTP id C93CEE0E8;
        Tue,  4 Aug 2020 13:49:53 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at aquilenet.fr
Received: from hera.aquilenet.fr ([127.0.0.1])
        by localhost (hera.aquilenet.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id scU3giwOwsSK; Tue,  4 Aug 2020 13:49:53 +0200 (CEST)
Received: from function.home (lfbn-bor-1-797-11.w86-234.abo.wanadoo.fr [86.234.239.11])
        by hera.aquilenet.fr (Postfix) with ESMTPSA id EB4FE2534;
        Tue,  4 Aug 2020 13:49:52 +0200 (CEST)
Received: from samy by function.home with local (Exim 4.94)
        (envelope-from <samuel.thibault@ens-lyon.org>)
        id 1k2vS3-001bAW-C5; Tue, 04 Aug 2020 13:49:51 +0200
Date:   Tue, 4 Aug 2020 13:49:51 +0200
From:   Samuel Thibault <samuel.thibault@ens-lyon.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, speakup@linux-speakup.org
Subject: Re: [PATCH 2/2] speakup: only build serialio when ISA is enabled
Message-ID: <20200804114951.ijs3hnezi4f64nll@function>
Mail-Followup-To: Samuel Thibault <samuel.thibault@ens-lyon.org>,
        Greg KH <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org,
        speakup@linux-speakup.org
References: <20200804111332.dex7jobmabifdzw5@function>
 <20200804113413.GA181242@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200804113413.GA181242@kroah.com>
Organization: I am not organized
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH, le mar. 04 août 2020 13:34:13 +0200, a ecrit:
> On Tue, Aug 04, 2020 at 01:13:32PM +0200, Samuel Thibault wrote:
> > Drivers using serialio are already made available in Kconfig only under
> > the ISA condition.
> > 
> > This solves warnings in inb/outb macros on platform that do not have 
> > support for ISA.
> > 
> > Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
> > 
> > Index: linux-2.6/drivers/accessibility/speakup/Makefile
> > ===================================================================
> > --- linux-2.6.orig/drivers/accessibility/speakup/Makefile
> > +++ linux-2.6/drivers/accessibility/speakup/Makefile
> > @@ -16,6 +16,7 @@ obj-$(CONFIG_SPEAKUP_SYNTH_TXPRT) += spe
> >  obj-$(CONFIG_SPEAKUP_SYNTH_DUMMY) += speakup_dummy.o
> >  
> >  obj-$(CONFIG_SPEAKUP) += speakup.o
> > +obj-$(CONFIG_ISA) += serialio.o
> >  speakup-y := \
> >  	buffers.o \
> >  	devsynth.o \
> > @@ -25,7 +26,6 @@ speakup-y := \
> >  	keyhelp.o \
> >  	kobjects.o \
> >  	selection.o \
> > -	serialio.o \
> >  	spk_ttyio.o \
> >  	synth.o \
> >  	thread.o \
> 
> Oops, no, I get the following build errors with this patch:
> 
> ERROR: modpost: "spk_wait_for_xmitr" [drivers/accessibility/speakup/speakup.ko] undefined!

Yes, it depends on the first of the queue.

Samuel
