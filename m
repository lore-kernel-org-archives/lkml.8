Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 525ACC2BB1D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 03:11:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 379B320678
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 03:11:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389393AbgDODLc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 23:11:32 -0400
Received: from smtprelay0247.hostedemail.com ([216.40.44.247]:38966 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731048AbgDODLV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 23:11:21 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id 66338181D341E;
        Wed, 15 Apr 2020 03:11:19 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: floor22_286eb4526923a
X-Filterd-Recvd-Size: 2068
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf12.hostedemail.com (Postfix) with ESMTPA;
        Wed, 15 Apr 2020 03:11:17 +0000 (UTC)
Message-ID: <414a17ea0978cf65020d9be84f257fe85edc62ab.camel@perches.com>
Subject: Re: [PATCH 1/2] staging: rtl8192u: Refactoring setKey function
From:   Joe Perches <joe@perches.com>
To:     Camylla Cantanheide <c.cantanheide@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        navid.emamdoost@gmail.com, sylphrenadin@gmail.com,
        nishkadg.linux@gmail.com, stephen@brennan.io,
        devel@driverdev.osuosl.org, LKML <linux-kernel@vger.kernel.org>,
        lkcamp@lists.libreplanetbr.org
Date:   Tue, 14 Apr 2020 20:09:07 -0700
In-Reply-To: <CAG3pEr+huVACoP7sTMALYfE46dc+D8DdGPF0ky6EShd4eXD9eg@mail.gmail.com>
References: <20200413030129.861-1-c.cantanheide@gmail.com>
         <20200414123326.GG1163@kadam>
         <CAG3pEr+huVACoP7sTMALYfE46dc+D8DdGPF0ky6EShd4eXD9eg@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2020-04-14 at 22:18 -0300, Camylla Cantanheide wrote:
> Em ter., 14 de abr. de 2020 às 09:35, Dan Carpenter <
> dan.carpenter@oracle.com> escreveu:
[]
> > > diff --git a/drivers/staging/rtl8192u/r8192U_core.c
[]
> > > +     target_content = macaddr[0] << 16 |
> > > +                      macaddr[0] << 24 |
> > > +                     (u32)us_config;

And Camylla, this statement should be

+     target_content = macaddr[0] << 16 |
+                      macaddr[1] << 24 |
+                     (u32)us_config;

Not a repeated [0]

> > > +
> > > +     write_nic_dword(dev, WCAMI, target_content);
> > > +     write_nic_dword(dev, RWCAM, target_command++);
> > > +
> > > +     /* MAC */
> > > +     target_content = macaddr[2]       |
> > > +                      macaddr[3] <<  8 |
> > > +                      macaddr[4] << 16 |
> > > +                      macaddr[5] << 24;



