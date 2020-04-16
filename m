Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A1F6C2BB55
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 16:08:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E5D9C206B9
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 16:08:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XSfEabIs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404983AbgDPQIv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 12:08:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727840AbgDPQIt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 12:08:49 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90A41C061A0C
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 09:08:49 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id b62so21848204qkf.6
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 09:08:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Nb4VLJt5d2ErqDbQ82nsBY2D5y/+fkaYPu7eHIaWN2A=;
        b=XSfEabIsJNAnHid8P/EIbBzkDwy1LntqqguA+wZ/vxydp/oi6OYN3QeAp6NQNRd8Jn
         5NHdqEe+ZAwY0auY5dIiJWWRzhpFyqLEGqB7PbLZqkaCyMtVgUA29E6hHNyGKh4tAwE3
         AlRcgnQkFzXxqscOV9Muh1/OotakS5SUpjiNQLu5XIWoRzgdemMOXawswJkZXO7oi6w1
         +W0Kotf3V47JiyvDBpbCz3PoA/o9RCf9DzZSPlWGOTuDXSQgUwDhADc64geZHQpGe8cg
         4km/V4/QfJRkrdzLccYC0sfA7ZPclDX1tE+sWo7GMfgCkXKoKv+ZjEy0J8oqbEJ8fAh3
         w4Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Nb4VLJt5d2ErqDbQ82nsBY2D5y/+fkaYPu7eHIaWN2A=;
        b=qAIFlMOIP0idNyw7TjivcVztAf5SN6aw0dEOBVit05Jmw0TJ8dLmAOfIXmz4hBx3HS
         pCGkeWUHzNz5w+0vo8LkpdJ8vhujRv+t4DL8k9CQ9hdxpvgA+GRHDK1AN/Z1BlGD+49c
         nouE+Xk8kDZKC8Ko/N1HjKqYYgBO1I9B/LATuIT2XFkexiuV9hfs6dGuX7QgHTP+0cO+
         jzWiELvtocnSjpOdkCseRRRJupOqVYRlimFJvCP9oUt4BlLHvlMivk8lEhW/53h26Yzt
         k5s6XUIY5XYHXJJiZ1EVpYSPNNXaghQA/u8hizdmG3cQW0TohMhcb40DgdxTzpBkvXgC
         eW3g==
X-Gm-Message-State: AGi0PuaGhozIyMg7KK+rY0q1N7QcL4NJ67RFrhIBCOPq01bD+jbGHViZ
        6tlnonb1iTC7HVeA6dalw2Kze0JKxcE=
X-Google-Smtp-Source: APiQypJbwUciWDTEkzCHCYIxKuUgOb4T3YM0k2kk6aYJK3N4wVcRx4Ltc4cNsdiiZUI4uEUFfQXhGg==
X-Received: by 2002:ae9:dfc2:: with SMTP id t185mr32316270qkf.20.1587053328690;
        Thu, 16 Apr 2020 09:08:48 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.37.151])
        by smtp.gmail.com with ESMTPSA id x125sm1650511qke.34.2020.04.16.09.08.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2020 09:08:47 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 8871E409A3; Thu, 16 Apr 2020 13:08:45 -0300 (-03)
Date:   Thu, 16 Apr 2020 13:08:45 -0300
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Arnaldo Carvalho de Melo <acme@redhat.com>,
        He Zhe <zhe.he@windriver.com>, tstoyanov@vmware.com,
        hewenliang4@huawei.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] tools lib traceevent: Take care of return value of
 asprintf
Message-ID: <20200416160845.GG2650@kernel.org>
References: <1582163930-233692-1-git-send-email-zhe.he@windriver.com>
 <5f7589c3-323d-1a5c-685c-9becd87a690b@windriver.com>
 <20200325133551.GA19495@redhat.com>
 <20200406222411.386ba51d@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200406222411.386ba51d@gandalf.local.home>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Apr 06, 2020 at 10:24:11PM -0400, Steven Rostedt escreveu:
> On Wed, 25 Mar 2020 10:35:51 -0300
> Arnaldo Carvalho de Melo <acme@redhat.com> wrote:
> 
> > Em Wed, Mar 25, 2020 at 09:05:46PM +0800, He Zhe escreveu:
> > > Can this be considered for the moment?  
> > 
> > Rostedt, have you looked at this?
> > 
> 
> Bah, I did but forgot to reply.
> 
> Yes, add my Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> 
> Sorry for not sending this out earlier.

Thanks, finally applied.

- Arnaldo
