Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33FB9C4332B
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 10:10:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05AE5206F8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 10:10:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JZP4wzo4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727865AbgCWKK4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 06:10:56 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:34948 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727806AbgCWKK4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 06:10:56 -0400
Received: by mail-pl1-f194.google.com with SMTP id g6so5741106plt.2
        for <linux-kernel@vger.kernel.org>; Mon, 23 Mar 2020 03:10:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KtTMpqs9OxKiRBs03AEs96J80S/zGsASR4PrhyjUT3A=;
        b=JZP4wzo4beoMLxJBVLD/QqEBPBZ9t86h31Hqm0XEpkowrEuxOcX8dj6NyNLj5Ftuiu
         tEhDThHONyVZlBcr0m5KZGtwpKfyKMt+G9GXRLkbWr1n2BHn98e7RlwoZcj8g2ZDMHtb
         Cii6j1xhq1kgahgrPUPDy86ZpkOZTeSDut3ZrZIYJuWJ6etSgrk5fMT6hqYVpHTGFPz5
         z4kmP6O5p7egkw535XP4FlNQxFzjt/xfmACvT3tKbR242P7RtbwtX/chbsn9TiYRUYYZ
         y9fEPjYiq0YoiZ9zFEOCsalnYHamo9RQYHSJ7ngv8Wlrn+/G2bhPbS/KJ5VgcjinZ9zV
         J9lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KtTMpqs9OxKiRBs03AEs96J80S/zGsASR4PrhyjUT3A=;
        b=nIBcXipJFEeqw7n+iq+LavuXFSD8wFUoD9lX4Qldy139taGWTx7Id62CzjOf3Q0Am3
         jXblmtD7CmSnzUL/E1fJfUiFrVbXi+TQP6NiwHPqQWfttAIPFl9UYyA2vqt25SbsEAhU
         Nad10TOWEiGHzNROa+RsXepdh9+TENLtBqc93p1AmdaXBn5HeOGcsKI8MVaCb1RjBYuB
         2dlubI/h+w9MkXPUvPtjjKjcPjRKUiln6FTn/GLXZGCF7Xqv7RwNGlhUkM/7wQ9cVejR
         ujeFBDTvGUDufwyVvIKXr1E6TJ0X/KPrUcKJS9pOPY/C+c1t0A9oeRnp/qenebLDeDXG
         2H9g==
X-Gm-Message-State: ANhLgQ1Ozr3RrLmBSasxhP4rV30uiPiEFYwfJVFzLfeX7j0hfLlNd6oo
        H9ixmN1IgR4z15lycTvME5I=
X-Google-Smtp-Source: ADFU+vuPoiqWwisjPAoCIttzhpLDzm2VizcxjgFE+lCnRbRoBCM28zxGYhryGBQ2V95/fyLzj9RtpA==
X-Received: by 2002:a17:90a:5d16:: with SMTP id s22mr18751427pji.184.1584958255380;
        Mon, 23 Mar 2020 03:10:55 -0700 (PDT)
Received: from Shreeya-Patel ([1.23.93.222])
        by smtp.googlemail.com with ESMTPSA id z16sm11851197pjt.40.2020.03.23.03.10.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 23 Mar 2020 03:10:54 -0700 (PDT)
Message-ID: <24a7d4a5b2595326f61082cbe5220ed73e9c27e9.camel@gmail.com>
Subject: Re: [Outreachy kernel] [PATCH 01/11] Staging: rtl8188eu: hal_com:
 Add space around operators
From:   Shreeya Patel <shreeya.patel23498@gmail.com>
To:     Stefano Brivio <sbrivio@redhat.com>
Cc:     Joe Perches <joe@perches.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Larry.Finger@lwfinger.net, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, outreachy-kernel@googlegroups.com
Date:   Mon, 23 Mar 2020 15:40:50 +0530
In-Reply-To: <20200323020425.62dbeebb@elisabeth>
References: <cover.1584826154.git.shreeya.patel23498@gmail.com>
         <19950c71482b3be0dd9518398af85e964f3b66b1.1584826154.git.shreeya.patel23498@gmail.com>
         <20200322112744.GC75383@kroah.com>
         <e40d49aaa96a61019804255c2990d229b2eef7dc.camel@perches.com>
         <f2b4f7f38a8a490ffc917f7199099ac95656c8c2.camel@gmail.com>
         <20200323020425.62dbeebb@elisabeth>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2020-03-23 at 02:04 +0100, Stefano Brivio wrote:
> Hi Shreeya,
> 
> On Mon, 23 Mar 2020 04:48:08 +0530
> Shreeya Patel <shreeya.patel23498@gmail.com> wrote:
> 
> > On Sun, 2020-03-22 at 08:09 -0700, Joe Perches wrote:
> > > On Sun, 2020-03-22 at 12:27 +0100, Greg KH wrote:  
> > 
> > Hi Greg and Joe,
> > 
> > > > On Sun, Mar 22, 2020 at 03:51:13AM +0530, Shreeya Patel
> > > > wrote:  
> > > > > Add space around operators for improving the code
> > > > > readability.
> > > > > Reported by checkpatch.pl
> > > > > 
> > > > > git diff -w shows no difference.
> > > > > diff of the .o files before and after the changes shows no
> > > > > difference.  
> > > > 
> > > > There is no need to have these two lines on every changelog
> > > > comment
> > > > in
> > > > this series :(  
> > > 
> > >   
> > 
> > Yes I get that.
> > 
> > > In my opinion, there's no need for a series here.
> > > 
> > > Whitespace only changes _should_ be done all at once.
> > > 
> > > Whitespace changes _could_ have changed string constants.
> > > 
> > > So noting that the patch in only whitespace and that
> > > there isn't a difference in object files is useful as
> > > it shows any change has been compiled and tested.
> > >   
> > 
> > Joe, I feel the same thing, there is no need of a patch series
> > for it but I was given a suggestion that it becomes difficult for
> > the
> > reviewers to review the patch so it is good to send a patchset
> > instead.
> 
> In this case, reviewing the 224 lines you're touching in one shot
> feels
> the same as reviewing them over 11 patches, as the change is always
> of
> the same type. Maybe a single patch is actually even a bit quicker to
> review.
> 
> Are you sure the suggestion was referring to this, and it wasn't
> about
> different type of changes in the same patch?
> 
Yes I am sure about it. But anyway I will send a single patch for these
changes now.

Thanks Stefano :)


