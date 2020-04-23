Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6B2DC54FCB
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 15:51:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 801DA20CC7
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 15:51:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="siyn8fn9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729419AbgDWPv0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 11:51:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729072AbgDWPv0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 11:51:26 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8770C09B040;
        Thu, 23 Apr 2020 08:51:24 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id 18so3144166pfx.6;
        Thu, 23 Apr 2020 08:51:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=+Lpx84ybnP3CbGO9+hIlMb8pKZvpHlBUCvuaUaL2gSc=;
        b=siyn8fn9dgNTeY0PFfNmf3LQOi0S4q18gLuG/8tqxoJ2xhYIUJtylgFoSPsgXvC62U
         13PR7A6ZHoCHxk6J5LGWsHxwmqAbc9fAL3QpZTmQHXf9lND8mWx5WZsepUSTtHf9ilO7
         iYoWUINohBd88hEZk/vniNzaVSpxQQlBxTzTUaUQwdFnNk1BX0IqjmE0DXZjEPE+BFO4
         o+TOxBANszxYwZg9ETuztp4Z1kS2iy8RSSXxvZKe5QHPZYDg2RfNblXS9svfX0sneC3Q
         Ap0U76J8jIoXqnEHpcJQWa7SFgJBTPm73RPp2csNvjdfbyUffI3AeCGPC6DWelbU6sFA
         eVVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=+Lpx84ybnP3CbGO9+hIlMb8pKZvpHlBUCvuaUaL2gSc=;
        b=Vw46uONZ2rbslhgTGFzcq7IbllIpLNb7skz35flTY6ZLxyxZE4Ra4+Hk2VXgTSHCft
         o7UqxtA/OuCBzfm+Mkmw2/OgGfUTxLiZKhMSxhIexyr3yTbUqOT5NB9RZMSiOaQ1C+6O
         I+NwCzEh34kDgREtBP6bH5X8oQrPlm1jsmq7P+TmJnLbXyLxXcsPsuOqZnXZ1ixStHoR
         wX5U9237YCBqmj/cZd9XVue6SXensU0qKmkFUO+z8YwreWyQnxBEvODexIjNwBSRZOaN
         qQLwKuJAnlTQQa/wpM3d347IlcSog7G0ncodvrhGuFxgorQswLqmpXoExe5wrOJB44wi
         7bqQ==
X-Gm-Message-State: AGi0PuYnSYht+stXoV2Po6iCcRoMj5tnmf6HCl+0HxjOmA19nLvHLiGd
        phBkcn4U4fiYv4tk6g6deQY=
X-Google-Smtp-Source: APiQypIz/YwOugDPJn9jgplod/vw/LcRDTS+6PH+rgJgIUALhMFb4iU4bXeGzUzz1cPDhS+gji1UoA==
X-Received: by 2002:a05:6a00:d:: with SMTP id h13mr4466425pfk.254.1587657084207;
        Thu, 23 Apr 2020 08:51:24 -0700 (PDT)
Received: from localhost (176.122.158.71.16clouds.com. [176.122.158.71])
        by smtp.gmail.com with ESMTPSA id h17sm2931338pfk.13.2020.04.23.08.51.22
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 23 Apr 2020 08:51:23 -0700 (PDT)
Date:   Thu, 23 Apr 2020 23:51:16 +0800
From:   Dejin Zheng <zhengdejin5@gmail.com>
To:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc:     gregkh@linuxfoundation.org, tglx@linutronix.de,
        FlorianSchandinat@gmx.de, ralf@linux-mips.org,
        tsbogend@alpha.franken.de, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v2] console: console: Complete exception handling in
 newport_probe()
Message-ID: <20200423155116.GA2247@nuc8i5>
References: <CGME20200423142637eucas1p2ea543e281d96c75aa4292b49756f2146@eucas1p2.samsung.com>
 <20200423142627.1820-1-zhengdejin5@gmail.com>
 <081f8192-1708-80ff-6eef-885d72bdf5c5@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <081f8192-1708-80ff-6eef-885d72bdf5c5@samsung.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 23, 2020 at 04:55:35PM +0200, Bartlomiej Zolnierkiewicz wrote:
> 
> Hi,
> 
> I believe that the patch summary line should be:
> 
> "[PATCH v2] console: newport_con: ..."
>
OK, thanks!

> On 4/23/20 4:26 PM, Dejin Zheng wrote:
> > A call of the function ¡°do_take_over_console¡± can fail here.
> > The corresponding system resources were not released then.
> > Thus add a call of the function ¡°iounmap¡± together with the check
> > of a failure predicate.
> > 
> > Fixes: e84de0c6190503 ("MIPS: GIO bus support for SGI IP22/28")
>
> I cannot see how this patch fixes commit e84de0c6190503
> (AFAICS npregs has also been leaked on error before)?
>
yes, you are right, the commit should be e86bb8acc0fdca82d2
("[PATCH] VT binding: Make newport_con support binding")

- move register ioremap from newport_startup() to newport_console_init()

> > CC: Andy Shevchenko <andy.shevchenko@gmail.com>
> > Signed-off-by: Dejin Zheng <zhengdejin5@gmail.com>
> > ---
> > v1 -> v2:
> > 	- modify the commit comments by Markus'suggestion.
> > 
> >  drivers/video/console/newport_con.c | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/drivers/video/console/newport_con.c b/drivers/video/console/newport_con.c
> > index 00dddf6e08b0..6bfc8e3ffd4a 100644
> > --- a/drivers/video/console/newport_con.c
> > +++ b/drivers/video/console/newport_con.c
> > @@ -720,6 +720,9 @@ static int newport_probe(struct gio_device *dev,
> >  	console_lock();
> >  	err = do_take_over_console(&newport_con, 0, MAX_NR_CONSOLES - 1, 1);
> >  	console_unlock();
> > +
> > +	if (err)
> > +		iounmap((void *)npregs);
> 
> Looks OK but while you are at it, could you please also add missing
> release_mem_region() on error and on device removal:
>
Ok, Thanks, I will send the patch v3 for it.

> 	newport_addr = dev->resource.start + 0xF0000;
> 	if (!request_mem_region(newport_addr, 0x10000, "Newport"))
> 		return -ENODEV;
> 
> 	npregs = (struct newport_regs *)/* ioremap cannot fail */
> 		ioremap(newport_addr, sizeof(struct newport_regs));
> 	console_lock();
> 	err = do_take_over_console(&newport_con, 0, MAX_NR_CONSOLES - 1, 1);
> 	console_unlock();
> 	return err;
> }
> 
> static void newport_remove(struct gio_device *dev)
> {
> 	give_up_console(&newport_con);
> 	iounmap((void *)npregs);
> }
> 
> ?
> 
> >  	return err;
> >  }
> >  
> 
> Best regards,
> --
> Bartlomiej Zolnierkiewicz
> Samsung R&D Institute Poland
> Samsung Electronics
