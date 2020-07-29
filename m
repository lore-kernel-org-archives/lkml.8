Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLACK,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6C3DC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 00:36:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC64D20663
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 00:36:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730868AbgG2AgZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 20:36:25 -0400
Received: from hera.aquilenet.fr ([185.233.100.1]:47076 "EHLO
        hera.aquilenet.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730507AbgG2AgZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 20:36:25 -0400
Received: from localhost (localhost [127.0.0.1])
        by hera.aquilenet.fr (Postfix) with ESMTP id 59C08A608;
        Wed, 29 Jul 2020 02:36:24 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at aquilenet.fr
Received: from hera.aquilenet.fr ([127.0.0.1])
        by localhost (hera.aquilenet.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 8TYzVrFxfY_g; Wed, 29 Jul 2020 02:36:23 +0200 (CEST)
Received: from function (lfbn-bor-1-797-11.w86-234.abo.wanadoo.fr [86.234.239.11])
        by hera.aquilenet.fr (Postfix) with ESMTPSA id C7FF2A5BF;
        Wed, 29 Jul 2020 02:36:23 +0200 (CEST)
Received: from samy by function with local (Exim 4.94)
        (envelope-from <samuel.thibault@ens-lyon.org>)
        id 1k0a51-003o5G-4E; Wed, 29 Jul 2020 02:36:23 +0200
Date:   Wed, 29 Jul 2020 02:36:23 +0200
From:   Samuel Thibault <samuel.thibault@ens-lyon.org>
To:     Joe Perches <joe@perches.com>
Cc:     linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        speakup@linux-speakup.org
Subject: Re: [PATCH] staging/speakup: Move out of staging
Message-ID: <20200729003623.d42ljafn6sd7y2be@function>
Mail-Followup-To: Samuel Thibault <samuel.thibault@ens-lyon.org>,
        Joe Perches <joe@perches.com>, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, speakup@linux-speakup.org
References: <20200728211208.691249-1-samuel.thibault@ens-lyon.org>
 <c4cb56cca7928f92d642aef467244db434bff26f.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c4cb56cca7928f92d642aef467244db434bff26f.camel@perches.com>
Organization: I am not organized
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Joe Perches, le mar. 28 juil. 2020 17:24:47 -0700, a ecrit:
> On Tue, 2020-07-28 at 23:12 +0200, Samuel Thibault wrote:
> > diff --git a/MAINTAINERS b/MAINTAINERS
> []
> > @@ -16077,6 +16077,15 @@ Q:	https://patchwork.kernel.org/project/linux-sparse/list/
> >  B:	https://bugzilla.kernel.org/enter_bug.cgi?component=Sparse&product=Tools
> >  F:	include/linux/compiler.h
> >  
> > +SPEAKUP CONSOLE SPEECH DRIVER
> > +M:	William Hubbs <w.d.hubbs@gmail.com>
> > +M:	Chris Brannon <chris@the-brannons.com>
> > +M:	Kirk Reiser <kirk@reisers.ca>
> > +M:	Samuel Thibault <samuel.thibault@ens-lyon.org>
> > +L:	speakup@linux-speakup.org
> > +W:	http://www.linux-speakup.org/
> > +F:	drivers/accessibility/speakup/
> 
> S:? 	Supported / Maintained / Odd Fixes ?

Ah, yes.  I should have read the documentation at the top, instead of
assuming that "S:" standed for the reason for being in "S"taging.

Submitted a v2.

Samuel
