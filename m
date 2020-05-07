Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34B04C38A24
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 14:14:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 126A62075E
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 14:14:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ID4stJ++"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727889AbgEGOO6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 10:14:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726320AbgEGOO5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 10:14:57 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CCB7C05BD43
        for <linux-kernel@vger.kernel.org>; Thu,  7 May 2020 07:14:57 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id l18so6586603wrn.6
        for <linux-kernel@vger.kernel.org>; Thu, 07 May 2020 07:14:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=5931JdBVqJww8AlSoc9F9FLcx5x8sQNSCU+GdSA9qtk=;
        b=ID4stJ++ymQe2D4Afi9BiGxUGCWV7OtTKyWhzRPG4Vgawh4yn009KaQV7R6QlQR0Pi
         1pxQ4UjH1F9fN9/W6rlx2/qg2gpH0z3CJ6TrcsTEU7oOrAxRF0T8sIaYY/cxmwu7X7aJ
         lrOt5RIEIs3hNsmuq+eeMS5ArHjIkwhRVcQyVNCFSQli2gJaPMH1mVLeZp7villOB+pe
         3dSmZAyLi39OqjMNw3t+nd1DVNokngFQxSfulJcya0Fax3tjRglj5zP5ggTmbRW7GCME
         OODFUt3mRTZKk++uN8wZeGWkqw/QDzBYmKQFgALrqOFJFVUuIGzmxUy4J7YErNRWJgt9
         aoiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5931JdBVqJww8AlSoc9F9FLcx5x8sQNSCU+GdSA9qtk=;
        b=NkEtgMI2duiW1f2LG60oFqHf/aTj7BH37E+7YPx1ODQ1G//ns2Ng2wLbbAXs96nIs7
         oEFhmUMUp2giwWC3Jg2zXIWZdzcf4YAMdk9t0OkKh8J88+DlLNclQ/49erBJkaIGQ7wa
         ioWFH9e/Zy5Sv5KNaMbxGVS1028i8oTah+Ue6sqx56p0NN9Vq7daXqETXym8fCytEjiR
         dqIHEJdCMze/KMWcOhOb/G7KV1L0eSflA5tHPeuY1iGAhbp4eYElGTJUFKO+79CGiCQD
         8Rjd5P3oQBqp8EEfspGkp39xAGCKlWU+MHCWRmyv48bOBlPDdksAx/NCAla7zyjwUqoW
         u43A==
X-Gm-Message-State: AGi0PubzUILn4SjG+gT5vIb20rJBHS3EmdytvYQnfSK9OVt59QWoHMEf
        a0+VDxcrS6nT8U+Vofdo9y8K4g==
X-Google-Smtp-Source: APiQypJ7NraBcRVZ1UAKnnYq5tZYvr2Hjw7sIJB2ILe5XmowAlEZFKbJXC8o4uuOwUTiILXHN5c4zg==
X-Received: by 2002:adf:fc92:: with SMTP id g18mr16180703wrr.10.1588860896184;
        Thu, 07 May 2020 07:14:56 -0700 (PDT)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id s8sm8113850wrt.69.2020.05.07.07.14.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2020 07:14:55 -0700 (PDT)
Date:   Thu, 7 May 2020 15:14:53 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Will Deacon <will@kernel.org>
Cc:     Jason Wessel <jason.wessel@windriver.com>,
        Douglas Anderson <dianders@chromium.org>,
        kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        patches@linaro.org
Subject: Re: [PATCH] kgdb: Fix spurious true from in_dbg_master()
Message-ID: <20200507141453.wjcq4hjfwv3pppex@holly.lan>
References: <20200506164223.2875760-1-daniel.thompson@linaro.org>
 <20200507083929.GC28215@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200507083929.GC28215@willie-the-truck>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 07, 2020 at 09:39:30AM +0100, Will Deacon wrote:
> On Wed, May 06, 2020 at 05:42:23PM +0100, Daniel Thompson wrote:
> > Currently there is a small window where a badly timed migration could
> > cause in_dbg_master() to spuriously return true. Specifically if we
> > migrate to a new core after reading the processor id and the previous
> > core takes a breakpoint then we will evaluate true if we read
> > kgdb_active before we get the IPI to bring us to halt.
> > 
> > Fix this by checking irqs_disabled() first. Interrupts are always
> > disabled when we are executing the kgdb trap so this is an acceptable
> > prerequisite. This also allows us to replace raw_smp_processor_id()
> > with smp_processor_id() since the short circuit logic will prevent
> > warnings from PREEMPT_DEBUG.
> > 
> > Fixes: dcc7871128e9 ("kgdb: core changes to support kdb")
> > Suggested-by: Will Deacon <will@kernel.org>
> > Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
> > ---
> >  include/linux/kgdb.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/include/linux/kgdb.h b/include/linux/kgdb.h
> > index b072aeb1fd78..4d6fe87fd38f 100644
> > --- a/include/linux/kgdb.h
> > +++ b/include/linux/kgdb.h
> > @@ -323,7 +323,7 @@ extern void gdbstub_exit(int status);
> >  extern int			kgdb_single_step;
> >  extern atomic_t			kgdb_active;
> >  #define in_dbg_master() \
> > -	(raw_smp_processor_id() == atomic_read(&kgdb_active))
> > +	(irqs_disabled() && (smp_processor_id() == atomic_read(&kgdb_active)))
> >  extern bool dbg_is_early;
> >  extern void __init dbg_late_init(void);
> >  extern void kgdb_panic(const char *msg);
> 
> Cheers, Daniel. I assume you'll route this one via the kgdb tree? I can
> live with the "small window" in the arm64 for-next/core branch ;)

Yes. I'll get this one applied very soon (thanks for Doug for the quick
review).


Daniel.
