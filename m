Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA890C2BA19
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 16:07:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 82DAA2166E
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 16:07:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="iRUvs+9r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2410204AbgDOQHP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 12:07:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729190AbgDOQHI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 12:07:08 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9AA1C061A0C
        for <linux-kernel@vger.kernel.org>; Wed, 15 Apr 2020 09:07:07 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id ca21so5579810edb.7
        for <linux-kernel@vger.kernel.org>; Wed, 15 Apr 2020 09:07:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0MLjDM9KsRvMVgG43FusnRuA/V1fF1PP6aJDpeifgKM=;
        b=iRUvs+9ratAYYazdxRWQjGbETjt7wPo7elXFoTo9rRkgbMtlx6glo20cP0xHh5oOQZ
         zeoBKppefNbtAwADYvNW3aaQHFPhaLgG/Xr22tvPeRHjK9+7Lyft492IH+Uz68AA0Gbf
         zqfhAgSiEtudIo8NwOetfiGetxDJK77hkLLlYH2OSU/8PD/p49nlLiWiLFLVB7Hh7AxM
         nfv4YUwHvsKfaT4aK+FtqtDlH/ue9Hr3nZo/z18/Q1Q9UCMNvr3lEpFhTUOD7YwXNffF
         6eeTGYZRTZHX/FIaDU7P8mPNGvESLOspPGAVRPqDizrEjlxZGcsWThQ+kr2XY6oaO4dm
         dHZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0MLjDM9KsRvMVgG43FusnRuA/V1fF1PP6aJDpeifgKM=;
        b=OwwoD0WNQUDBGfdEzzvE5kHzOVONuMrvDojK6yWleRoIcWZV/UePA8awZk6p7pN2Jd
         c/y5wJ76yRkf9tmWSPxY9W1v2RYXLNHQYOjnzDHsRZOHmNqd/QI+5VjBD/TS3fDvCUjE
         FCxkqhtkrFOQW+SSKWO6L1T6NJACQ6AmyRsfb+6go1b6MnS9/h2pFmymvLJDc01cBnDH
         Lo6Hz2kYAONWHwN67d5DHF8b2V6qZuOLk+HBxOFRTrMNr0yzOEivW51JBJalxLDR2hl6
         nwr/K4ZvGJAAZDm7uMFltjW8Xidh8b1xmVYH43sbrbbDBEsXTatl22zZLXhC03drb2Qc
         h1Aw==
X-Gm-Message-State: AGi0PubCk6SfnJLSI1zXvDFS/RcI7iTg2SqWHQU83i3IFaYvr6CXr1QY
        aswOAICX0jfv4S2AuTcfUcChuQF9zh1fYxdfFhRO
X-Google-Smtp-Source: APiQypLP8COjvsdYHv4oXFXwMf6J6TP99ygaMw9PYLf1PRivCLwn52/dEdrcmQ4/gmtocLU0XDdyhTYcQV/snRujxWw=
X-Received: by 2002:a05:6402:1d1c:: with SMTP id dg28mr23779746edb.135.1586966826498;
 Wed, 15 Apr 2020 09:07:06 -0700 (PDT)
MIME-Version: 1.0
References: <20191128153203.GA23803@workstation-kernel-dev>
 <20191130020742.GF157739@google.com> <20200415153417.svpbimg66vbeuk7u@madcap2.tricolour.ca>
In-Reply-To: <20200415153417.svpbimg66vbeuk7u@madcap2.tricolour.ca>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 15 Apr 2020 12:06:55 -0400
Message-ID: <CAHC9VhTdfkxdiEwCZu-JCQGxJ_DNr0b_Ukm40VEUxq=Lc-zx1g@mail.gmail.com>
Subject: Re: [PATCH v2] kernel: audit.c: Add __rcu notation to RCU pointer
To:     Richard Guy Briggs <rgb@redhat.com>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        Shuah Khan <skhan@linuxfoundation.org>, linux-audit@redhat.com,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org, Amol Grover <frextrite@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 15, 2020 at 11:34 AM Richard Guy Briggs <rgb@redhat.com> wrote:
> On 2019-11-29 21:07, Joel Fernandes wrote:
> > On Thu, Nov 28, 2019 at 09:02:03PM +0530, Amol Grover wrote:
> > > add __rcu notation to RCU protected global pointer auditd_conn
> >
> > Again, please use proper punctuation and captilization. This is unacceptable.
> > Please put more effort into changelog.
> >
> > Otherwise the patch diff itself looks good to me, with the above nit
> > corrected, you could add my tag to the next revision:
> >
> > Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> >
> > thanks,
> >
> >  - Joel
> >
> > >
> > > Fixes multiple instances of sparse error:
> > > error: incompatible types in comparison expression
> > > (different address spaces)
>
> Amol or Joel: Is there a reproducer recipe for this?

The commit which was merged has a slightly better description which may help.

  commit cb5172d96d16df72db8b55146b0ec00bfd97f079
  Author: Amol Grover <frextrite@gmail.com>
  Date:   Mon Dec 2 00:03:48 2019 +0530

   audit: Add __rcu annotation to RCU pointer

   Add __rcu annotation to RCU-protected global pointer auditd_conn.

   auditd_conn is an RCU-protected global pointer,i.e., accessed
   via RCU methods rcu_dereference() and rcu_assign_pointer(),
   hence it must be annotated with __rcu for sparse to report
   warnings/errors correctly.

   Fix multiple instances of the sparse error:
   error: incompatible types in comparison expression
   (different address spaces)

   Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
   Signed-off-by: Amol Grover <frextrite@gmail.com>
   [PM: tweak subject line]
   Signed-off-by: Paul Moore <paul@paul-moore.com>

-- 
paul moore
www.paul-moore.com
