Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5B20C10DCE
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 12:42:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C1E120724
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 12:42:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DSWidas2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726814AbgCMMmo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 08:42:44 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:45582 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726646AbgCMMmo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 08:42:44 -0400
Received: by mail-pf1-f196.google.com with SMTP id 2so5155219pfg.12;
        Fri, 13 Mar 2020 05:42:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=K7BMALHz5cMte+OkN45e7QyNpK4gOvBQVmtB+1UqSOM=;
        b=DSWidas2yl2Aa/zcpiVFcKh6gcrKC4Uwdym2iRWyTUoKJKvdWN/zMvJQSQjZ2Wn9dV
         RjYWeEx7DVNMO8qvpb6VWEbMlnOYEv3mrdinxYuKB/TDTvOlQDL6jfTS5JDhQEDnpPwn
         /m9pGQFPrVk9cW/SPomAacb2tjSAMa9NLNXr624w9ORx/V/4ABg20ItONNuXoOLEwgmL
         XUzpC3U7n4d9XcI+pVih2wrGQHBsvaCedWytA4aYjrQwY+wmIry9jX5YJguhRqR5NQkj
         Zg7MjxPQLfilwOpNy96BHStzrux1LpxyhaSNkpK4HI9gFUosRZwCJUC/MJXtDmTPg0fy
         Vvcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=K7BMALHz5cMte+OkN45e7QyNpK4gOvBQVmtB+1UqSOM=;
        b=p8aQlUjFPJ5L6kIGZq6Bz/aByAG0KGG294k6sNO3M+fdhJctOK6wugzO+7h5RzeN3Z
         N3ug9eWT7jNJVvNOftR25crtmn8e3voUs6WZSwNElYQDEAvCuZn9KCUUdapFhpPFNAxu
         Z5O36qE1dDzuy0kO5VdCpdvxPclR5r5mBscssT6PL4YdovPjpVsXRbkJLuda2EAk3a7j
         /ACWbltslJvhAopJoRA6GC3KvGPlsfvFzhVeXx8SEC3BL9BHS7Ld+/STFpzhdO9QRhz7
         1I8YSOELpjs9N21KJDWE9i9UziA6KnkWYS1GJTCfSIN4WtakBUBtzS78Lole7w4J0bEr
         4Big==
X-Gm-Message-State: ANhLgQ0ydzCNZU8kfw3jAnH3gdQ2HJeD2TKojHQ432d72+F5oZNMxBmF
        tvMzR2YiaKDkV6nd8hb3xD1AfdTw
X-Google-Smtp-Source: ADFU+vvxh9DtGmJ8zX1+fVCJlBfjuHRLzXae9X/UuabKFaeKW/2AfhDkbgS5Akgfl6UjBskMDhedHg==
X-Received: by 2002:a63:4c0b:: with SMTP id z11mr12947291pga.385.1584103363087;
        Fri, 13 Mar 2020 05:42:43 -0700 (PDT)
Received: from localhost ([106.51.232.35])
        by smtp.gmail.com with ESMTPSA id w124sm8090098pfd.71.2020.03.13.05.42.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 13 Mar 2020 05:42:42 -0700 (PDT)
Date:   Fri, 13 Mar 2020 18:12:40 +0530
From:   afzal mohammed <afzal.mohd.ma@gmail.com>
To:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>
Cc:     linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] sh: replace setup_irq() by request_irq()
Message-ID: <20200313124240.GB7225@afzalpc>
References: <20200304005120.5403-1-afzal.mohd.ma@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200304005120.5403-1-afzal.mohd.ma@gmail.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yoshinori Sato,

On Wed, Mar 04, 2020 at 06:21:19AM +0530, afzal mohammed wrote:
> request_irq() is preferred over setup_irq(). Invocations of setup_irq()
> occur after memory allocators are ready.
> 
> Per tglx[1], setup_irq() existed in olden days when allocators were not
> ready by the time early interrupts were initialized.
> 
> Hence replace setup_irq() by request_irq().
> 
> [1] https://lkml.kernel.org/r/alpine.DEB.2.20.1710191609480.1971@nanos
> 
> Signed-off-by: afzal mohammed <afzal.mohd.ma@gmail.com>
> ---
> Hi sh maintainers,
> 
> if okay w/ this change, please consider taking it thr' your tree, else please
> let me know.

Seems you handle pull requests for sh, if this patch is okay, please
consider it for inclusion in your tree.

Regards
afzal
