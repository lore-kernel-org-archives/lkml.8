Return-Path: <SRS0=Atmy=73=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAB26C433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jun 2020 14:25:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 87A572071A
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jun 2020 14:25:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fGKR9qOa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726955AbgFNOZI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Jun 2020 10:25:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725815AbgFNOZH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Jun 2020 10:25:07 -0400
Received: from mail-vs1-xe44.google.com (mail-vs1-xe44.google.com [IPv6:2607:f8b0:4864:20::e44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0D3AC05BD43;
        Sun, 14 Jun 2020 07:25:07 -0700 (PDT)
Received: by mail-vs1-xe44.google.com with SMTP id q2so7906944vsr.1;
        Sun, 14 Jun 2020 07:25:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cfVjOZDAg4BBthnGwIxEn39WTPqhnTAEqhXcrP5ukl8=;
        b=fGKR9qOa0BcpUXThh6VXJAsEHBd7uiApOx7zumoNm+F0f2Ulmqkw/DS5DaekW+7zCp
         7MXX/sjRSeSEH/ba3IGK03AFje1ZY1vSxLLFOa8+WOAkvcaqhF+Pj21j++cNylB1YFVS
         0XmW2aUfN1rK+PIaTALHXUSkHXKRDOz+2EWbo5nTTTQp8UPI98lA4AL9QEhBl3KaGUTg
         e+iXHr5y8oQpaP5ZqRiX59cL/HopcjIkD9RwXauWkVhFgKNaEuaUmV1lb4aC9ffFcC3F
         vKM7y/bpIqBDWWnSSY0oXsJQQwgYGUkPQ9TGCgk66o+op/VcTbhgyHeM44p9/i9opVey
         cQAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cfVjOZDAg4BBthnGwIxEn39WTPqhnTAEqhXcrP5ukl8=;
        b=Nv1LcXuEtkYfT+aT297vdUgnrynoFVHbH41IV4mjvroUSX/w+LtYm33IKkUYTX3JLS
         rsmaI155csPi3r9BAQ5T3As1rZZvzkS8SBRh4uw+qSkCRj1arrA9qZQ0vTIUGuXtcYs8
         2W33hmhhG3ye0t2+qHIr2Kv2NnZl4WjUInQH0Lie7SZatMOytycm2FDEKWGkwI+C+qcl
         Rqd7L1HE4THzRiy9xmRNLbBVb3Bha4KBlUE5VPIxY3rReymZJNCr+OKffkHJI/F8HzsK
         nH9CFDO+HnjASwrTh5OTyE2jG4riJNPCeGkZji4VjhTmE1As38Dbkgv+YU75gXP1bwUj
         LknQ==
X-Gm-Message-State: AOAM532YVUlcDegX4h6Ehyd/wB3of9liFYalD6r9kQtKSyFWJzQi1bAW
        oBOSUM8bFISfRLlSZbcjo63CF/SmU/0iJrApuwFLdz9Q
X-Google-Smtp-Source: ABdhPJws+lNLJ21MwBMe8i3Q0YgHuxqdieeevfbtrR5JDBVC2KbI6xh3a74omJ0SZLLi7T6NlN8MKdD37guH5u0/j/8=
X-Received: by 2002:a67:fc17:: with SMTP id o23mr16152958vsq.92.1592144706364;
 Sun, 14 Jun 2020 07:25:06 -0700 (PDT)
MIME-Version: 1.0
References: <20200613155738.2249399-1-jim.cromie@gmail.com>
 <20200613155738.2249399-2-jim.cromie@gmail.com> <20200614060401.GA2608744@kroah.com>
In-Reply-To: <20200614060401.GA2608744@kroah.com>
From:   jim.cromie@gmail.com
Date:   Sun, 14 Jun 2020 08:24:40 -0600
Message-ID: <CAJfuBxz3+yk6E_1KO11R=iurNEtg-4We79epj9BG+nZj9JRDAQ@mail.gmail.com>
Subject: Re: [PATCH v2 01/24] dyndbg-docs: eschew file /full/path query in docs
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Jason Baron <jbaron@akamai.com>,
        LKML <linux-kernel@vger.kernel.org>, akpm@linuxfoundation.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Jonathan Corbet <corbet@lwn.net>,
        Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Orson Zhai <orson.zhai@unisoc.com>,
        Petr Mladek <pmladek@suse.com>,
        Linux Documentation List <linux-doc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 14, 2020 at 12:04 AM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Sat, Jun 13, 2020 at 09:57:15AM -0600, Jim Cromie wrote:
> > Regarding:
> > ---
> >  .../admin-guide/dynamic-debug-howto.rst       | 19 +++++++++----------
> >  1 file changed, 9 insertions(+), 10 deletions(-)
>
> None of your patches have a signed-off-by line so they can't be applied
> anywhere :(

oof.  I missed the -s in format-patch
will resend soon, after some time for remaining feedback.
