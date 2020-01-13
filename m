Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97728C33CAA
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 09:07:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78159206D7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 09:07:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726523AbgAMJHI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 04:07:08 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:34540 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725939AbgAMJHI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 04:07:08 -0500
Received: from mail-oi1-f198.google.com ([209.85.167.198])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1iqvgf-0000ST-SZ
        for linux-kernel@vger.kernel.org; Mon, 13 Jan 2020 09:07:06 +0000
Received: by mail-oi1-f198.google.com with SMTP id a124so2875430oii.17
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jan 2020 01:07:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=y08y1Vf0ul0EzKQPAWCtvf/eaBmNdOl4Jj/XRj2SI+s=;
        b=THT5L1bhpEFWIYS3UyZ5JFPCiUIma0mJKU14dVCwOLQdiXYJmJxoEnW5253XhdyMfP
         W39S9unUb354C6xtR0iPsy5u9px9MGUny+9jYgWCUuDYR6JTHGg9oH7Kn/bo/tUScUB3
         MT6iDuXtmWY47p/x3F3V3RXE79xi8Qpo/1PmcvAvIq38z4ARCKH5SuJHq+WzY7X/q6cr
         VT8OL/AdfLux8GehmtqqZqSn3U34EM1aI7l4pIrCsPQDdRbaC9dkBrOnV1SWfUq9lPcE
         +HIJwswRABIfrJ+g5TYxxOro5Frm//xiHEAVtPeq0+qQH3o0SqEJi4rZJEDPb3Z652BS
         2QKA==
X-Gm-Message-State: APjAAAUV7yCnwfqOPu/1VxRuTmp1C3VIfX49jPZyW7t2NZ+UptmV3MHG
        z1pyxG1BiNrRfVoD/IoJ0t9ujwsEHZQviRQukJy8GotKNIVhvE4j/ScFA7ja9LGp8+i4B1SuFkl
        cack+OBilSriwXjPQdV/F51QVQBKOKMVwwx3F/Oho+ZK+A2At4U6QE0S2OQ==
X-Received: by 2002:a05:6830:2116:: with SMTP id i22mr12883838otc.0.1578906424885;
        Mon, 13 Jan 2020 01:07:04 -0800 (PST)
X-Google-Smtp-Source: APXvYqz1UBoFSpWRN87k5IpNKV/5s81VoSSDYKOfWs3DY7xagcs1yYHS47D0v7UYSuf8nrzns+dxZirJyN7rjK/r7b4=
X-Received: by 2002:a05:6830:2116:: with SMTP id i22mr12883821otc.0.1578906424631;
 Mon, 13 Jan 2020 01:07:04 -0800 (PST)
MIME-Version: 1.0
References: <20200103084008.3579-3-kai.heng.feng@canonical.com>
 <20200110080211.22626-1-kai.heng.feng@canonical.com> <20200111192353.GA435222@kroah.com>
In-Reply-To: <20200111192353.GA435222@kroah.com>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Mon, 13 Jan 2020 17:06:53 +0800
Message-ID: <CAAd53p6vGpv0L+XFa1raA2HzO+3LYvHwPW968CEuW8aDbNC7BQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] USB: Disable LPM on WD19's Realtek Hub
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Mathias Nyman <mathias.nyman@intel.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        AceLan Kao <acelan.kao@canonical.com>,
        USB list <linux-usb@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 12, 2020 at 4:01 AM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Fri, Jan 10, 2020 at 04:02:11PM +0800, Kai-Heng Feng wrote:
> > Realtek Hub (0bda:0x0487) used in Dell Dock WD19 sometimes drops off the
> > bus when bringing underlying ports from U3 to U0.
> >
> > Disabling LPM on the hub during setting link state is not enough, so
> > let's disable LPM completely for this hub.
> >
> > Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> > ---
> >  drivers/usb/core/quirks.c | 3 +++
> >  1 file changed, 3 insertions(+)
>
> What changed from v1?  Always put that below the --- line.
>
> Also I only see 1 patch here, what happened to the first two?

The first two are can be actually treat separately, since they are
more generic fixes for xHCI.

>
> Please resend the whole series, and properly document what went on, you
> know this...

I forgot that, will do in next version.

Kai-Heng

>
> thanks,
>
> greg k-h
