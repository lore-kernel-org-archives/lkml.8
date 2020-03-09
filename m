Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1C55C10F27
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 13:26:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8325120873
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 13:26:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vZN2XnYD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726512AbgCIN0K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 09:26:10 -0400
Received: from mail-pj1-f66.google.com ([209.85.216.66]:53794 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726384AbgCIN0K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 09:26:10 -0400
Received: by mail-pj1-f66.google.com with SMTP id l36so1600935pjb.3
        for <linux-kernel@vger.kernel.org>; Mon, 09 Mar 2020 06:26:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SN/uB0D2Yzk6crG8CckiI8AbJhkaIxgSVOsdNRCejtQ=;
        b=vZN2XnYDJ42k+ninu6A+IqHKelBwH0M+hvsD+QV5C1ROyLTi2CL/HhhIyjJdutTh/1
         pm1NaWqdB3J+PCc/hmjN7jo8hHGJwXnBk4S+fbh5wZFbZ5jjP2Km+6L0VY7iMrY0L7aA
         Y7p+WwwdH8DtI3Lb4sE1zsFcv5tQrvN4g/xCdPryr+YFKoAy2AZ2fR72wC2pJp4GuQKj
         KcLsJGg4vKdABf8bMPdCfQuisRs+6A89s78laLH06lBhpeZBHPaDAyZYwR7gPXSVmw70
         p6HMEoGKYu041hKfHOxlPj7MIZzisw82/ECfEnov4ZOLA/1j4hFO+xgcM4dmYDOiHlkl
         EHlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SN/uB0D2Yzk6crG8CckiI8AbJhkaIxgSVOsdNRCejtQ=;
        b=F5lGnMVnOvyCdCfkMeT+FXYxdnkKRGB5coFzD8s/J5Vb+tWFqXLJyMAihfFB+YXTZ4
         jirVkGCey/z5uteG9YoIFLySWu9e8nFrjV6oLHI4vPBtcWwXlfecywGrEwUHZkBALdfU
         cGvTDyO+i0L2GqX3E/eh8EGi7PYo49lGqlv50ALmm04/1hngjVNJABD1XzW4cJf4ILi4
         comfRnUNypeVpwVizBffkUY2Q5AMiSkCqLIV7OgSR386SdgDcjHvjF6kha+cSDL+Aaj+
         PNIMPLWDMQgk9JZOnk4CvD9L3z2aSI3UgYM1ECXemzvjELeP573UfsTLX7bEKVmQU1co
         6Vww==
X-Gm-Message-State: ANhLgQ07gP1M3/gTlWlXCSb9dmX+QugbBn12uDLutGTWQTGh7zTULlnP
        F8gTEeG3KCd2JQmQVnjdBpE=
X-Google-Smtp-Source: ADFU+vuvA9G9Mzw9D+dwlX93AP7zcnrABY3oCgOA0sXAqr3IsZ/b+/wj64/nixCwGiiRrOLixf9kiw==
X-Received: by 2002:a17:90b:238c:: with SMTP id mr12mr3164241pjb.161.1583760368597;
        Mon, 09 Mar 2020 06:26:08 -0700 (PDT)
Received: from Shreeya-Patel ([2405:204:2188:9cfe:18bc:a849:c699:3914])
        by smtp.googlemail.com with ESMTPSA id v133sm33700710pfc.68.2020.03.09.06.26.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 09 Mar 2020 06:26:07 -0700 (PDT)
Message-ID: <b2db452217ced8bbd6f85121bf4c8fef3881d6ba.camel@gmail.com>
Subject: Re: [Outreachy kernel] [PATCH] Staging: rtl8188eu: Add space around
 operators
From:   Shreeya Patel <shreeya.patel23498@gmail.com>
To:     Julia Lawall <julia.lawall@inria.fr>
Cc:     Joe Perches <joe@perches.com>,
        outreachy-kernel <outreachy-kernel@googlegroups.com>,
        gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, sbrivio@redhat.com,
        daniel.baluta@gmail.com, nramas@linux.microsoft.com,
        hverkuil@xs4all.nl, Larry.Finger@lwfinger.net
Date:   Mon, 09 Mar 2020 18:56:00 +0530
In-Reply-To: <alpine.DEB.2.21.2003090825280.2676@hadrien>
References: <20200308220004.9960-1-shreeya.patel23498@gmail.com>
          <f1327099b774e141bbeaa8abc47f98b9c6d49264.camel@perches.com>
         <af1a27fb8c5f7efbaf99ce3055cf3801b366d627.camel@gmail.com>
         <alpine.DEB.2.21.2003090825280.2676@hadrien>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2020-03-09 at 08:35 +0100, Julia Lawall wrote:
> On Mon, 9 Mar 2020, Shreeya Patel wrote:
> 
> > On Sun, 2020-03-08 at 16:05 -0700, Joe Perches wrote:
> > > On Mon, 2020-03-09 at 03:30 +0530, Shreeya Patel wrote:
> > > > Add space around operators for improving the code
> > > > readability.
> > > 
> > > Hello again Shreeya.
> > > 
> > 
> > I have some questions here...
> > 
> > > The subject isn't really quite appropriate as you
> > > are not doing this space around operator addition
> > > for the entire subsystem.
> > > 
> > > IMO, the subject should be:
> > > 
> > > [PATCH] staging: rtl8188eu: rtw_mlme: Add spaces around operators
> > > 
> > > because you are only performing this change on this
> > > single file.
> > > 
> > > If you were to do this for every single file in the
> > > subsystem, you could have many individual patches with
> > > the exact same subject line.
> > > 
> > > And it would be good to show in the changelog that you
> > > have compiled the file pre and post patch without object
> > > code change.
> > > 
> > 
> > I'm not sure how to show this. Do you mean to add the output of
> > "make drivers/staging/rtl8188eu/core" before and after the changes?
> 
> You are working on one specific file, maybe foo.c.  Compile before
> making changes, which will give you foo.o.  Rename that file to
> something
> else.  Make your changes and compile again.  Do a diff with the
> previously
> compiled file.  It should produce nothing, indicating no difference.
> 
> If this .o file doesn't change and you only changed this .c file, the
> whole compiled driver won't change either.
> 

ok, got it.

> > I also don't understand the meaning of no object code change. If we
> > are
> > making the changes to code and then compiling it using the make
> > command
> > then a new file with .o extension is created and replaced by the
> > previous one isn't it?
> > 
> > > Also, it's good to show that git diff -w shows no source
> > > file changes.
> > > 
> > 
> > And this has to be...
> > git diff -w --shortstat drivers/staging/rtl8188eu/core/
> 
> --shortstat does not seem useful.  What you hope to see is that it
> produces nothing.
> 
Okay.
I will send a V2 with all the changes required.

Btw Joe, I am working against staging-testing tree

> julia
> 
> > Am I correct?
> > 
> > Thanks
> > 
> > > > Reported by checkpatch.pl
> > > > 
> > > > Signed-off-by: Shreeya Patel <shreeya.patel23498@gmail.com>
> > > > ---
> > > >  drivers/staging/rtl8188eu/core/rtw_mlme.c | 40 +++++++++++--
> > > > ----
> > > > ------
> > > >  1 file changed, 20 insertions(+), 20 deletions(-)
> > > 
> > > When I try this using checkpatch --fix-inplace, I get
> > > 21 changes against the latest -next tree.
> > > 
> > > What tree are you doing this against?
> > > 
> > > 
> > 
> > --
> > You received this message because you are subscribed to the Google
> > Groups "outreachy-kernel" group.
> > To unsubscribe from this group and stop receiving emails from it,
> > send an email to outreachy-kernel+unsubscribe@googlegroups.com.
> > To view this discussion on the web visit 
> > https://groups.google.com/d/msgid/outreachy-kernel/af1a27fb8c5f7efbaf99ce3055cf3801b366d627.camel%40gmail.com
> > .
> > 

