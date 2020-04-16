Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC923C2BA19
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 03:02:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B421D2072D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 03:02:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VHDWTH12"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389506AbgDPDCf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 23:02:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2388679AbgDPDCb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 23:02:31 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44DE6C061A0C
        for <linux-kernel@vger.kernel.org>; Wed, 15 Apr 2020 20:02:29 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id w65so993147pfc.12
        for <linux-kernel@vger.kernel.org>; Wed, 15 Apr 2020 20:02:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=aS9SvWs+DFxFnL1yPS3fa3q3wGVb4/CrbEfA9CK4OJw=;
        b=VHDWTH12n0eDNyXUHGNtEGLj4u923xNka26EwVoKsNpfXE0Id3DdAOMSiJuxUyoAEp
         hLeUmGLXvDW57Awkpy7nmxLQvWzImQvMlevUXrbyzLypUo3jCBFrCRAv+e5isS5YOurm
         vrxPhm5R40MZDbhZ4Bh8jzqta2OYU8X78XX1Wd6RcKDEnyt+ZrfENPPRfp4pP0qJQyms
         ++7VAqQIfLDlJqaUXT0BB/9SwzKu00sx815FcE5pak/mkpSsnOD8kkKaKDsn3I9SY1Tn
         nxKHRbykKJi8rMtnV8abiobUI3GiKkR720nuFZ6FnNxuP5/DbTo1rWGTqDPY/pZHRNS5
         2ytQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=aS9SvWs+DFxFnL1yPS3fa3q3wGVb4/CrbEfA9CK4OJw=;
        b=nd/rT2H9Y7qVD3xcoiUNZCftk34wEHDiLhRMUUF2Z8jQ/Wdu4SrW8YT3tVieBkzxJg
         eZWVJoIBCyXX7Oe0Z4FpvCq4QZGD0/yqcUK21+5z1Dv8og+nTLZc2sAG0XPCpjnAnX61
         lkmqbninexNrEBYLceUOiDpKUO9Qne1W9kXdMT8vEp6inmm2qCOjKJIIjRxontHl9s24
         DcCO9lHMcjI5tST018dmx2UApD/80VXvq7AKjpNSsfZrGK21Y/4U6NLTHvKvq1yOHglY
         nQfxUqRyQ1dlULNNiSg31+OZs6d/kFQbYwM8ZXiXHP9wnB9C/rYbz/eVNhRNswJRN4Z1
         Y8ZQ==
X-Gm-Message-State: AGi0PuZQ2b1yk+PXYffqzdYqMaTiYQSlcNAvAsUMRZoPTpEAkg+ZnoCf
        SLcMDreTEcgfs4x2j/6K5a4=
X-Google-Smtp-Source: APiQypLVE9VN8YaJvUS02f39lWzs1vZfFEwlQDhKE6YfRydGARiJNPbtka/ueCX6O9UT1JmdRMWOpQ==
X-Received: by 2002:a62:1415:: with SMTP id 21mr13347992pfu.134.1587006148481;
        Wed, 15 Apr 2020 20:02:28 -0700 (PDT)
Received: from localhost (181.56.30.125.dy.iij4u.or.jp. [125.30.56.181])
        by smtp.gmail.com with ESMTPSA id g2sm15274781pfh.193.2020.04.15.20.02.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2020 20:02:27 -0700 (PDT)
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
X-Google-Original-From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Date:   Thu, 16 Apr 2020 12:02:25 +0900
To:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v3 2/3] ARM: bcm2835: Switch to use %ptT
Message-ID: <20200416030225.GD30641@jagdpanzerIV.localdomain>
References: <20200415170046.33374-1-andriy.shevchenko@linux.intel.com>
 <20200415170046.33374-3-andriy.shevchenko@linux.intel.com>
 <20200416025358.GC30641@jagdpanzerIV.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200416025358.GC30641@jagdpanzerIV.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (20/04/16 11:53), Sergey Senozhatsky wrote:
> > +	if (ret)
> > +		return;
> >  
> > -		dev_info(fw->cl.dev,
> > -			 "Attached to firmware from %04ld-%02d-%02d %02d:%02d\n",
> > -			 tm.tm_year + 1900, tm.tm_mon + 1, tm.tm_mday,
> > -			 tm.tm_hour, tm.tm_min);
> > -	}
> > +	dev_info(fw->cl.dev, "Attached to firmware from %ptT\n", &packet);
> >  }
> 
> So can this be instead:
> 
> 	struct rtc_time tm;
> 
> 	rtc_time64_to_tm(time, &tm);
> 	dev_info(.... "%ptR", &tm);
                       ^^^^
			%ptRdt  ?

P.S. I wonder what's the longest English word which can be constructed
from a valid vsprintf() specifiers sequence (consecutive specifiers).

	-ss
