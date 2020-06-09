Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2505FC433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 16:18:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE88820760
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 16:18:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Wt0DGBGI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727787AbgFIQSw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 12:18:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725894AbgFIQSv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 12:18:51 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 197C2C03E97C
        for <linux-kernel@vger.kernel.org>; Tue,  9 Jun 2020 09:18:50 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id bh7so8217798plb.11
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jun 2020 09:18:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ztrSjb9Hc0jDPbsrcCP9Go/9i0R+UcDFFdl7eZx/r6Q=;
        b=Wt0DGBGICEfKEaimVAhmarg/KGSjFyRO5TzqXO6XNLncSbl4O/fYj7iUOCtswpKzN+
         HevAzRySRopFcCSeXweK5e1PBXobSPbw5nH2EJMegFAuKaGoY8E1mOIVxh2aev2COv0t
         kmR/gG4ejJZ4/WNjHaoSiU7wu9Cj80+IT+LS4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ztrSjb9Hc0jDPbsrcCP9Go/9i0R+UcDFFdl7eZx/r6Q=;
        b=EtuvJvP5ZpNjdeoR8HoyfBnpb2DVY7C/Lz5bt6H7Uhd4oixT4AHhZ4IpCyAvL7kear
         iplHXwlg2Drj8mP8ar2RYDLlqKPWeLTa5EXxolm/R9jFUvdBqe5sjUHp7WCG5wfL5iqQ
         o85vz6Knb4dgdcg/vjiJXu9zEdB1kNn99IBoD5l+xWqqiMhkFO8aHrr9LO0erwI1hCjN
         AcIWaEQE+C2fXtCUq2+I3UlN1fB3hhU8Zqjw1nddvNoLNBpkDBM9UI3tIvH4EDal22iM
         Ot12YqbmOtXMyzBKyWTy5HJdYMLLFImXhLPyMZaGw+zBrfzm/rtsYM7BexHB7785eOEW
         4Nvw==
X-Gm-Message-State: AOAM531VcQ5PoEYVP6niM0WdWaF3BBV6ikTqreiKIdMv3+H6yGzgqvvS
        0hwkYlFpvOxPPJ6Fs29o1Pww/g==
X-Google-Smtp-Source: ABdhPJzjmSmb72TVgOWLhqsjL+dd4r5fyjx7ZveMTCvaUG5Lp8LN8tzhQDJ3aYIZ5V3XnrmyX+A/dg==
X-Received: by 2002:a17:902:aa92:: with SMTP id d18mr4086799plr.127.1591719530249;
        Tue, 09 Jun 2020 09:18:50 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id h3sm3136722pje.28.2020.06.09.09.18.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2020 09:18:49 -0700 (PDT)
Date:   Tue, 9 Jun 2020 09:18:48 -0700
From:   Kees Cook <keescook@chromium.org>
To:     David Howells <dhowells@redhat.com>
Cc:     linux-afs@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/6] afs: Fix debugging statements with %px to be %p
Message-ID: <202006090918.58395776C@keescook>
References: <159171918506.3038039.10915051218779105094.stgit@warthog.procyon.org.uk>
 <159171921360.3038039.10494245358653942664.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <159171921360.3038039.10494245358653942664.stgit@warthog.procyon.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 09, 2020 at 05:13:33PM +0100, David Howells wrote:
> Fix a couple of %px to be %x in debugging statements.
> 
> Fixes: e49c7b2f6de7 ("afs: Build an abstraction around an "operation" concept")
> Fixes: 8a070a964877 ("afs: Detect cell aliases 1 - Cells with root volumes")
> Reported-by: Kees Cook <keescook@chromium.org>
> Signed-off-by: David Howells <dhowells@redhat.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

Thanks!

-- 
Kees Cook
