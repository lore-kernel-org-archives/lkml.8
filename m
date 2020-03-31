Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5754FC43331
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 23:03:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E57120787
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 23:03:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=massaru-org.20150623.gappssmtp.com header.i=@massaru-org.20150623.gappssmtp.com header.b="BYPoPlZD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731522AbgCaXDz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 19:03:55 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:44202 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731362AbgCaXDy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 19:03:54 -0400
Received: by mail-qk1-f196.google.com with SMTP id j4so25028138qkc.11
        for <linux-kernel@vger.kernel.org>; Tue, 31 Mar 2020 16:03:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=massaru-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=6+Ad8chN8N6NC/ANcuSXXfqOAu/A2JYw1wt09IvHLHk=;
        b=BYPoPlZDMsKi0FSqwT7J8j6e3ZsLsoLTc7e6bIfOvF8i9JfwL7ujted9TDYKSoyCEL
         wss6qyMAAdamEMvjPT/2XG2iacb18LUIARFADHbjQeX9VksO5PqLSbZxbeT06uYN98YF
         4BQopInUjf1ZuGBvv67W/pnS8xy0ztTGyLBWHG33iRK7T52eSeT0vLLjb4bHx9tz2K1J
         qjaQDPDGP9cY7gIqyqz+kGRc8cwjYbjNXKXVcTnXfqmRAg7b9DPF6suxl4WF3fau28jE
         MKGMYopKmx6oqV5ILGl6MO0TDuf9+ewPUKiOVbP6bhHhx5z4ZJtytn/nREN/UCOMjdRj
         jZDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=6+Ad8chN8N6NC/ANcuSXXfqOAu/A2JYw1wt09IvHLHk=;
        b=mNyWcPfujn8HD4JLBVOmvStDeMt5Z/QfjIObt+frG8h7idQpAKMsXeRTjRJG+qrV5y
         5TCh32dKuIDQMrTPOhvShRrSv7Qu0mldUMz/HjokYEGBE1NeqofoeTw+LLX938lxs3aN
         YsiO7BZCZIYLdxEwOg0simDnkpd37yylCW8XnW1o3YNJ4kkmdOCH57j6N8W4fUYD0DPn
         mCLyNMyyrS0zvGBWYpsoc8haRKCp+xbrSnS7wLhli5uEWJVq+UPgfLDpH9BOEzYddzEi
         4OQu+Q959ECB6QveEAPub6zO8DyX8dr4Qhxi4zV+rKNoClI/pUpJw6CJrPGDqWynsGOh
         fR4w==
X-Gm-Message-State: ANhLgQ2fq1l7W7RAuxwMc9gYiDj2+ZTDCqGCF59kPI+iIZSNFsfN8249
        YZIOg/AGOU6Ubg75nET/gyB7MA==
X-Google-Smtp-Source: ADFU+vvgq8KvtHWzopj9WKZIu9UuPfUEJEUwl8GnN31YdGOfnI2WhbAP2wY/viaa+nxTOMOBd1yfgw==
X-Received: by 2002:ae9:dd85:: with SMTP id r127mr6295575qkf.58.1585695832139;
        Tue, 31 Mar 2020 16:03:52 -0700 (PDT)
Received: from bbking.lan ([2804:14c:4a5:36c::cd2])
        by smtp.gmail.com with ESMTPSA id j39sm228345qtk.96.2020.03.31.16.03.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2020 16:03:51 -0700 (PDT)
Message-ID: <6db0b1a2a521386613489443053a980621c48767.camel@massaru.org>
Subject: Re: [PATCH 1/2] Documentation: filesystems: Convert sysfs-pci to
 ReST
From:   Vitor Massaru Iha <vitor@massaru.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        brendanhiggins@google.com, skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Date:   Tue, 31 Mar 2020 20:03:46 -0300
In-Reply-To: <20200331165707.7c708646@lwn.net>
References: <cover.1585693146.git.vitor@massaru.org>
         <637c0379a76fcf4eb6cdde0de3cc727203fd942f.1585693146.git.vitor@massaru.org>
         <20200331165707.7c708646@lwn.net>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.5 (3.32.5-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2020-03-31 at 16:57 -0600, Jonathan Corbet wrote:
> On Tue, 31 Mar 2020 19:28:56 -0300
> Vitor Massaru Iha <vitor@massaru.org> wrote:
> 
> > Signed-off-by: Vitor Massaru Iha <vitor@massaru.org>
> > ---
> >  .../{sysfs-pci.txt => sysfs-pci.rst}          | 40 ++++++++++-----
> > ----
> >  1 file changed, 22 insertions(+), 18 deletions(-)
> >  rename Documentation/filesystems/{sysfs-pci.txt => sysfs-pci.rst}
> > (82%)
> 
> Please supply a changelog with your patches.
> 
> The conversion you have done in this file is incomplete; I suspect
> that
> you have not actually built the docs and seen what the results look
> like.
> There are literal blocks that you have not marked as such, as a
> minimum.
> Please actually do a docs build (after adding this file to index.rst)
> and
> make sure that the output is what you intended.
> 
> One other thing of note...this file dates back to before the Git era,
> and
> while it has seen numerous tweaks since then, it's clearly
> outdated.  Look
> at what's actually under /sys/devices/pci* compared to what's
> documented.
> I will take the conversion without it, but what I would really like
> to see
> would be an effort to document all of the attributes that appear
> there
> with current kernels.
> 
> Thanks,
> 
> jon

Thanks for the review, I will check your comments and correct themif that document is still needed.

BR,
Vitor

