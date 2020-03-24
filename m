Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E23D2C41621
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 13:42:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB76E206F6
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 13:42:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lp6lG9qe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727716AbgCXNmN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 09:42:13 -0400
Received: from mail-qt1-f180.google.com ([209.85.160.180]:40323 "EHLO
        mail-qt1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726802AbgCXNmN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 09:42:13 -0400
Received: by mail-qt1-f180.google.com with SMTP id c9so7923373qtw.7
        for <linux-kernel@vger.kernel.org>; Tue, 24 Mar 2020 06:42:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=2N/zF9IA49A0LlheC2a+Dop1FC0bxU9znCYzeW+4cjg=;
        b=Lp6lG9qeDzOiO8nFbO6+WgYHH1QQyuK3zI9O30IGW/K+w8lGVvO3/jpB3MSXeMJu8v
         XLnIInc3QRxol9qREWkX6GZUCHP93LyS63M9S/9a5cABFc2ba7L5AMnUCH1GsEh2+a9M
         KwUVWg4Iglfy2xuKcF5jrFLzON9S43h8FEAQqUcFDfXE3ATyeSK8m8H+6BTeep3JBug2
         c58QJyl7SbcexeMST2ImFUnf6vtSD2GpZOr8zk7/6CenyzIUI+ADDHn6dhSRRoSDPhER
         DDZoZdAxX7qb2CMyluW73m8ao7hUmAEsrAImqfyA/p/3+uTO3gpe1tGW9DLmTvvBC/qT
         +GJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2N/zF9IA49A0LlheC2a+Dop1FC0bxU9znCYzeW+4cjg=;
        b=g69q0eOhT3x5PtUtmGv8dikGuOZEzQr4WAB+hmnzmXSl8sHKLdZqsSv1slQlB5MxLG
         L6x3+wPZcaFNcM9T4Kn9+SXgazXbcGmXq4MZKncVN+zETzxngNnM8vl8EMm5NAROMjtz
         9MFdmWlKTZh6S04Sk5DvtShzhmWBW5Xi1fFALOfVTB207543HBRjFEIJZrs/oUE/2HjM
         186ZxC8voOdRepBz7rJkMnqjmF85k+t1taE8QGtgoKCGSyJGdNR56KBwo8v5WiSFUdfu
         go+iCwR5CrgPd1QSfZ1jHIdsiOOe3C41ObxrgFv3J93Xf+yco2cq10E4xNQwd6XQhk1Z
         3QgQ==
X-Gm-Message-State: ANhLgQ0VNz34B8DWm0zQaA9UsxGELXM7jMsMJr0Og4QKh0Jh581SqpHe
        4RXDvY2zHaAsMbInlk5g6bk=
X-Google-Smtp-Source: ADFU+vtnCMU8tBZgvryOaqGD8Wq23v1AG6A0OwN8EHv+pL9mdAzzeaR1R6E44xzjsej+ggn9NqJJ8w==
X-Received: by 2002:ac8:33cd:: with SMTP id d13mr26155901qtb.265.1585057331063;
        Tue, 24 Mar 2020 06:42:11 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.37.151])
        by smtp.gmail.com with ESMTPSA id 68sm13018074qkh.75.2020.03.24.06.42.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2020 06:42:10 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 8AD8440F77; Tue, 24 Mar 2020 10:42:07 -0300 (-03)
Date:   Tue, 24 Mar 2020 10:42:07 -0300
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        linux-kernel@vger.kernel.org, namhyung@kernel.org,
        mark.rutland@arm.com, naveen.n.rao@linux.vnet.ibm.com
Subject: Re: [PATCH] perf dso: Fix dso comparison
Message-ID: <20200324134207.GH9917@kernel.org>
References: <20200324042424.68366-1-ravi.bangoria@linux.ibm.com>
 <20200324104843.GS1534489@krava>
 <3cf2bd1b-e1c2-f82f-a06a-ce0d5e4b5eac@linux.ibm.com>
 <20200324132258.GX1534489@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200324132258.GX1534489@krava>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Mar 24, 2020 at 02:22:58PM +0100, Jiri Olsa escreveu:
> On Tue, Mar 24, 2020 at 06:07:23PM +0530, Ravi Bangoria wrote:
> 
> SNIP
> 
> > > looks good, do we need to add the dso_id check to sort__dso_cmp?
> > 
> > I guess with different filename there is no need to compare dso_id.
> > But for same filename, adding dso_id cmp will separate out the
> > samples:
> > 
> > Ex, Without dso_id compare:
> > 
> >   $ ./perf report -s dso,dso_size -v
> >     66.63%  /home/ravi/a.out                                  4096
> >     33.36%  /home/ravi/Workspace/linux/tools/perf/a.out       4096
> > 
> >   $ ./perf report -s dso,dso_size
> >     99.99%  a.out                 4096
> > 
> > 
> > With below diff:
> > 
> >   -       return strcmp(dso_name_l, dso_name_r);
> >   +       ret = strcmp(dso_name_l, dso_name_r);
> >   +       if (ret)
> >   +               return ret;
> >   +       else
> >   +               return dso__cmp_id(dso_l, dso_r);
> > 
> > 
> >   $ ./perf report -s dso,dso_size
> >     99.99%  a.out                 4096
> >     33.36%  a.out                 4096
> > 
> > though, the o/p also depends which other sort keys are used along
> > with dso key. Do you think this change makes sense?
> 
> the above behaviour is something I'd expect from 'dso'
> sort key to do - separate out different dsos, even with
> the same name

This specific one can be resolved using -v when long_name will be used,
the biggest problem is when long_name is the same (and thus short_name),
which can happen when developing some software, i.e. compile+rebuild and
get a different content, same short/long name, in that case we should
use some diferentiator, the build-id comes to mind, but one that could
be more useful would be file timestamp, meaning, hey, the older version
is actually better, which one, lemme look at the build-id, and even the
source code if developed with -g, by using the copy we stored in the
build-id cache (~/.debug), which would be really useful workflow.

- Arnaldo

> jirka
> 

-- 

- Arnaldo
