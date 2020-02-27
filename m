Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DAA5C3F2C2
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 21:53:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B4C8246A1
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 21:53:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582840436;
	bh=/5m83hqrXLbOV9ZphYEfsU4UnROjR8cXYZCUEOkJjhU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=CHkT3oOmKRAMqx39/uzwQQIer7lpG8agorB42OuNSlBvzOsKcwwVaR0isZXiq9R+G
	 mUgdYmNboh700A+modmKbVpbhymA/DCTTlt9XTxeoFQ3ZwkjKXBBLsPWcug0Oh1F30
	 kd75KIw9JcA+MOET+LPvyAdI+YfjPdpvfTG3akIw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730223AbgB0Vxz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 16:53:55 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:40310 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729773AbgB0Vxy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 16:53:54 -0500
Received: by mail-pf1-f194.google.com with SMTP id b185so532119pfb.7
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2020 13:53:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7dwQH34KOZabRYRAwZrdnJHMAH3aJ68bic4ZknrTLvQ=;
        b=mjmOJ66owX0Df96b/m5GC1crg6u5wtB1ayeppKZj6Rh3bevN9Nj/By2G3ScTRQpKn7
         l+QLMQJsMBwlF1Zv2iBkFTRR4zrlvvcKN2MrL/R6n5r9pc/SRafnlN/oxqFg3CCvhFkw
         x3rKHRm5o1xq8zpLmYfzBSkrODdyNgBksE58gfKBjFofl3sAgeX9ZF9lhTfstRzvzgUO
         vXWIH65KMcmLCNHHgxg6IbeiXN1IFExj7wyNO1eYaAQAjFUveBoFv0WbPqH0pukyHoAN
         a6tDVZmzsPqplyKO/DIOOkWvoHUxTBq3BZ2DbwpFclx7qXI34rd0ey+jlA1W2Rylis/C
         pNsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=7dwQH34KOZabRYRAwZrdnJHMAH3aJ68bic4ZknrTLvQ=;
        b=j5oQTpvaEw14apK6WSurOexJ3O0/lWyCu4BvePLrx/Hv/LeBcgR6w3UnB4wVx0sxY+
         xhXuMiV/gPRzCb8W7ZcKbj2EUoaMHx+7yOSY92XO9H83cjERJ0QuZNljebw83v+VeVzW
         tXmfBpK2R6CTXhA1MNFQ04Cy+aePQyP10YWFQMD7i9Q2dIMNuvX0qidMamk+CN6nmAuy
         IIc0S954Kwa6xOussD/EX7tBZzAe5XK609hYuNkTr0DJkUed3Tw/0NYa5WR6fuch0vqU
         1GsWh4qP61IhkVLOF/oVxTh/fBAFKyOZjzXPRfAPz5rbjPpk35dbvH0Dw57kBp37g73M
         u5kQ==
X-Gm-Message-State: APjAAAUnzl5RAo6xoJA2huMPM2pYWRbgsNgM03n+2x2W8Onht/68z9Ko
        SM0dbCXZ755LG/ietsEr2Ks=
X-Google-Smtp-Source: APXvYqz5QB5KbH7ouKCsYRcBx7vHfkREoBFOhQIyPNHIK9IoBYbDdNs3l1ALOgJ1mlD2tgMMN01Dog==
X-Received: by 2002:a63:f13:: with SMTP id e19mr1283835pgl.135.1582840433706;
        Thu, 27 Feb 2020 13:53:53 -0800 (PST)
Received: from google.com ([2620:15c:211:1:3e01:2939:5992:52da])
        by smtp.gmail.com with ESMTPSA id q4sm8748395pfl.175.2020.02.27.13.53.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2020 13:53:52 -0800 (PST)
Date:   Thu, 27 Feb 2020 13:53:51 -0800
From:   Minchan Kim <minchan@kernel.org>
To:     Jules Irenge <jbi.octave@gmail.com>
Cc:     linux-kernel@vger.kernel.org, boqun.feng@gmail.com,
        Nitin Gupta <ngupta@vflare.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "open list:ZSMALLOC COMPRESSED SLAB MEMORY ALLOCATOR" 
        <linux-mm@kvack.org>
Subject: Re: [PATCH 13/30] mm/zsmalloc: Add missing annotation for unpin_tag()
Message-ID: <20200227215351.GE215068@google.com>
References: <0/30>
 <20200214204741.94112-1-jbi.octave@gmail.com>
 <20200214204741.94112-14-jbi.octave@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200214204741.94112-14-jbi.octave@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 14, 2020 at 08:47:24PM +0000, Jules Irenge wrote:
> Sparse reports a warning at unpin_tag()()
> 
> warning: context imbalance in unpin_tag() - unexpected unlock
> 
> The root cause is the missing annotation at unpin_tag()
> Add the missing __releases(bitlock) annotation
> 
> Signed-off-by: Jules Irenge <jbi.octave@gmail.com>
Acked-by: Minchan Kim <minchan@kernel.org>
