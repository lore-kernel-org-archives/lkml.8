Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51C21C3F2D1
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 01:24:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 155F720637
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 01:24:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P4Q+2KJA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387418AbgCDBYM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 20:24:12 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:43743 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727725AbgCDBYM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 20:24:12 -0500
Received: by mail-pg1-f193.google.com with SMTP id u12so161194pgb.10
        for <linux-kernel@vger.kernel.org>; Tue, 03 Mar 2020 17:24:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Rt8TtTL2J2teY8pg3mAMBDxFdn/EEgf4y2xMHvWn/v8=;
        b=P4Q+2KJAFjMZOlZOparRgmdpjak5uoAJFTD5Y90LErx3JpfK0UNQGBOM5TQsh4lxw0
         vnAjLQe0ENDCo0ZQ5hnkkRawhWxRuF3wImszc6mqaZAUmf32J23Y36c3qL2LATOSc2h2
         tVfjBltn2QrYuDOibSBHTKVxQDmRfLH3BblY27gzz8VkF8PU1bMMY3k4FqUDkcmeaj0i
         6J+nMb2iMJxcPnvOlMcFlR69jl/RqmbOoafXTX2H0o6QwLhM6dM9YHoCSaA6FUK7qgHW
         08QwM9aaL559yyLm5RkZljBckbvwIlaynPPEOZ1GlwrypPVsFAsDcc4ElsCiDKbYgt+y
         C6mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Rt8TtTL2J2teY8pg3mAMBDxFdn/EEgf4y2xMHvWn/v8=;
        b=Ozu5kOZGAm2Y+5KTJl1Du5Qzv11ZirPkt7Q14IdbG7mDJHShcyszYYPG/q/ywcTXGx
         /2zDWMWfber89PBzcEgLL0ujUCZy7hwES3xp0M3l1zyuCJga3LRgWzlIih2GFdbQzT0L
         VDrvXCmjn/fesYxIs/l7sgPnO9g9f61HufYNUSsoqgBdOINT9GLHqA1kxW3vNB1fD6cb
         YTR6KDAsgprN0Q9mRtEglyy61KuzHar0jQwsgd8xFhivbIhEtLy3K9tu+7fxHd1Wf6R2
         8HlzIC6zXxJdVqqrVT+q3Bww7be90V5bFS3EI2sFyLswSisuDHhGbQJiIX5hCJdG7hR0
         LIfQ==
X-Gm-Message-State: ANhLgQ2Ej3MlXCK0zUq8QgDTX6nj9Rz8WCqDuo5oSaIlGVTghsg0KecA
        zL+FrBkIXbtSuHlqBuWJ9SPGBwqUI0M=
X-Google-Smtp-Source: ADFU+vsn8BpgZ0uD9Kj8MicwFBE3Bv2NWVCEbUXbGCPpouGZIfn6QZU1OP0ZBgg8Au4qQWr8+E19nA==
X-Received: by 2002:a62:1682:: with SMTP id 124mr550487pfw.107.1583285051211;
        Tue, 03 Mar 2020 17:24:11 -0800 (PST)
Received: from localhost ([106.51.232.35])
        by smtp.gmail.com with ESMTPSA id z13sm26175369pge.29.2020.03.03.17.24.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 03 Mar 2020 17:24:10 -0800 (PST)
Date:   Wed, 4 Mar 2020 06:54:08 +0530
From:   afzal mohammed <afzal.mohd.ma@gmail.com>
To:     Finn Thain <fthain@telegraphics.com.au>
Cc:     linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
        Greg Ungerer <gerg@linux-m68k.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v2 06/18] m68k: Replace setup_irq() by request_irq()
Message-ID: <20200304012408.GA5014@afzalpc>
References: <cover.1582471508.git.afzal.mohd.ma@gmail.com>
 <00b0bf964278dd0bb3e093283994399ff796cca5.1582471508.git.afzal.mohd.ma@gmail.com>
 <20200229131553.GA4985@afzalpc>
 <alpine.LNX.2.22.394.2003010958170.8@nippy.intranet>
 <20200301010511.GA5195@afzalpc>
 <alpine.LNX.2.22.394.2003011337590.15@nippy.intranet>
 <20200301061327.GA5229@afzalpc>
 <alpine.LNX.2.22.394.2003021717150.8@nippy.intranet>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LNX.2.22.394.2003021717150.8@nippy.intranet>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Finn,

On Mon, Mar 02, 2020 at 05:26:17PM +1100, Finn Thain wrote:

> I had assumed that your intention was to find a consensus so that the 
> whole tree could be consistently and automatically improved

Yeah, my main goal was to get rid of setup_irq(), other things were
secondary and proceeded to achieve the removal by hook or crook, but was
caught red handed :)

> > Sometimes had a feeling as though the changes in this series is akin to 
> > cutting the foot to fit the shoe ;), but still went ahead as it was 
> > legacy code, easier & less error prone. But now based on the overall 
> > feedback, to proceed, i had to change.
> > 
> 
> Not based on feedback from me I hope -- I have no veto in this case, as 
> you can see from MAINTAINERS.

i don't know what to say, i attempted to accomodate the reviews as
much as possible, some times when opinions are conflicting i had to
take a call one way or the other, with more importance to maintainer's
view.

Regards
afzal
