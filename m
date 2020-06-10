Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5D81C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 09:44:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F2E720734
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 09:44:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591782295;
	bh=DgudfPLHTEc2MSMs9eqwrbJDZp0N3Dn6kSW0M4scuuc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=I9vVVIfHkCfotHDEU1RplrmLghNlgHMAsZibG/NccAU8GPSPkOva76F4ivOCma4c0
	 8ygD49j/7sSjlIzWfqXGMjHf0RjMy1izT3n/tulxShzzOw7sRWlE5xCt5xgIkEncnU
	 mFZlwaTbte70oTnWchLhvSKCavDXSNUu/WfJSDa0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727937AbgFJJox (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 05:44:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:52296 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727909AbgFJJox (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 05:44:53 -0400
Received: from pali.im (pali.im [31.31.79.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E83A4204EC;
        Wed, 10 Jun 2020 09:44:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591782292;
        bh=DgudfPLHTEc2MSMs9eqwrbJDZp0N3Dn6kSW0M4scuuc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Lc1DJuxGI8LC89mVZ+B0YN7qhmzSzTNXQ1M6TpLam6lLlNl0cEN4Gv+A80PnpxC7g
         U6l2PH1G5ZzOWIfiqS/tRYkH4doqZqjdgXpX6v/ry3mpHdbsFZ/O7Fz4xZ+qDne8jf
         1ROAbNHyOBBVV38IyMOhFFP8Sn7QUzUeiUdHhXGE=
Received: by pali.im (Postfix)
        id 184B1810; Wed, 10 Jun 2020 11:44:50 +0200 (CEST)
Date:   Wed, 10 Jun 2020 11:44:49 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Mario.Limonciello@dell.com
Cc:     rdunlap@infradead.org, y.linux@paritcher.com,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        mjg59@srcf.ucam.org
Subject: Re: [PATCH v2 3/3] platform/x86: dell-wmi: add new dmi keys to
 bios_to_linux_keycode
Message-ID: <20200610094449.xltvs2y6kp7driyh@pali>
References: <cover.1591584631.git.y.linux@paritcher.com>
 <cover.1591656154.git.y.linux@paritcher.com>
 <d585d2a0f01a6b9480352530b571dec2d1afd79f.1591656154.git.y.linux@paritcher.com>
 <8053252a-83ad-bcaa-2830-ccfbca1b4152@infradead.org>
 <20200608235508.wthtgilgmifwfgz2@pali>
 <ced5832cfe984c68b27a577cac0f02f1@AUSX13MPC105.AMER.DELL.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ced5832cfe984c68b27a577cac0f02f1@AUSX13MPC105.AMER.DELL.COM>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 09 June 2020 19:49:18 Mario.Limonciello@dell.com wrote:
> > 
> > Looking at the last two lines... and for me it looks like that 0x00FF
> > and 0xFFFF are just "placeholders" or special values for unknown /
> > custom / unsupported / reserved / special / ... codes.
> > 
> > It is really suspicious why first 38 values are defined, then there is
> > gap, then one value 255 and then huge gap to 65535.
> > 
> > Mario, this looks like some mapping table between internal Dell BIOS key
> > code and standard Linux key code. Are you able to get access to some
> > documentation which contains explanation of those Dell key numbers?
> > It could really help us to understand these gaps and what is correct
> > interpretation of these numbers.
> > 
> 
> The codes are actually 4 bytes in the table, but in practice nothing above the
> first two bytes is used.
> 
> Those two called out are special though, here are their meanings:
> 
> 0x00FF is user programmable function
> 0xFFFF is no function
> 
> For the purpose of memory consumption I think it's reasonable to ignore the
> upper 2 bytes and special case these two.

Thank you for information!

So 0x00FF is "user programmable" button. Do I understand it correctly
that Dell/BIOS does not explicitly provide meaning for these buttons,
they do not have fixed functionality and therefore user should configure
them as he want?

And what does mean "no function"? I do not know what should I imagine if
I receive key press marked as "no function".

> > E.g. I remember that pressing Fn+Q or Fn+W on some Dell Latitude
> > generates code 255, which could prove my thesis about "special codes"
> > (which are probably not found in e.g. Windows or Linux mapping tables).
> > 
> > > >  };
> > > >
> > > >  /*
> > > > @@ -503,10 +504,7 @@ static void handle_dmi_entry(const struct
> > dmi_header *dm, void *opaque)
> > > >  					&table->keymap[i];
> > > >
> > > >  		/* Uninitialized entries are 0 aka KEY_RESERVED. */
> > > > -		u16 keycode = (bios_entry->keycode <
> > > > -			       ARRAY_SIZE(bios_to_linux_keycode)) ?
> > > > -			bios_to_linux_keycode[bios_entry->keycode] :
> > > > -			KEY_RESERVED;
> > > > +		u16 keycode = bios_to_linux_keycode[bios_entry->keycode];
> > > >
> > > >  		/*
> > > >  		 * Log if we find an entry in the DMI table that we don't
> > > >
> > >
> > > Something like:
> > >
> > > 		u16 keycode;
> > >
> > > 		keycode = bios_entry->keycode == 0xffff ? KEY_UNKNOWN :
> > > 			(bios_entry->keycode <
> > > 			       ARRAY_SIZE(bios_to_linux_keycode)) ?
> > > 			bios_to_linux_keycode[bios_entry->keycode] :
> > > 			KEY_RESERVED;
> > >
> > >
> > >
> > > Also please fix this:
> > > (no To-header on input) <>
> > 
> > Hint: specifying git send-email with '--to' argument instead of '--cc'
> > should help.
> > 
> > >
> > > --
> > > ~Randy
> > >
