Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 392B4C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 20:50:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 19211206F6
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 20:50:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728889AbgGGUuS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 16:50:18 -0400
Received: from smtprelay0200.hostedemail.com ([216.40.44.200]:44778 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726273AbgGGUuS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 16:50:18 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id 7AEAD182CED34;
        Tue,  7 Jul 2020 20:50:17 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: wine20_5511feb26eb7
X-Filterd-Recvd-Size: 3058
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf01.hostedemail.com (Postfix) with ESMTPA;
        Tue,  7 Jul 2020 20:50:16 +0000 (UTC)
Message-ID: <51eeed808ce61e0d7b7978b2dfd4fd80f315b3b1.camel@perches.com>
Subject: Re: [PATCH 04/30] usb: misc: sisusbvga: sisusb_init: Mark all
 'static const' arrays as __maybe_unused
From:   Joe Perches <joe@perches.com>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Thomas Winischhofer <thomas@winischhofer.net>
Date:   Tue, 07 Jul 2020 13:50:15 -0700
In-Reply-To: <20200707080311.GE3500@dell>
References: <20200703174148.2749969-1-lee.jones@linaro.org>
         <20200703174148.2749969-5-lee.jones@linaro.org>
         <af66b6e94a26ebd500c1376631891b0bdd0912f0.camel@perches.com>
         <20200707080311.GE3500@dell>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.3-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2020-07-07 at 09:03 +0100, Lee Jones wrote:
> On Fri, 03 Jul 2020, Joe Perches wrote:
> 
> > On Fri, 2020-07-03 at 18:41 +0100, Lee Jones wrote:
> > > drivers/usb/misc/sisusbvga/sisusb_init.h is included by a few
> > > source files.  Most of which do not use the majority of the
> > > shared static const arrays which have been declared.  This
> > > causes the build system to spew 100's of warnings.
> > > 
> > > Fixes the following W=1 kernel build warning(s) - and a whole lot more:
> > > 
> > >  In file included from drivers/usb/misc/sisusbvga/sisusb.c:54:
> > >  drivers/usb/misc/sisusbvga/sisusb_init.h:695:34: warning: ‘SiSUSB_VCLKData’ defined but not used [-Wunused-const-variable=]
> > >  695 | static const struct SiS_VCLKData SiSUSB_VCLKData[] = {
> > >  | ^~~~~~~~~~~~~~~
> > > [10's of lines snipped]
> > >  drivers/usb/misc/sisusbvga/sisusb_init.h:206:28: warning: ‘SiS_VGA_DAC’ defined but not used [-Wunused-const-variable=]
> > >  206 | static const unsigned char SiS_VGA_DAC[] = {
> > >  | ^~~~~~~~~~~
> > > [10's of lines snipped]
> > >  drivers/usb/misc/sisusbvga/sisusb_init.h:171:29: warning: ‘ModeIndex_1280x1024’ defined but not used [-Wunused-const-variable=]
> > >  171 | static const unsigned short ModeIndex_1280x1024[] = { 0x3a, 0x4d, 0x00, 0x65 };
> > >  | ^~~~~~~~~~~~~~~~~~~
> > > [10's of lines snipped]
> > 
> > They are not __maybe_unused, they _are_ used.
> 
> Actually, it looks like all of the ModeIndex_* table are *not* used,
> so those will be removed.
> 
> > I think these instead should be moved to where
> > they are used instead of being declared in an
> > #include file.
> 
> The remaining tables are many and large, so stuffing them into the
> source file does not seem like the correct thing to do.

It the right thing to do is because otherwise they
would be duplicated.  Either declare them only in
the single file where use or declare them extern
and define them only in one place.


