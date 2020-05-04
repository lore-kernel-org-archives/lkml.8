Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6A4DC3A5A9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 17:30:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD1D4206D9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 17:30:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730377AbgEDRat convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 13:30:49 -0400
Received: from relay11.mail.gandi.net ([217.70.178.231]:47693 "EHLO
        relay11.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729597AbgEDRas (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 13:30:48 -0400
Received: from xps13 (unknown [91.224.148.103])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay11.mail.gandi.net (Postfix) with ESMTPSA id EFDA2100009;
        Mon,  4 May 2020 17:29:37 +0000 (UTC)
Date:   Mon, 4 May 2020 19:29:36 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Kamal Dasu <kamal.dasu@broadcom.com>
Cc:     Vignesh Raghavendra <vigneshr@ti.com>,
        Kamal Dasu <kdasu.kdev@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH] mtd: set mtd partition panic write flag
Message-ID: <20200504192936.2973c3bf@xps13>
In-Reply-To: <CAKekbevhWqsYSacTFCp+XEv7nBjL7tbo_wkOiCDZ1UYPf=RoeA@mail.gmail.com>
References: <20191021193343.41320-1-kdasu.kdev@gmail.com>
        <20191105200344.1e8c3eab@xps13>
        <1718371158.75883.1572995022606.JavaMail.zimbra@nod.at>
        <20200109160352.6080e1e5@xps13>
        <CAKekbeucdjZgttQfHeiXH6S92He2qkKGsQcEqz_4_okHzDK16A@mail.gmail.com>
        <20200109182807.04c8866a@xps13>
        <20200502200806.1d6b1cba@xps13>
        <CAKekbevhWqsYSacTFCp+XEv7nBjL7tbo_wkOiCDZ1UYPf=RoeA@mail.gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kamal,

Kamal Dasu <kamal.dasu@broadcom.com> wrote on Mon, 4 May 2020 11:20:16
-0400:

> On Sat, May 2, 2020 at 2:08 PM Miquel Raynal <miquel.raynal@bootlin.com> wrote:
> >
> > Hi Kamal,
> >
> > Miquel Raynal <miquel.raynal@bootlin.com> wrote on Thu, 9 Jan 2020
> > 18:28:07 +0100:
> >  
> > > Hi Kamal,
> > >
> > > Kamal Dasu <kamal.dasu@broadcom.com> wrote on Thu, 9 Jan 2020 10:25:59
> > > -0500:
> > >  
> > > > Miquel,
> > > >
> > > > Yes the issue is still open. I was trying to understand the suggestion
> > > > and did not get a reply on the question I had
> > > >
> > > > Richard wrote :
> > > > "So the right fix would be setting the parent's oops_panic_write in
> > > > mtd_panic_write().
> > > > Then we don't have to touch mtdpart.c"
> > > >
> > > > How do I get access to the parts parent in the core ?. Maybe I am
> > > > missing something.  
> > >
> > > I think the solution is to set the oops_panic_write of the root parent, instead of updating the flag of the mtd device itself (which is maybe a partition).
> > >
> > > Would this help?
> > >
> > > https://www.spinics.net/lists/linux-mtd/msg10454.html  
> >
> > I'm pinging you here as well, as I think you raise a real issue, and we
> > agreed on a solution, which can now be easily setup with the above
> > change which has been applied and support for functions like:
> >
> >         static inline struct mtd_info *mtd_get_master(struct mtd_info *mtd)
> >         static inline u64 mtd_get_master_ofs(struct mtd_info *mtd, u64 ofs)
> >         static inline bool mtd_is_partition(const struct mtd_info *mtd)
> >         static inline bool mtd_has_partitions(const struct mtd_info *mtd)
> >  
> 
> So I should only set  master->oops_panic_write  with the new code ?.

Yes, if you can still reproduce the issue and it solves your problem,
then it's I think a nice fix.

Thanks,
Miquèl
