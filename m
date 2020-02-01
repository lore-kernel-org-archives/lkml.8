Return-Path: <SRS0=DSTS=3V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8FEAC33CB3
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Feb 2020 16:40:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B4DD205F4
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Feb 2020 16:40:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jsFiPNcF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726837AbgBAQkh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Feb 2020 11:40:37 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:55994 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726669AbgBAQkh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Feb 2020 11:40:37 -0500
Received: by mail-pj1-f65.google.com with SMTP id d5so4330774pjz.5
        for <linux-kernel@vger.kernel.org>; Sat, 01 Feb 2020 08:40:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=QwZ3CLPSOKerZ4q2cB/Hi0ai1yGFzd/B3udh3ZqTtuM=;
        b=jsFiPNcF+Kv+AD+cCoimAjdmxdXVfz+jklLjuWAodKYGoYYpsmGFXd7lewm9b+k+0a
         YxyMuZnoFgQBJJT4fvhBfbLaQinvoO/ovQPcFEXi5AGzl5olCx5gYZ4Eq7/UZCm/eIOr
         OQ9onHvvIcrtHkP4clI72kPgvkSCx4wYKUuIw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QwZ3CLPSOKerZ4q2cB/Hi0ai1yGFzd/B3udh3ZqTtuM=;
        b=THn6JMzf2vpmkYdnL38X22+In4r7Y6sMGsXwofZzbK2S/FmGrEHUJsjUyHP+aIja+8
         o1YxaEji0NIkw1BHhUykvv1I0OJg1c1Jipr+S7dZK1wYsehs32KAHtsSYFCWtlHoC8NM
         V6wBjb7UdvBDt4SrttYBPWkB37378qnhxZAygFcnOa1X3BJwoXHjXVWTRaaGQtGGISwx
         asN8AHvzjJxACmH0px28gZhmfzPD19h1oKdCk+0Gd2nCMCiDoX32chHqLmvmu2uOEg6y
         oTbFbf9L0O8dw7QAEfLOh6jbocxIhRP9T21NKmTCZdGOCH56Si4//b6IHLcYnIJtP0LS
         NB1A==
X-Gm-Message-State: APjAAAUoG+XUgVlgWEQmYv16NUWEknHHooYLooW3EIQUsloGKT44mqlr
        UC8O+KmUmvLONCn43Y1bJpw52A==
X-Google-Smtp-Source: APXvYqxXMppfrfTklyz+pwg0P3CdY6ihdgY9Vslz5MfHbndtzF8KzUGwo01U+1jLgg/AvUUKozH1GA==
X-Received: by 2002:a17:902:d20f:: with SMTP id t15mr16360800ply.55.1580575236433;
        Sat, 01 Feb 2020 08:40:36 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id dw10sm14222430pjb.11.2020.02.01.08.40.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Feb 2020 08:40:35 -0800 (PST)
Date:   Sat, 1 Feb 2020 08:40:34 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Russell Currey <ruscur@russell.cc>
Cc:     Christophe Leroy <christophe.leroy@c-s.fr>, mpe@ellerman.id.au,
        linux-kernel@vger.kernel.org, dja@axtens.net,
        kernel-hardening@lists.openwall.com, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] lkdtm: Test KUAP directional user access unlocks on
 powerpc
Message-ID: <202002010836.76B19684@keescook>
References: <20200131053157.22463-1-ruscur@russell.cc>
 <1b40cea6-0675-731a-58b1-bdc65f1e495e@c-s.fr>
 <0b016861756cbe27e66651b5c21229a06558cb57.camel@russell.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0b016861756cbe27e66651b5c21229a06558cb57.camel@russell.cc>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 31, 2020 at 05:53:14PM +1100, Russell Currey wrote:
> Correct, the ACCESS_USERSPACE test does the same thing.  Splitting this
> into separate R and W tests makes sense, even if it is unlikely that
> one would be broken without the other.

That would be my preference too -- the reason it wasn't separated before
was because it was one big toggle before. I just had both directions in
the test out of a desire for completeness.

Splitting into WRITE_USERSPACE and READ_USERSPACE seems good. Though if
you want to test functionality (read while only write disabled), then
I'm not sure what that should look like. Does the new
user_access_begin() API provide a way to query existing state? I'll go
read the series...

-- 
Kees Cook
