Return-Path: <SRS0=dnKw=BT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 115B0C433E0
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Aug 2020 00:50:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E37E2206D8
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Aug 2020 00:50:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PSl8Nmud"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726299AbgHIAuk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Aug 2020 20:50:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726040AbgHIAui (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Aug 2020 20:50:38 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA078C061756;
        Sat,  8 Aug 2020 17:50:38 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id o1so3026317plk.1;
        Sat, 08 Aug 2020 17:50:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=SVQj5qhpcJx5458dmkItx649M+rUsyKRr5ejPEPf2ho=;
        b=PSl8Nmud+Sra0Xk4u5STYo1NqhZ/j+tsWDTn7GrRronYe8lyE+LgFhvGzRNkE+HAXi
         GqY43arY2XRK0faJjuEsUPsdDp20uIPDLt2DLOVF+FxJvG/QcLWEV7jHvWAwSN8lF9zX
         TxA1h3WdGnoKoF7URjaKgf9oT4DB91MYy0N6qbSalfLLnl1zKuZcT8IQdipOM69FQ7wF
         uNmNLsRFPonT5r334TjqAzs+8QV7Xzbk276vJfOQjpVi6hSGaojbDwdpr6I9zsoZscgO
         Cj23E4fx90bnHUs+pJo70NQzdKAa0C5oZgfE10sxPq/aA6uAQVdWKyhgL6ejb6aJk/Aj
         wqug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=SVQj5qhpcJx5458dmkItx649M+rUsyKRr5ejPEPf2ho=;
        b=EpPJKGU226rXAl4AESkv9ia1x/G/9X/KNs494zJ0O4VxuAHuRRvhX2msOrPezCS2KE
         xYr60Fk3fb6cmHzRbY1KCn6jSQe0u4Rayd4D5uWDetZkpYoGgYGUacZiqOTCuhV0HkHx
         sCAh/zPcQRIRSFueYVrNf++0/bYbe07hyw6xqfcdbgpByN2sirFSUOTT2dF2c1A9cNUp
         hq9OUgdUmiNhFvBGRF8h7g0rUrJiN4I21DUA1CDf3DIoklLD1CIVPpdxQkX0U5yg5RgQ
         MU9hAWfx1pwQpbhLa6+LHsaD1LsAbHCH8MmTZ/aqPnL1xt7ve9IfYBSsDptgJaRoueM+
         UnwQ==
X-Gm-Message-State: AOAM532fBjnMQm4g3Vcfg/SkOWWdgcvpOVEFdeTd6T9k/0gxfmE2FM/n
        Z52wfGIEcnVofM2po37VI4s=
X-Google-Smtp-Source: ABdhPJyFfwJNnjRgRxDEZD1e5kwxl/o2VNsVzpa5hsTY/5+0SOqV+L8X/arc3UPGWcChoXnYlCcVMA==
X-Received: by 2002:a17:902:c154:: with SMTP id 20mr19264971plj.64.1596934238002;
        Sat, 08 Aug 2020 17:50:38 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id x18sm17161588pfc.93.2020.08.08.17.50.37
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 08 Aug 2020 17:50:37 -0700 (PDT)
Date:   Sat, 8 Aug 2020 17:50:36 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alan Maguire <alan.maguire@oracle.com>
Subject: Re: linux-next: build failure after merge of the thunderbolt tree
Message-ID: <20200809005036.GA100652@roeck-us.net>
References: <20200630160346.696f6419@canb.auug.org.au>
 <20200630113302.GN5180@lahna.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200630113302.GN5180@lahna.fi.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 30, 2020 at 02:33:02PM +0300, Mika Westerberg wrote:
> On Tue, Jun 30, 2020 at 04:03:46PM +1000, Stephen Rothwell wrote:
> > Hi all,
> > 
> > After merging the thunderbolt tree, today's linux-next build (powerpc
> > allyesconfig) failed like this:
> > 
> > 
> > Caused by commit
> > 
> >   54509f5005ca ("thunderbolt: Add KUnit tests for path walking")
> > 
> > interacting with commit
> > 
> >   d4cdd146d0db ("kunit: generalize kunit_resource API beyond allocated resources")
> > 
> > from the kunit-next tree.
> 
> Thanks for reporting and fixing. The fix looks good to me.

Unfortunately, the fix didn't make it into mainline.

Building x86_64:allyesconfig ... failed
--------------
Error log:
drivers/thunderbolt/test.c: In function '__ida_init':
drivers/thunderbolt/test.c:20:5: error: 'struct kunit_resource' has no member named 'allocation'
   20 |  res->allocation = ida;
      |     ^~
drivers/thunderbolt/test.c: In function '__ida_destroy':
drivers/thunderbolt/test.c:26:23: error: 'struct kunit_resource' has no member named 'allocation'
   26 |  struct ida *ida = res->allocation;
      |                       ^~
make[3]: *** [drivers/thunderbolt/test.o] Error 1

Guenter
