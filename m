Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0CB4C10F25
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 05:50:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DCF620665
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 05:50:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZASaf3Yu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726383AbgCIFtJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 01:49:09 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:40234 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725796AbgCIFtJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 01:49:09 -0400
Received: by mail-pg1-f196.google.com with SMTP id t24so4196827pgj.7
        for <linux-kernel@vger.kernel.org>; Sun, 08 Mar 2020 22:49:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oZkC5jhk4EOPYchWGqBHGQPJ7o1ZBAozfok1ceDhJV0=;
        b=ZASaf3YuN3B+j/KI/qNDSYWrHHUZtHeQwHKi0PaCz9w4R3sv9X+Ksj14Jcde5QYK9+
         dxykImt3KiJAW0tX9DwbFamh1V39kcau1SxtGpbJrPjy+2z+wzWqaLdSx3RGvbGbYZP0
         Yr8VXYTO10Hu9jB0QT0+VYkHVnz2m44MHYvZErpnNVAcEQquneuZT8UhihN8gSexas2F
         dca1plE3EKhNXfT8p1yqwI+6byGh2w6K585Uawprfk61UtLxU9CxNL54BDGzRC3d26W0
         jzWKqP49f9ELw1MzdPkaQiY4HBCJv5U6IZfCdY5Wxvq5N907h35Yi8C4Ul12IXr08xvi
         vTVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oZkC5jhk4EOPYchWGqBHGQPJ7o1ZBAozfok1ceDhJV0=;
        b=lejB9WbbxPhJJEmglbuYheVOpEGw5rkOyuU7IH4ArbPu1Flf/KobW0YzFfKui9bks4
         o/aLqcQjAOzA5KYb93hw0t2m5H7d49fd564Sel2DcaO9Hvl5KwurnH4lO1pOp4lUYwct
         GDx5sNH+V4f6V6k3IMbU4m85kCi8hMFSqY3hO/FE2WUq3/arrw0Rh9WWTVvFQ4RghpMo
         xsO3hdM4YBfs054mVP/b27KP/FmacXAGAPrZw7wIPsO2iXUtTmxe/4QeORcCqM+P+LMj
         1G+m/3LyISe7z0vueprXVnCg046h9mv+pTKE7J9OVSvd8NA8ERqazyAG1FaL4miPS9g9
         5uiQ==
X-Gm-Message-State: ANhLgQ36PkVpdYaCsZW1KQEjuu9tpuJMFwBhYis6twcsdlYudS4BVNtW
        lMoibVPVD/5erltI7kGAUH8=
X-Google-Smtp-Source: ADFU+vt2URdzb/LPamPP5uu7fSoHrlQcADJNohiXAR3PQoEpQ3THu66EYzZkMez0CUV0foH9kw6O1w==
X-Received: by 2002:a63:f243:: with SMTP id d3mr7471050pgk.254.1583732948106;
        Sun, 08 Mar 2020 22:49:08 -0700 (PDT)
Received: from Shreeya-Patel ([2405:204:2188:9cfe:18bc:a849:c699:3914])
        by smtp.googlemail.com with ESMTPSA id j5sm16904080pjz.44.2020.03.08.22.49.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 08 Mar 2020 22:49:07 -0700 (PDT)
Message-ID: <e392f09212ef4ad6dc917503e3e9782b7fefc07c.camel@gmail.com>
Subject: Re: [Outreachy kernel] [PATCH] Staging: rtl8188eu: Add space around
 operators
From:   Shreeya Patel <shreeya.patel23498@gmail.com>
To:     Joe Perches <joe@perches.com>,
        outreachy-kernel <outreachy-kernel@googlegroups.com>
Cc:     gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, sbrivio@redhat.com,
        daniel.baluta@gmail.com, nramas@linux.microsoft.com,
        hverkuil@xs4all.nl,
        "Larry.Finger@lwfinger.net" <Larry.Finger@lwfinger.net>
Date:   Mon, 09 Mar 2020 11:18:59 +0530
In-Reply-To: <f1327099b774e141bbeaa8abc47f98b9c6d49264.camel@perches.com>
References: <20200308220004.9960-1-shreeya.patel23498@gmail.com>
         <f1327099b774e141bbeaa8abc47f98b9c6d49264.camel@perches.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2020-03-08 at 16:05 -0700, Joe Perches wrote:
> On Mon, 2020-03-09 at 03:30 +0530, Shreeya Patel wrote:
> > Add space around operators for improving the code
> > readability.
> 
> Hello again Shreeya.
> 
> The subject isn't really quite appropriate as you
> are not doing this space around operator addition
> for the entire subsystem.
> 
> IMO, the subject should be:
> 
> [PATCH] staging: rtl8188eu: rtw_mlme: Add spaces around operators
> 
> because you are only performing this change on this
> single file.
> 
> If you were to do this for every single file in the
> subsystem, you could have many individual patches with
> the exact same subject line.

Oh yes, thanks for correcting me.
> 
> And it would be good to show in the changelog that you
> have compiled the file pre and post patch without object
> code change.
> 
> Also, it's good to show that git diff -w shows no source
> file changes.

okay will do this in v2.

> 
> > Reported by checkpatch.pl
> > 
> > Signed-off-by: Shreeya Patel <shreeya.patel23498@gmail.com>
> > ---
> >  drivers/staging/rtl8188eu/core/rtw_mlme.c | 40 +++++++++++------
> > ------
> >  1 file changed, 20 insertions(+), 20 deletions(-)
> 
> When I try this using checkpatch --fix-inplace, I get
> 21 changes against the latest -next tree.
> 
> What tree are you doing this against?

I am doing this against the latest -testing tree

Thanks
> 
> 

