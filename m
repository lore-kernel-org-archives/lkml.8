Return-Path: <SRS0=dFdc=BX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08D58C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 12:04:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D781020774
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 12:04:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dvSPFCwP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726568AbgHMMEB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Aug 2020 08:04:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726244AbgHMMDD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Aug 2020 08:03:03 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC207C061757
        for <linux-kernel@vger.kernel.org>; Thu, 13 Aug 2020 05:02:57 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id cq28so3970851edb.10
        for <linux-kernel@vger.kernel.org>; Thu, 13 Aug 2020 05:02:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=8gVuDPG5fwBM/nVNmrluJ9T+yfN5fpI57qGEmjbyAn0=;
        b=dvSPFCwPqldouRdB4psdrvzNjTmBKeebNW7WdNVJk1W1t7qbF35Taew1xw5ILv1x7/
         3N1JGoPHD0JQdYSTUGw+7xR9RhYIJUiy7cW8fy5Y2pkjcvQe9Mx7FZLvui76s/Xup9I4
         w6cAxTT3GLn9Sr0iPLZQncCgtZliagsAtQEqH4fA+tnU7Xy0DJi5wuXISXQg7O7Bzo01
         NCnQUEkwsqCeVzV+DMdvvmK1S72G89Ctu0BqhjC8zgRdql9sJcyM6+bET0elgekoZMjN
         t2XQvq4beBbHA5m8/xeCAI1JI54+G0gqCGBfCL58QZ0gVMazfgwh+xNPrQewlJtO4lPQ
         dGJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8gVuDPG5fwBM/nVNmrluJ9T+yfN5fpI57qGEmjbyAn0=;
        b=as4skp+90+DeRCQ7DqTEgIJ/MwaDfxoo4zeiT94sZRspSIfN3jojr45jyAfgUzed8l
         KLqcdqTlpuVBIbcf3v+/2LFmDc25/RJMkjrbXon5BKL5JPPNwFSO1d0kug1+N22CDkgp
         V5e/Vob2yJhjat5f2rxzjKOiK/Ub5DWY3b1U6PytbS5oqapg/xybp6VxdAtxvZAz3mQY
         sAYHh0GZYgPrZxCZRNGGefciItEh4H79eQmYEX/i3YGbvFiSUFjZ1PzOFK6A4ydWQLuE
         XS1hobT3QGFro2diPKli1l3Ons00YAv3+bdR5KnuqRf2eHP8hef2VUaVkqe0LYEStjNL
         0tVQ==
X-Gm-Message-State: AOAM532HKh6F4PBCg6j0BkQ1GjLhBRmv/Z9PmwLdZ5EMF+nw+zVZ4OdZ
        54cC1GdBAyeQJgObwnKI9jAwGRcT
X-Google-Smtp-Source: ABdhPJxqey0YyD3v4qSoSxUAPrW5OYT2NYBcPmao4WckWPew5kgv+BQgWS1CDLvQCUqgUeCUuivaHA==
X-Received: by 2002:a05:6402:1457:: with SMTP id d23mr4324075edx.149.1597320171688;
        Thu, 13 Aug 2020 05:02:51 -0700 (PDT)
Received: from ltop.local ([2a02:a03f:a7fb:e200:9dbd:a64d:5aba:371b])
        by smtp.gmail.com with ESMTPSA id a26sm3756368eju.83.2020.08.13.05.02.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2020 05:02:50 -0700 (PDT)
Date:   Thu, 13 Aug 2020 14:02:49 +0200
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     kernel test robot <lkp@intel.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kbuild-all@lists.01.org,
        mingo@kernel.org, peterz@infradead.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, morten.rasmussen@arm.com,
        Quentin Perret <qperret@google.com>
Subject: Re: [PATCH v5 06/17] sched/debug: Output SD flag names rather than
 their values
Message-ID: <20200813120249.vdadn3nutkx3mq7y@ltop.local>
References: <20200812125300.11889-7-valentin.schneider@arm.com>
 <202008130025.XjiXqp1O%lkp@intel.com>
 <jhjpn7v66lf.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <jhjpn7v66lf.mognet@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 12, 2020 at 07:51:08PM +0100, Valentin Schneider wrote:
> On 12/08/20 17:35, kernel test robot wrote:
> 
> > config: i386-randconfig-s001-20200811 (attached as .config)
> > reproduce:
> >         # sparse version: v0.6.2-168-g9554805c-dirty
> >         make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' ARCH=i386
> >
> >>> kernel/sched/debug.c:279:17: sparse: sparse: non size-preserving pointer to integer cast
> >>> kernel/sched/debug.c:279:17: sparse: sparse: non size-preserving integer to pointer cast
> >
> >  > 279		tmp += *ppos;
> 
> I pretty much copied kernel/sysctl.c::_proc_do_string() and I think that's
> exactly the same types here: char* buffer incremented by loff_t offset. It
> does look fine to me, but I can't really parse that warning.

The warnings mean that there is a cast from a pointer to an integer with
a size other than the size of a pointer and the other way around.

I's indeed the case here, on i386, where pointers are 32-bit and loff_t
is 64-bit. But yes, I agree:
1) these messages are far from clear
2) these casts are internal and are probably not appropriate here.

I'll look later what can be done at sparse level.

Regards,
-- Luc
