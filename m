Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F232C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 03:47:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E10120737
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 03:47:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BFmS6M5H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726754AbgGXDri (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 23:47:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726503AbgGXDrh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 23:47:37 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7106FC0619D3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jul 2020 20:47:37 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id c16so8512605ioi.9
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jul 2020 20:47:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=k28nnbIjLpUaw48v3Wg0EF9RoEud+Xa2hvvVzYAxRhM=;
        b=BFmS6M5HOfplD1ug0NC+yBsGlfECyobwZZSovY9+oxt4Em4q8pOAXos6rDvqJU//R8
         TZ/HXImqWX1m2309WbS7mO4QxhTxwjxB9Iw2S71Bdgxs/sEVnvthNse4Xpoq4vm6qBGj
         agFmJgOg55XiTIZs5yUtYMEzoSbwdNiUGa4+syKojyN9palXySyA1MLU7M+To/hI/klI
         AudE0tjpqn5hbaQbWSs0mEjU5qf9xlcblgYlH72NrN0pJ0BTcZGLBg46g5rLYug9qkJE
         2RfhFxfIB2I63xPsSXCWuUEIoKt14c9QQAdg6C9rUFtBnRjsJZepnanoT/MArA0aIHKN
         MEGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=k28nnbIjLpUaw48v3Wg0EF9RoEud+Xa2hvvVzYAxRhM=;
        b=TUXT2Am4IBz5CvdUpJ5GEMHVLpowKsAfwwXHrirq5VnXUw4m/TGBDfCzCgdGWybAxy
         PCmnds1Dm28J5ceuCXSnjHjzeJYBA4y4sv07M1QhXJwVodw7w7kw3XHTjKitPBnxGHKr
         VZr3I4XWJPVEvZTXK7nFy8g5Hz4K5o+OalonpcGmJyShHoGmFwP+zJS6oHHQOOrpsa95
         Q1cFr7U5qVFEpGdfm7HD8O5COfhTPPWi0KMqg1aZZt1UQTKG8CfTNhINuW8HX60DQILX
         JrR9enwsDzWFo9fYdsRGZOvo4pWBa7fQT7BRn8UoU+3VFCB7hCdpSLsYe70d8O+PSIKG
         kheQ==
X-Gm-Message-State: AOAM530VKFOAVRnnOSLKOdEnn5/Uf5q6rbi9B5HkIKTdNr1pdO8KhqgU
        M28bfZV8Gvm6tEuSJ5MG8Ogxb/9AtgDSWAxN310=
X-Google-Smtp-Source: ABdhPJx6AFYMn+jkFZnlsATo/34vmdIRPckl2LUZY0kFAfqsU+3UPuqJ04G7deZ6rOKPmnS6oPqljURVWozO6VTLLLw=
X-Received: by 2002:a02:a986:: with SMTP id q6mr8079962jam.93.1595562456535;
 Thu, 23 Jul 2020 20:47:36 -0700 (PDT)
MIME-Version: 1.0
References: <20200721001505.GD19262@shao2-debian> <CAOQ4uxgq39EDS_k3eDTngEAm8cxHPa7qrkUSW8Rk6qS9cxC18w@mail.gmail.com>
 <9a2a4086-fbad-b4f8-9c00-2b7606441022@intel.com>
In-Reply-To: <9a2a4086-fbad-b4f8-9c00-2b7606441022@intel.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Fri, 24 Jul 2020 06:47:24 +0300
Message-ID: <CAOQ4uxgHf_4GQzQGGRTxTECMvEeNjoqhsbGOm5T3GRpV+=0YzA@mail.gmail.com>
Subject: Re: [fsnotify] c738fbabb0: will-it-scale.per_process_ops -9.5% regression
To:     Rong Chen <rong.a.chen@intel.com>
Cc:     Jan Kara <jack@suse.cz>, LKML <linux-kernel@vger.kernel.org>,
        lkp@lists.01.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 24, 2020 at 5:45 AM Rong Chen <rong.a.chen@intel.com> wrote:
>
>
>
> On 7/21/20 11:59 PM, Amir Goldstein wrote:
> > On Tue, Jul 21, 2020 at 3:15 AM kernel test robot <rong.a.chen@intel.com> wrote:
> >> Greeting,
> >>
> >> FYI, we noticed a -9.5% regression of will-it-scale.per_process_ops due to commit:
> >>
> >>
> >> commit: c738fbabb0ff62d0f9a9572e56e65d05a1b34c6a ("fsnotify: fold fsnotify() call into fsnotify_parent()")
> > Strange, that's a pretty dumb patch moving some inlined code from one
> > function to
> > another (assuming there are no fsnotify marks in this test).
> >
> > Unless I am missing something the only thing that changes slightly is
> > an extra d_inode(file->f_path.dentry) deference.
> > I can get rid of it.
> >
> > Is it possible to ask for a re-test with fix patch (attached)?
>
> Hi Amir,
>
> We failed to apply this patch, could you tell us the base commit or the
> base branch?
>

Hi Rong,

The patch is applied on top of the reported offending commit:
c738fbabb0ff62d0f9a9572e56e65d05a1b34c6a ("fsnotify: fold fsnotify()
call into fsnotify_parent()")

I pushed it to my github:
https://github.com/amir73il/linux/commits/for_lkp

Thanks,
Amir.
