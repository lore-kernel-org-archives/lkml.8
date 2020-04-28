Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B98DAC83000
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 18:28:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 932F920730
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 18:28:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="n29TFIPK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729129AbgD1S2F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 14:28:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729093AbgD1S1z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 14:27:55 -0400
Received: from mail-oo1-xc44.google.com (mail-oo1-xc44.google.com [IPv6:2607:f8b0:4864:20::c44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07A96C03C1AB
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 11:27:55 -0700 (PDT)
Received: by mail-oo1-xc44.google.com with SMTP id e18so4908275oot.9
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 11:27:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fDqv3R9cE9Y5n/V2wUs8Y32OjnZ/aKdvT0h6Lgiz/HY=;
        b=n29TFIPK+JhYt+TPWIz1/KhNtyqQ7L5/rZxHlp7HpJQZGYlLqpRpOnGf0iPajeKYqy
         tVZ/Q1POb6DEHqWsQqdi0tdxUTcZmLPkq+2U719TbJyj7uhKm3s6pa4/PpHxbuNbZjIS
         u2bscJLu51H71kntdVPEglWvHDfWfZPCmXlfELFR5SmVifInYuOSjWZ85cNSH7HgX98W
         AIgMewWq5YPwtUbDb7IkeoQs9aZl8IA1uhdC/s883fjhxDd59Tg6eZRNMP8JY4mZbLxg
         FsWihl7ryjCoMDcaqpobRT8Y1RY81wCK0sevyUkOByuVkjCit5Zy75qq7mNpCPSErd2Q
         Wn2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fDqv3R9cE9Y5n/V2wUs8Y32OjnZ/aKdvT0h6Lgiz/HY=;
        b=FZZHSiUMvWhyytf9fkClQcUE0y4GX0mCNJdcMro1OWLrxfy8c6A/bUGcAoaYZ11Z0d
         rcmF3qPFhzIyGXbavV/REdDdg1prf7EII2Ev4bgGLDr9LIuBPUREyiqg8PP0Qh238PgV
         9zIM3GmeehCgUcqjLq8CxtyUrlN+GxmrYyL/4YA2Andhz/Gqxk3wfiHg8UEEQjYcNhcC
         9T/nHq2fEfV9pf4t/ky7rxdEld6QZz7HuPbtcBToKq/wxdqFf0esLhoZrSsHY8alSO0W
         kb4SH+hfzNDnRHOgKqngeb8Q+R6bty1CkGyRvyZJvQjmMORNIO+Uhv3fYf+utjqgpHrf
         Uziw==
X-Gm-Message-State: AGi0PuaHZYhlt0dl7KJOBU8ymPYMKae7VMV86+SG1U8R22PWMacD6Z0m
        VvwwJHiWf4uJtk7AWth19y//Xi0dH39j1MFhxTHbLw==
X-Google-Smtp-Source: APiQypIjxc9zzxbXdsZPSPNo55/H/IOTaFV2ac11jvrMkl9FRsIxseYy/mB4h80YD9VH1Suqm/zPue0vPRtWPx1jeVA=
X-Received: by 2002:a4a:615d:: with SMTP id u29mr24640962ooe.15.1588098474005;
 Tue, 28 Apr 2020 11:27:54 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20200331022842eucas1p29e52dc93c4bd0b6e470c41aef19c9a86@eucas1p2.samsung.com>
 <20200331022832.209618-1-saravanak@google.com> <781eefdc-c926-7566-5305-bb9633e6fac0@samsung.com>
 <CAGETcx8aW-EY+bGEPr+20bZUF-=ghZDPyQ8AdU7eYYd-wOvekA@mail.gmail.com>
 <20200331072910.GC854501@kroah.com> <CAGETcx9r_t0AWVaTt5hk9s6Tti0UcNAersjXCJ_A04yJKNPtDA@mail.gmail.com>
 <20200428155222.GA1584194@kroah.com>
In-Reply-To: <20200428155222.GA1584194@kroah.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Tue, 28 Apr 2020 11:27:18 -0700
Message-ID: <CAGETcx8nbz-J1gLvoEKE_HgCcVGyV2o8rZeq_USFKM6=s7WmNg@mail.gmail.com>
Subject: Re: [PATCH v1] driver core: Fix handling of fw_devlink=permissive
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Android Kernel Team <kernel-team@android.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 28, 2020 at 8:52 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Thu, Apr 16, 2020 at 11:25:47AM -0700, Saravana Kannan wrote:
> > On Tue, Mar 31, 2020 at 12:29 AM Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> > >
> > > On Mon, Mar 30, 2020 at 11:18:01PM -0700, Saravana Kannan wrote:
> > > > On Mon, Mar 30, 2020 at 10:43 PM Marek Szyprowski
> > > > <m.szyprowski@samsung.com> wrote:
> > > > >
> > > > > Hi,
> > > > >
> > > > > On 2020-03-31 04:28, Saravana Kannan wrote:
> > > > > > When commit 8375e74f2bca ("driver core: Add fw_devlink kernel
> > > > > > commandline option") added fw_devlink, it didn't implement "permissive"
> > > > > > mode correctly.
> > > > > >
> > > > > > That commit got the device links flags correct to make sure unprobed
> > > > > > suppliers don't block the probing of a consumer. However, if a consumer
> > > > > > is waiting for mandatory suppliers to register, that could still block a
> > > > > > consumer from probing.
> > > > > >
> > > > > > This commit fixes that by making sure in permissive mode, all suppliers
> > > > > > to a consumer are treated as a optional suppliers. So, even if a
> > > > > > consumer is waiting for suppliers to register and link itself (using the
> > > > > > DL_FLAG_SYNC_STATE_ONLY flag) to the supplier, the consumer is never
> > > > > > blocked from probing.
> > > > > >
> > > > > > Fixes: 8375e74f2bca ("driver core: Add fw_devlink kernel commandline option")
> > > > > > Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
> > > > > > Signed-off-by: Saravana Kannan <saravanak@google.com>
> > > > > > ---
> > > > > > Hi Marek,
> > > > > >
> > > > > > If you pull in this patch and then add back in my patch that created the
> > > > > > boot problem for you, can you see if that fixes the boot issue for you?
> > > > >
> > > > > Indeed, this fixes booting on my Raspberry Pi3/4 boards with linux
> > > > > next-20200327. Thanks! :)
> > > >
> > > > Hi Marek,
> > > >
> > > > Thanks for testing, but I'm not able to find the tag next-20200327. I
> > > > can only find next-20200326 and next-20200330. I was just trying to
> > > > make sure that next-20200327 doesn't have the revert Greg did. I'm
> > > > guessing you meant next-20200326?
> > > >
> > > > > Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
> > > >
> > > > Thanks!
> > > >
> > > > Greg,
> > > >
> > > > Can you pull in my fix and then revert the revert?
> > >
> > > After 5.7-rc1 is out I will, thanks.
> >
> > Hi Greg,
> >
> > Just to clarify, this patch is a bug fix and I think this patch should
> > go into all the stable branches that support fw_devlink.
> >
> > The only risky change that you needed to wait on for 5.7-rc1 is the
> > patch [1] that sets fw_devlink=permissive by default. Well, a revert
> > of the revert of [1].
> >
> > [1] - https://lore.kernel.org/lkml/20200321210305.28937-1-saravanak@google.com/
>
> I don't understand, what kernels should this go back to?  Your "Fixes:"
> line just shows for a 5.7-rc1 patch, nothing older.

That's all. I was just stating the obvious I guess -- to pull this
into all the releases that have the "Fixes" commit. Btw you had
reverted the "Fixes" commit. So you'll have to revert the revert and
then apply this patch. Hope that makes sense.

-Saravana
