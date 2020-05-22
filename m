Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CA09C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 19:08:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 80312206D5
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 19:08:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="cRntDdoY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731012AbgEVTIl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 15:08:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730922AbgEVTIk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 15:08:40 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A63B7C05BD43
        for <linux-kernel@vger.kernel.org>; Fri, 22 May 2020 12:08:39 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id l1so9143989qtp.6
        for <linux-kernel@vger.kernel.org>; Fri, 22 May 2020 12:08:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=l5Gcr5m4S/6pQuLY8XpkHljkd4WMuN97DO2m6VE7kCE=;
        b=cRntDdoYIMzWKFILaRkTlszjX/lMqXJHF+YaYPhXxUqbOBzsGIvYxVds1TOclAb3Eg
         K9avNoRQEWW7GyBys2tg6s/5hBQI01Bc0PSfg5Wyf/tgsC9Mep9Oe97SD8hWq6sc1cAg
         yHpaB0AOjDg0E0U/klbbRZnfO6eDi0WriOMJo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=l5Gcr5m4S/6pQuLY8XpkHljkd4WMuN97DO2m6VE7kCE=;
        b=SAinG/drAbgb4eWjvMOpE75Ia8r733zYgoOkxR8eYvIKkidfXbsusTpIGNzZiDZ0y+
         7UWb7dh84Z26IsEx2Bbg5T4R/E8F0xujBf6WRChp4R8frLJZQpdBdQR0BOPQzf2ELqfa
         z4k5ViL/5zw2oM+iAqatTysaZ905kew16Ib/LpoHnafeLg988NTmK8S4vJelXQItny93
         ZV6/VFyPuL3CiSeqlrlhE7cejiGw1ITkDKD4agRdaP1rdl7ifhv0FnO2UXBelM97tjcp
         rJMqmp8wj9h77Is+h7yPk5chEF0b4SYopJbRXkIMFYMR2BDpe+G3UDwv+r1MyUiR3F9t
         0koQ==
X-Gm-Message-State: AOAM533CC5xKpffh/5Wsw+IbbiVjukhmd3yNOT0C+832NK6coHu4pL6H
        vU36HwrRzwLyjy4USx5nkIhhZg==
X-Google-Smtp-Source: ABdhPJyiX9QcJL0jbn8s5Fgz/RYlhCmz94BfdJfz+i+aTl9TjEMivU/EzTVzRuF5di2K1/81fUA/bw==
X-Received: by 2002:ac8:6bd5:: with SMTP id b21mr12891370qtt.90.1590174518838;
        Fri, 22 May 2020 12:08:38 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id 88sm8797502qth.9.2020.05.22.12.08.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2020 12:08:38 -0700 (PDT)
Date:   Fri, 22 May 2020 15:08:37 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Matthew Blecker <matthewb@google.com>,
        Jesse Barnes <jsbarnes@google.com>,
        Mike Frysinger <vapier@google.com>,
        Christian Brauner <christian@brauner.io>,
        Vineeth Remanan Pillai <vpillai@digitalocean.com>,
        vineethrp@gmail.com, stable <stable@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH RFC] sched/headers: Fix sched_setattr userspace
 compilation issues
Message-ID: <20200522190837.GB213825@google.com>
References: <20200521155346.168413-1-joel@joelfernandes.org>
 <CAEXW_YTj83gO0STovrOuL9zgDwEYWRJusUZ3ebVw_jOG6yJxTg@mail.gmail.com>
 <20200522140226.GT317569@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200522140226.GT317569@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 22, 2020 at 04:02:26PM +0200, Peter Zijlstra wrote:
> On Thu, May 21, 2020 at 11:55:21AM -0400, Joel Fernandes wrote:
> > On Thu, May 21, 2020 at 11:53 AM Joel Fernandes (Google)
> > <joel@joelfernandes.org> wrote:
> > >
> > > On a modern Linux distro, compiling the following program fails:
> > >  #include<stdlib.h>
> > >  #include<stdint.h>
> > >  #include<pthread.h>
> > >  #include<linux/sched/types.h>
> > >
> > >  void main() {
> > >          struct sched_attr sa;
> > >
> > >          return;
> > >  }
> > >
> > > with:
> > > /usr/include/linux/sched/types.h:8:8: \
> > >                         error: redefinition of ‘struct sched_param’
> > >     8 | struct sched_param {
> > >       |        ^~~~~~~~~~~
> > > In file included from /usr/include/x86_64-linux-gnu/bits/sched.h:74,
> > >                  from /usr/include/sched.h:43,
> > >                  from /usr/include/pthread.h:23,
> > >                  from /tmp/s.c:4:
> > > /usr/include/x86_64-linux-gnu/bits/types/struct_sched_param.h:23:8:
> > > note: originally defined here
> > >    23 | struct sched_param
> > >       |        ^~~~~~~~~~~
> > >
> > > This is also causing a problem on using sched_attr Chrome. The issue is
> > > sched_param is already provided by glibc.
> > >
> > > Guard the kernel's UAPI definition of sched_param with __KERNEL__ so
> > > that userspace can compile.
> > >
> > > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > 
> > If it is more preferable, another option is to move sched_param to
> > include/linux/sched/types.h
> 
> Yeah, not sure. Ingo, you got a preference?
> 
> Also, this very much misses a Fixes tag.

Ok, will add Fixe: tag as follows:

Fixes: e2d1e2aec572a ("sched/headers: Move various ABI definitions to <uapi/linux/sched/types.h>")

thanks,

 - Joel

