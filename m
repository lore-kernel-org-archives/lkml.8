Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC981C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 19:57:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B549A20792
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 19:57:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j+gOXK8r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726753AbgGWT5b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 15:57:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726029AbgGWT5a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 15:57:30 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 415AAC0619DC
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jul 2020 12:57:30 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id d27so5337541qtg.4
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jul 2020 12:57:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Hk1VOua7WA4W+2a0I8tnHK2NN+ZOxHTFP4Vzc6rLNi8=;
        b=j+gOXK8rtTNs77JTc+74zeZInWXCebPkiK/Qra1mP+D0F5cHd9qLF9OvxofuHVNkZQ
         Ewc7nDTdnrpEjzXM2dKHTWVQLOEASdds3607fOuHPynBxCAXEN1IgdlFSXnowoe8gQ5o
         3i6j+QdgSAd8X/UZlH+Aar36Bc4rxRx2vWtgTZ6FRzrL3jypvRUG0SaKfCui/w2d6iNm
         a5sBDMWAcv9OYSLfqz4tj+740k9AAuIavOY95lhSoEqn8GmmzQ0V/MyOmuy/d0coOH1a
         biZ3A+ZLRrDNRasMdi/VfuBrP4bZtRe+a2oxt3EjeRbdsJQT+/OhB+FQuYffy2qNvcY3
         TamA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Hk1VOua7WA4W+2a0I8tnHK2NN+ZOxHTFP4Vzc6rLNi8=;
        b=jiQQ66ra59UKeLj4q3Oc8FnYabbM3rEd8UuApRkIpXuDCbxrNqkko0UxvCVSOQfWB/
         SJhiCSlwJNjfsFpNNZRoVOZHdrsEetY423PMWdIJP2kj2ZLrVraC4HgWD3P4wW/kZ+eP
         ODc3Iwia14u7+1e94pO/gdGaX6Y97MF9Uaryu3r4Yjk/1yPcIHoYjaMp67wo26NMS+EL
         NVwu+N8Ha9906ZZWRiJlTmwALW11xqp9DX1hn5OwzOi+ixlxN6cIADXdaarKMfF/GnYd
         qEfrrsS9cKmjzaNYBOBKUZLUc7GW7PCFcCnfaXyZLfs2XwyYggMDKiLm8LUEua+HyOFh
         6nPQ==
X-Gm-Message-State: AOAM531BTe2W5Zqf2jsiwzOgjrHk/Jmo6rr352EqRdZNFv8nZ1qOTyDY
        rlzenEY23jhq6S/rwvtotUvs3QK+rJcdJFN0HS4Pcw==
X-Google-Smtp-Source: ABdhPJyx2lXUQ3HDTMYdZgeEMfHMWEhRcamB/2Z1IY/HT2QdGNZBtXBBN7HtWjH6eRybQhV+lkurDSOe++dKQvFVJOU=
X-Received: by 2002:aed:2f46:: with SMTP id l64mr5986227qtd.1.1595534249528;
 Thu, 23 Jul 2020 12:57:29 -0700 (PDT)
MIME-Version: 1.0
References: <20200716115346.GA1667288@kroah.com> <20200723111827.GA1963557@kroah.com>
In-Reply-To: <20200723111827.GA1963557@kroah.com>
From:   Richard Weinberger <richard.weinberger@gmail.com>
Date:   Thu, 23 Jul 2020 21:57:18 +0200
Message-ID: <CAFLxGvzP5wMUvXzTFc8S8oqfM8mereFSy92qwwmgg-R73Z9sgQ@mail.gmail.com>
Subject: Re: [PATCH] mtd: properly check all write ioctls for permissions
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 23, 2020 at 1:19 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Thu, Jul 16, 2020 at 01:53:46PM +0200, Greg Kroah-Hartman wrote:
> > When doing a "write" ioctl call, properly check that we have permissions
> > to do so before copying anything from userspace or anything else so we
> > can "fail fast".  This includes also covering the MEMWRITE ioctl which
> > previously missed checking for this.
> >
> > Cc: Miquel Raynal <miquel.raynal@bootlin.com>
> > Cc: Richard Weinberger <richard@nod.at>
> > Cc: Vignesh Raghavendra <vigneshr@ti.com>
> > Cc: stable <stable@kernel.org>
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > ---
> >  drivers/mtd/mtdchar.c | 54 +++++++++++++++++++++++++++++++++++--------
> >  1 file changed, 45 insertions(+), 9 deletions(-)
>
> Any objection to this patch getting into 5.8-final?

Well, I hoped to get some acks/reviews...

Applied to mtd/fixes! :-)

-- 
Thanks,
//richard
