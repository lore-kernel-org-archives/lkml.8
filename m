Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3F10C2BB1D
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 19:27:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86F992072A
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 19:27:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ibtNEGxZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726310AbgDFT1m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 15:27:42 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:46436 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725957AbgDFT1m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 15:27:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586201260;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QwF4wq4AYvXRbfz5PvV0g0CmU7fPPunQdEwXYUcKME4=;
        b=ibtNEGxZeTG++hvl9c4NRAHu1DDWpAh+S3+miJDnzVsVNjzLRCyeF6MwpEZsUeTnJexq/B
        yqpGoZ9+8AERMVQb5DUy7kN5RJsLaupzDQrryGBuu2QtZww6WV62X0/bY+nUYirneytQXG
        lcSJEZrco3lFij4s1/Bh3JhpS+ygSgc=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-7-J62SIZiVMhGt-IC2FZZJIg-1; Mon, 06 Apr 2020 15:27:38 -0400
X-MC-Unique: J62SIZiVMhGt-IC2FZZJIg-1
Received: by mail-qv1-f71.google.com with SMTP id e9so843977qvr.9
        for <linux-kernel@vger.kernel.org>; Mon, 06 Apr 2020 12:27:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=QwF4wq4AYvXRbfz5PvV0g0CmU7fPPunQdEwXYUcKME4=;
        b=Ms+HBmLN08rPRRrhDkk19MOpq2XGlwyWSCbm2TAM4mmACg40XvPifZIgW9/BG3xLYp
         E58wVBCnD7ayiRjs84RH7GebIaIXAUhrIPBhrjVrGKGafFtwSUxd0lj+OJox9xQTxo0/
         hsI7qzQTkbjEB6Tk3fTmXt5YBkSJxqnLZ4UUQ2BAIklbEsMRp9lxzJTnMPkaHLNKtZ+7
         RT+i2Zuiw2I7APcXjrr0jymMiKfmQZ9v4ix9j99BB4cebEH93j4PAzaVJcvL0C2tU9Jz
         a1txpjLe2JLc2gU6vr4PDIFY00h8rSpAvIBvq89Pj7Fp/S9ydXRWtNUWtHCvM8rBRMP/
         MKLQ==
X-Gm-Message-State: AGi0PuY3qPwikHv46RQ+19fmanwtjwoRn7X0nPn6VYCQmxq5SnpgaZRg
        Gttc6eamL/FGPe+J+TIGCrIRtUl/fGKd+lYQ/GxYUWwdZyOjJgLAAdWrbuKMxWo0ara0UbPNMIt
        Vx6jJK3aLIkRKyUzbix8BKuwd
X-Received: by 2002:ac8:10f:: with SMTP id e15mr1115210qtg.355.1586201257855;
        Mon, 06 Apr 2020 12:27:37 -0700 (PDT)
X-Google-Smtp-Source: APiQypIcSVxln0+TxAGiz9pu5WgjVaSm1wM1cLgviUCkvqSS8unS4LyeOc9Fq545caCsXLfk1u4yAQ==
X-Received: by 2002:ac8:10f:: with SMTP id e15mr1115187qtg.355.1586201257610;
        Mon, 06 Apr 2020 12:27:37 -0700 (PDT)
Received: from Ruby.lyude.net (static-173-76-190-23.bstnma.ftas.verizon.net. [173.76.190.23])
        by smtp.gmail.com with ESMTPSA id g2sm2896284qtj.96.2020.04.06.12.27.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2020 12:27:36 -0700 (PDT)
Message-ID: <e6802716d4ddb18a43cedd2c8af4c96726f62719.camel@redhat.com>
Subject: Re: [PATCH 2/4] drm/dp_mst: Reformat drm_dp_check_act_status() a bit
From:   Lyude Paul <lyude@redhat.com>
To:     Sean Paul <sean@poorly.run>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        stable <stable@vger.kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Dave Airlie <airlied@redhat.com>,
        Todd Previte <tprevite@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
