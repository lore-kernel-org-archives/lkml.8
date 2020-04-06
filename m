Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A000C2BA19
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 14:12:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B074323AAC
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 14:12:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iL4FU3D6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728641AbgDFOMM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 10:12:12 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:41667 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728558AbgDFOMM (ORCPT
        <rfc822;Linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 10:12:12 -0400
Received: by mail-qt1-f196.google.com with SMTP id i3so12872242qtv.8
        for <Linux-kernel@vger.kernel.org>; Mon, 06 Apr 2020 07:12:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ADeygDmDshiwBFimIBaQj/8/rgpwlfnIyNwUzX484CA=;
        b=iL4FU3D67fqsaCepBNsy7biptM6SsPi5ExUEhDToSnYJCClKBwd6jjVgDiSGiEWMTQ
         YJ9KUzgUTX5/Kk3CFpJpnKHUroG4JwLAsMQSt39KdmPQLmgICR38+hCdZoP9U/IZkh/F
         RpDJGE0D8I5NIgQo4BwPkeEDjdftrmTqBfnPRwQmE3U0rUW+/0ynHrNIt9YUCeW71bHh
         sF/pQLh0Ep5NG9NXDDKotTZY9VXiPUIukGGvPs+hosSMFZD9Hzj+PuLov05OTKXy+R+D
         +8q+eNVAk9D65tyNu/zsObvN1zbcOSDGOGcsAGn0FKFeOCZp1sF51x9wanEKgMaViMQH
         ymXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ADeygDmDshiwBFimIBaQj/8/rgpwlfnIyNwUzX484CA=;
        b=mCINfF6tVXKRD8kB/3gASWRC/sQ94HpnGYzyTeuPB1aAWR/UyLhQf9K+BQZZfYjN7d
         5H5DhZSjCZQ5vezgdArUxhDidjDRZ5ixaTohM8EsQ/kM3MITwTV7eI5F9Z56SMCdExU2
         aZaygFw2TONUdvtcspq98l8Rf3bOCvESrcpgvXotLrEGOfgyki0uU7prjyZh8LylMeHD
         TsUoYv5qUgPc3dByA7gZbIXihDgU3D673zGZbP3PaJGw3X273kaHmRXccUlrXmu3DDDN
         K+2VUUbShS5+Cfhr8TpOG8f/huMeaeHK2NRJMJbMdvl+FSeeTVye5klKfC10Dwb/hluF
         n4yw==
X-Gm-Message-State: AGi0Pubg5NH++4MXT//flHf1MmiNVXD1V5f+KLGff/hU+n5Jk7Ilf+WB
        YX6O+tr72W0QPedofPo91f4=
X-Google-Smtp-Source: APiQypIiqGLgM1OHeQUgAtx0U9o55M2/BDbCmaUzRIUx0gj+TeS+BtU3i4UVpTOZJhD+wElwgtKvQQ==
X-Received: by 2002:aed:29e1:: with SMTP id o88mr5109758qtd.251.1586182329772;
        Mon, 06 Apr 2020 07:12:09 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.37.151])
        by smtp.gmail.com with ESMTPSA id o186sm14722652qke.39.2020.04.06.07.12.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2020 07:12:08 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id B3F62409A3; Mon,  6 Apr 2020 11:12:06 -0300 (-03)
Date:   Mon, 6 Apr 2020 11:12:06 -0300
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Jin Yao <yao.jin@linux.intel.com>, jolsa@kernel.org,
        peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, Linux-kernel@vger.kernel.org,
        ak@linux.intel.com, kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH] perf stat: Fix no metric header if --per-socket and
 --metric-only set
Message-ID: <20200406141206.GF29826@kernel.org>
References: <20200331180226.25915-1-yao.jin@linux.intel.com>
 <20200403094500.GH2784502@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200403094500.GH2784502@krava>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Apr 03, 2020 at 11:45:00AM +0200, Jiri Olsa escreveu:
> On Wed, Apr 01, 2020 at 02:02:26AM +0800, Jin Yao wrote:
> > We received a report that was no metric header displayed if --per-socket
> > and --metric-only were both set.
> > 
> > It's hard for script to parse the perf-stat output. This patch fixes this
> > issue.
> > 
> > Before:
> > 
> >   root@kbl-ppc:~# perf stat -a -M CPI --metric-only --per-socket
> >   ^C
> >    Performance counter stats for 'system wide':
> > 
> >   S0        8                  2.6
> > 
> >          2.215270071 seconds time elapsed
> > 
> >   root@kbl-ppc:~# perf stat -a -M CPI --metric-only --per-socket -I1000
> >   #           time socket cpus
> >        1.000411692 S0        8                  2.2
> >        2.001547952 S0        8                  3.4
> >        3.002446511 S0        8                  3.4
> >        4.003346157 S0        8                  4.0
> >        5.004245736 S0        8                  0.3
> > 
> > After:
> > 
> >   root@kbl-ppc:~# perf stat -a -M CPI --metric-only --per-socket
> >   ^C
> >    Performance counter stats for 'system wide':
> > 
> >                                CPI
> >   S0        8                  2.1
> > 
> >          1.813579830 seconds time elapsed
> > 
> >   root@kbl-ppc:~# perf stat -a -M CPI --metric-only --per-socket -I1000
> >   #           time socket cpus                  CPI
> >        1.000415122 S0        8                  3.2
> >        2.001630051 S0        8                  2.9
> >        3.002612278 S0        8                  4.3
> >        4.003523594 S0        8                  3.0
> >        5.004504256 S0        8                  3.7
> > 
> > Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
> 
> Acked-by: Jiri Olsa <jolsa@redhat.com>

Thanks, applied.

- Arnaldo
