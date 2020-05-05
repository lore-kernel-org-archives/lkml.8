Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01842C47254
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 13:38:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF2DC206A5
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 13:38:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FdPJ9PJ+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729145AbgEENia (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 09:38:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729060AbgEENi3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 09:38:29 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 760CAC061A0F
        for <linux-kernel@vger.kernel.org>; Tue,  5 May 2020 06:38:29 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id x15so901303pfa.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 May 2020 06:38:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=cIcX2UjQIgHRbs3TJz5WX3kPHVSR5+eVwL96c6ypyzA=;
        b=FdPJ9PJ+NLqy96PHwEMwTeTQqFBNY9623JasN3XKLZ14W7mVX4MCKMXtTiXt6PGzR0
         Ya9I8OjsiIhp/2XGRquqEyPoW/CJ+ebO/Lb6GOP5eC9CHo8homjvRj+RwBibiDhjt3i7
         dSKSb3PfeYceUIrvF7SwxbdJwjLkANC0Valms9kYitueY1U2SJ07YP0+xQSUbQZSHjPp
         +y3sXSDAJrZzwN80uyr/2O4XPYl80JgxeT9KGapro3fpclIALcdgZ3i4PEK19eq/X45/
         i7mvtDM6MVOnVTN1zdXLmcrFszJrUYw/Oi56tcOqTJaOcTR4umxR8/5Wryh2o53qTJcb
         WF7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=cIcX2UjQIgHRbs3TJz5WX3kPHVSR5+eVwL96c6ypyzA=;
        b=YEjNSFJAS+097K4QxctbIrxyknFYn4RlERL/nFAxd/jfPJkj7gxjBErPby5yfrtn2r
         vyiuZYz9SipGi+iKE2MhbBXeCSfQOTNR+a1V6V6omV06aqFt0FY4rsJHu2DJ2RmyAN6T
         ktmc3tHtw+4rjcOdmPiC+0piCOhJqWM7WrOkC0BUQjsIbyQpmmZVZPkezSwliqZDgLMC
         Tqf5IhALvE+TICd8/RJBydP8rcH9Fl7PbshczGFLK8oraD0xPUaRz/jPfY5ZcOjfMQWs
         jtuEcHuyopLv+LWTD4jW1gMOoribFl9kbBUofYFeJ03QLWyA1dZ8zpIjUraqjLXAwovB
         ESsg==
X-Gm-Message-State: AGi0PubpZNKIQr0QXzp1ZuXRs4MtQclYRP8ZWm0/5hlfDsO4kn46AAGe
        vzfQpx0creToWiK5jNISJdRSarXzSVc=
X-Google-Smtp-Source: APiQypIEgqHJzbOD5o403MmFxlsohwC1k5ltsD5xP4QL4800174jeJFzTanyAw6K8LdxOAQY8IUVbA==
X-Received: by 2002:a62:6dc3:: with SMTP id i186mr3026345pfc.273.1588685908981;
        Tue, 05 May 2020 06:38:28 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([2600:3c01::f03c:91ff:fe8a:bb03])
        by smtp.gmail.com with ESMTPSA id w30sm2136304pfj.25.2020.05.05.06.38.25
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 05 May 2020 06:38:28 -0700 (PDT)
Date:   Tue, 5 May 2020 21:38:28 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Thomas Backlund <tmb@mageia.org>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Mike Leach <mike.leach@linaro.org>,
        Suzuki Kuruppassery Poulose <suzuki.poulose@arm.com>
Subject: Re: perf build error with gcc 10 on arm and aarch64
Message-ID: <20200505133828.GC17996@leoy-ThinkPad-X240s>
References: <2869c4f6-9adf-3d55-a41d-a42865ae56f2@mageia.org>
 <EqtrWAkr-uZW90nfEH5i3KgHuQU8DLdDEXPSqRws1z9zrOixq2T0wt5uDhcFI5JVaIr_DGq7PP9Z-Q3B-LAaqQ==@protonmail.internalid>
 <d_gtAu9vE4vjOEgey1diEg23nPoDIv-gc4ranvkRDMtmWycFo1uU_YHcJn5BNlrNVJA1y2zVbUvE8_Lf44bKDg==@protonmail.conversationid>
 <20200505041050.GA8131@leoy-ThinkPad-X240s>
 <ed17a79e-81cd-8514-aaa7-13223bd1c789@mageia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ed17a79e-81cd-8514-aaa7-13223bd1c789@mageia.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 05, 2020 at 04:11:14PM +0300, Thomas Backlund wrote:
> Den 05-05-2020 kl. 07:10, skrev Leo Yan:
> > 
> > Hi Thomas,
> > 
> > [ + Mathieu/Mike/Suzuki ]
> > 
> > On Mon, May 04, 2020 at 10:22:27PM +0300, Thomas Backlund wrote:
> > > This is building perf from kernel-5.6.10 on armv7hl and aarch64:
> > > 
> > > Compiler is gcc 10.1.0-RC
> > > 
> > > 
> > >    LD       perf-in.o
> > > ld: arch/perf-in.o: in function `.LANCHOR0':
> > > /home/iurt/rpmbuild/BUILD/kernel-arm/linux-5.6/tools/perf/util/include/../../util/cs-etm.h:118:
> > > multiple definition of `traceid_list'; util/perf-in.o:/home/iurt/rpmbuild/BUILD/kernel-arm/linux-5.6/tools/perf/util/cs-etm.h:118:
> > > first defined here
> > > make[3]: *** [/home/iurt/rpmbuild/BUILD/kernel-arm/linux-5.6/tools/build/Makefile.build:145:
> > > perf-in.o] Error 1
> > > 
> > >    LD       perf-in.o
> > > ld: arch/perf-in.o:/home/iurt/rpmbuild/BUILD/kernel-aarch64/linux-5.6/tools/perf/util/include/../../util/cs-etm.h:118:
> > > multiple definition of `traceid_list'; util/perf-in.o:/home/iurt/rpmbuild/BUILD/kernel-aarch64/linux-5.6/tools/perf/util/cs-etm.h:118:
> > > first defined here
> > > make[3]: *** [/home/iurt/rpmbuild/BUILD/kernel-aarch64/linux-5.6/tools/build/Makefile.build:145:
> > > perf-in.o] Error 1
> > > make[2]: *** [Makefile.perf:616: perf-in.o] Error 2
> > > make[1]: *** [Makefile.perf:225: sub-make] Error 2
> > > make: *** [Makefile:70: all] Error 2
> > > 
> > > 
> > > The same build succeeds with gcc 9.3.0
> > 
> > Thanks for reporting the issue.
> > 
> > Could you help confirm if below change can resolve this issue?
> 
> Yes,
> 
> fix confirmed on i586, x86_64, armv7hl and aarch64 builds
> 
> so I guess you can add:
> 
> Reported-by: Thomas Backlund <tmb@mageia.org>
> Tested-by: Thomas Backlund <tmb@mageia.org>

Thanks, Thomas!  Have sent formal patch with your and Mike's tags.

Leo
