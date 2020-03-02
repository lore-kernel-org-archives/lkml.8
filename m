Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82007C3F2D7
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 13:51:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A65820656
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 13:51:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mmLGIQqL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727261AbgCBNvl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 08:51:41 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:38754 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726969AbgCBNvk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 08:51:40 -0500
Received: by mail-wm1-f68.google.com with SMTP id u9so4857841wml.3
        for <linux-kernel@vger.kernel.org>; Mon, 02 Mar 2020 05:51:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=R2BZu+imcykNACPLPvIynfptCCeFQHdJvvg/T84qCP8=;
        b=mmLGIQqLs40/1JctkJUW6fbnrI0wxyktW/MCLs1VqwiTzd4SDvBGmvOxVfPkG5rZh5
         uJOIAYDexjxz0yNhBvg09cLZfbwPNB0bBkJHNv+3WEvizQvZfuZ3AU4SRlzG1g5mk2B6
         6llx37T3S+hlKdpV+y2jbBUJ79l3tlddWzm2s2FedCGfwWzUs47UvEOu5PBCppwg5+xW
         ac+OsYujE/Xtu1/oDlh3eYFUeABe6ORlhnB3CGOPTXr3M6HT0acqwrAzGalKO74ZEZj4
         gRVXWMijclJLyTIZqs4CpiEVANmMCGVLWD1imqMswpQ8LNtWQ4dgW9ezZEmblkQfjK8s
         WFTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=R2BZu+imcykNACPLPvIynfptCCeFQHdJvvg/T84qCP8=;
        b=hrFKGrnjikI5qqpSdHoH934GxPVp2ED1sBJgLTjzG9lrAAt8kmoo6hrksMnBE7qxX6
         xdOr/ieiCEhXZR8p7CaAD9t7jp2YIEjvIdq51YqnLTuOvlmxqmLrXDgvAWGgsG1q1vTP
         +A7CWzuPObNklaSl0pjwvl3dFo5S4bCm2JXMIjawX6CsSW7zOjtICcXRIQ3+FOQbLrXa
         ERln3r8QP3Dy6p8xyRuJkX4y9ALDpYX2BisaTR58ZWLQj1owmR+yTENPW6klwDv55832
         l8i8jnblL8jpVcPdQFfeS/WHa/pTNCEi06J12553TL6JpKr9XXtxQqRXq/liWy6hoti5
         BN0w==
X-Gm-Message-State: ANhLgQ2T8L4W9e+TKtDPed9Ww07VperSb8lahU3y4S6KMhVkjQKyILJ9
        ooltZmp3g7vfWSFJCJANVfw=
X-Google-Smtp-Source: ADFU+vt/Vy32uNCBI4Sk9lNPXzlHfMBJTlaslZWI9ZLyr6KXc2/mDivaYthY+LJV4eqjQSkIGmYZCQ==
X-Received: by 2002:a05:600c:351:: with SMTP id u17mr6467430wmd.22.1583157098661;
        Mon, 02 Mar 2020 05:51:38 -0800 (PST)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id l17sm7530089wmi.10.2020.03.02.05.51.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 02 Mar 2020 05:51:37 -0800 (PST)
Date:   Mon, 2 Mar 2020 13:51:37 +0000
From:   Wei Yang <richard.weiyang@gmail.com>
To:     mateusznosek0@gmail.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org
Subject: Re: [PATCH] mm/mm_init.c: Clean code. Use BUILD_BUG_ON when
 comparing compile time constant
Message-ID: <20200302135137.lm5syk7r2thohs54@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20200228224617.11343-1-mateusznosek0@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200228224617.11343-1-mateusznosek0@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 28, 2020 at 11:46:17PM +0100, mateusznosek0@gmail.com wrote:
>From: Mateusz Nosek <mateusznosek0@gmail.com>
>
>MAX_ZONELISTS is compile time constant,
>so it should be compared using BUILD_BUG_ON not BUG_ON.
>
>Signed-off-by: Mateusz Nosek <mateusznosek0@gmail.com>

Sounds you are right.

Reviewed-by: Wei Yang <richard.weiyang@gmail.com>

>---
> mm/mm_init.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/mm/mm_init.c b/mm/mm_init.c
>index 5c918388de99..7da6991d9435 100644
>--- a/mm/mm_init.c
>+++ b/mm/mm_init.c
>@@ -37,7 +37,7 @@ void __init mminit_verify_zonelist(void)
> 		struct zonelist *zonelist;
> 		int i, listid, zoneid;
> 
>-		BUG_ON(MAX_ZONELISTS > 2);
>+		BUILD_BUG_ON(MAX_ZONELISTS > 2);
> 		for (i = 0; i < MAX_ZONELISTS * MAX_NR_ZONES; i++) {
> 
> 			/* Identify the zone and nodelist */
>-- 
>2.17.1

-- 
Wei Yang
Help you, Help me
