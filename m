Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 132AEC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 15:08:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D0F752072C
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 15:08:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W0+hqrHw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729777AbgEUPIW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 11:08:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728229AbgEUPIV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 11:08:21 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FEC5C061A0E
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 08:08:21 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id c24so5709269qtw.7
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 08:08:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=LTvEEGeS3AeJSpq4ZVHIXuVyD9+KGHohS7s/D0phJak=;
        b=W0+hqrHwbUhpCwGT7ted1RVsLGtTjL0p0TEkD3LwLl9GRA2IdpqAWpISKTp4KrWR3G
         qSqgSG/IpmziIG6tYqE6Cb+i8Nrnhpk5bdKafdHXulONG7HV2EH/ErDqQVc9iHGAzHKv
         GDEu4sE6lpSfvwwpseoIHMT/oQqN26+4MeDlDSL/ZtkHeXVPCeA0nTGw1tc6ZrwH+WVO
         LXbksT7gqyfOS7p41+6N9FRDPhuKjzZYqiwnk9VJSzo1meA/2IEPFHPai/Y5SHf1TlFs
         81zOrny5IBupdmdr8qdu8LxMK0fxQ9HUlICIeNy9iQR8kjZcTuLQX85d1JxJK30c4wAE
         jiSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=LTvEEGeS3AeJSpq4ZVHIXuVyD9+KGHohS7s/D0phJak=;
        b=i36kWdh2LD8jWlVYsSSW8aA1u2cjqAWvD8dL7trhaBek7ovz7E68xbRZTA6FIBvBt8
         u4uwRDQ7gNALU21heBmRuYpjiS4vPqtniZFBdCyaAdklY2uhq8EeR/7AL5P+uX8OP2qg
         +umcQ19VGujthvRJhNV1idVVOxxwwJ2gAT6tF7FMa2m8SHt7K70sltVfF6CZg96f/x0t
         0+05IumcV0y5o0w0DTXKLsJr70n3ssK55WSZ2RmznUwXidqqywpW3LAPO/LDUVR4q3Zt
         1UC9o9me1ox+eUwLH6aIbitXG9FMf2r2i0JGjI28vjAVXNZBdY2ux3O9u/ANo4auHGlX
         OVVA==
X-Gm-Message-State: AOAM533o4/rl9v+ALiszmEwKjZD/oNDA9r93hJ3XADF024DlXVSH3bPC
        Cnq/oWFqnZ4VgxxFpKWlteQ=
X-Google-Smtp-Source: ABdhPJwxFUfB/1USs4ZGm76wB/m1C0p9RspnffXzZWb+DsqOmJMJPE37vhy4QHPbN/ZavH4BzAhwsQ==
X-Received: by 2002:ac8:4e06:: with SMTP id c6mr11191079qtw.360.1590073700207;
        Thu, 21 May 2020 08:08:20 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id o2sm5606013qtj.70.2020.05.21.08.08.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2020 08:08:19 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Thu, 21 May 2020 11:08:17 -0400
To:     Petr Mladek <pmladek@suse.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Joe Perches <joe@perches.com>,
        Chenggang Wang <wangchenggang@vivo.com>,
        linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [RFC PATCH 2/2] init: Allow multi-line output of kernel command
 line
Message-ID: <20200521150817.GA502432@rani.riverdale.lan>
References: <cover.1589916689.git.joe@perches.com>
 <2b3832fed9370f0f8dfd1ea33dddb1d05a36e265.1589916689.git.joe@perches.com>
 <20200520044127.GB938@jagdpanzerIV.localdomain>
 <ae3aff79301c130aa15b3fe0ff801804bb019384.camel@perches.com>
 <20200520121000.GF520@jagdpanzerIV.localdomain>
 <19a8c717f8d9dc76f2b09e6dd19f3fbb71bf29c5.camel@perches.com>
 <20200520180028.8fc1b7890774c6f92a6c2623@linux-foundation.org>
 <20200521043628.GB755@jagdpanzerIV.localdomain>
 <20200520214007.86f36f61e1fc0329b66758ed@linux-foundation.org>
 <20200521123117.GD8397@linux-b0ei>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200521123117.GD8397@linux-b0ei>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 21, 2020 at 02:31:17PM +0200, Petr Mladek wrote:
> On Wed 2020-05-20 21:40:07, Andrew Morton wrote:
> > On Thu, 21 May 2020 13:36:28 +0900 Sergey Senozhatsky <sergey.senozhatsky@gmail.com> wrote:
> > 
> > > On (20/05/20 18:00), Andrew Morton wrote:
> > > [..]
> > > > I'm wondering if we shold add a kernel puts() (putsk()?  yuk) which can
> > > > puts() a string of any length.
> > > > 
> > > > I'm counting around 150 instances of printk("%s", ...) and pr_foo("%s",
> > > > ...) which could perhaps be converted, thus saving an argument.
> > > 
> > > Can you point me at some examples?
> > > 
> > 
> > ./arch/powerpc/kernel/udbg.c:           printk("%s", s);
> > ./arch/powerpc/xmon/nonstdio.c:         printk("%s", xmon_outbuf);
> > ./arch/um/os-Linux/drivers/ethertap_user.c:             printk("%s", output);
> > ./arch/um/os-Linux/drivers/ethertap_user.c:             printk("%s", output);
> > ./arch/um/os-Linux/drivers/tuntap_user.c:                       printk("%s", out
> > 
> > etc.
> > 
> > My point is, if we created a length-unlimited puts() function for printing the
> > kernel command line, it could be reused in such places, resulting in a
> > smaller kernel.
> 
> Interesting idea. Well, such a generic function would need to be safe
> and do not modify the original string. We would need to implement
> printk() variant that would support strigs limited by size instead
> of the trailing '\0'. I am not sure if it is worth it.
> 
> Best Regards,
> Petr

You don't need a printk variant for strings -- you'd only need one if
you wanted formatted output of unlimited length. Using printk("%.*s",
chunk_size, str) should print at most chunk_size characters from str.
The puts could then just be a loop around that.

Something like:

do {
	printed = printk("%.*s", chunk_size, str);
	str += printed;
} while (printed >= chunk_size);