Date:   Mon, 06 Apr 2020 15:27:35 -0400
In-Reply-To: <CAMavQKL6G9QsUE7ZzGXNpjjEVdZGQZkbN3oke-M=Lz=pHOn70A@mail.gmail.com>
References: <20200403200757.886443-1-lyude@redhat.com>
         <20200403200757.886443-3-lyude@redhat.com>
         <CAMavQKL6G9QsUE7ZzGXNpjjEVdZGQZkbN3oke-M=Lz=pHOn70A@mail.gmail.com>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2020-04-06 at 15:23 -0400, Sean Paul wrote:
> On Fri, Apr 3, 2020 at 4:08 PM Lyude Paul <lyude@redhat.com> wrote:
> > Just add a bit more line wrapping, get rid of some extraneous
> > whitespace, remove an unneeded goto label, and move around some variable
> > declarations. No functional changes here.
> > 
> > Signed-off-by: Lyude Paul <lyude@redhat.com>
> > [this isn't a fix, but it's needed for the fix that comes after this]
> > Fixes: ad7f8a1f9ced ("drm/helper: add Displayport multi-stream helper
> > (v0.6)")
> > Cc: Sean Paul <sean@poorly.run>
> > Cc: <stable@vger.kernel.org> # v3.17+
> > ---
> >  drivers/gpu/drm/drm_dp_mst_topology.c | 22 ++++++++++------------
> >  1 file changed, 10 insertions(+), 12 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/drm_dp_mst_topology.c
> > b/drivers/gpu/drm/drm_dp_mst_topology.c
> > index 2b9ce965f044..7aaf184a2e5f 100644
> > --- a/drivers/gpu/drm/drm_dp_mst_topology.c
> > +++ b/drivers/gpu/drm/drm_dp_mst_topology.c
> > @@ -4473,33 +4473,31 @@ static int drm_dp_dpcd_write_payload(struct
> > drm_dp_mst_topology_mgr *mgr,
> >   */
> >  int drm_dp_check_act_status(struct drm_dp_mst_topology_mgr *mgr)
> >  {
> > +       int count = 0, ret;
> >         u8 status;
> > -       int ret;
> > -       int count = 0;
> > 
> >         do {
> > -               ret = drm_dp_dpcd_readb(mgr->aux,
> > DP_PAYLOAD_TABLE_UPDATE_STATUS, &status);
> > -
> > +               ret = drm_dp_dpcd_readb(mgr->aux,
> > +                                       DP_PAYLOAD_TABLE_UPDATE_STATUS,
> > +                                       &status);
> >                 if (ret < 0) {
> > -                       DRM_DEBUG_KMS("failed to read payload table status
> > %d\n", ret);
> > -                       goto fail;
> > +                       DRM_DEBUG_KMS("failed to read payload table status
> > %d\n",
> > +                                     ret);
> > +                       return ret;
> >                 }
> > 
> >                 if (status & DP_PAYLOAD_ACT_HANDLED)
> >                         break;
> >                 count++;
> >                 udelay(100);
> > -
> >         } while (count < 30);
> > 
> >         if (!(status & DP_PAYLOAD_ACT_HANDLED)) {
> > -               DRM_DEBUG_KMS("failed to get ACT bit %d after %d
> > retries\n", status, count);
> > -               ret = -EINVAL;
> > -               goto fail;
> > +               DRM_DEBUG_KMS("failed to get ACT bit %d after %d
> > retries\n",
> 
> Should we print status in base16 here?
> 
> Otherwise:
> 
> Reviewed-by: Sean Paul <sean@poorly.run>

Good point - I'll make sure to fix that before I push the series
> 
> > +                             status, count);
> > +               return -EINVAL;
> >         }
> >         return 0;
> > -fail:
> > -       return ret;
> >  }
> >  EXPORT_SYMBOL(drm_dp_check_act_status);
> > 
> > --
> > 2.25.1
> > 
-- 
Cheers,
	Lyude Paul (she/her)
	Associate Software Engineer at Red Hat

