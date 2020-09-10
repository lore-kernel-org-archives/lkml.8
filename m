Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F941C433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 09:55:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0BC8D2074B
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 09:55:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lZlEh1YT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730722AbgIJJz1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 05:55:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730614AbgIJJwf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 05:52:35 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01C5EC0613ED;
        Thu, 10 Sep 2020 02:52:29 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id a17so5984683wrn.6;
        Thu, 10 Sep 2020 02:52:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Z/WTs995/g3fO5m+3L9KWIUC7hDRFeEbybv1OaWWyOU=;
        b=lZlEh1YT/Cfp8r4di9/VEB3246er7r5xQMXktyh37taS6m5s5B72Lj5KkSsVYHPNon
         TwD8lJMkjUtfJ44gJqsDaIJtlgNFRf9L1s+6Ojuh6sRWBU5Q5wabnD9YkF+x43bp7Foi
         wdJ8P0jJkmBVptrObhPux79NBWgN784MamLPN+TibtZUk0rCYv8q/OqTDjgh1MxpdnAc
         TMn7e7dcD1pC/gecR6b8lQqgYzWWp+97UdnRvJZcsTDO4NHTlAym+Srb2DeXDs/iepvV
         XrOf/Jq3Co4+bbbXzEPksjC4BkvkOBVPyqZXYn1hiyqaWXN0SLCaV5hsonH3205SCoMy
         b5Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Z/WTs995/g3fO5m+3L9KWIUC7hDRFeEbybv1OaWWyOU=;
        b=T9UmGePC7OvIpk34sKx0a7QHV5EEAFZ+LcbEaEc+shEv2TBz3Jpa306IDqZhEN0tFL
         0yk0eXVkN+1iU01xvc0q/RrOL5QkkVMq+ZL08ZWJuy8gsWreFFrOrKOxFw0zYA9+io3x
         DXRLDQLMG8fcUVVxtnGPkS3Avffh1vgLoUfxxu7LrOiO2jK0BT5+mdiaZKKz4BMn8dyI
         GdwO0QC7BzP7cwKlyNWcafKiEOCKkYAPLEM8Mz3wXneqbXMhvYwSGBGbRlyYttgP7+1q
         zhmqHl3sFNVqRlycFMYo1G18Hs9Ks2IioXjntJF0eJIOT15G+9sOXF9SCp058BWMbSiA
         4pLQ==
X-Gm-Message-State: AOAM533dljpLCb+nIv6ByfKnRcD8Ym2OjLz8zQ0hE8ESbXR6xod7unc6
        qzLPrKeEtYQyydfCTwdjNA2d8HuBzM9o64SmpK31HFHCk34=
X-Google-Smtp-Source: ABdhPJzUAsuoGgsg9RnTinHKhMf6Y6PfM/S+uk4RhnbtEu7LCKeSy6EM7Hpo+zRXj8QMEvZuzT7yDU3lU2IOMaYEkdU=
X-Received: by 2002:a05:6000:11cd:: with SMTP id i13mr7900215wrx.140.1599731547579;
 Thu, 10 Sep 2020 02:52:27 -0700 (PDT)
MIME-Version: 1.0
References: <20200909193419.2006744-1-james.hilliard1@gmail.com>
 <1599706954.10822.3.camel@suse.de> <a1161f77-5b37-39ea-eb91-7b0b59278960@gmail.com>
 <20200910080850.GD24441@localhost> <CADvTj4rDdj8KtLhGZEZP+XZcF4DTE4oW9sNf=zNWaRPzkny93A@mail.gmail.com>
 <20200910085541.GA1099591@kroah.com>
In-Reply-To: <20200910085541.GA1099591@kroah.com>
From:   James Hilliard <james.hilliard1@gmail.com>
Date:   Thu, 10 Sep 2020 03:52:14 -0600
Message-ID: <CADvTj4pYR9H1X1_f4DYTkb5ViXAdx9sO5yBgHgM5vFaDMs_miQ@mail.gmail.com>
Subject: Re: [PATCH v2] usb: serial: Repair FTDI FT232R bricked eeprom
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Johan Hovold <johan@kernel.org>, Lars Melin <larsm17@gmail.com>,
        Oliver Neukum <oneukum@suse.de>, linux-usb@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Russ Dill <Russ.Dill@gmail.com>,
        Hector Martin <hector@marcansoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 10, 2020 at 2:55 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Thu, Sep 10, 2020 at 02:17:44AM -0600, James Hilliard wrote:
> > On Thu, Sep 10, 2020 at 2:08 AM Johan Hovold <johan@kernel.org> wrote:
> > >
> > > On Thu, Sep 10, 2020 at 12:33:55PM +0700, Lars Melin wrote:
> > > > On 9/10/2020 10:02, Oliver Neukum wrote:
> > > > > Am Mittwoch, den 09.09.2020, 13:34 -0600 schrieb James Hilliard:
> > > > >> This patch detects and reverses the effects of the malicious FTDI
> > > > >> Windows driver version 2.12.00(FTDIgate).
> > > > >
> > > > > Hi,
> > > > >
> > > > > this raises questions.
> > > > > Should we do this unconditionally without asking?
> > > > > Does this belong into kernel space?
> > > > >
> > > >
> > > > My answer to both of those question is a strong NO.
> > > >
> > > > The patch author tries to justify the patch with egoistical arguments
> > > > (easier for him and his customers) without thinking of all other users
> > > > of memory constrained embedded hardware that doesn't need the patch code
> > > > but have to carry it.
> > > >
> > > > The bricked PID is btw already supported by the linux ftdi driver so
> > > > there is no functionality gain in the patch.
> > >
> > > I fully agree. This doesn't belong in the kernel. If the Windows driver
> > > breaks someones device on purpose they should know about it, and *if*
> > > they want they can reprogram the device using the tools mentioned in the
> > > thread. But the kernel shouldn't be playing such games and reprogram
> > > eeproms behind people's backs.
> > One of the main issues is that this issue is very often not-obvious, FTDI
> > specifically designed their malicious driver to make it appear that the
> > hardware failed, they intentionally do not provide proper feedback to
> > the user when they soft-brick it. I assume this is because they want
> > to push the support costs related to their malicious driver onto the
> > integrator rather than themselves.
>
> That's fine, but why is it the Linux kernel's job to fix up this mess?
Well the kernel seems to be the place a fix would be most effective.
Not like it's unusual for the kernel to work around hardware issues in
general. :P
>
> There is already a userspace tool that can be run to resolve this for
> devices that wish to have this fixed up for.  Use that.  We want to keep
> things that can be done in userspace, in userspace, whenever possible.
So I'm having trouble coming up with a reliable way to fix this in userspace,
I've already got quite a few moving parts there as is and most of what I
come up with seems like it would not work reliably, at least for automatically
repairing the eeprom.
>
> And again, Linux runs just fine with these devices so why is it Linux's
>
> I'm with Johan here, reprogramming eeproms when people least expect it
> is not nice, and in a way, is much the same thing that the Windows
> drivers are doing.
Yeah, it does seem a bit sketchy at first, I went with this approach mostly
since I couldn't think of a practical scenario where fixing it automatically
would be a real issue, assuming we can reliably detect the preimage
attack.

So maybe identify the preimage attack and log a message instead? From
my understanding false positives should be nearly impossible with the
signature identification technique I'm using.

Maybe we could expose an interface that triggers the eeprom repair,
one which doesn't require userspace to implement low level USB handling?
>
> thanks,
>
> greg k-h
