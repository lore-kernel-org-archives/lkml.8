Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EF60C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 20:08:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 598DD20656
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 20:08:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="srYLnMZE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728541AbgG1UIO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 16:08:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728112AbgG1UIN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 16:08:13 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68703C061794
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 13:08:13 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id d27so15864137qtg.4
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 13:08:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=7dLNNRTV2GJLqVTQNBxoLMGUKeruJRc+tK69t/CHzL4=;
        b=srYLnMZE/6CsfNbhZXgRXeNbaHpEQRue6V16dDOedEn7I58IpYY7APoybLJnCMX0P9
         KCmSG9lGSTZd5gJimR/yWMl8lrVniUTr4bqVEkOt2+xS4Ox7eRQwxVHLnX9TL0X2hQKF
         zW+7U70YnPfTet+7T2od9fd5zlJtw04VuAF6M1PwhnH6FJ3eVsEN6yQtN6w0OB+gfo/8
         LBeTd5LVzDnaV1HtYyj79myhgYsSFKKhzjBoyXwfXGmdhKSN4aFaZrupw+4o4alBtZM6
         DLZG/v9WyPdMTCAWgR7UckEBTTH7BedSw3LvQnMBef8zJi6ZI1eaAQLmG/CfpKXPmA7O
         m3iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=7dLNNRTV2GJLqVTQNBxoLMGUKeruJRc+tK69t/CHzL4=;
        b=mC9UVr2cYrpMXwWmnXCTf+kyEHHBj45ZjBt2xloNJJf+zrb8tNP0WuaD+c/yf4cGc/
         qSLUcC1ImbbBIW4vKhvXPSTydOUY+7QZ3tPEafUeBB+1iuTUDOIVhfAHsjGdgUMuf05g
         U2oWXH2syzxwrPSlvoYGaRBjtpg2sos/L2BKsq6uqmjcgQvJ5WKwuZ0OY/vsTCZEwK7Z
         ZmlpiUnYVTHYyJ/WMJG50CNO/DTYCmwxl7iH7kKqDWkLX56Q2KMxCTcYRCk6yTuF3u7h
         0ljuhi01TqV061TM3AWbv/YSoUgbl3HmUuRjtVu9dJerIuhMWME4iBpO40C5NPsqWhR7
         2mgw==
X-Gm-Message-State: AOAM5331r0upo90YUEWNcs70X8S49hSUKcx79LeYoEdydNphH1E8/vwi
        SHwSPS6MwEzYfwq4QBdet5I=
X-Google-Smtp-Source: ABdhPJyafTfFEOdj7V2LoX9/oM8hp1gG7RElCEueMITs49txP+GsOEnGDA1LA/bRJwEPSSycVSAJiA==
X-Received: by 2002:ac8:7741:: with SMTP id g1mr13007508qtu.28.1595966892616;
        Tue, 28 Jul 2020 13:08:12 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id f130sm24457609qke.99.2020.07.28.13.08.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2020 13:08:12 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Tue, 28 Jul 2020 16:08:10 -0400
To:     Kees Cook <keescook@chromium.org>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 8/8] x86/kaslr: Don't use 64-bit mem_vector for 32-bit
 kernel
Message-ID: <20200728200810.GD4150860@rani.riverdale.lan>
References: <20200727215047.3341098-1-nivedita@alum.mit.edu>
 <20200727230801.3468620-9-nivedita@alum.mit.edu>
 <202007281235.B9743EA@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <202007281235.B9743EA@keescook>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 28, 2020 at 12:37:12PM -0700, Kees Cook wrote:
> On Mon, Jul 27, 2020 at 07:08:01PM -0400, Arvind Sankar wrote:
> > Commit
> >   f28442497b5c ("x86/boot: Fix KASLR and memmap= collision")
> > converted mem_vector type to use 64-bit on the 32-bit kernel as well,
> > based on Thomas's review [0]. However:
> > - the code still doesn't consistently use 64-bit types. For instance,
> >   mem_avoid_overlap uses 32-bit types when checking for overlaps.  This
> >   is actually okay, as the passed in memory range will have been clipped
> >   to below 4G, but it is difficult to reason about the safety of the
> >   code.
> > - KASLR on 32-bit can't use memory above 4G anyway, so it's pointless
> >   to keep track of ranges above 4G.
> > 
> > Switch the type back to unsigned long, and use a helper function to clip
> > regions to 4G on 32-bit, when storing mem_avoid, immovable_mem, EFI,
> > E820 and command-line memory regions.
> 
> The reason for long long is to avoid having to check for overflows in
> any of the offset calculations. Why not just leave this as-is?
> 

The first bullet: there are still unsigned long's in the code that get
assigned mem_vector.start etc. Taking into account Ingo's review as
well, I'm planning to just make all those u64 as well in v3, instead of
this patch.
