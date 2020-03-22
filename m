Return-Path: <SRS0=o5Nk=5H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39D2BC54EEB
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Mar 2020 23:18:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FD1720735
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Mar 2020 23:18:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HIp+rh9W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726936AbgCVXSR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Mar 2020 19:18:17 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:43385 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726814AbgCVXSR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Mar 2020 19:18:17 -0400
Received: by mail-pl1-f194.google.com with SMTP id v23so1035300ply.10
        for <linux-kernel@vger.kernel.org>; Sun, 22 Mar 2020 16:18:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sAqNs7cLCNrJManKOoO5nJSc+vgXtk4yt3qmrV/VGSA=;
        b=HIp+rh9WJhP9XJ05dPnVLE6lGZZVOrktfOxFWCcQc6e+ITUiDnTHi7eVBHR+gqTpz1
         9E3jTzzgeo75fyj4YLXAKf43uYVdNqGlHsRWqpJqRGfJjb40PH/6cTyUF1nW7q9dF7Lh
         mVN1aweTD8A8eZagP0n40qUi52I+bbuwsKLRGB4QuwuqJfu4A+NVxrIEp779rGyrp9b8
         PHpzicfdVQHDOMxdmM/HPNdMb6K17ElTO2yxT1XFbYh1OMpDgaHtPnMpWthE4gQ2Jvct
         4j85JZzluxPclQWmXmX0txu07361+pzqsbxmdf1w+Gt2KhoOYFOd4fOWiau20nAZxlaK
         vEcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sAqNs7cLCNrJManKOoO5nJSc+vgXtk4yt3qmrV/VGSA=;
        b=glL4MFAmiKBnbrUd/NzugtefBPKbGvlwDsl2Lw14dk2XUCpI+8q0iNZWOLd0HwWYzC
         cIHku7xpVxXCuCp/TRgtjDMUlfTE5aIufG34X9X3+lLFyQdoQr8lgP2oQ8yyVwvQvFS5
         lHe+JdVY1NoALZi67P5miQM0Z2Rrq00barbN/hYjOEIwY7m4ict+B1qX5Pzxt7jY9U6M
         iSFduLVwba8qRKfBESSEa81a5IOWMOsrqDGZ+K6N+n74BWXJCs+KMcWW/Z6pfAhoMhc6
         yEUSWTXGFBtqnBPM5jjX4SdyW58ep0xTCmI2zcRY2YmvwwsJn+6Uekqi24/nyybN4qXC
         OJyQ==
X-Gm-Message-State: ANhLgQ16kNKSwndO0B0O/Zsmy4W0CUYESoNqHL7Ok+BqmPq/Dzl+hKdt
        NJ1xdKR4buDrbhQxxT2NHWA=
X-Google-Smtp-Source: ADFU+vvdLVqHMNFGHPUVUc1e14qG8smozDKMLnqvr/DxMD5yvtO27wPyexteJOp/73/BvjTEUcO7VA==
X-Received: by 2002:a17:902:694c:: with SMTP id k12mr18968806plt.173.1584919094450;
        Sun, 22 Mar 2020 16:18:14 -0700 (PDT)
Received: from Shreeya-Patel ([113.193.34.113])
        by smtp.googlemail.com with ESMTPSA id z12sm12403521pfj.144.2020.03.22.16.18.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 22 Mar 2020 16:18:13 -0700 (PDT)
Message-ID: <f2b4f7f38a8a490ffc917f7199099ac95656c8c2.camel@gmail.com>
Subject: Re: [Outreachy kernel] [PATCH 01/11] Staging: rtl8188eu: hal_com:
 Add space around operators
From:   Shreeya Patel <shreeya.patel23498@gmail.com>
To:     Joe Perches <joe@perches.com>, Greg KH <gregkh@linuxfoundation.org>
Cc:     Larry.Finger@lwfinger.net, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, outreachy-kernel@googlegroups.com
Date:   Mon, 23 Mar 2020 04:48:08 +0530
In-Reply-To: <e40d49aaa96a61019804255c2990d229b2eef7dc.camel@perches.com>
References: <cover.1584826154.git.shreeya.patel23498@gmail.com>
         <19950c71482b3be0dd9518398af85e964f3b66b1.1584826154.git.shreeya.patel23498@gmail.com>
         <20200322112744.GC75383@kroah.com>
         <e40d49aaa96a61019804255c2990d229b2eef7dc.camel@perches.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2020-03-22 at 08:09 -0700, Joe Perches wrote:
> On Sun, 2020-03-22 at 12:27 +0100, Greg KH wrote:

Hi Greg and Joe,

> > On Sun, Mar 22, 2020 at 03:51:13AM +0530, Shreeya Patel wrote:
> > > Add space around operators for improving the code
> > > readability.
> > > Reported by checkpatch.pl
> > > 
> > > git diff -w shows no difference.
> > > diff of the .o files before and after the changes shows no
> > > difference.
> > 
> > There is no need to have these two lines on every changelog comment
> > in
> > this series :(
> 
Yes I get that.

> In my opinion, there's no need for a series here.
> 
> Whitespace only changes _should_ be done all at once.
> 
> Whitespace changes _could_ have changed string constants.
> 
> So noting that the patch in only whitespace and that
> there isn't a difference in object files is useful as
> it shows any change has been compiled and tested.
> 

Joe, I feel the same thing, there is no need of a patch series
for it but I was given a suggestion that it becomes difficult for the
reviewers to review the patch so it is good to send a patchset instead.

But as you said, we are testing that there is no change in the object
file so we can go ahead with a single patch for all the whitespace
changes.

If you feel this is right then can I go ahead and send a single patch
for it? ( need your or Greg's confirmation before I do it )

Thanks

> 

