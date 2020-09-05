Return-Path: <SRS0=flm+=CO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D94AFC43461
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Sep 2020 21:34:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 947732073B
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Sep 2020 21:34:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WlVgjmdV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728703AbgIEVeO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Sep 2020 17:34:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728103AbgIEVeN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Sep 2020 17:34:13 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFD61C061244
        for <linux-kernel@vger.kernel.org>; Sat,  5 Sep 2020 14:34:11 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id a8so2740103plm.2
        for <linux-kernel@vger.kernel.org>; Sat, 05 Sep 2020 14:34:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Qk4slgfid1yPByHqYlwQFEuSRddQf9kuyAkrPfErQjg=;
        b=WlVgjmdVfdyU8pU/+PGGtpMTnKySdx4q36fU9wgecVCQ9lEg6XpJcuUeleFuJ+JRgV
         3uzS0+4jHXBXokhpPV2+w+0Ifdop36SjFUIZE8k+SscsyUrTI5jYGHTnY2uJmdWuP8Kb
         bMuTPgC1guHZTOFgZXeHGuDdt1C57tdioBt2kIbh1vDhw0uZCvQFKRhqPh+dpZd9RYK5
         EES3GokZZ471TqFAJpBCYB0O1MMgkk0tOrTUHBMN+qrZKapFBO/aKX7uinmSOW/vpbV5
         wo/rr264kNHCxeT2ML5BzhnBKIgm7d9vaGzuPeJ5yM5ft488R5lnL8FbbSNWi1Ed9OiL
         3tkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Qk4slgfid1yPByHqYlwQFEuSRddQf9kuyAkrPfErQjg=;
        b=I4x/WNSh7QkVfAfK6PRvVCdDdlmS4s4iPQ/2499iVaRub8ath/ojMAUuQO87yptuWE
         Q1DptYmYR/ZxwI514EBQ2eOgL9ABQoVLVJ7IwqqJrWCdXAAIzNz6kPdwRgPGmwSYK7ha
         Fb+mTOisWFeYFRfJ4vv4s6xr4AbPFmfRmWZI0NmLppLFJgHxlBSU8TmOmVhca4rRu4nh
         Y6MwwmGO0fAj4ZycpFvjQQSYCpg4TIrVgqLlZS6XJfi7+S87UtPmADLtPO1FeI4OICOA
         ZvMXZSVIRFXNW8IPFQpDWxXofyn8ff+7EsJPc9x6LuHneRmDMfhF9MgrzQG2tXx4BFm3
         b+pg==
X-Gm-Message-State: AOAM5300WGDWg/ZfNWRzbV+bF5DijAHgPTfc3LREljE9kKru2wK89uxS
        U0iqe8QxIXA70IssH2n1Nr4=
X-Google-Smtp-Source: ABdhPJzKUHHA3feATlv6jsm69qf4LKSDklMjXEE1Q86SIik3kweQMIipte0rN6+WJlslTfsZHh54JQ==
X-Received: by 2002:a17:90a:f198:: with SMTP id bv24mr14533985pjb.117.1599341651203;
        Sat, 05 Sep 2020 14:34:11 -0700 (PDT)
Received: from localhost (g223.115-65-55.ppp.wakwak.ne.jp. [115.65.55.223])
        by smtp.gmail.com with ESMTPSA id u138sm10713710pfc.218.2020.09.05.14.34.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Sep 2020 14:34:10 -0700 (PDT)
Date:   Sun, 6 Sep 2020 06:34:08 +0900
From:   Stafford Horne <shorne@gmail.com>
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Andrew Morton <akpm@linux-foundation.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Greentime Hu <green.hu@gmail.com>,
        openrisc@lists.librecores.org
Subject: Re: [PATCH v2 3/3] openrisc: Fix issue with get_user for 64-bit
 values
Message-ID: <20200905213408.GI3562056@lianli.shorne-pla.net>
References: <20200905131935.972386-1-shorne@gmail.com>
 <20200905131935.972386-4-shorne@gmail.com>
 <20200905135714.74bsr5h423k7guw4@ltop.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200905135714.74bsr5h423k7guw4@ltop.local>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 05, 2020 at 03:57:14PM +0200, Luc Van Oostenryck wrote:
> On Sat, Sep 05, 2020 at 10:19:35PM +0900, Stafford Horne wrote:
> 
> Hi,
> 
> The change for 64-bit get_user() looks good to me.
> But I wonder, given that openrisc is big-endian, what will happen
> you have the opposite situation:
> 	u32 *ptr;
> 	u64 val;
> 	...
> 	get_user(val, ptr);
> 
> Won't you end with the value in the most significant part of
> the register pair?

Hi Luc,

The get_user function uses the size of the ptr to determine how to do the load ,
so this case would not use the 64-bit pair register logic.  I think it should be
ok, the end result would be the same as c code:

  var = *ptr;

-Stafford
