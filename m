Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C80AC1975A
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 20:47:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41E3620714
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 20:47:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="c9nyhi39"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726892AbgCQUrT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 16:47:19 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:46759 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726761AbgCQUrS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 16:47:18 -0400
Received: by mail-pf1-f194.google.com with SMTP id c19so12594652pfo.13
        for <linux-kernel@vger.kernel.org>; Tue, 17 Mar 2020 13:47:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/ZMNFVo7Tsi5t68rALsYOvDVbYQdbqGTWKL9lb3JvuE=;
        b=c9nyhi39KsZWTsbpDFXgSXKk3n7yOwp3uxTzHaQnVDIM13uJ4QnSSw/aQZXKdFL1ei
         88iumTiBDgVcsVpOXraZRTpCQZJC4n/haKrhbtsyJ1arprcZ2hNrICrMgesDskYlzrHL
         m0keVQltdevZKhucb9zYrQJdR6L7RgUiKoNJ8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/ZMNFVo7Tsi5t68rALsYOvDVbYQdbqGTWKL9lb3JvuE=;
        b=FxU6bG7bz0D8dhayHRQbJ6UUMBQslMP7s2S3GxRIVq8JQF9ip5VGbkvA1GNFz5A55w
         yVIiuxFM6wiUtxOloPEdRNv/UAVg2esvwlmYDKpDqZ3pv3TqtdUrSvRsetnQsIpPG/lI
         BoCbw0dB4YYAe8RcfVOcpygpCoYsoOHSMTQ9bi5ZJgHn0oPIDDJGhu8Kfy8dOXFCdPnQ
         Us6+HWPZlppThLo/OTWUZCa0wZlI7j9JD9HCaSTgDDMm5xvlHu/tbnjmmczGngf1toQq
         DHNkBP9uatSfY0BuzObLiIWpCLJ2H1R50tGiMWJRuY5DoHzDjBDDj/HRGN6UHKcqy3Ua
         84PQ==
X-Gm-Message-State: ANhLgQ0Pt29qfOLaITeoLW2P3/Ij+qMi61AbdzixieVs4JH55UEBc2h/
        irK9EuebOGGYY1CKqKWTIuId9f8cRRw=
X-Google-Smtp-Source: ADFU+vu6/iwKJHS7qAmilHd6qy3wjFZHBgJSRKd1VFcdNCaGVajZVzYQ5jIB8zxApm9ZrQs3cBrUsw==
X-Received: by 2002:a62:de83:: with SMTP id h125mr607859pfg.161.1584478035217;
        Tue, 17 Mar 2020 13:47:15 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id j21sm258232pji.13.2020.03.17.13.47.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2020 13:47:14 -0700 (PDT)
Date:   Tue, 17 Mar 2020 13:47:13 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     shuah@kernel.org, luto@amacapital.net, wad@chromium.org,
        linux-kselftest@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com, Tim.Bird@sony.com
Subject: Re: [PATCH v3 0/6] kselftest: add fixture parameters
Message-ID: <202003171346.C4E287D@keescook>
References: <20200316225647.3129354-1-kuba@kernel.org>
 <20200316155917.5ba8db1c@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200316155917.5ba8db1c@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 16, 2020 at 03:59:17PM -0700, Jakub Kicinski wrote:
> On Mon, 16 Mar 2020 15:56:40 -0700 Jakub Kicinski wrote:
> > Hi!
> > 
> > Shuah please consider applying to the kselftest tree.
> > 
> > This set is an attempt to make running tests for different
> > sets of data easier. The direct motivation is the tls
> > test which we'd like to run for TLS 1.2 and TLS 1.3,
> > but currently there is no easy way to invoke the same
> > tests with different parameters.
> > 
> > Tested all users of kselftest_harness.h.
> > 
> > v2:
> >  - don't run tests by fixture
> >  - don't pass params as an explicit argument
> > 
> > v3:
> >  - go back to the orginal implementation with an extra
> >    parameter, and running by fixture (Kees);
> >  - add LIST_APPEND helper (Kees);
> >  - add a dot between fixture and param name (Kees);
> >  - rename the params to variants (Tim);
> > 
> > v1: https://lore.kernel.org/netdev/20200313031752.2332565-1-kuba@kernel.org/
> > v2: https://lore.kernel.org/netdev/20200314005501.2446494-1-kuba@kernel.org/
> 
> Ugh, sorry I forgot to realign things after the rename :S
> 
> I'll send a whitespace-only v4 in a hour, allowing a little bit 
> of time in case there are some comments already.

No worries! I think a few small changes are needed for a v5 (please
carry my Acked-bys with for v5). Thanks for working on this; I love it!
:)

-Kees

-- 
Kees Cook
