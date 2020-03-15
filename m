Return-Path: <SRS0=iqK9=5A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7B70C10F29
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Mar 2020 20:55:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C16C206E9
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Mar 2020 20:55:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="TUqHtxac"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729196AbgCOUzv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Mar 2020 16:55:51 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:39291 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729170AbgCOUzv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Mar 2020 16:55:51 -0400
Received: by mail-pg1-f194.google.com with SMTP id b22so2460685pgb.6
        for <linux-kernel@vger.kernel.org>; Sun, 15 Mar 2020 13:55:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=tbQkUnVAWk4DdNT2eI9KPJ4CRtZVJETNZZv1PgzqPdM=;
        b=TUqHtxacJZiW83OVGKgFfuF6Fc/KC14JPIfKhWr/ZLp8b86LYAZcIh4ZLGLvv8HUqh
         qDzP4e7q1vFJZKCl55haTEh/XB2LBczr02MYiehd3c1KVo8oo4NkaGTGAtwHlXKE2t/M
         7pcrHYhRordlMkfMW29YuYSIcpzYZyDZ1wDpc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tbQkUnVAWk4DdNT2eI9KPJ4CRtZVJETNZZv1PgzqPdM=;
        b=C26dqb1QLd/y5E7EFNdTcuXlBbODfk4kvLB5fnQIEDTK8YQaNXhuWc2ECwbsZTIaEX
         iyUpvWiAwahXtdIidr1Q4PpYXT+tp4SFbXb+BIrbDr9/tfD6wF1LfX2cC7ENYKQAscix
         quAO52pofxBpieAJ9r/+sVziTDcSkSSa5ZssNmnxsVnBTRyupG2esh/aIZoXju0vttR2
         FOrVMm00za7Thbml8BmnEeUQYl9xOvG75G3ZprVF+VuhaHFNO5ZDVzp3GzW5RkNOh46X
         Dv8NpcZo/4Bo86wftBi9xIs/w/V69XbzTzP7jcMiLC8EuT0m/9jfBV5/1g2TTI9ZIE/f
         uV6Q==
X-Gm-Message-State: ANhLgQ0wukasX4YN8Fz0CEX2VZ3s7Ef+BJOLTjpu95d8knlvLyWbO6or
        94YVfINHs0ZVk3cwlPanSWJ5lg==
X-Google-Smtp-Source: ADFU+vtxEx4oeojuJNx6exzRxdGuXoqCl51ncVvkkl2QI21JaiWr2FV9967v4dRa9pBNfHP5Tulp2w==
X-Received: by 2002:a63:a06e:: with SMTP id u46mr23528688pgn.140.1584305749808;
        Sun, 15 Mar 2020 13:55:49 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id h23sm13566341pfo.220.2020.03.15.13.55.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Mar 2020 13:55:48 -0700 (PDT)
Date:   Sun, 15 Mar 2020 13:55:48 -0700
From:   Kees Cook <keescook@chromium.org>
To:     David Miller <davem@davemloft.net>
Cc:     kuba@kernel.org, shuah@kernel.org, luto@amacapital.net,
        wad@chromium.org, linux-kselftest@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH v2 0/4] kselftest: add fixture parameters
Message-ID: <202003151355.C9118025F@keescook>
References: <20200314005501.2446494-1-kuba@kernel.org>
 <20200315.000517.641109897419327751.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200315.000517.641109897419327751.davem@davemloft.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 15, 2020 at 12:05:17AM -0700, David Miller wrote:
> From: Jakub Kicinski <kuba@kernel.org>
> Date: Fri, 13 Mar 2020 17:54:57 -0700
> 
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
> > Note that we loose a little bit of type safety
> > without passing parameters as an explicit argument.
> > If user puts the name of the wrong fixture as argument
> > to CURRENT_FIXTURE() it will happily cast the type.
> 
> Hmmm, what tree should integrate this patch series?

I expect the final version (likely v3) to go via Shuah's selftest tree.

-Kees

-- 
Kees Cook
