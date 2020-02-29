Return-Path: <SRS0=iO2y=4R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7ED1C3F2C6
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Feb 2020 12:41:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1023246AF
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Feb 2020 12:41:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EE/Xiw56"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727000AbgB2Mlw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Feb 2020 07:41:52 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:38952 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726960AbgB2Mlw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Feb 2020 07:41:52 -0500
Received: by mail-pl1-f196.google.com with SMTP id g6so2344120plp.6
        for <linux-kernel@vger.kernel.org>; Sat, 29 Feb 2020 04:41:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Lzl90WXFMunmegLZSSnHumkI0Mbsnp6eNKi/ikeorF4=;
        b=EE/Xiw56ufCyWh2lad67WOdkEhm4cR13tOqRDePCig6fXNo9d4Dq2DPWGEwkbXdII3
         dAayYQgspowv/VF4q8CLWnTEChMxGGehYO3iAAMlgjc+9DEl2fcPN0zWCG4B2h5zkG7n
         Q1tcNkq2cqsksxtGU8y6F/huwJEwOYUC356jqXEU68AYh3zgd/ZhenAS53WM5gFEzPu9
         HvpOFnKcKon+7YInrKhc6YdAtWr/K52dgdMCfm7nbyajnAV18s4/Q5fkc3rJrA7BCLO1
         rTsy5CFhgkDhxHPL66tXu+l9Q4SLFfoumQiBNWldVryOFV6p1px2dRQrFQ7PR3V6WEVJ
         5KiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Lzl90WXFMunmegLZSSnHumkI0Mbsnp6eNKi/ikeorF4=;
        b=epnLwFrwpNsqVierzn95c/SlO13NDoSlDGkvqVU93aLYNq2kqs3jbgTbtu30Z/zDrJ
         gD3ZzgDFhif74l2CEnngNTJwKtcOuSM99aSof7GMjOQZaKvYtciQDzuuRZKFyEeNws2w
         j9lIsD4DuLlzjSd2JcghG8rr9NoL076SG3xXRGFAjMm0j7/FdrnMiuFn14/NKKUxnTBW
         AXvie7PGcyGA9RAUYZsEirQXjokPt4WxU6rWF3JL0LTI49o1yH+PXqUCrutr7ur7GcdJ
         BJ20R1lT1oaxx2BCGY2t7c3uQcO19uqvf1XNkvWXoSCFdd64xTP8v+UlsP+ouf+xbb+S
         ECkA==
X-Gm-Message-State: APjAAAWy9U+xUM3TQZ4yKXbxxqvhWry9t8RtmUOq06CyclJaHpuKlU0G
        w7uTC2Tpe1OPJmrFW88Rf1blKPTf
X-Google-Smtp-Source: APXvYqyw/j6QAQfvPR7MNvf6QqgF2hY7nn9sxQ1XrPv/Ex4nsx2wPvx6512CJbhgI4Ptv8o2wbTJxA==
X-Received: by 2002:a17:90a:30a3:: with SMTP id h32mr10117769pjb.48.1582980110880;
        Sat, 29 Feb 2020 04:41:50 -0800 (PST)
Received: from localhost ([106.51.232.35])
        by smtp.gmail.com with ESMTPSA id 1sm10787547pff.11.2020.02.29.04.41.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 29 Feb 2020 04:41:49 -0800 (PST)
Date:   Sat, 29 Feb 2020 18:11:47 +0530
From:   afzal mohammed <afzal.mohd.ma@gmail.com>
To:     Finn Thain <fthain@telegraphics.com.au>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v2 06/18] m68k: Replace setup_irq() by request_irq()
Message-ID: <20200229124147.GA27151@afzalpc>
References: <alpine.LNX.2.22.394.2002270908380.8@nippy.intranet>
 <a682c89d-baf2-3d3c-647f-a07b2a146c9f@linux-m68k.org>
 <alpine.LNX.2.22.394.2002261637400.8@nippy.intranet>
 <caa5686a-5be3-5848-fdee-36f54237ccb6@linux-m68k.org>
 <alpine.LNX.2.22.394.2002261151220.9@nippy.intranet>
 <73c3ad08-963d-fea2-91d7-b06e4ef8d3ef@linux-m68k.org>
 <20200227081805.GA5746@afzalpc>
 <CAMuHMdWVVWaoHA1Tie5APYBq3Pa3s4BAoWN1jAACAZZS65UA7w@mail.gmail.com>
 <20200227120618.GA6312@afzalpc>
 <alpine.LNX.2.22.394.2002280927130.8@nippy.intranet>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LNX.2.22.394.2002280927130.8@nippy.intranet>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Finn,

On Fri, Feb 28, 2020 at 09:38:20AM +1100, Finn Thain wrote:

> If you want to stop the compiler complaining about an unchecked return 
> value, assuming that it does so, please consider using
> 
> 	if (request_irq(...))
> 		pr_debug(...);
> 
> That way there is no penalty paid for adding error messages that the 
> original author apparently did not want.

Okay

Regards
afzal
