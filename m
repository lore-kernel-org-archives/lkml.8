Return-Path: <SRS0=ixK5=7Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF672C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 14:14:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B49012081A
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 14:14:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591971255;
	bh=IH7UdieyZGW+usBOFPflBBSMx20SRJo9dTNX6/VChDM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=gyIKOscrfspH3lh8Xuj4nmRe7dPboFjPDURjTmPkL8uvE2w1C5RYjcX05rjpNFz3G
	 A6022uJGPPlKGVWa4DV4zCBe4lfbI1VycalgwiOPhJfa2g3hczlRJ3YUO1fwV9I1zG
	 x9ju62C/jJ9MGRRBU5W6IUcRuIyp1SSlAkZ4FKfk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726380AbgFLOOO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jun 2020 10:14:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:38086 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726089AbgFLOON (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 10:14:13 -0400
Received: from pali.im (pali.im [31.31.79.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E9B3820801;
        Fri, 12 Jun 2020 14:14:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591971253;
        bh=IH7UdieyZGW+usBOFPflBBSMx20SRJo9dTNX6/VChDM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2USNl1oN/1eKZ/q/kPTl7OW+JYbuUNuAmIJU6OyHczHEdA2qMOEVHz6qulCCfqPDy
         vYEvzvWF3rEH51dKCiLmtxVUQp/brFaGD+PSrsHhzm1Iw66Olc879rl7TIOVbYGfSC
         OlFWdHc72rbO04sSr6JtabUbkbAOGGKvK+1D4iI8=
Received: by pali.im (Postfix)
        id 2871C582; Fri, 12 Jun 2020 16:14:11 +0200 (CEST)
Date:   Fri, 12 Jun 2020 16:14:10 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Mario.Limonciello@dell.com
Cc:     rdunlap@infradead.org, y.linux@paritcher.com,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        mjg59@srcf.ucam.org
Subject: Re: [PATCH v2 3/3] platform/x86: dell-wmi: add new dmi keys to
 bios_to_linux_keycode
Message-ID: <20200612141410.7sp7brcmgcel3bfc@pali>
References: <cover.1591584631.git.y.linux@paritcher.com>
 <cover.1591656154.git.y.linux@paritcher.com>
 <d585d2a0f01a6b9480352530b571dec2d1afd79f.1591656154.git.y.linux@paritcher.com>
 <8053252a-83ad-bcaa-2830-ccfbca1b4152@infradead.org>
 <20200608235508.wthtgilgmifwfgz2@pali>
 <ced5832cfe984c68b27a577cac0f02f1@AUSX13MPC105.AMER.DELL.COM>
 <20200610094449.xltvs2y6kp7driyh@pali>
 <a7b5dd31dd32461aad51e08d38777edf@AUSX13MPC105.AMER.DELL.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a7b5dd31dd32461aad51e08d38777edf@AUSX13MPC105.AMER.DELL.COM>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 10 June 2020 12:35:09 Mario.Limonciello@dell.com wrote:
> > -----Original Message-----
> > From: platform-driver-x86-owner@vger.kernel.org <platform-driver-x86-
> > owner@vger.kernel.org> On Behalf Of Pali Rohár
> > Sent: Wednesday, June 10, 2020 4:45 AM
> > To: Limonciello, Mario
> > Cc: rdunlap@infradead.org; y.linux@paritcher.com; linux-
> > kernel@vger.kernel.org; platform-driver-x86@vger.kernel.org;
> > mjg59@srcf.ucam.org
> > Subject: Re: [PATCH v2 3/3] platform/x86: dell-wmi: add new dmi keys to
> > bios_to_linux_keycode
> > 
> > 
> > [EXTERNAL EMAIL]
> > 
> > On Tuesday 09 June 2020 19:49:18 Mario.Limonciello@dell.com wrote:
> > > >
> > > > Looking at the last two lines... and for me it looks like that 0x00FF
> > > > and 0xFFFF are just "placeholders" or special values for unknown /
> > > > custom / unsupported / reserved / special / ... codes.
> > > >
> > > > It is really suspicious why first 38 values are defined, then there is
> > > > gap, then one value 255 and then huge gap to 65535.
> > > >
> > > > Mario, this looks like some mapping table between internal Dell BIOS
> > key
> > > > code and standard Linux key code. Are you able to get access to some
> > > > documentation which contains explanation of those Dell key numbers?
> > > > It could really help us to understand these gaps and what is correct
> > > > interpretation of these numbers.
> > > >
> > >
> > > The codes are actually 4 bytes in the table, but in practice nothing
> > above the
> > > first two bytes is used.
> > >
> > > Those two called out are special though, here are their meanings:
> > >
> > > 0x00FF is user programmable function
> > > 0xFFFF is no function
> > >
> > > For the purpose of memory consumption I think it's reasonable to ignore
> > the
> > > upper 2 bytes and special case these two.
> > 
> > Thank you for information!
> > 
> > So 0x00FF is "user programmable" button. Do I understand it correctly
> > that Dell/BIOS does not explicitly provide meaning for these buttons,
> > they do not have fixed functionality and therefore user should configure
> > them as he want?
> 
> Correct
> 
> > 
> > And what does mean "no function"? I do not know what should I imagine if
> > I receive key press marked as "no function".
> 
> It means no action is expected to occur, should behave like a no-op.  I think
> discarding it makes fine sense.

Thank you! This was missing bit of information.

Just I'm curious, why firmware sends "no-op" event which we could ignore? :D

I can imagine that those events / scan codes may contain some
information which we can use...

> > 
> > > > E.g. I remember that pressing Fn+Q or Fn+W on some Dell Latitude
> > > > generates code 255, which could prove my thesis about "special codes"
> > > > (which are probably not found in e.g. Windows or Linux mapping tables).
> > > >
> > > > > >  };
> > > > > >
> > > > > >  /*
> > > > > > @@ -503,10 +504,7 @@ static void handle_dmi_entry(const struct
> > > > dmi_header *dm, void *opaque)
> > > > > >  					&table->keymap[i];
> > > > > >
> > > > > >  		/* Uninitialized entries are 0 aka KEY_RESERVED. */
> > > > > > -		u16 keycode = (bios_entry->keycode <
> > > > > > -			       ARRAY_SIZE(bios_to_linux_keycode)) ?
> > > > > > -			bios_to_linux_keycode[bios_entry->keycode] :
> > > > > > -			KEY_RESERVED;
> > > > > > +		u16 keycode = bios_to_linux_keycode[bios_entry->keycode];
> > > > > >
> > > > > >  		/*
> > > > > >  		 * Log if we find an entry in the DMI table that we don't
> > > > > >
> > > > >
> > > > > Something like:
> > > > >
> > > > > 		u16 keycode;
> > > > >
> > > > > 		keycode = bios_entry->keycode == 0xffff ? KEY_UNKNOWN :
> > > > > 			(bios_entry->keycode <
> > > > > 			       ARRAY_SIZE(bios_to_linux_keycode)) ?
> > > > > 			bios_to_linux_keycode[bios_entry->keycode] :
> > > > > 			KEY_RESERVED;
> > > > >
> > > > >
> > > > >
> > > > > Also please fix this:
> > > > > (no To-header on input) <>
> > > >
> > > > Hint: specifying git send-email with '--to' argument instead of '--cc'
> > > > should help.
> > > >
> > > > >
> > > > > --
> > > > > ~Randy
> > > > >
