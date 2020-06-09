Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54C34C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 08:27:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 28D0B2074B
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 08:27:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591691256;
	bh=PMImXP1lwxmzTgkVhCHPvWpsWK8qCUVg8/8Nia95PaM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=X/6FAe2bFqfi1YjHLYozylzgu3kVashDGX51ooaYSZlvTM3Ww7lwDX3KCKHc5AUMX
	 wM2rDMuMali5dixQ8caEN4HWQAm8i4PvUy1fvYZTbgjXgkqbCuaTFXE1aNqO9FGt0O
	 Rnv7gGQ2nqZ2KkUTv1tW0dk5HtPYxG280bQq+U/8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728095AbgFII1e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 04:27:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:57450 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727960AbgFII1d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 04:27:33 -0400
Received: from pali.im (pali.im [31.31.79.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7AA752074B;
        Tue,  9 Jun 2020 08:27:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591691252;
        bh=PMImXP1lwxmzTgkVhCHPvWpsWK8qCUVg8/8Nia95PaM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kG/HLr3YA65ZVPcJtjG53D98p1xJGII6M8DipkLEQ1jqg+5h0EzopWVUcIPTLE3VS
         24zz/DFYgME7eehXtewoqnQ2BZuvgyi++B9vYS106ZWUmdH3FoRPwJyAuKgX0vp+wY
         jdp2RR1FFF2Oir3ubWDH1FrI65VKgPmxVEfuIKG0=
Received: by pali.im (Postfix)
        id 8EAE8884; Tue,  9 Jun 2020 10:27:30 +0200 (CEST)
Date:   Tue, 9 Jun 2020 10:27:30 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Mario.Limonciello@dell.com
Cc:     y.linux@paritcher.com, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, mjg59@srcf.ucam.org
Subject: Re: [PATCH 3/3] platform/x86: dell-wmi: add keys to
 bios_to_linux_keycode
Message-ID: <20200609082730.ncs3lbdtzfxb4fma@pali>
References: <cover.1591584631.git.y.linux@paritcher.com>
 <13951508596a3f654c6d47f5380ddb4f38e2f6b5.1591584631.git.y.linux@paritcher.com>
 <20200608090017.4qgtbosz7oullex2@pali>
 <8baab72e3d2e407792c3ffa1d9fffba8@AUSX13MPC105.AMER.DELL.COM>
 <20200608204826.kb7x5mh6hzj2hxcz@pali>
 <f7ab352f27954bbb88bafb41d6b17fe1@AUSX13MPC105.AMER.DELL.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f7ab352f27954bbb88bafb41d6b17fe1@AUSX13MPC105.AMER.DELL.COM>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 08 June 2020 20:58:38 Mario.Limonciello@dell.com wrote:
> > -----Original Message-----
> > From: platform-driver-x86-owner@vger.kernel.org <platform-driver-x86-
> > owner@vger.kernel.org> On Behalf Of Pali Rohár
> > Sent: Monday, June 8, 2020 3:48 PM
> > To: Limonciello, Mario
> > Cc: y.linux@paritcher.com; linux-kernel@vger.kernel.org; platform-driver-
> > x86@vger.kernel.org; mjg59@srcf.ucam.org
> > Subject: Re: [PATCH 3/3] platform/x86: dell-wmi: add keys to
> > bios_to_linux_keycode
> > 
> > 
> > [EXTERNAL EMAIL]
> > 
> > On Monday 08 June 2020 15:46:44 Mario.Limonciello@dell.com wrote:
> > > I would actually question if there is value to lines in dell-wmi.c like
> > this:
> > >
> > > pr_info("Unknown WMI event type 0x%x\n", (int)buffer_entry[1]);
> > >
> > > and
> > >
> > > pr_info("Unknown key with type 0x%04x and code 0x%04x pressed\n", type,
> > code);
> > >
> > > In both of those cases the information doesn't actually help the user, by
> > default it's
> > > ignored by the driver anyway.  It just notifies the user it's something
> > the driver doesn't
> > > comprehend.  I would think these are better suited to downgrade to debug.
> > And if
> > > a key combination isn't doing something expected the user can use dyndbg
> > to turn it
> > > back on and can be debugged what should be populated or "explicitly"
> > ignored.
> > 
> > My motivation for these messages was to provide information to user that
> > kernel received event, but was not able to process it as it do not
> > understand it.
> > 
> > It could help in situation when user press special key and nothing is
> > delivered to userspace. But he could see that something happened in log.
> > 
> 
> But does a user know what to do with this information?  From time to time
> coming to kernel mailing list, but that's it.

That is a good question. I'm really not sure if user can do anything
with it. But also users do not care about these kind of logs. So
probably even do not know about them.

What is nice in this solution that if you want to try "debug" such
problem you just need to ask user for logs. Nothing is needed to enabled
/ disable.

> I think same person who would know to come to kernel mailing list for a key
> not working can likely also hand turning on dyndbg to get the info.

You are probably right.

In past I did one thing thanks to these logs. I searched for these log
messages on interned. More results were on forum discussions. I tried to
contact users of those posts and I think 3-4 people wrote me back with
details which allowed me to extend dell-wmi driver to handle additional
key codes.

So I see two benefits from these logs: 1) no special setup is needed to
gather these logs (useful for non-power users) and 2) ability to search
on internet if we have laptops which generates such unknown key codes
and users are "complaining" or posting their logs for investigation on
places where are no kernel developers available.

So question is if these two points are reason why to stick with these
logs or turn them off by default.

I still think it can be useful.

> > Similar message is also printed by PS/2 keyboard driver atkbd.c:
> > 
> > 	case ATKBD_KEY_UNKNOWN:
> > 		dev_warn(&serio->dev,
> > 			 "Unknown key %s (%s set %d, code %#x on %s).\n",
> > 			 atkbd->release ? "released" : "pressed",
> > 			 atkbd->translated ? "translated" : "raw",
> > 			 atkbd->set, code, serio->phys);
> > 		dev_warn(&serio->dev,
> > 			 "Use 'setkeycodes %s%02x <keycode>' to make it known.\n",
> > 			 code & 0x80 ? "e0" : "", code & 0x7f);
> > 		input_sync(dev);
> > 		break;
> 
> I think the difference here is that user can actually do something from userland
> to do with `setkeycodes` for PS2.

Of course, I agree.
