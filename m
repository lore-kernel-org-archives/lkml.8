Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 595E2C433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 22:31:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 06C59208CA
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 22:31:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cavoj.net header.i=@cavoj.net header.b="f9Zjpi4+";
	dkim=pass (1024-bit key) header.d=cavoj.net header.i=@cavoj.net header.b="f9Zjpi4+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725771AbgIJWbg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 18:31:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725300AbgIJWbe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 18:31:34 -0400
Received: from mail.sammserver.com (sammserver.com [IPv6:2001:470:5a5b:1::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9F38C061573;
        Thu, 10 Sep 2020 15:31:33 -0700 (PDT)
Received: by mail.sammserver.com (Postfix, from userid 5011)
        id 6999C10301A5; Fri, 11 Sep 2020 00:31:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cavoj.net; s=email;
        t=1599777090; bh=mi+BeHMXG5WEOu1gJhnZU78E72welfdyaQTB7APYDag=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=f9Zjpi4+2Wx4rxodNEWGjydP/e1D8T0Li2gEkFdp3MZ91nAOwxX5HblsaqIDxvd+R
         bXDbd90WiTcALhIgxAPrxtvj7denbs3hAlA8MQrR8j3Sz4xaEWi7vjycewfjXxEU9z
         luAqBD4pTzPB7jl3UnWLyeUydtBUqVo8XrjrBxnE=
Received: from fastboi.localdomain (fastboi.wg [10.32.40.5])
        by mail.sammserver.com (Postfix) with ESMTP id DD1BB10301A2;
        Fri, 11 Sep 2020 00:31:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cavoj.net; s=email;
        t=1599777090; bh=mi+BeHMXG5WEOu1gJhnZU78E72welfdyaQTB7APYDag=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=f9Zjpi4+2Wx4rxodNEWGjydP/e1D8T0Li2gEkFdp3MZ91nAOwxX5HblsaqIDxvd+R
         bXDbd90WiTcALhIgxAPrxtvj7denbs3hAlA8MQrR8j3Sz4xaEWi7vjycewfjXxEU9z
         luAqBD4pTzPB7jl3UnWLyeUydtBUqVo8XrjrBxnE=
Received: by fastboi.localdomain (Postfix, from userid 1000)
        id C56D1142049F; Fri, 11 Sep 2020 00:31:29 +0200 (CEST)
Date:   Fri, 11 Sep 2020 00:31:29 +0200
From:   Samuel =?utf-8?B?xIxhdm9q?= <samuel@cavoj.net>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Corentin Chary <corentin.chary@gmail.com>,
        acpi4asus-user@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: platform/x86: asus-wmi: SW_TABLET_MODE is always 1 on some
 devices
Message-ID: <20200910223129.epmeyvodj6agnzav@fastboi.localdomain>
References: <20200901215536.qcouepovmfxje4n5@fastboi.localdomain>
 <0f7302c9-b508-a078-8c62-5ad5a03d92c2@redhat.com>
 <20200902125220.25x52dl2vupejg5f@fastboi.localdomain>
 <20200904094546.jes44d2kn5mtn2zu@fastboi.localdomain>
 <320c0b71-af94-c673-21c8-c32a0fdb4d4e@redhat.com>
 <20200904171743.ejew22p3zzada55p@fastboi.localdomain>
 <a21a6fbf-f38b-3531-07f4-74edd0e42eb6@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a21a6fbf-f38b-3531-07f4-74edd0e42eb6@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On 10.09.2020 19:44, Hans de Goede wrote:
> Hi,
> 
> On 9/4/20 7:17 PM, Samuel Čavoj wrote:
> > Hi,
> > 
> > On 04.09.2020 12:06, Hans de Goede wrote:
> > > Hi,
> > > 
> > > On 9/4/20 11:45 AM, Samuel Čavoj wrote:
> > > > Hello!
> > > > 
> > > > On 02.09.2020 14:52, Samuel Čavoj wrote:
> > > > > Hello,
> > > > > 
> > > > > On 02.09.2020 13:52, Hans de Goede wrote:
> > > > > > But I would rather try to figure out a better way. Can you
> > > > > > create an acpidump, by as root running:
> > > > > > 
> > > > > > acpidump -o acpidump.asus-UX360CA
> > > > > 
> > > > > The file is attached gzipped.
> > > > > 
> > > > > > 
> > > > > > And then send me a direct (so without including the list)
> > > > > > email with the generated acpidump.asus-UX360CA file attached please?
> > > > > > 
> > > > > > Also, if necessary are you capable of building your own
> > > > > > kernel with a (test)patch applied ?
> > > > > 
> > > > > Yes, that is no problem at all.
> > > > > Thank you for your quick response.
> > > > > 
> > > > > Regards,
> > > > > Samuel
> > > > 
> > > > I don't mean to waste your time, it's just that my trust in mail systems
> > > > has been steadily decreasing. I would just like to make sure you have
> > > > received my previous email with the acpidump.
> > > > 
> > > > In case not, here[1] it is available over https, if the message got
> > > > dropped because of the attachment.
> > > 
> > > I got your mail, but I've been burried under a ton of work,
> > > so it may take a couple of days at least before I can take
> > > a closer look at this.
> > 
> > That's quite alright.
> > 
> > I decided I would try and see if I can be of any use, so I looked around
> > in the WMI implementation in the DSDT and found the following in the
> > DSTS method:
> > 
> > [...]
> > 37486     If ((IIA0 == 0x00120063))
> > 37487     {
> > 37488         Local0 = ^^PCI0.LPCB.EC0.DKPS ()
> > 37489         If ((Local0 == One))
> > 37490         {
> > 37491             Return (0x00010001)
> > 37492         }
> > 37493         Else
> > 37494         {
> > 37495             Return (0x00010000)
> > 37496         }
> > 37497     }
> > [...]
> > 
> > This is the If statement responsible for the ASUS_WMI_DEVID_KBD_DOCK
> > device, and it always seems to return 0x00010000 on my machine. I
> > followed it up the call chain but in the end it just read some bit from
> > some register of the EC.
> > 
> > Then I noticed the If statement right above it, which corresponds to
> > dev_id 0x00060062:
> > 
> > [...]
> > 37472     If ((IIA0 == 0x00060062))
> > 37473     {
> > 37474         If (^^PCI0.LPCB.EC0.RPIN (0x15))
> > 37475         {
> > 37476             Local0 = 0x00010001
> > 37477         }
> > 37478         Else
> > 37479         {
> > 37480             Local0 = 0x00010000
> > 37481         }
> > 37482
> > 37483         Return (Local0)
> > 37484     }
> > [...]
> > 
> > By a stroke of luck, it turns out it's the correct one! I patched the
> > driver to query the state on every event and print it out, and it is
> > exactly what we are looking for.
> > 
> > The state is 0 if the device is in normal, laptop state and changes to 1
> > if flipped over 180 degrees. I patched the module so that the
> > SW_TABLET_MODE switch was set according to it, and everything seems to
> > be behaving as it should.
> 
> Good work on figuring this out!

I'm glad to have learned something new. ACPI was mostly a magic black
box for me up to now.

> 
> > This is, of course, not a full solution, as we
> > still somehow need to decide whether to use the KDB_DOCK device or this
> > one. I don't know what to do about that. Ideally find some flag in the
> > ACPI which says which one we should use?
> > 
> > The event code which is fired when the lid switch state changes, as we
> > already know from the sparse keymap[1], is 0xfa. When the laptop is
> > suspended in laptop mode, flipped to tablet mode in its sleep and
> > awoken, the event is fired. It is, however, not fired when doing it the
> > other way around, so we should probably check the state on resume as
> > well.
> 
> Ok, I've written a patch to try and use the 0x00060062 WMI object/devid
> first and only if that is not there use the 0x00120063 one which the
> Bay Trail and Cherry Trail devices use.

Yeah, that's the solution I had in mind as well and should hopefully be
fine. Until ASUS ships a device with yet another weird firmware quirk,
anyway.

> 
> I've attached the patch, please give it a try.

I've tested the patch on the laptop applied on top of 5.8.8 and it works
as it should!

The patch itself looks good to me, but I have one tiny nitpick: A typo
in my name on line 15. I feel bad for even mentioning that though.

I'm glad we are able to resolve the issue so quickly. I was going to say
that the report on bugzilla should be addressed also, but I see you have
already done that. Thank you for kindly your work.

Regards,
Samuel
