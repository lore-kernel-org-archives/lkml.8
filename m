Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43A99C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 21:39:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 12F772064C
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 21:39:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hl2mRBj5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728364AbgGNVj4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 17:39:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726722AbgGNVjz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 17:39:55 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C1E8C061755
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 14:39:55 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id f7so318188wrw.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 14:39:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=cmHcwmTccT13ZJXcb7SBLzTw/UgSDiTbBWL8nKbEfh8=;
        b=hl2mRBj5TXYfXXlig2eChw0XasjMiOrb9AtRFxZdbPyHE59r5Wap6WzQTySOdEQUJI
         tgFQc7fupgoqDrRc4Wn0CrupPbdEojws4yyp8xGLozYqdZ+6dSzfYy9qzKGkM5FV2Oot
         JbUj+RtfHk/mhyglpCa+/0ezOc66UcAQVwVY/q5jd1U8RZZvcfbf5rWZ8jh+w0OB4ndd
         BOAIKcnWA4EHnVvIftC76Fk+nsHIzerjm0BABgGduehlIa3KOS9RIL5mJPZMwTxnzhFc
         6g0zZxbsTIbeQwd0MMdLVYaPZjRj2G5QXPIswenRv7L1YSXMhp26dAtHy6ZelPtw6+o6
         cbyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=cmHcwmTccT13ZJXcb7SBLzTw/UgSDiTbBWL8nKbEfh8=;
        b=Lgn080a89OSXFAuNTKlhzm/qL5vwmfpwcv3XZN1ZRz9lqMh6msKtdvBcbbdPjXtbAe
         jl6Xf8X0Q5TugjodL2ypxlwDXVx+dGzY0P8AIVwQA3rs9ACWoH2Nl2uU0s0RCkga8AWB
         B+2lh16B4Z+rgSA8zJFxlJvmTKDDsT7YMr6nQOxJDmb4y8L45+KcigiUmKHuZ9w3tAKs
         53OxYLXkndM1pCtalKcvXe5xZSy+L1FKwwfa4qxdHqkbNZ4DRMt/X/ZCcfAdxA+4Lbhj
         tjE7e3O7IzA9wDTMB8PZogGHEPFEwNN50AbP15YbS75L5S9wV9wmXIEeoV0qgDJHj7Ih
         99GQ==
X-Gm-Message-State: AOAM531Pc0F0PvWAMDSBTIJgA3ND7AdAkc+aU+cMr3rX4Xu/5RFmecZc
        UafO6ZqzpYBRkZwOG+v1cwqe7klYejOMVA==
X-Google-Smtp-Source: ABdhPJxIEccNsYzkB+5beVgvKTvwXqRGoyrdzYXHMD7gkZ4Eq4nfKYrUQld8CLXdiaS/LHOlv5+6SQ==
X-Received: by 2002:a5d:5388:: with SMTP id d8mr7829244wrv.35.1594762793831;
        Tue, 14 Jul 2020 14:39:53 -0700 (PDT)
Received: from dell ([2.31.163.61])
        by smtp.gmail.com with ESMTPSA id v18sm26479wrv.49.2020.07.14.14.39.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2020 14:39:53 -0700 (PDT)
Date:   Tue, 14 Jul 2020 22:39:51 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     James Bottomley <jejb@linux.ibm.com>
Cc:     Hannes Reinecke <hare@suse.de>, martin.petersen@oracle.com,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        Hannes Reinecke <hare@suse.com>
Subject: Re: [PATCH v2 24/24] scsi: aic7xxx: aic79xx_osm: Remove set but
 unused variabes 'saved_scsiid' and 'saved_modes'
Message-ID: <20200714213951.GL1398296@dell>
References: <20200713080001.128044-1-lee.jones@linaro.org>
 <20200713080001.128044-25-lee.jones@linaro.org>
 <559e47de-fa26-9ae5-a3c5-4adeae606309@suse.de>
 <1594741430.4545.15.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1594741430.4545.15.camel@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Jul 2020, James Bottomley wrote:

