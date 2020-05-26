Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AA81C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 23:41:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C03C2084C
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 23:41:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=massaru-org.20150623.gappssmtp.com header.i=@massaru-org.20150623.gappssmtp.com header.b="CCE+sc2P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726440AbgEZXl6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 19:41:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726326AbgEZXl5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 19:41:57 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C59DC061A0F
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 16:41:57 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id c185so8538495qke.7
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 16:41:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=massaru-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=hXQqv/v9vEVYiQfhG65G3PbZzCVHsVLEfF5BwtCgffQ=;
        b=CCE+sc2PHzbrIdaja5D95876TdFmtlvMwrZdxapWFx+gcP/UjUcuZDtdW6X4Awh3gM
         iDH0DKaGQmql1ZEmlKdncgkvW68rzQ1bPsMyzzYKfBbgD2zPwIQWVtCvqAXtDs+FJPdA
         r23b/rRw7qmQYzX/W2pp1jT6jlCz+DkheqodVzvs9yq4YBSeULxIaqAH29A5PDJ4xkVZ
         teWED5H5O9Tvd8vecCa1b+szTWTEh4M8rktKSOgtu3BBMsvpexasFyyOkCrs/idNOsa2
         q1Z/MiBe7s4wdzL/XOmY8r6qC23mZzD1FtqZgxFcATDrNDni5s2h85YRRP5drFYU+FQf
         SRdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=hXQqv/v9vEVYiQfhG65G3PbZzCVHsVLEfF5BwtCgffQ=;
        b=Xf27lEurxSqpFuK74JAxSILIWkMls+ExoKq5AJwFwVi1dOngpE9oQGPZ+9vvOUJNj5
         DAJQYrSTb+vFowtIYNv7Jx/ZsLkdZkXSsnjbpc+OWqxR1vw8I17oYNoTkkBZputmVsQ8
         qy2Oe/Iz7a8IXruyfjlbex4KDL5jx9WPcWpbDywkurMXZ3cZ5MP48askdF/8HYJyfICD
         H963M+wZo2AGfMdV+nwKyzAijOb7Cz5LZ0KSOECNcFtQkxKrLtl+Mjgy+WpQf7r9aWKb
         slxMM5DqwY+JZOTHdv5RVB+j4Mtq3oRatMmELISk9b1pDOGBrhY17wL4LEGSmjCwfRQW
         uFzg==
X-Gm-Message-State: AOAM5300Hu1oAhkCmkxUMAObbLUfozJeVORrESLopOXcWkLz1JXDAB7u
        7KWGFXi5Q0TC6g1pLbJ1v9y67w==
X-Google-Smtp-Source: ABdhPJyE14ZUR04SAQDVd8MHMq53V+KJw3CgOd4MvBhRY9xxbeFMhUtX1Xb318fAiIuunVXvHq0vMQ==
X-Received: by 2002:a37:8302:: with SMTP id f2mr1397002qkd.220.1590536516733;
        Tue, 26 May 2020 16:41:56 -0700 (PDT)
Received: from bbking.lan ([2804:14c:4a5:36c::cd2])
        by smtp.gmail.com with ESMTPSA id k43sm1150727qtk.67.2020.05.26.16.41.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2020 16:41:56 -0700 (PDT)
Message-ID: <adc28ceff89a7fffb8b6af4badc850b29b9e6207.camel@massaru.org>
Subject: Re: [fixup] kunit: use --build_dir=.kunit as default
From:   Vitor Massaru Iha <vitor@massaru.org>
To:     Shuah Khan <skhan@linuxfoundation.org>, kunit-dev@googlegroups.com
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        brendanhiggins@google.com,
        linux-kernel-mentees@lists.linuxfoundation.org
Date:   Tue, 26 May 2020 20:41:53 -0300
In-Reply-To: <ace26347-a78e-1bd1-86f5-f8e644aa93ec@linuxfoundation.org>
References: <20200526183436.47026-1-vitor@massaru.org>
         <ace26347-a78e-1bd1-86f5-f8e644aa93ec@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.2 (3.36.2-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2020-05-26 at 16:29 -0600, Shuah Khan wrote:
> On 5/26/20 12:34 PM, Vitor Massaru Iha wrote:
> > To make KUnit easier to use, and to avoid overwriting object and
> > .config files, the default KUnit build directory is set to .kunit
> > 
> >   * Related bug: https://bugzilla.kernel.org/show_bug.cgi?id=205221
> > 
> > Fixed up minor merge conflicts - Shuah Khan <
> > skhan@linuxfoundation.org>
> > 
> > Signed-off-by: Vitor Massaru Iha <vitor@massaru.org>
> > Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
> > Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
> > ---
> > version after merge on kunit brach:
> >   * fix identation (tabs instead of spaces)
> 
> You mentioned spaces breaking python. Please include the python
> errors and make it clear in the change log what is fixes.

Of course, I will add this.
> 
> thanks,
> -- Shuah
> 

