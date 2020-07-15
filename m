Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 227D5C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 06:30:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F049020658
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 06:30:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="H/hExH6+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728688AbgGOGag (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 02:30:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725823AbgGOGag (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 02:30:36 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8AB7C061755
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 23:30:35 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id 17so4297648wmo.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 23:30:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=pW+E9VMEkuNif/eMT9oEhAwUc+yvfIgFOHLRgw3DUS0=;
        b=H/hExH6+GtecEFWkgKRt3cttKcMeGN+R1qPxATBZxISPIv0YJJi9Nkm8bJ8GpUZoUY
         mXXU2Ehufq79mAA16BrMohYpZh6uY6GK+8GNOOiGEDvt5ZNVf1IejWhl9o+F1MO1eInn
         gspsd8Rh9NU4PFHle6JgA0R9pJCeDIkbgcklf1E/xHNAALl6piz4dlXJ5G7Tb23nKCxB
         LFyRaTgmvC+Y8f0GG5mBLNGvX+wEF6GYF6I9RhuueG5Lv0mK0dqtV6Voko6dXJy/eYaN
         nxALTrtF+8txn82MO9uOGeM74sk2NoRe0giLr7hLwjuNdnOicadlz0dgAE0vWuSFQumP
         L1jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=pW+E9VMEkuNif/eMT9oEhAwUc+yvfIgFOHLRgw3DUS0=;
        b=kD1oMOz8rxC4E9A1C1dBhOvuGAU/bSggkUtTA0hKC1jQvv48i4zXqgGquvEg+xtQ2z
         +HAZ9fCOK5cYOo2fpNE+iR6t5PDiMvkCyucZG3yvas0272ZIKipPotCAZIj2lZT1Qc7T
         qIHvtg0a/toYNWajFjY5nkqfGnfU3dcaQmVFMJAWDET5hwkPkun2y5tR34XVoREOwZy0
         gFM5x20sGBYi51zMFHBrHWZ1mr+ueYcRR3Ma06jNnaQO8/diE5O7YQQzWbyDy8niCMhF
         ONllKsngtpuCf5b3Oqx0y119gfhNCBGQefaM1oGgnoB9EQK07DnasNrLQ75kIJCTHcUs
         OGxg==
X-Gm-Message-State: AOAM5313aNIxoUyD+KzeIatkjESK54qq6jLmu/J/UbH7KbRJ+WQTW1w9
        DDO7pj2VW1v9YgZ5sslzrtpeHg==
X-Google-Smtp-Source: ABdhPJwVXfUMJKYeBCAI/pLQG8nNOZJC9J50UYu2eXR+TuYeMCeXSgAx9qXKQhWnrNmmUUHQ5dvCcA==
X-Received: by 2002:a7b:ca4c:: with SMTP id m12mr7089891wml.33.1594794634586;
        Tue, 14 Jul 2020 23:30:34 -0700 (PDT)
Received: from dell ([2.31.163.61])
        by smtp.gmail.com with ESMTPSA id g3sm2119227wrb.59.2020.07.14.23.30.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2020 23:30:34 -0700 (PDT)
Date:   Wed, 15 Jul 2020 07:30:32 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Hannes Reinecke <hare@suse.de>
Cc:     James Bottomley <jejb@linux.ibm.com>, martin.petersen@oracle.com,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        Hannes Reinecke <hare@suse.com>
Subject: Re: [PATCH v2 24/24] scsi: aic7xxx: aic79xx_osm: Remove set but
 unused variabes 'saved_scsiid' and 'saved_modes'
Message-ID: <20200715063032.GN1398296@dell>
References: <20200713080001.128044-1-lee.jones@linaro.org>
 <20200713080001.128044-25-lee.jones@linaro.org>
 <559e47de-fa26-9ae5-a3c5-4adeae606309@suse.de>
 <1594741430.4545.15.camel@linux.ibm.com>
 <20200714213951.GL1398296@dell>
 <708d8fb0-512f-a1d3-79d2-50bccda0264c@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <708d8fb0-512f-a1d3-79d2-50bccda0264c@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Jul 2020, Hannes Reinecke wrote:

