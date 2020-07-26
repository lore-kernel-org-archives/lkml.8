Return-Path: <SRS0=7zi/=BF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1778DC433E4
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 11:53:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E99172065E
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 11:53:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MYcmhW1M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727937AbgGZLw7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Jul 2020 07:52:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725972AbgGZLw7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jul 2020 07:52:59 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07352C0619D2
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jul 2020 04:52:59 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id l17so570610ilq.13
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jul 2020 04:52:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=RbTqwz1nod/4qOFk+Ft7cV9vFYPL8YQ81urbkgP2GUc=;
        b=MYcmhW1Mr4aVt8cR3m7wyJ8l9ADziP9lpEzyvO5i+4H3UWpGhtJMslsRRGlL1a7pQV
         GoIFJEgABiF5Qk7ODqDXnP33VOgp311pKxPsxeO9IY9t7NpojBDUd5PSXCA6BYp+7Cia
         oXqJs7zpOR4DOCDygBGm+7gWhLKgSjIve4kugnwyRijUehfYzcuo/vWvSAV/V8rOaV5F
         TxyqfTfo+Tfk37iFZx3nnmw8YxhVQlizHrHRY2Km3H2CWITdHxlSnIaBsXBLvHTlfY1u
         U6L4xfpi0zE4mXAbDyMBq9N7qC35LC1JCRlLH2e30knfIz8TH6UTRraYYjmMx7bh3nK+
         HxfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=RbTqwz1nod/4qOFk+Ft7cV9vFYPL8YQ81urbkgP2GUc=;
        b=BtzDadg747vD6QMK9e0x5WaPiH+tcFWnU3XWpqiU5RX/o5NMlNlRcDbw81UQdFMl46
         IXGeKtGQNopWPHb3PSWjpjhz3XxEBo6qYsCd7a0qfCVSHAPtPIz1IZVkluWozSDiCQBi
         9hyrLei55ZdaRQzfenaHUZTCzdYG67d4xZjJbWmrcsGXiYk+hLrCTogcln2y4oZQ9F89
         CvUbh7xwp6U7yYcfwy2/hqIEqewAlwvtu53TcTYj49Yd59JIqXmoRPKyVeu4VtE364M0
         nboS3CeEVJZpN4quRgBLmmJvM2yz21GYK+yoVhB5PcUlTuoanlaWsPYXFD2EEZ6bwSyp
         Byag==
X-Gm-Message-State: AOAM532oE7qzMGjNjmLzcDue2nImskoo6MkHInGZkHoSXQCor1O6ISmn
        3d7UJgauxYmHcuYojrURyaLmjvb9aMMbvXmReVM=
X-Google-Smtp-Source: ABdhPJyhdzQ3rNjzVW9ouZLEBFZnzfBKW+Mr9ZCGAvre/Dq7CwyThZL5idtWUtxbOKT5vJDz2ltchLjvsVHm77Sa2m4=
X-Received: by 2002:a92:89c9:: with SMTP id w70mr11045336ilk.250.1595764378331;
 Sun, 26 Jul 2020 04:52:58 -0700 (PDT)
MIME-Version: 1.0
References: <20200721001505.GD19262@shao2-debian> <CAOQ4uxgq39EDS_k3eDTngEAm8cxHPa7qrkUSW8Rk6qS9cxC18w@mail.gmail.com>
 <9a2a4086-fbad-b4f8-9c00-2b7606441022@intel.com> <CAOQ4uxgHf_4GQzQGGRTxTECMvEeNjoqhsbGOm5T3GRpV+=0YzA@mail.gmail.com>
In-Reply-To: <CAOQ4uxgHf_4GQzQGGRTxTECMvEeNjoqhsbGOm5T3GRpV+=0YzA@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Sun, 26 Jul 2020 14:52:47 +0300
Message-ID: <CAOQ4uxiXiSAaK92pvGDGUCd2hYq=J-7FxJYdUp=KSXncivwJZw@mail.gmail.com>
Subject: Re: [fsnotify] c738fbabb0: will-it-scale.per_process_ops -9.5% regression
To:     Rong Chen <rong.a.chen@intel.com>
Cc:     Jan Kara <jack@suse.cz>, LKML <linux-kernel@vger.kernel.org>,
        lkp@lists.01.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 24, 2020 at 6:47 AM Amir Goldstein <amir73il@gmail.com> wrote:
