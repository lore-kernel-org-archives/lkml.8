Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC5A6C54FCB
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 14:52:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 95E192074F
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 14:52:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qE2OfZI2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728897AbgDWOwr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 10:52:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726380AbgDWOwr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 10:52:47 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FCD6C08E934;
        Thu, 23 Apr 2020 07:52:47 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id t16so2439098plo.7;
        Thu, 23 Apr 2020 07:52:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=XXa44dRejUVD9khGbpB7Lq0g9wT1bE7Lq11QXvftrgA=;
        b=qE2OfZI2wUVvj77T4PFS0pvS8DTwl271ADgwm6nQaDeGBfGTNSVgYanwxrIvfw4rAI
         J58hPTNIqmjrHrUpsIOY6RtbFoJGIgscCA41U8MGHAHQTPoudHOATd9n32TM7IoqKprO
         7s/TmDNACHiujN3hfikbHxN8ZlKxSGsqz2Ql/+u5h8BPgBFgL19XhinLPzl2rW8Nh1ZQ
         G/HIyN4hEzJHAz/4ZmhJE3bAvpQqzlXcYv0qngMoe68yFw0BvvR8Am6znPtWDs2jnPQO
         w/px3lOq3k9fN2N+okO6iwWf0bdu1nGSw3QjAMDkoovNlS16b3D6r2yGbnlV7bXlHBZl
         4aIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=XXa44dRejUVD9khGbpB7Lq0g9wT1bE7Lq11QXvftrgA=;
        b=oihQQ+JOFBLI2z7XH6Tt6N0YQvbA58dJUN1ochJS8KOsUL7leK6qLARivz6fgOCCdU
         wHPtjTxysZ2St37eM47+xbx/kFlbWIgQWDSXv0s2KyjgLb8G4AMWQ6UF35z+4CA9b++E
         mqwpNETs8hAfN0SPgTbW1p8c06fX1N6+D6PSk8nFE6gzi3TB/YvlmGBEg4krbCz5e/mW
         LGnQh3VFC7ryNynopDfgtbZtPKliTjwzmIJpgd32bJrc6L7gNcGK8beKBo94LU/Q2MtJ
         Z3yj7/cfW0dgth/NpoEKauogjUr4P/eGtQxy2erlDzGeHoDTb04/1ab8cLxNINSuGqbQ
         R4tQ==
X-Gm-Message-State: AGi0PuY2fLG5Vi/R2cnR4xeJPfQKIGJXN98p4DqIsbZ4tmyj4gW7L0H7
        R8SA1BHjJvU+iuGmFWzt+X0=
X-Google-Smtp-Source: APiQypJpH6Jh81nSVTNgvgCANJgQ3DPA4JhoZAwMB7qvMzGPSlAcC3qmZOotUwN/EekORxapq5Vkgw==
X-Received: by 2002:a17:90a:2f64:: with SMTP id s91mr1147538pjd.30.1587653566730;
        Thu, 23 Apr 2020 07:52:46 -0700 (PDT)
Received: from localhost ([176.122.158.71])
        by smtp.gmail.com with ESMTPSA id r189sm2319896pgr.31.2020.04.23.07.52.45
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 23 Apr 2020 07:52:46 -0700 (PDT)
Date:   Thu, 23 Apr 2020 22:52:40 +0800
From:   Dejin Zheng <zhengdejin5@gmail.com>
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Teddy Wang <teddy.wang@siliconmotion.com>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v1] fbdev: sm712fb: fix an issue about iounmap for a
 wrong address
Message-ID: <20200423145239.GC1562@nuc8i5>
References: <bb6ba7c9-ad92-9c54-e1c4-91d2f7d0f5f8@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bb6ba7c9-ad92-9c54-e1c4-91d2f7d0f5f8@web.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 23, 2020 at 02:14:48PM +0200, Markus Elfring wrote:
> > the sfb->fb->screen_base is not save the value get by iounmap() when
> > the chip id is 0x720.
> 
> I suggest to improve this change description.
> How did you determine relevant differences for the mentioned chip model?
>
Read and check its codes。

smtcfb_pci_probe() --> smtc_map_smem()

smtcfb_pci_probe()
switch (sfb->chip_id) {
        case 0x710:
        case 0x712:
		sfb->lfb = ioremap(mmio_base, mmio_addr);
	case 0x720:
		sfb->dp_regs = ioremap(mmio_base, 0x00200000 + smem_size);
                sfb->lfb = sfb->dp_regs + 0x00200000;
	}
smtc_map_smem()
	sfb->fb->screen_base = sfb->lfb;


smtcfb_pci_remove() --> smtc_unmap_smem()

smtc_unmap_smem()
	iounmap(sfb->fb->screen_base);

> 
> > so iounmap() for address sfb->fb->screen_base is not right.
> 
> Will another imperative wording become helpful here?
> 
yes, this is why need to change this code.

> 
> …
> > +++ b/drivers/video/fbdev/sm712fb.c
> > @@ -1429,6 +1429,8 @@  static int smtc_map_smem(struct smtcfb_info *sfb,
> >  static void smtc_unmap_smem(struct smtcfb_info *sfb)
> >  {
> >  	if (sfb && sfb->fb->screen_base) {
> > +		if (sfb->chip_id == 0x720)
> > +			sfb->fb->screen_base -= 0x00200000;
> >  		iounmap(sfb->fb->screen_base);
> 
> How do you think about to use descriptive identifiers for
> the shown constants?
>
These two constants are originally in the driver, I don't know enough
about its meaning, There are a lot of constants in this driver. If I
replace it with the macro, I worry that the name of the macro may not
be accurate.

> Would you like to clarify any related software analysis approaches?
>
just read coedes and check it.

> Regards,
> Markus