> On Tue, 2020-07-14 at 09:46 +0200, Hannes Reinecke wrote:
> > On 7/13/20 10:00 AM, Lee Jones wrote:
> > > Haven't been used since 2006.
> > > 
> > > Fixes the following W=1 kernel build warning(s):
> > > 
> > >  drivers/scsi/aic7xxx/aic79xx_osm.c: In function
> > > ‘ahd_linux_queue_abort_cmd’:
> > >  drivers/scsi/aic7xxx/aic79xx_osm.c:2155:17: warning: variable
> > > ‘saved_modes’ set but not used [-Wunused-but-set-variable]
> > >  drivers/scsi/aic7xxx/aic79xx_osm.c:2148:9: warning: variable
> > > ‘saved_scsiid’ set but not used [-Wunused-but-set-variable]
> > > 
> > > Cc: Hannes Reinecke <hare@suse.com>
> > > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > > ---
> > >  drivers/scsi/aic7xxx/aic79xx_osm.c | 4 ----
> > >  1 file changed, 4 deletions(-)
> > > 
> > > diff --git a/drivers/scsi/aic7xxx/aic79xx_osm.c
> > > b/drivers/scsi/aic7xxx/aic79xx_osm.c
> > > index 3782a20d58885..140c4e74ddd7e 100644
> > > --- a/drivers/scsi/aic7xxx/aic79xx_osm.c
> > > +++ b/drivers/scsi/aic7xxx/aic79xx_osm.c
> > > @@ -2141,14 +2141,12 @@ ahd_linux_queue_abort_cmd(struct scsi_cmnd
> > > *cmd)
> > >  	u_int  saved_scbptr;
> > >  	u_int  active_scbptr;
> > >  	u_int  last_phase;
> > > -	u_int  saved_scsiid;
> > >  	u_int  cdb_byte;
> > >  	int    retval;
> > >  	int    was_paused;
> > >  	int    paused;
> > >  	int    wait;
> > >  	int    disconnected;
> > > -	ahd_mode_state saved_modes;
> > >  	unsigned long flags;
> > >  
> > >  	pending_scb = NULL;
> > > @@ -2239,7 +2237,6 @@ ahd_linux_queue_abort_cmd(struct scsi_cmnd
> > > *cmd)
> > >  		goto done;
> > >  	}
> > >  
> > > -	saved_modes = ahd_save_modes(ahd);
> > >  	ahd_set_modes(ahd, AHD_MODE_SCSI, AHD_MODE_SCSI);
> > >  	last_phase = ahd_inb(ahd, LASTPHASE);
> > >  	saved_scbptr = ahd_get_scbptr(ahd);
> > > @@ -2257,7 +2254,6 @@ ahd_linux_queue_abort_cmd(struct scsi_cmnd
> > > *cmd)
> > >  	 * passed in command.  That command is currently active on
> > > the
> > >  	 * bus or is in the disconnected state.
> > >  	 */
> > > -	saved_scsiid = ahd_inb(ahd, SAVED_SCSIID);
> > >  	if (last_phase != P_BUSFREE
> > >  	    && SCB_GET_TAG(pending_scb) == active_scbptr) {
> > >  
> > > 
> > 
> > Reviewed-by: Hannes Reinecke <hare@suse.de>
> 
> Hey, you don't get to do that ... I asked you to figure out why we're
> missing an ahd_restore_modes().  Removing the ahd_save_modes() is
> cosmetic: it gets rid of a warning but doesn't fix the problem.  I'd
> rather keep the warning until the problem is fixed and the problem is
> we need a mode save/restore around the ahd_set_modes() which is only
> partially implemented in this function.

I had a look.  Traced it back to the dawn of time (time == Git), then
delved even further back by downloading and trawling through ~10-15
tarballs.  It looks as though drivers/scsi/aic7xxx/aic79xx_osm.c was
upstreamed in v2.5.60, nearly 20 years ago.  'saved_modes' has been
unused since at least then.  If no one has complained in 2 decades,
I'd say it probably isn't an issue worth perusing.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