>
> On Fri, Jul 24, 2020 at 5:45 AM Rong Chen <rong.a.chen@intel.com> wrote:
> >
> >
> >
> > On 7/21/20 11:59 PM, Amir Goldstein wrote:
> > > On Tue, Jul 21, 2020 at 3:15 AM kernel test robot <rong.a.chen@intel.=
com> wrote:
> > >> Greeting,
> > >>
> > >> FYI, we noticed a -9.5% regression of will-it-scale.per_process_ops =
due to commit:
> > >>
> > >>
> > >> commit: c738fbabb0ff62d0f9a9572e56e65d05a1b34c6a ("fsnotify: fold fs=
notify() call into fsnotify_parent()")
> > > Strange, that's a pretty dumb patch moving some inlined code from one
> > > function to
> > > another (assuming there are no fsnotify marks in this test).
> > >
> > > Unless I am missing something the only thing that changes slightly is
> > > an extra d_inode(file->f_path.dentry) deference.
> > > I can get rid of it.
> > >
> > > Is it possible to ask for a re-test with fix patch (attached)?
> >
> > Hi Amir,
> >
> > We failed to apply this patch, could you tell us the base commit or the
> > base branch?
> >
>
> Hi Rong,
>
> The patch is applied on top of the reported offending commit:
> c738fbabb0ff62d0f9a9572e56e65d05a1b34c6a ("fsnotify: fold fsnotify()
> call into fsnotify_parent()")
>
> I pushed it to my github:
> https://github.com/amir73il/linux/commits/for_lkp
>

FWIW, I tried reproducing the reported regression on a local machine.

I ran the test twice on each of the branch commits:

26dc3d2bff62 fsnotify: pass inode to fsnotify_parent()
c738fbabb0ff fsnotify: fold fsnotify() call into fsnotify_parent()
71d734103edf fsnotify: Rearrange fast path to minimise overhead when
there is no watcher
47aaabdedf36 fanotify: Avoid softlockups when reading many events

Not only did I not observe a regression with the reported commit,
but there was a slight improvement. And then there yet was another
improvement with the fix commit on top of it.

But it could be that I am doing something wrong, because I have zero
millage with LKP.

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
compiler/cpufreq_governor/kconfig/mode/nr_task/rootfs/tbox_group/test/testc=
ase:
  gcc-7/performance/defconfig/process/16/ubuntu/amir-lkp/open1/will-it-scal=
e

commit:
  47aaabdedf366ac5894c7fddec388832f0d8193e
  71d734103edfa2b4c6657578a3082ee0e51d767e
  c738fbabb0ff62d0f9a9572e56e65d05a1b34c6a
  26dc3d2bff623768cbbd0c8053ddd6390fd828d2

47aaabdedf366ac5 71d734103edfa2b4c6657578a30
c738fbabb0ff62d0f9a9572e56e 26dc3d2bff623768cbbd0c8053d
---------------- ---------------------------
--------------------------- ---------------------------
       fail:runs  %reproduction    fail:runs  %reproduction
fail:runs  %reproduction    fail:runs
           |             |             |             |             |
          |             |
         45:2         -555%          34:2         -807%          29:2
       -996%          25:2     dmesg.timestamp:last
         45:2         -555%          34:2         -807%          29:2
       -996%          25:2     kmsg.timestamp:last
         %stddev     %change         %stddev     %change
%stddev     %change         %stddev
             \          |                \          |                \
         |                \
   1097404            +1.7%    1116452            +2.7%    1126533
       +3.5%    1135663        will-it-scale.16.processes
      0.02 =C2=B1 60%     +20.0%       0.03 =C2=B1 66%     +20.0%       0.0=
3 =C2=B1
66%     -20.0%       0.02 =C2=B1 50%  will-it-scale.16.processes_idle
     68587            +1.7%      69778            +2.7%      70408
       +3.5%      70978        will-it-scale.per_process_ops


Thanks,
Amir.
