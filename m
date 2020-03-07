Return-Path: <SRS0=IBMW=4Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7060C10F26
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Mar 2020 13:11:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F8F02075A
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Mar 2020 13:11:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=mvista-com.20150623.gappssmtp.com header.i=@mvista-com.20150623.gappssmtp.com header.b="1/8MHk1O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726296AbgCGNLl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Mar 2020 08:11:41 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:42215 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726105AbgCGNLk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Mar 2020 08:11:40 -0500
Received: by mail-ot1-f67.google.com with SMTP id 66so5201933otd.9
        for <linux-kernel@vger.kernel.org>; Sat, 07 Mar 2020 05:11:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mvista-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=J4p6CveRCCmA2UOrY+JX/CiuZIW93/gthzgtABNAuu0=;
        b=1/8MHk1O7FLY17YfXkC+nkMhj/pCDJQDaSXUX3nfjZ1VOTf+nyTAaJ94as4sPG+vXr
         zJ9Si1xqkRV0mX+f5k4aUstJVHiepuZEySL0zb5J9DL637dw+n2a7ESC4rZQExO6JHvv
         pX9L9QK2ZK/RH2ifCDy6iDNFzjzJlATTZggA0B7XFPGtGJeZwfx+k2O3dDCLsTmb1BcO
         Ouu5GQfqwz1hrDPc49OJedXO6nX5k1FkMHOHRe4VSUBxtC7ZU77g9hqsjqbL1FmVt0fz
         9QvSntzQky3OydY0/jyw4KxCShAH+cCEBY+af6bHZvkfiIVI6sR9iMG0W2kdv5WB+GhO
         jk5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=J4p6CveRCCmA2UOrY+JX/CiuZIW93/gthzgtABNAuu0=;
        b=gI2jSv+5DgdsuQWP9mpyWj4vfz16Fw5T0J0EBhcu/G+KpaQ7ewTE96Aytda3c6RfZb
         gUH3lAhkt8LQrsxZbn8p9N2ejuFI7S4Mcide6PwDDvofrGyFvG7sliHdwFzdI/NScDnB
         h3960m7r56sUSr3A3gnTlkueB70/JurI5q45ZmBPwHZHbduPBFEdoUClIfRiCjQx7+EG
         LCw9MWLD/ZgbILeA7DUlbz8I0o9oS7m7JOgGlbZyytTp+rUHeHdje3dSbWHr+VzDf/OZ
         YyYA7cVClnB5v0KKcW0Gwcr4l3Ek6JaLKJUuGPkn0ybYTMnZWVQbKY4l12otXv8WPz/e
         Z4qg==
X-Gm-Message-State: ANhLgQ17MyDBWuc0ZR9ubBlMRqvOkMV5YkoqrytXXBb4JxpeTcvyj/vE
        OiCRt7gIcgk8pF/+XN5/sm0w3A==
X-Google-Smtp-Source: ADFU+vvVyZPXSmAxtQpvvaio/rX9SrEtO/27S7Qk9r3r3pkTzRT5RxNkJ+ip1g+0uhhEcY4rhK06VA==
X-Received: by 2002:a9d:7cd4:: with SMTP id r20mr6434214otn.148.1583586699738;
        Sat, 07 Mar 2020 05:11:39 -0800 (PST)
Received: from minyard.net ([2001:470:b8f6:1b:a549:b51b:bece:c41b])
        by smtp.gmail.com with ESMTPSA id o1sm12475012otl.49.2020.03.07.05.11.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 07 Mar 2020 05:11:38 -0800 (PST)
Date:   Sat, 7 Mar 2020 07:11:36 -0600
From:   Corey Minyard <cminyard@mvista.com>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     minyard@acm.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, Adrian Reber <areber@redhat.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Andrei Vagin <avagin@gmail.com>
Subject: Re: [PATCH v2] pid: Fix error return value in some cases
Message-ID: <20200307131136.GD2847@minyard.net>
Reply-To: cminyard@mvista.com
References: <20200306172314.12232-1-minyard@acm.org>
 <20200307110007.fmtaaqt2udsgohtp@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200307110007.fmtaaqt2udsgohtp@wittgenstein>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 07, 2020 at 12:00:07PM +0100, Christian Brauner wrote:
> On Fri, Mar 06, 2020 at 11:23:14AM -0600, minyard@acm.org wrote:
> > From: Corey Minyard <cminyard@mvista.com>
> > 
> > Recent changes to alloc_pid() allow the pid number to be specified on
> > the command line.  If set_tid_size is set, then the code scanning the
> > levels will hard-set retval to -EPERM, overriding it's previous -ENOMEM
> > value.
> > 
> > After the code scanning the levels, there are error returns that do not
> > set retval, assuming it is still set to -ENOMEM.
> > 
> > So set retval back to -ENOMEM after scanning the levels.
> > 
> > Fixes: 49cb2fc42ce4 "fork: extend clone3() to support setting a PID"
> > Signed-off-by: Corey Minyard <cminyard@mvista.com>
> > Cc: <stable@vger.kernel.org> # 5.5
> > Cc: Adrian Reber <areber@redhat.com>
> > Cc: Christian Brauner <christian.brauner@ubuntu.com>
> > Cc: Oleg Nesterov <oleg@redhat.com>
> > Cc: Dmitry Safonov <0x7f454c46@gmail.com>
> > Cc: Andrei Vagin <avagin@gmail.com>
> 
> Thanks! I've pulled the patch now and applied.
> 
> I think that restores the old behavior. If you don't mind, I'll add a
> comment on top of it saying something like:
> "ENOMEM is not the most obvious choice but it's the what we've been
>  exposing to userspace for a long time and it's also documented
>  behavior. So we can't easily change it to something more sensible."

That's great.  I was just looking through the code for another reason
and noticed the issue.  Every little thing counts for quality.

-corey

> 
> Acked-by: Christian Brauner <christian.brauner@ubuntu.com>
