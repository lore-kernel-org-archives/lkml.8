Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C45D6C3F68F
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 08:15:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A444E2075B
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 08:15:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728801AbgAMIPU convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 03:15:20 -0500
Received: from relay11.mail.gandi.net ([217.70.178.231]:35671 "EHLO
        relay11.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728695AbgAMIPT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 03:15:19 -0500
Received: from xps13 (lfbn-tou-1-1151-102.w90-76.abo.wanadoo.fr [90.76.211.102])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay11.mail.gandi.net (Postfix) with ESMTPSA id 1ED34100013;
        Mon, 13 Jan 2020 08:15:16 +0000 (UTC)
Date:   Mon, 13 Jan 2020 09:15:15 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     kbuild test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Subject: Re: [PATCH 3/3] mtd: onenand: Enable compile testing of OMAP and
 Samsung drivers
Message-ID: <20200113091515.4404dbb6@xps13>
In-Reply-To: <20200113074632.GA1187@pi3>
References: <20191229183612.22133-3-krzk@kernel.org>
        <201912310904.9iM6MaFr%lkp@intel.com>
        <20191231073339.GA6747@pi3>
        <20200109161826.7fda02a4@xps13>
        <20200113074632.GA1187@pi3>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

Krzysztof Kozlowski <krzk@kernel.org> wrote on Mon, 13 Jan 2020
08:46:32 +0100:

> On Thu, Jan 09, 2020 at 04:18:26PM +0100, Miquel Raynal wrote:
> > Hi Krzysztof,
> > 
> > Krzysztof Kozlowski <krzk@kernel.org> wrote on Tue, 31 Dec 2019
> > 08:33:39 +0100:
> >   
> > > On Tue, Dec 31, 2019 at 10:00:48AM +0800, kbuild test robot wrote:  
> > > > Hi Krzysztof,
> > > > 
> > > > I love your patch! Perhaps something to improve:
> > > > 
> > > > [auto build test WARNING on linus/master]
> > > > [also build test WARNING on v5.5-rc4 next-20191220]
> > > > [if your patch is applied to the wrong git tree, please drop us a note to help
> > > > improve the system. BTW, we also suggest to use '--base' option to specify the
> > > > base tree in git format-patch, please see https://stackoverflow.com/a/37406982]
> > > > 
> > > > url:    https://github.com/0day-ci/linux/commits/Krzysztof-Kozlowski/mtd-onenand-samsung-Fix-pointer-cast-Wpointer-to-int-cast-warnings-on-64-bit/20191230-030838
> > > > base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git bf8d1cd4386535004c4afe7f03d37f9864c9940e
> > > > reproduce:
> > > >         # apt-get install sparse
> > > >         # sparse version: v0.6.1-129-g341daf20-dirty
> > > >         make ARCH=x86_64 allmodconfig
> > > >         make C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__'
> > > > 
> > > > If you fix the issue, kindly add following tag
> > > > Reported-by: kbuild test robot <lkp@intel.com>
> > > >     
> > > 
> > > It is not related to my patch. I'll fix it up soon.  
> > 
> > I would like this to be fixed before enabling compile testing, is your
> > fix read?  
> 
> Yes, you picked up the fix here:
> https://lore.kernel.org/lkml/20200103164158.4265-1-krzk@kernel.org/

Perfect, I did not even linked these issues together.

Thanks,
Miquèl
