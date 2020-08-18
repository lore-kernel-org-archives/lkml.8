Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93390C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 00:38:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5FA592078D
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 00:38:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="mKXJ54FN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726731AbgHRAi2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 20:38:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726444AbgHRAi1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 20:38:27 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEADBC061389
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 17:38:26 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id o23so20026641ejr.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 17:38:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=llLDdslF9VJQ+TYHo8ll+MktUpA631YAS7CkJsS+nq8=;
        b=mKXJ54FNK4M/pWcY94jCxEjnLGU4PMqb80VKZ+evJpoLvBlocyCTRn+PIU0N6EOhMV
         Etk3f5Bx9ya4QV+rUVvKWTokGRgeiDlZzVufz7HXb65NFQmPFjmnkAiQ87JHInkDgz40
         IP+2V/FINJgeEwUm9I285db+lNlTw1Xq398xW0SuH3TbRJio6qIQiLz99gxVw6y+CIuN
         t7mGJDvXtDB6EP3mzKEurvPdBRx5jPwBZb5VWvlqTZbxZD53zCzL2jVSyrSDfs2OlO+6
         PtTXw86xyBDNUt7pK7+YYnJfUa+8fN2gC6x6B2vaC/BZ/z+flKyTDlTEmtvi7Qw+YGPF
         kChA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=llLDdslF9VJQ+TYHo8ll+MktUpA631YAS7CkJsS+nq8=;
        b=JFJubacSZiRq0jo5G0wk9nXY41POcPk3Rx2VYQK+MLuLZJDEaU8KSua5yHVbb48/5X
         1RN7WC/FCartZi5HS5VPNo7f/OPfEcov0m1jbf0kaQEgBms5MPHXB4T7gh5bV/CMXQ9P
         NqAv8sQdtDUOrFmORZjO0VicekLn/KwTLiPEsyY9J/ux8fqZdIJQQXPYlSgklb41hu6m
         eXM+cFM7GzFSzR8mFZlvXYz02LnOdDb8AnVrY44ITwNRfDRHEKkyMKPnk+hhMmPZ8BAz
         0Ii1Bd+KIs8/1GiZMjafBrbgdX1Cter2OCa+100SUgKb8GMLpvTNpXUDJHeLbrc4KRBL
         lzAg==
X-Gm-Message-State: AOAM530t4lsIPLhN6f4resdP1Z2onJevPRD8RTSV9Ok0xAQd7wCU6QPf
        sHc97XtAyo7LaQr3HbxSJNhmjjxkPzjcAwsiIcLh
X-Google-Smtp-Source: ABdhPJxD/WHhrRHYPJ7Z6bI5LpRYeokjFbmCu3YWL+lFCVHWHiC3mpb/U0Y3UJuJEW5i0MrlwMBf6u3gwyMLyrvfIvs=
X-Received: by 2002:a17:906:990c:: with SMTP id zl12mr17327397ejb.488.1597711104381;
 Mon, 17 Aug 2020 17:38:24 -0700 (PDT)
MIME-Version: 1.0
References: <20200803123439.83400-1-jbi.octave@gmail.com> <20200803123439.83400-2-jbi.octave@gmail.com>
 <CAHC9VhR1-=veLYGeRiF9MAi3QxrGy_z-q+B1DD9t-foPPRJmbA@mail.gmail.com>
In-Reply-To: <CAHC9VhR1-=veLYGeRiF9MAi3QxrGy_z-q+B1DD9t-foPPRJmbA@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 17 Aug 2020 20:38:13 -0400
Message-ID: <CAHC9VhQNZkEa-PmhCDu8mGW8AV0UkA5-Qxh_FGPu+hAcH=tK0Q@mail.gmail.com>
Subject: Re: [RESEND PATCH 1/2] audit: change unnecessary globals into statics
To:     Jules Irenge <jbi.octave@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Eric Paris <eparis@redhat.com>,
        "moderated list:AUDIT SUBSYSTEM" <linux-audit@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 6, 2020 at 2:33 PM Paul Moore <paul@paul-moore.com> wrote:
>
> On Mon, Aug 3, 2020 at 8:35 AM Jules Irenge <jbi.octave@gmail.com> wrote:
> >
> > Variables sig_pid, audit_sig_uid and audit_sig_sid
> > are only used in the audit.c file across the kernel
> > Hence it appears no reason for declaring them as globals
> > This patch removes their global declarations from the .h file
> > and change them into static in the .c file.
> >
> > Signed-off-by: Jules Irenge <jbi.octave@gmail.com>
> > ---
> >  kernel/audit.c | 6 +++---
> >  kernel/audit.h | 4 ----
> >  2 files changed, 3 insertions(+), 7 deletions(-)
>
> Thanks Jules, this looks reasonable although I'm not going to merge
> them into audit/next until after the merge window closes.  I'll send
> another reply once this has been merged.

... and I just merged this into audit/next, thanks Jules.

-- 
paul moore
www.paul-moore.com
