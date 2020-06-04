Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11DBCC433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 17:57:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E557820738
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 17:57:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="V4z9JKfd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730376AbgFDR5P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 13:57:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730008AbgFDR5N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 13:57:13 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23EC4C08C5C0
        for <linux-kernel@vger.kernel.org>; Thu,  4 Jun 2020 10:57:13 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id t16so2486929plo.7
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jun 2020 10:57:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=V76SN9ULYTXcj2nfE4XluNWJ/apYyE25p/aMUS5j4DU=;
        b=V4z9JKfdEWs9MDeS/EPBuIqMb1/3Id2oYdNI6PRplwSaLTUpCWcNBTKmcMdU9XPQLz
         VZPPPCjrTJm2TNz6/jfXB7ZbPyocg07b7HSOMxqFd4NKlQmzWIKUqhCYUuvGNWGlvi12
         fKhvas9WXyTTn5rzMJzhq4H482u029HNUa5t0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=V76SN9ULYTXcj2nfE4XluNWJ/apYyE25p/aMUS5j4DU=;
        b=dqUFqfKRlMJvnCy2cpkPzvn4D+3e3514YTRPm1DppRaGitNmnHKfF6TZXT3qcuPYeF
         3zW5OmoplvlfvXKDOCuWtvXvwHIOyNTXlYmLmt7znSw7w8Mbh3Kiusj3oQ+gqCnOM27l
         7sFNj9jcdSiBEA7jyWEdySDN5jVTLP4kLD8ydp5G83AE4/ULOOypmar9YXwyM/s48mJv
         qwLQARHGXB+seq0Xwn07XVyL2zOwUD3dpo6kdD3bsDbqzkHGExArcRT00Rc71mQoKy4P
         ne4tjZY8KkWAnTpe5GvzG6J4dCUhi6y1KUecGbSA95nSs2LJTxWW0Z/x5yB0dsZKS755
         Xa0g==
X-Gm-Message-State: AOAM533p9poKfCV4oefum93/mHxSQ6tgqWx60k+KVAIGDbGaeOKaG6FZ
        QIPNQIDa8UYaTZ/613gFyauCbA==
X-Google-Smtp-Source: ABdhPJyO8qGrlBRmUktz1P+Kkq0V7ss4Vc6dU/2Mx+l6qK8PjAByRudw9CWP/5XjkhsROEMzxXc8Sg==
X-Received: by 2002:a17:90a:5d14:: with SMTP id s20mr7784264pji.9.1591293427831;
        Thu, 04 Jun 2020 10:57:07 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id y18sm3281756pfn.177.2020.06.04.10.57.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2020 10:57:07 -0700 (PDT)
Date:   Thu, 4 Jun 2020 10:57:05 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Vegard Nossum <vegard.nossum@oracle.com>
Cc:     Vlastimil Babka <vbabka@suse.cz>, Christoph Lameter <cl@linux.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Marco Elver <elver@google.com>,
        Waiman Long <longman@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>
Subject: Re: slub freelist issue / BUG: unable to handle page fault for
 address: 000000003ffe0018
Message-ID: <202006041054.874AA564@keescook>
References: <4dc93ff8-f86e-f4c9-ebeb-6d3153a78d03@oracle.com>
 <7839183d-1c0b-da02-73a2-bf5e1e8b02b9@suse.cz>
 <94296941-1073-913c-2adb-bf2e41be9f0f@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <94296941-1073-913c-2adb-bf2e41be9f0f@oracle.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 04, 2020 at 07:20:18PM +0200, Vegard Nossum wrote:
> On 2020-06-04 19:18, Vlastimil Babka wrote:
> > On 6/4/20 7:14 PM, Vegard Nossum wrote:
> > > 
> > > Hi all,
> > > 
> > > I ran into a boot problem with latest linus/master
> > > (6929f71e46bdddbf1c4d67c2728648176c67c555) that manifests like this:
> > 
> > Hi, what's the .config you use?
> 
> Pretty much x86_64 defconfig minus a few options (PCI, USB, ...)

Oh yes indeed. I immediately crash in the same way with this config. I'll
start digging...

(defconfig finishes boot)

-Kees

-- 
Kees Cook
