Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9953EC4724C
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 19:57:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B61320731
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 19:57:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=massaru-org.20150623.gappssmtp.com header.i=@massaru-org.20150623.gappssmtp.com header.b="XqTNUK6O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726931AbgD3T5a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 15:57:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726366AbgD3T53 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 15:57:29 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52402C035494
        for <linux-kernel@vger.kernel.org>; Thu, 30 Apr 2020 12:57:29 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id 71so6111003qtc.12
        for <linux-kernel@vger.kernel.org>; Thu, 30 Apr 2020 12:57:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=massaru-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=LQzvuTiDzxPg8UH93cWpbzSYrqHmgu+qFCbwAwEqzrw=;
        b=XqTNUK6OjR2wnrjL1ekQ59FruO/L9hC7avESb1TAex4GM8KYVyffZ4+yeO3rgDBoUD
         2JM7qmOtjmkqyIbqGgDTxKdj5aKTTJrwcU2x+hGF68kCCaX1o+7t6EjfKZLsbCSKeyi/
         dQ37o9HIVVPZfBhMBhSOAOf3H+zo6qz7bd/Bkc8SWtEUNLvc8F8e6AQAX5CaQouOqCU+
         W1at4ORGUGKKdS6YPURLv15trAp09e+ejrSOJV3YzgCUzRS0zVOUOGVjXAk1yqsJ5q8O
         8OAtOt19hNTrv9zqMmpE7gQlUN9IC7CQpFeBjFDh661QROIIOSonPON3ipKsxtySNr/F
         2IQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=LQzvuTiDzxPg8UH93cWpbzSYrqHmgu+qFCbwAwEqzrw=;
        b=WGg86HG5GX3t/flRFzzLhPuCCJcySR6M38sr9/C2yAx58+4z1xta3d15nKg/+bJZFq
         PqySUa6RdbLuxdXfp2W2rkI5JB3VN0FYQG4g0RQsXo6cTt5N5e5SMAStjlbI291W/vjK
         7Nqjv+/Iowo7itEWJKL7htidQi8EK6HLd+g8QHbX6OehHL4oF20JoqP4Gg02QxAZiHfZ
         obtnmApKvM7Q9g7ox+FKxtaVRWcgmGCv9DcQgHjvhBShYQXufzNc76iY5wIOzG0s+GiB
         LxXpCH/7DzmhObY15zIfkk6G56jCohbh/dasvpXTyY29XmFfCx7U8uet1DuJrtlsYFbI
         vpdA==
X-Gm-Message-State: AGi0PuZ0/9la5J/SRdgG/pzFUQYf8VN4oizY8SKhrfNpQA4L1ZKxoTVa
        o51dxO4I2gEkVJMLcDSt2B+quA==
X-Google-Smtp-Source: APiQypLeHtVRo31TWgHmb+0zDjdx4VCsPKzmGa+gDrrI/ELs5FpHmKX0AdnqBHMTMiWGBPap150b5Q==
X-Received: by 2002:ac8:470e:: with SMTP id f14mr151315qtp.87.1588276648462;
        Thu, 30 Apr 2020 12:57:28 -0700 (PDT)
Received: from bbking.lan ([2804:14c:4a5:36c::cd2])
        by smtp.gmail.com with ESMTPSA id b19sm861386qkg.72.2020.04.30.12.57.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2020 12:57:28 -0700 (PDT)
Message-ID: <07d33cf9937c89519bafc9210a98dab42579e681.camel@massaru.org>
Subject: Re: [PATCH] docs: filesystems: fix `make htmldocs` warning
From:   Vitor Massaru Iha <vitor@massaru.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org, hubcap@omnibond.com,
        martin@omnibond.com, devel@lists.orangefs.org,
        linux-kernel@vger.kernel.org, brendanhiggins@google.com,
        skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Date:   Thu, 30 Apr 2020 16:57:24 -0300
In-Reply-To: <20200430134704.236c612b@lwn.net>
References: <20200430190737.80950-1-vitor@massaru.org>
         <20200430134704.236c612b@lwn.net>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jon,

On Thu, 2020-04-30 at 13:47 -0600, Jonathan Corbet wrote:
> On Thu, 30 Apr 2020 16:07:37 -0300
> Vitor Massaru Iha <vitor@massaru.org> wrote:
> 
> > make htmldocs
> > Documentation/filesystems/orangefs.rst:124: WARNING: Literal block
> > expected; none found.
> > 
> > Signed-off-by: Vitor Massaru Iha <vitor@massaru.org>
> > ---
> >  Documentation/filesystems/orangefs.rst | 4 +---
> >  1 file changed, 1 insertion(+), 3 deletions(-)
> > 
> > diff --git a/Documentation/filesystems/orangefs.rst
> > b/Documentation/filesystems/orangefs.rst
> > index e41369709c5b..628dc220567e 100644
> > --- a/Documentation/filesystems/orangefs.rst
> > +++ b/Documentation/filesystems/orangefs.rst
> > @@ -119,9 +119,7 @@ it comes to that question::
> >  
> >      /opt/ofs/bin/pvfs2-genconfig /etc/pvfs2.conf
> >  
> > -Create an /etc/pvfs2tab file::
> > -
> > -Localhost is fine for your pvfs2tab file:
> > +Create an /etc/pvfs2tab file. Localhost is fine for your pvfs2tab
> > file::
> >  
> >      echo tcp://localhost:3334/orangefs /pvfsmnt pvfs2
> > defaults,noauto 0 0 > \
> >  	/etc/pvfs2tab
> 
> Thanks, but this has already been fixed in docs-next.

Sorry about that. I searched but I didn't find the documentation tree.
Could you point me to the git url?

Thanks,
Vitor

