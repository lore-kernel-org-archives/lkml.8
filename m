Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4A47C3F2D7
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 20:51:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D21320732
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 20:51:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho-ws.20150623.gappssmtp.com header.i=@tycho-ws.20150623.gappssmtp.com header.b="PQo1pucP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726702AbgCEUvT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 15:51:19 -0500
Received: from mail-yw1-f67.google.com ([209.85.161.67]:38583 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726111AbgCEUvT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 15:51:19 -0500
Received: by mail-yw1-f67.google.com with SMTP id 10so84282ywv.5
        for <linux-kernel@vger.kernel.org>; Thu, 05 Mar 2020 12:51:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tycho-ws.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=H+HudSkASYAYqykfNzjJYhs/ehkqHxljholOtfs/JM8=;
        b=PQo1pucPPu8nYc2aWJc1L1kIe2vKrAY8lZuHgv6o1c/y0YWscOobJ7UA92CTHlP9OM
         KgpOdGO18c5gBe+QhFeYyl0UMc7ZaW94sL+uL5QyXQI3btX5oAEWmUz1pF6px1ojl/TB
         oKRwZJiaQwxemfvnpFIdEPchCniZUzOuEgk7Lv05Fxnt92SXYYquMY4lHTEr5ZPbbRy0
         H2LS/izwoAIU1agkmAG+rMo0cTv49NcrqZ3KB/8EbKcHTlso92hwQKBNYao5KY59jmbf
         KS+1TWrts6u6iY4GhjiZS8ueyIsyv+yyRdc5wvbHsB8V8Vq1HJnfcQBvFxiFTvCB2KTn
         NWEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=H+HudSkASYAYqykfNzjJYhs/ehkqHxljholOtfs/JM8=;
        b=qxkKw6legeM0u64pX78gQerknwq1FRauZSdZpHUOT+NskzaVFL9zaZYPkTC32+t1hz
         NqSIdh7lqvuz++0sHdilJnpQ2/oy94TvVoIE7iT+EKLv93e39B5enNSSZbBHr6eTf4c+
         L/mjKWk8N+ol5sBTfSq/M9axTqNamz6SIyvhMQN0+LWyS6Dg00FaCe9osPildZP71Jn6
         x1f8q7vY/5O1VLY2k7NSZ1Z7sEHp51B+GL3XMGCYURAB6XmrublSD2lczhoWZruQmwYJ
         UGpD8sgfcbDo/OAHTMkWuW3XBOHAGY4/dchFOAH3HOCHPWIhvZrJMxJmZtPL+KBIy+97
         N9Tw==
X-Gm-Message-State: ANhLgQ2LZWGQ2yaTaotmsUPrmF4/m/BRq1e8jSM2uSwiBDHOZJiRj6yT
        FeBqNuUU0uGXj+3bxEPJwYyhcg==
X-Google-Smtp-Source: ADFU+vtRxts30zPpiSD+50Cgz5G/jqp5VoSl5xCPzpgpgmakOUz9Lt/dTNP9IOFwAkDCMh+6/OSMCw==
X-Received: by 2002:a25:6b44:: with SMTP id o4mr95466ybm.345.1583441478112;
        Thu, 05 Mar 2020 12:51:18 -0800 (PST)
Received: from cisco ([2607:fb90:17d4:133:1002:9a44:e2a2:4464])
        by smtp.gmail.com with ESMTPSA id y197sm1678532ywg.101.2020.03.05.12.51.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2020 12:51:17 -0800 (PST)
Date:   Thu, 5 Mar 2020 13:51:11 -0700
From:   Tycho Andersen <tycho@tycho.ws>
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Kees Cook <keescook@chromium.org>,
        "Tobin C . Harding" <me@tobin.cc>,
        kernel-hardening@lists.openwall.com,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        linux-xtensa@linux-xtensa.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] xtensa/mm: Stop printing the virtual memory layout
Message-ID: <20200305205111.GE6506@cisco>
References: <202003021038.8F0369D907@keescook>
 <20200305151144.836824-1-nivedita@alum.mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200305151144.836824-1-nivedita@alum.mit.edu>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 05, 2020 at 10:11:44AM -0500, Arvind Sankar wrote:
> For security, don't display the kernel's virtual memory layout.
> 
> Kees Cook points out:
> "These have been entirely removed on other architectures, so let's
> just do the same for ia32 and remove it unconditionally."
> 
> 071929dbdd86 ("arm64: Stop printing the virtual memory layout")
> 1c31d4e96b8c ("ARM: 8820/1: mm: Stop printing the virtual memory layout")
> 31833332f798 ("m68k/mm: Stop printing the virtual memory layout")
> fd8d0ca25631 ("parisc: Hide virtual kernel memory layout")
> adb1fe9ae2ee ("mm/page_alloc: Remove kernel address exposure in free_reserved_area()")
> 
> Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>

Acked-by: Tycho Andersen <tycho@tycho.ws>
