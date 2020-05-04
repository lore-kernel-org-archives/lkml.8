Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B25FC3A5A9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 15:20:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E37AF2054F
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 15:20:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="ar8D3WWo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728608AbgEDPUy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 11:20:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725941AbgEDPUx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 11:20:53 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59067C061A0E
        for <linux-kernel@vger.kernel.org>; Mon,  4 May 2020 08:20:53 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id 19so12655376ioz.10
        for <linux-kernel@vger.kernel.org>; Mon, 04 May 2020 08:20:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=T6E4sa47WiUWY45YJzDn9sg5wskjTrREH+XL57J4HjA=;
        b=ar8D3WWowhf3TqhMXvosjX37VL5Q3PMOE23J1QCv7tuISdMTJC0n0Cv+q8afrpkrBK
         MKxDhD6taHPoUUGb8UZSZ3Vtw298CeT6gMiCExHKX2Mk1wMVRxgj9sxzLAxB1nkKcRsX
         r7OkHfZwH5rTo0FRaf5ydWedH4FqyaGGOkkRc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=T6E4sa47WiUWY45YJzDn9sg5wskjTrREH+XL57J4HjA=;
        b=UuexV4wv2NwtpmcuOx6hr0hIpvDAnvnFnlRThuyh4WaZ6RggdLtf9/WXQOYP3Bqxbb
         nnAlB9IlpH8Q7wdeAjPkqdVVtUDDoD2A8+X5J+hSG/2CoGY5xm5aIhZ0ebPvVCbaY+s8
         EtZAT/ioCUU7uOS7PZANipuh3wm+ViZ49ZyyuzZ1zYTx8+3UYhGmoT2M+sDhUE7pOJAT
         7R1Bz7Ppfuhui+skKlnPpw30ieUdpos7SUUoDCdywelF2VGC4iyQoJrL4cFGl2u3+EGD
         MHFY3qAJvjEAAyWeJPOHiFjqc6Xs/zocIBklInXZt7EE6vuJxZSJ8UdpNpItLKTOkhwB
         tR/g==
X-Gm-Message-State: AGi0PuaVN8BQ87Lgm8BfzfN9bDhwDOiFsKkTzFQdBTSDcVL/QApn9MFe
        ZkCgBzlqpt/op7kI88Nw7gnWQsJNj1l2CfcZ8cbDJA==
X-Google-Smtp-Source: APiQypKVjWID+3rjrtFjLcSSUH+W8buTUh3xgn1YhjYKIoTsozCZ0Fz29P55Fk0GHlGltBqh//rR3Tiv8gGmRnIpECo=
X-Received: by 2002:a6b:3e0a:: with SMTP id l10mr2587371ioa.112.1588605652380;
 Mon, 04 May 2020 08:20:52 -0700 (PDT)
MIME-Version: 1.0
References: <20191021193343.41320-1-kdasu.kdev@gmail.com> <20191105200344.1e8c3eab@xps13>
 <1718371158.75883.1572995022606.JavaMail.zimbra@nod.at> <20200109160352.6080e1e5@xps13>
 <CAKekbeucdjZgttQfHeiXH6S92He2qkKGsQcEqz_4_okHzDK16A@mail.gmail.com>
 <20200109182807.04c8866a@xps13> <20200502200806.1d6b1cba@xps13>
In-Reply-To: <20200502200806.1d6b1cba@xps13>
From:   Kamal Dasu <kamal.dasu@broadcom.com>
Date:   Mon, 4 May 2020 11:20:16 -0400
Message-ID: <CAKekbevhWqsYSacTFCp+XEv7nBjL7tbo_wkOiCDZ1UYPf=RoeA@mail.gmail.com>
Subject: Re: [PATCH] mtd: set mtd partition panic write flag
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Vignesh Raghavendra <vigneshr@ti.com>,
        Kamal Dasu <kdasu.kdev@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 2, 2020 at 2:08 PM Miquel Raynal <miquel.raynal@bootlin.com> wr=
ote:
>
> Hi Kamal,
>
> Miquel Raynal <miquel.raynal@bootlin.com> wrote on Thu, 9 Jan 2020
> 18:28:07 +0100:
>
> > Hi Kamal,
> >
> > Kamal Dasu <kamal.dasu@broadcom.com> wrote on Thu, 9 Jan 2020 10:25:59
> > -0500:
> >
> > > Miquel,
> > >
> > > Yes the issue is still open. I was trying to understand the suggestio=
n
> > > and did not get a reply on the question I had
> > >
> > > Richard wrote :
> > > "So the right fix would be setting the parent's oops_panic_write in
> > > mtd_panic_write().
> > > Then we don't have to touch mtdpart.c"
> > >
> > > How do I get access to the parts parent in the core ?. Maybe I am
> > > missing something.
> >
> > I think the solution is to set the oops_panic_write of the root parent,=
 instead of updating the flag of the mtd device itself (which is maybe a pa=
rtition).
> >
> > Would this help?
> >
> > https://www.spinics.net/lists/linux-mtd/msg10454.html
>
> I'm pinging you here as well, as I think you raise a real issue, and we
> agreed on a solution, which can now be easily setup with the above
> change which has been applied and support for functions like:
>
>         static inline struct mtd_info *mtd_get_master(struct mtd_info *mt=
d)
>         static inline u64 mtd_get_master_ofs(struct mtd_info *mtd, u64 of=
s)
>         static inline bool mtd_is_partition(const struct mtd_info *mtd)
>         static inline bool mtd_has_partitions(const struct mtd_info *mtd)
>

So I should only set  master->oops_panic_write  with the new code ?.

> Thanks,
> Miqu=C3=A8l


Kamal
