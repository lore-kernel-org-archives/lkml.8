Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2348FC4332D
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 18:36:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB92B20787
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 18:36:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EMduB5pR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727422AbgCSSg0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 14:36:26 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:46509 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725787AbgCSSg0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 14:36:26 -0400
Received: by mail-qt1-f194.google.com with SMTP id t13so2712245qtn.13
        for <linux-kernel@vger.kernel.org>; Thu, 19 Mar 2020 11:36:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=KNebSnBdrZ/6z/FStqy7M9Zyh+LbdANWWGx5FjzQeMY=;
        b=EMduB5pR07+Ca/I8dIlgrqu86DsieUYz8q81Jx/Glsqn35g1stMn+NaUOkH5/DrQsh
         Q+Ihnd8KmM4/1Q6JR2ZM3lpS68B1M+yo+GiJ8mbzKqbSBzCjIDjZ+U1BFXpZUb3ZvE/n
         nkJQq9SR+8N/iDvZlCrn67yLzntV3tA7floas8ki7s3ivTS/fjgQXBNCVJo13PpsENZk
         XPSkxicss5faQW0FKHCquAc8IGNy6F57KNEaKW2AgTKzYZkQ4S2XEg8yYDvGYjRRPiSc
         XiJT0aCyI/6HNlmErTTOfcdxY+/jilbMk5eDXRHA2ZshRj0ZjmhrAZ60MN3V4zKpCsLH
         gikg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=KNebSnBdrZ/6z/FStqy7M9Zyh+LbdANWWGx5FjzQeMY=;
        b=jANjwY8kK+IdbELNLEn28siDrnPwKKQ9hkNH2P7LEGbBWClc/rPw5XcTvOUriyCUih
         BDlqzMVp3OcP7Ycl5G9e3fQDGwPwaKQXqbowUapPHRAJ3/48jqFAdwQVYzi1k4PM36nT
         TSLZSA6gfzcnE/Yyvnet9aP4WXhOgR79EYkKED06df+Mt3g0nImSOSorRfrEw7M8tIr9
         LNVE5Oug9wusWhlv7oSj0ksSgXZYQHEnQG+j0zfXsQw2KgNSEuu1Bkph7JSvRtElYDYM
         GdBVonZkgXm8GXQGaoZv8Il+zSbCd8SiiTN4zlYIYO3Wrv1A9QgieFDMSq9M0WUjB1Qr
         rejQ==
X-Gm-Message-State: ANhLgQ3cheCRqFa+EtLJD3n17SAJW6kEwXlr8LK3P9ICmW4wJtfGJjuj
        ZxD8t7yY8yfgWSuyDRZUOLU=
X-Google-Smtp-Source: ADFU+vsiivgYrHXYoDPQr91JLkSKO7wJqI7DGeOf0RHnQvx4YfeqWIaYO2RF7kxB+WaE8415qcOphg==
X-Received: by 2002:ac8:8b9:: with SMTP id v54mr4341613qth.229.1584642985439;
        Thu, 19 Mar 2020 11:36:25 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.37.151])
        by smtp.gmail.com with ESMTPSA id e2sm2074630qkb.112.2020.03.19.11.36.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2020 11:36:24 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id B23FB404E4; Thu, 19 Mar 2020 15:36:22 -0300 (-03)
Date:   Thu, 19 Mar 2020 15:36:22 -0300
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     John Garry <john.garry@huawei.com>, peterz@infradead.org,
        mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, namhyung@kernel.org,
        will@kernel.org, ak@linux.intel.com, linuxarm@huawei.com,
        linux-kernel@vger.kernel.org, james.clark@arm.com,
        qiangqing.zhang@nxp.com
Subject: Re: [PATCH v2 7/7] perf test: Test pmu-events aliases
Message-ID: <20200319183622.GD14841@kernel.org>
References: <1584442939-8911-1-git-send-email-john.garry@huawei.com>
 <1584442939-8911-8-git-send-email-john.garry@huawei.com>
 <20200317162043.GC759708@krava>
 <01dd565b-931c-e853-a721-aa995f87469c@huawei.com>
 <20200317170730.GF759708@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200317170730.GF759708@krava>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Mar 17, 2020 at 06:07:30PM +0100, Jiri Olsa escreveu:
> On Tue, Mar 17, 2020 at 04:41:04PM +0000, John Garry wrote:
> > On 17/03/2020 16:20, Jiri Olsa wrote:
> > > On Tue, Mar 17, 2020 at 07:02:19PM +0800, John Garry wrote:
> > > > @@ -36,6 +51,8 @@ static struct perf_pmu_test_event test_cpu_events[] = {
> > > >   			.desc = "Number of segment register loads",
> > > >   			.topic = "other",
> > > >   		},
> > > > +		.alias_str = "umask=0x80,(null)=0x30d40,event=0x6",

> > > ah so we are using other pmus because of the format definitions

> > > why is there the '(null)' in there?

> > Well this is just coming from the generated alias string in the pmu code,
> > and it does not seem to be handling "period" argument properly. It needs to
> > be checked.
 
> nice, it found first issue already ;-)

Applied the series to perf/core, good job! What about the fix for the
above (null) problem?

Cheers,

- Arnaldo
