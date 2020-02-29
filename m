Return-Path: <SRS0=iO2y=4R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65957C3F2D3
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Feb 2020 15:48:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C2292469C
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Feb 2020 15:48:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uRWN+s3l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727229AbgB2Psn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Feb 2020 10:48:43 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:34977 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727170AbgB2Psm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Feb 2020 10:48:42 -0500
Received: by mail-ot1-f68.google.com with SMTP id r16so5549659otd.2;
        Sat, 29 Feb 2020 07:48:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0LnoqPNiVrVWIzM0qc+C8NSFCH3fjCc6Ip8H3uzdRjc=;
        b=uRWN+s3lnC8mvap1pnVxrPVHRrBViwj98MVPC+EpUcNZmjCorLmzo0vtPCd6xVRLLr
         e+Bn8pb16wEJxdmc8084PVbtEo/6CPMJswcykKhDfeY4eI25wpMYgvYYDvcayBmR+G4b
         1jeutUQvPsyvIVgjXiVIiViZmvi2yFAg3SZt37aBkUUbdHpvpMDlLWDKkaJ7B9Oustyr
         Lk4jsTWsA0ZJZzdMtvd+sr5tYX/6AOORje0GyNapLB1Qcf41xoCQI7oOZ6d03ERrCE2x
         VHNgpohCRi4nvVyYkEPCRRy8M5X3g1GRz/qOQsZxGQMi3FeBUhJQC9gfGbrOPWSwEdvu
         2xxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0LnoqPNiVrVWIzM0qc+C8NSFCH3fjCc6Ip8H3uzdRjc=;
        b=sOYoeCfezVmhlZy5S/J4gzT1N60ZvF+jFXYk9NpceOpTDXNK5tbBA4fuiGAhLMWo9x
         dVBpI09b8nr+qkLNWbI76gkZrBn/OpK8PDR7hpv2hV9yoo96/3BToFRgPSEPzLFoTol+
         yt9wFR9E2xrtuQng3dSSymtM8Imoyge7G9aZ41hKUn12hJA6dcAnQToVHYRdWaPx8Oq9
         eAn5oeEK5H5Qfs4+M1ElKUql3IBhvImvD+Ja8FnQe/yKelbHNfm20bSMZlIUOTgK7WTZ
         v5J4enZsBJzKQmJ/YWsQrG6nfaXep/PMLZblrFUXek5tWNuuw0OD6oCR4ZgkTtPPs07r
         rCOA==
X-Gm-Message-State: APjAAAWAE2sQsFdBECV0yVYxyg9JF8t+XoFNfXEcNPWbXKmMsbwAD9RW
        dhkDr+A0K98EIVsUnuiYpc7hePlnImY=
X-Google-Smtp-Source: APXvYqznx4lMyeqJ9EkKf+z3GdQ7TAGSjbclkRH6ecBnD+7p4xk2SOjhpTNGWo1XKQaTP9CAse6RHw==
X-Received: by 2002:a9d:7617:: with SMTP id k23mr6830091otl.329.1582991321933;
        Sat, 29 Feb 2020 07:48:41 -0800 (PST)
Received: from grant-ubuntu (99-189-78-97.lightspeed.austtx.sbcglobal.net. [99.189.78.97])
        by smtp.gmail.com with ESMTPSA id t22sm4442881otq.18.2020.02.29.07.48.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 29 Feb 2020 07:48:41 -0800 (PST)
Date:   Sat, 29 Feb 2020 09:48:39 -0600
From:   Grant Peltier <grantpeltier93@gmail.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        openbmc@lists.ozlabs.org, adam.vaughn.xh@renesas.com,
        zaitsev@google.com
Subject: Re: [PATCH] hwmon: (pmbus) Add support for 2nd Gen Renesas digital
 multiphase
Message-ID: <20200229154839.GA8048@grant-ubuntu>
References: <20200228212349.GA1929@raspberrypi>
 <20200228225848.GA14676@roeck-us.net>
 <20200228235206.GA3468@raspberrypi>
 <1a456016-682a-2d53-767b-fe09784883ef@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1a456016-682a-2d53-767b-fe09784883ef@roeck-us.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 28, 2020 at 05:55:44PM -0800, Guenter Roeck wrote:
> On 2/28/20 3:52 PM, Grant Peltier wrote:
> > Hi Guenter,
> > 
> > Thank you for your expedient review. I will need to consult with my
> > coworkers to determine a more appropriate driver name. In the meantime I
> > will make the desired changes and I will also create a document for the
> > driver, which I will submit as a linked but separate patch.
> > 
> > With regard to the part numbers, this family of parts is currently in
> > the process of being released and we have not yet published all of the
> > corresponding datasheets. However, I have been assured that all of the
> > parts listed are slated to have a datasheet published publicly in the near
> > future.
> > 
> That would be great.
> 
> As for the driver name, I had a look into drivers/hwmon/pmbus/isl68137.c,
> and I don't immediately see why the new chips would warrant a new driver.
> The only differences seem to be that VMON is a new command, and of course
> only the ISL68137 supports AVL. But then there is, for example, ISL68127,
> which is again quite similar. The only other difference as far as I can
> see is input voltage scaling, but that doesn't warrant a separate driver
> (and, of course, I have no means to validate if input voltage scaling
> is indeed different for all the new chips).
> 
> Overall I would suggest to extend the isl68137 driver. I would also
> suggest to not add separate tables for each of the rail configurations
> but use the three-phase entry as starting point, copy it, and adjust its
> values as needed.
> 
> For the multi-phase chips, I question if reporting the input voltage
> for each phase make sense. Is it really a different voltage ? For IIN
> and PIN, the question is if the registers are indeed paged, since they
> are not paged in the older chips.
> 
> Guenter

The ISL68137 is part of the first generation of our digital multiphase
parts which are all exclusively 2-rail (2-page) devices. There are a
couple of reasons that we are opting for a new driver for the new
generation of devices:

1) Gen 2 has multiple rail configurations (1, 2, or 3) with different scaling
parameters than Gen 1
2) We are planning to support some of the non-generic PMBus functions of
the Gen 2 devices using the debugfs interface.

I am currently working on point 2 and those features are not
quite ready to be included in a patch set but we wanted to move forward
with the hwmon functionality for now as that is useful on it's own.

Fair point on the global vs paged commands. I will modify the page
functions so that global commands are only read from page 0.

Thank you,
Grant
