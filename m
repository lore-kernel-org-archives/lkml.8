Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE929C11D30
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 16:53:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C522120836
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 16:53:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=es-iitr-ac-in.20150623.gappssmtp.com header.i=@es-iitr-ac-in.20150623.gappssmtp.com header.b="LZUPXNMG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727891AbgBXQxx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 11:53:53 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:43644 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727108AbgBXQxv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 11:53:51 -0500
Received: by mail-pg1-f196.google.com with SMTP id u12so5431981pgb.10
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2020 08:53:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=es-iitr-ac-in.20150623.gappssmtp.com; s=20150623;
        h=from:date:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=OdqiOQAOv7VgOZu/EsgkC0pt5i360/zcmmngPxMs3Jg=;
        b=LZUPXNMGsJpZL0Qbw/me2VA45AU1OO3KoHU/3b2IW07ItijSWVCB4TlUel8Abtn0Ul
         YQYNv2TRwTIP1eMTCk6eQ4QXMs7kR4LsZwpUrW0XcvZiW53m1xvt98LosglIn+u2vlo4
         8sbkz5ScLPLsqjhB1DvOZMtaY/jGeGW0ncJO0FiAlx4zjcvIJ9k1Apgj7iOR7dkToflE
         m443v/+a1XJZ7DH3RX3wD/GE61vcSBSRqU4W6RYIMxpT5HIw/Rrr863pSy14LWAWiYTc
         du8SwQekouTMNvivhKbLSydoxZmo7iJqHkOf+Vg4Zyq1gjzu+a3cVln9E/OwOW09/zbu
         r0yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=OdqiOQAOv7VgOZu/EsgkC0pt5i360/zcmmngPxMs3Jg=;
        b=pUiM2hEk6OjLxw2hHQZLcH9bPx8jI7w/cyofdQi/dbN/1lWUK5kUDhIucejmQhPD1h
         peFoXEXANvx+ctyd8i20RRQe9Jlzt6a/QuPPPPuWKk/WPXlpZBjgUK7IwACytDp9p6Qn
         f6h4+aphFDGeSG6JqI+XsffT+cemVXmaEfGnSkXLNxjN5dDStlsABN7yIHCzqNc6Ob1t
         629zphnk2llRP05v8DJ+4ViwFtwTLhfhgARXSSZptGH6llEJZOXBwOCaGt8UFtaMAqf0
         e1nat1KdELIB5UbvqM7+frtIcAVfxQ91sOSKFzw5oY5LmQB44u+xqGdk1hm/LNK5EIFm
         79PQ==
X-Gm-Message-State: APjAAAXCriOD2DNapCG69CGSuxxc1ZEh5LdIFMfiJA5w+HsO6vTSS7eD
        0kTcW7IpY80pzseH16jYKPwqtTmflZTJxcfx
X-Google-Smtp-Source: APXvYqwte7KiY9kZcStaLGSCoQ5/ZSfRN+riGxvxmR5ZQ3DOW0cOn3YPqDfoZI5CgkmaWnC9sIt7JA==
X-Received: by 2002:a63:3004:: with SMTP id w4mr54015697pgw.164.1582563231181;
        Mon, 24 Feb 2020 08:53:51 -0800 (PST)
Received: from kaaira-HP-Pavilion-Notebook ([103.37.201.170])
        by smtp.gmail.com with ESMTPSA id m12sm13189030pjf.25.2020.02.24.08.53.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 24 Feb 2020 08:53:50 -0800 (PST)
From:   Kaaira Gupta <kgupta@es.iitr.ac.in>
X-Google-Original-From: Kaaira Gupta <Kaairakgupta@es.iitr.ac.in>
Date:   Mon, 24 Feb 2020 22:23:44 +0530
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Vaibhav Agarwal <vaibhav.sr@gmail.com>,
        Mark Greer <mgreer@animalcreek.com>,
        Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        greybus-dev@lists.linaro.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [greybus-dev] [PATCH] staging: greybus: match parenthesis
 alignment
Message-ID: <20200224165344.GB7214@kaaira-HP-Pavilion-Notebook>
References: <20200219195651.GA485@kaaira-HP-Pavilion-Notebook>
 <20200224114929.GB4827@pendragon.ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200224114929.GB4827@pendragon.ideasonboard.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 24, 2020 at 01:49:29PM +0200, Laurent Pinchart wrote:
> Hi Kaaira,
> 
> Thank you for the patch.
> 
> On Thu, Feb 20, 2020 at 01:26:51AM +0530, Kaaira Gupta wrote:
> > Fix checkpatch.pl warning of alignment should match open parenthesis in
> > audio_codec.c
> > 
> > Signed-off-by: Kaaira Gupta <kgupta@es.iitr.ac.in>
> > ---
> >  drivers/staging/greybus/audio_codec.c | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/staging/greybus/audio_codec.c b/drivers/staging/greybus/audio_codec.c
> > index 08746c85dea6..d62f91f4e9a2 100644
> > --- a/drivers/staging/greybus/audio_codec.c
> > +++ b/drivers/staging/greybus/audio_codec.c
> > @@ -70,7 +70,7 @@ static int gbaudio_module_enable_tx(struct gbaudio_codec_info *codec,
> >  		i2s_port = 0;	/* fixed for now */
> >  		cportid = data->connection->hd_cport_id;
> >  		ret = gb_audio_apbridgea_register_cport(data->connection,
> > -						i2s_port, cportid,
> > +							i2s_port, cportid,
> >  						AUDIO_APBRIDGEA_DIRECTION_TX);
> 
> I'm curious to know why you think the line you changed deserves a
> modification, while the next one doesn't :-)

According to me, both the lines deserve a modification. But I did not do
that as changing the other line was throwing 'greater than 80
characters' warning and I wasn't sure if I should go ahead with the
changes anyhow.

> 
> >  		if (ret) {
> >  			dev_err_ratelimited(module->dev,
> > @@ -160,7 +160,7 @@ static int gbaudio_module_disable_tx(struct gbaudio_module_info *module, int id)
> >  		i2s_port = 0;	/* fixed for now */
> >  		cportid = data->connection->hd_cport_id;
> >  		ret = gb_audio_apbridgea_unregister_cport(data->connection,
> > -						i2s_port, cportid,
> > +							  i2s_port, cportid,
> >  						AUDIO_APBRIDGEA_DIRECTION_TX);
> >  		if (ret) {
> >  			dev_err_ratelimited(module->dev,
> > @@ -205,7 +205,7 @@ static int gbaudio_module_enable_rx(struct gbaudio_codec_info *codec,
> >  		i2s_port = 0;	/* fixed for now */
> >  		cportid = data->connection->hd_cport_id;
> >  		ret = gb_audio_apbridgea_register_cport(data->connection,
> > -						i2s_port, cportid,
> > +							i2s_port, cportid,
> >  						AUDIO_APBRIDGEA_DIRECTION_RX);
> >  		if (ret) {
> >  			dev_err_ratelimited(module->dev,
> > @@ -295,7 +295,7 @@ static int gbaudio_module_disable_rx(struct gbaudio_module_info *module, int id)
> >  		i2s_port = 0;	/* fixed for now */
> >  		cportid = data->connection->hd_cport_id;
> >  		ret = gb_audio_apbridgea_unregister_cport(data->connection,
> > -						i2s_port, cportid,
> > +							  i2s_port, cportid,
> >  						AUDIO_APBRIDGEA_DIRECTION_RX);
> >  		if (ret) {
> >  			dev_err_ratelimited(module->dev,
> 
> -- 
> Regards,
> 
> Laurent Pinchart
