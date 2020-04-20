Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A982CC3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 12:05:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 846F3206DD
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 12:05:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TRHLRU+2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726562AbgDTMFs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 08:05:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726387AbgDTMFq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 08:05:46 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12723C061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 05:05:45 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id c63so10195220qke.2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 05:05:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=3A+0nM8hNKafzGk6IKdKwOoK9jYn43r9XcaFv8KjCXA=;
        b=TRHLRU+27dFKXFhXzfUS259L0ChAhkzDhEZZXrPDLaSTDu2ILRUTA3vJDqnPkWdxLI
         HJhFPUj90UuGRoySLRuJKG5NIxjiWJKfzboGeoYo2oau0X6f5lXYdGHya7jsTp3msAo+
         tHf3J/jXvUNI+/keatWH00TevxAN4eIE9WZcgeLOuJX/hqCrSiufhcqp9vU3SvXNQWsc
         RurUe+3Kamwui9w89QF/Qut8Lwipk+Tuw95TkBwRVfP27Z3EwW3Ix5LlOa1oEpgBSTxN
         yMrXs8hsnpEAgbmqfrGMa4N11BIp9HYUBh/W93swL3H+a+8ZsKMD/9ViaqdA7Rqlidm5
         Fdxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3A+0nM8hNKafzGk6IKdKwOoK9jYn43r9XcaFv8KjCXA=;
        b=TcnF2PPgVuIVueCVKBjXYRtNpkvAN377mh7FkuNPRAxuzzYpJpIDovYtRqQRY6kpqY
         Q5kmsifheM8KZIIfdx9eUaVpm0Q1+lLP3XnmNZ7/3baABtSyLX/uDb8NyFuGoB4OGDxS
         zyS/VQwVi51sJu4tXkHXgY19Z4XxTN0Na1ucQjUn/njq3+cRgu2BPVNbb6BnlEHnx6Bj
         EHZCrUqdN2IQMGvsjB0YewjWEvY6zRQUiBKsWzPYwZ/DfdpRb2FktGE4ZxZvWw8siOW7
         kITYo8EuHo0sBpU9uxhKItCMCEWVmGrjKiiJPklim5A9Ofyxtw9QPOqFPCAaWDkN5+st
         RNmw==
X-Gm-Message-State: AGi0PubKtYIlFsaMgt0ieErd5ArmoRQtpzQWZHm+GNAxhyr4QDUQYzIY
        mqlJ5sujO437KTlLk7pf0e4=
X-Google-Smtp-Source: APiQypJ5UncJYBm3/6vdGxWIv7d+8JWyS0KPcmivPCH/nHuwusTkaoLLRFx4w1Wpxt/Yi4BAzWRHsQ==
X-Received: by 2002:a37:9f4a:: with SMTP id i71mr15546268qke.132.1587384344271;
        Mon, 20 Apr 2020 05:05:44 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.37.151])
        by smtp.gmail.com with ESMTPSA id h25sm337529qto.87.2020.04.20.05.05.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2020 05:05:43 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id C9921409A3; Mon, 20 Apr 2020 09:05:40 -0300 (-03)
Date:   Mon, 20 Apr 2020 09:05:40 -0300
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Tommi Rantala <tommi.t.rantala@nokia.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] perf cgroup: Avoid needless closing of unopened fd
Message-ID: <20200420120540.GB14597@kernel.org>
References: <20200417132330.119407-1-tommi.t.rantala@nokia.com>
 <20200420084847.GC718574@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200420084847.GC718574@krava>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Apr 20, 2020 at 10:48:47AM +0200, Jiri Olsa escreveu:
> On Fri, Apr 17, 2020 at 04:23:26PM +0300, Tommi Rantala wrote:
> > Do not bother with close() if fd is not valid, just to silence valgrind:
> > 
> >     $ valgrind ./perf script
> >     ==59169== Memcheck, a memory error detector
> >     ==59169== Copyright (C) 2002-2017, and GNU GPL'd, by Julian Seward et al.
> >     ==59169== Using Valgrind-3.14.0 and LibVEX; rerun with -h for copyright info
> >     ==59169== Command: ./perf script
> >     ==59169==
> >     ==59169== Warning: invalid file descriptor -1 in syscall close()
> >     ==59169== Warning: invalid file descriptor -1 in syscall close()
> >     ==59169== Warning: invalid file descriptor -1 in syscall close()
> >     ==59169== Warning: invalid file descriptor -1 in syscall close()
> >     ==59169== Warning: invalid file descriptor -1 in syscall close()
> >     ==59169== Warning: invalid file descriptor -1 in syscall close()
> >     ==59169== Warning: invalid file descriptor -1 in syscall close()
> >     ==59169== Warning: invalid file descriptor -1 in syscall close()
> > 
> > Signed-off-by: Tommi Rantala <tommi.t.rantala@nokia.com>
> 
> Acked-by: Jiri Olsa <jolsa@redhat.com>

Thanks, applied,

- Arnaldo