> On 7/14/20 11:39 PM, Lee Jones wrote:
> > On Tue, 14 Jul 2020, James Bottomley wrote:
> > 
> > > On Tue, 2020-07-14 at 09:46 +0200, Hannes Reinecke wrote:
> > > > On 7/13/20 10:00 AM, Lee Jones wrote:
> > > > > Haven't been used since 2006.
> > > > > 
> > > > > Fixes the following W=1 kernel build warning(s):
> > > > > 
> > > > >   drivers/scsi/aic7xxx/aic79xx_osm.c: In function
> > > > > ‘ahd_linux_queue_abort_cmd’:
> > > > >   drivers/scsi/aic7xxx/aic79xx_osm.c:2155:17: warning: variable
> > > > > ‘saved_modes’ set but not used [-Wunused-but-set-variable]
> > > > >   drivers/scsi/aic7xxx/aic79xx_osm.c:2148:9: warning: variable
> > > > > ‘saved_scsiid’ set but not used [-Wunused-but-set-variable]
> > > > > 
> > > > > Cc: Hannes Reinecke <hare@suse.com>
> > > > > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > > > > ---
> > > > >   drivers/scsi/aic7xxx/aic79xx_osm.c | 4 ----
> > > > >   1 file changed, 4 deletions(-)
> > > > > 
> > > > > diff --git a/drivers/scsi/aic7xxx/aic79xx_osm.c
> > > > > b/drivers/scsi/aic7xxx/aic79xx_osm.c
> > > > > index 3782a20d58885..140c4e74ddd7e 100644
> > > > > --- a/drivers/scsi/aic7xxx/aic79xx_osm.c
> > > > > +++ b/drivers/scsi/aic7xxx/aic79xx_osm.c
> > > > > @@ -2141,14 +2141,12 @@ ahd_linux_queue_abort_cmd(struct scsi_cmnd
> > > > > *cmd)
> > > > >   	u_int  saved_scbptr;
> > > > >   	u_int  active_scbptr;
> > > > >   	u_int  last_phase;
> > > > > -	u_int  saved_scsiid;
> > > > >   	u_int  cdb_byte;
> > > > >   	int    retval;
> > > > >   	int    was_paused;
> > > > >   	int    paused;
> > > > >   	int    wait;
> > > > >   	int    disconnected;
> > > > > -	ahd_mode_state saved_modes;
> > > > >   	unsigned long flags;
> > > > >   	pending_scb = NULL;
> > > > > @@ -2239,7 +2237,6 @@ ahd_linux_queue_abort_cmd(struct scsi_cmnd
> > > > > *cmd)
> > > > >   		goto done;
> > > > >   	}
> > > > > -	saved_modes = ahd_save_modes(ahd);
> > > > >   	ahd_set_modes(ahd, AHD_MODE_SCSI, AHD_MODE_SCSI);
> > > > >   	last_phase = ahd_inb(ahd, LASTPHASE);
> > > > >   	saved_scbptr = ahd_get_scbptr(ahd);
> > > > > @@ -2257,7 +2254,6 @@ ahd_linux_queue_abort_cmd(struct scsi_cmnd
> > > > > *cmd)
> > > > >   	 * passed in command.  That command is currently active on
> > > > > the
> > > > >   	 * bus or is in the disconnected state.
> > > > >   	 */
> > > > > -	saved_scsiid = ahd_inb(ahd, SAVED_SCSIID);
> > > > >   	if (last_phase != P_BUSFREE
> > > > >   	    && SCB_GET_TAG(pending_scb) == active_scbptr) {
> > > > > 
> > > > 
> > > > Reviewed-by: Hannes Reinecke <hare@suse.de>
> > > 
> > > Hey, you don't get to do that ... I asked you to figure out why we're
> > > missing an ahd_restore_modes().  Removing the ahd_save_modes() is
> > > cosmetic: it gets rid of a warning but doesn't fix the problem.  I'd
> > > rather keep the warning until the problem is fixed and the problem is
> > > we need a mode save/restore around the ahd_set_modes() which is only
> > > partially implemented in this function.
> > 
> > I had a look.  Traced it back to the dawn of time (time == Git), then
> > delved even further back by downloading and trawling through ~10-15
> > tarballs.  It looks as though drivers/scsi/aic7xxx/aic79xx_osm.c was
> > upstreamed in v2.5.60, nearly 20 years ago.  'saved_modes' has been
> > unused since at least then.  If no one has complained in 2 decades,
> > I'd say it probably isn't an issue worth perusing.
> > 
> That's not really the point; this function is the first stage of error
> recovery. And the only real way of exercising this is to inject a command
> timeout, which is nearly impossible without dedicated hardware.
> So this function will have a very limited exposure, but nevertheless a quite
> crucial function.
> Hence I'm not quite agree with your reasoning, and rather would have it
> fixed.

100% agree.

> But as we're having an alternative fix now, it might be best if you could
> drop it from your patchset and we'll fix it separately.

Sounds good.  Thanks.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
