Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0725AC3B189
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 11:43:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE4D7218AC
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 11:43:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=interia.pl header.i=@interia.pl header.b="AAOrYEO6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729922AbgBMLn5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 06:43:57 -0500
Received: from smtpo.poczta.interia.pl ([217.74.65.152]:42729 "EHLO
        smtpo.poczta.interia.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729893AbgBMLn4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 06:43:56 -0500
X-Interia-R: Interia
X-Interia-R-IP: 185.15.80.246
X-Interia-R-Helo: <photon>
Received: from photon (185-15-80-246.ksi-system.net [185.15.80.246])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by poczta.interia.pl (INTERIA.PL) with ESMTPSA;
        Thu, 13 Feb 2020 12:43:53 +0100 (CET)
Date:   Thu, 13 Feb 2020 12:43:52 +0100
From:   Radoslaw Smigielski <radoslaw.smigielski@interia.pl>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     perex@perex.cz, tiwai@suse.com, corbet@lwn.net,
        radoslaw.smigielski@interia.pl, alsa-devel@alsa-project.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [alsa-devel] [PATCH] ALSA: doc: fix snd_hda_intel driver name
Message-ID: <20200213114352.GA742571@photon>
References: <20200213103636.733463-1-radoslaw.smigielski@interia.pl>
 <s5ha75mrbyb.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <s5ha75mrbyb.wl-tiwai@suse.de>
X-Interia-Antivirus: OK
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=interia.pl;
        s=biztos; t=1581594234;
        bh=HMNQ0ByYostuHLzXcVPMAhsXuFIIt6ZWJhldOgLujpY=;
        h=X-Interia-R:X-Interia-R-IP:X-Interia-R-Helo:Date:From:To:Cc:
         Subject:Message-ID:References:MIME-Version:Content-Type:
         Content-Disposition:In-Reply-To:X-Interia-Antivirus;
        b=AAOrYEO6R7Hn9ML3o/K6XyBmIXIZI7Ly2yKJcfedYXDVziYuujxykWtv9BRGtr9C5
         FpUswTD3tiYlaFDm6ClLr1LdyoDBuO4MsLHVSIKFUOIPHZnk7JRj+ilaT4AFJIQG4S
         TN3GkfpEmECy9gZICuJW1Qopqb98wprYHPyLYjWY=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 13, 2020 at 11:58:04AM +0100, Takashi Iwai wrote:
> On Thu, 13 Feb 2020 11:36:37 +0100,
> Radoslaw Smigielski wrote:
> > 
> > Update driver name snd-hda-intel to proper, existing driver
> > name snd_hda_intel in Documentation/sound/hd-audio/notes.rst.
> 
> snd-hda-intel is correct from the module file name POV.
> Both are handled equivalently.
> 
> 
> thanks,
> 
> Takashi
> 

Takashi-san, I agree that the names with hyphens (snd-hda-intel)
are present in help sections of many options in sound/pci/hda/Kconfig.
But snd-hda-intel is confusing from end user point of view.
After reading notes.rst, end user is going to do someting like this:

    lsmod | grep snd-hda-intel

and this command gives false result.

Also this modprobe.conf file is not going to work but it's an existing
example in Documentation/sound/hd-audio/notes.rst:

> > -    options snd-hda-intel patch=on-board-patch,hdmi-patch


Cheers,
Radek
