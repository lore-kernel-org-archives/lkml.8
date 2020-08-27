Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6D24C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 05:37:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E62F2177B
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 05:37:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ToO6z40E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726242AbgH0FhR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 01:37:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725847AbgH0FhQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 01:37:16 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F366C061246
        for <linux-kernel@vger.kernel.org>; Wed, 26 Aug 2020 22:37:15 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id o4so4094113wrn.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Aug 2020 22:37:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=y3sZv+z9fUpTpAfWVMzXCp8zFYNqHdSRRJDCE3vmCJw=;
        b=ToO6z40E3y9B80oZKLLoMf/rHsgxuisDAqp9dXMXaRRQJFIGBpnUwbrtphZ4T8mLcQ
         84HZIpo1UVZsbHxRrSjcE/KUJPQrKzxL/+A+WTq0uhB/NHVZ5ZhAj5+rth8eVD87ty5j
         RG9qsXxAcSkTbSrhbPjdKcfGHonPeOYbZPJTXOGpM+Ak3VHXCcUVy/q2XKRYePa6IvDy
         SgpoYPNYxcTSl7IkA0BmbuxwqjMUrZPVv0ARcyONlpCCntrQL3PZz4C/cjY2LPXDpfzL
         HUQWtu96rMC8urtC8lB8rY/i2Qx/bWc591c5x5ZNQf+ZLTNkGPlfKSb2djzgBx4nnAoI
         vEmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=y3sZv+z9fUpTpAfWVMzXCp8zFYNqHdSRRJDCE3vmCJw=;
        b=s/5hCbiRkQCTd6I4KMhY+PQrjkAc8cbF8GsU+1PoRjQ9PTsAGHtEXMOjoucRfHvDwP
         gJiG1HFnO9ze1lXgkpfQRDyiZBwUIfX4ODUnJtyzfRYT2dzVB145+Jm9s1bmcu1dk+kC
         ZNZPer05C5YXTzG/dT/aroL2wRkraE1EO4VwYLitg8ZwCevx8MFRjCZH8FA49VoAX7ue
         Tc5LmUx/y6U5cDSWOpUHnmWhJer6tQ517saWOChQkiozy+iccfjc68z13aeu21AKywUL
         BR+gsr1/pCYDUd3iF9KSZofjzn3y7Z6AxJffB/m24QYLbaag/UEfv0UJn6bIFoOEMkeH
         MGbw==
X-Gm-Message-State: AOAM5306CTD4xvXUqUIszLXtRlQrgRQNweZPvH79LOOXbJOLIK1ApczY
        10MN9WBujG5MeCILWS3jLIEy9aK1BYWDMnHmfa1LDQ==
X-Google-Smtp-Source: ABdhPJw6LTY+0/F1eOf1fDFx8ICAyXBJqfxQdilkWGb/ID6G544UUBTyAWnn9TbP9bQHwYM6k1Berttd9YcZWPGn0HQ=
X-Received: by 2002:adf:f184:: with SMTP id h4mr5335878wro.376.1598506632307;
 Wed, 26 Aug 2020 22:37:12 -0700 (PDT)
MIME-Version: 1.0
References: <20200813222155.268183-1-pc@us.ibm.com> <CAP-5=fU4P7o1TwVz+PzcrJsBKnrHW4yrNx3R165i9d3BwgP2RQ@mail.gmail.com>
 <cfa27e83-ac2c-7495-b453-ceeaf2412311@linux.ibm.com> <20200814124307.GF13995@kernel.org>
 <CAP-5=fWw-W3wfy_WeirM_jbEmsbQCC8L_AGo2zsMvv2MW1x04A@mail.gmail.com> <20200827020640.GA48404@li-24c3614c-2adc-11b2-a85c-85f334518bdb.ibm.com>
In-Reply-To: <20200827020640.GA48404@li-24c3614c-2adc-11b2-a85c-85f334518bdb.ibm.com>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 26 Aug 2020 22:37:01 -0700
Message-ID: <CAP-5=fUyw0XmktnSOANkPsXhmTOF6Uq7FKb+QdbXZRvWoxc1yA@mail.gmail.com>
Subject: Re: [PATCH] perf stat: update POWER9 metrics to utilize other metrics
To:     "Paul A. Clarke" <pc@us.ibm.com>
Cc:     kajoljain <kjain@linux.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, maddy@linux.ibm.com,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 26, 2020 at 7:06 PM Paul A. Clarke <pc@us.ibm.com> wrote:
>
> On Wed, Aug 26, 2020 at 09:26:40AM -0700, Ian Rogers wrote:
> > On Fri, Aug 14, 2020 at 5:43 AM Arnaldo Carvalho de Melo
> > <acme@kernel.org> wrote:
> > > Em Fri, Aug 14, 2020 at 11:20:42AM +0530, kajoljain escreveu:
> > > > On 8/14/20 9:13 AM, Ian Rogers wrote:
> > > > > On Thu, Aug 13, 2020 at 3:21 PM Paul A. Clarke <pc@us.ibm.com> wrote:
> > > > >> These changes take advantage of the new capability added in
> > > > >> merge commit 00e4db51259a5f936fec1424b884f029479d3981
> > > > >> "Allow using computed metrics in calculating other metrics".
> > > > >>
> > > > >> The net is a simplification of the expressions for a handful
> > > > >> of metrics, but no functional change.
> > > > >>
> > > > >> Signed-off-by: Paul A. Clarke <pc@us.ibm.com>
> > > >
> > > >   The patch looks good to me.
> > > >
> > > > Reviewed-by: Kajol Jain<kjain@linux.ibm.com>
> > >
> > > Thanks, applied. Added Ian's Acked-by as well.
> >
> > I've synced perf and testing on a remote machine (not easy for me to
> > log into) I see failures in perf test "10.3: Parsing of PMU event
> > table metrics" like:
> > ...
> > parsing metric: dfu_stall_cpi - dflong_stall_cpi
> > Parse event failed metric 'dfu_other_stall_cpi' id 'dflong_stall_cpi'
> > expr 'dfu_stall_cpi - dflong_stall_cpi'
> > Error string 'parser error' help '(null)'
> > Parse event failed metric 'dfu_other_stall_cpi' id 'dfu_stall_cpi'
> > expr 'dfu_stall_cpi - dflong_stall_cpi'
> > Error string 'parser error' help '(null)'
> > ...
> >
> > This may be that the test doesn't handle the metric in terms of metric
> > addition and so I'll look for a fix. I thought I'd send a heads up in
> > case you had already seen/addressed this. Is perf test on PowerPC
> > clean for you at the moment?
>
> I see these errors as well (on 5.9-rc2).  Each error seems to be for the
> newer metrics that take advantage of the newer functionality, including
> the metrics I changed recently, and Kajol's 24x7 and nest metrics.
>
> Thanks for the heads up!  I confess I had not seen the errors only because
> I wasn't looking.  :-/

No worries, if we create a similar Intel metric it will likely exhibit
a similar issue in the test. Arnaldo and I have wondered about having
an all architectures mode for jevents to make it easier to test cases
like this. As my PowerPC set up is a bit special it is great that
you've confirmed this isn't at fault :-) I'll try to get time to dig a
little further.

Thanks,
Ian

> PC
