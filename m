Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A48AC433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 06:34:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E601D20874
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 06:34:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HtFtunGx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726455AbgGBGed (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 02:34:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726047AbgGBGed (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 02:34:33 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C88AFC08C5C1
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jul 2020 23:34:32 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id l6so8916098pjq.1
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jul 2020 23:34:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=93Q7ysA0UsltrPOj5kzoA7eym5Pk9IL4kO10kGOSHzM=;
        b=HtFtunGxRcXUUuGaf4tE8tLzAWvxlUsLdJHi82wsxN0AqDViYhL7R2OlSftUok6Ay7
         avA0ed5dFAvqg/MzR0UZx/HR+xySxTO9SCgTnnPS8O8pi+1q7/KXjOrJGF97dKowNwt7
         9HD8eZVZ4Rw119uPjp+uio4K7D6ZtmO+hMZs4T1kmVXXzRl2vLRa4rVZZahudE5hGtnp
         4bD0YwtR+OvXIw3cErctqe73QkOzsEJyQBoAhJd2dDg27hA7Z7TsdzXM4fMk0nq31UQo
         M/GiIuUtVfXSLBgnpWrUqbAvBIxm21YYfP+XK9Qa9QnxSLdIaOGFFfz7u9zvAmY9rt96
         21VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=93Q7ysA0UsltrPOj5kzoA7eym5Pk9IL4kO10kGOSHzM=;
        b=Y1TV8ClePL2YP6KW54bEWPTcWKk1wXYKIymJTvPq9ue0sckh6ITq2h8Ud9sry6H9LE
         LXYJLqv65C9bnegKrrsnDnOxPMg0Gor5/azOUOLj1KO6vA5MwBuZOx+8UtcQRMy3HqtU
         T6w0FRNwbYhOse6RWGmpUbuo2GLxCVOLpIJZ3TU9zHGSZubXVoIMuTMDLLEEH3x+wJeL
         gT3V0j+l0PKcrrXxH7aiUn5Hvh1uD68KN9s/Ss00wHmwNHegrC9m2gjPT/E6DF/Br7VF
         025yjotDoFA+RMILqRj2ycfz7mNZMt8a6Uraz1ZimtBsxXMcJyJXsxcWOOJGhE7f86tT
         wA5A==
X-Gm-Message-State: AOAM533c9P9K2VWn4ug68h+ahlSJv5I/RTTYk16i2r09MHg4AUd+qD1q
        E0Gyg4vN5YwF5rp+sSCh0xE=
X-Google-Smtp-Source: ABdhPJyeL5/nziKe5rg25/dBaQod2/Vw7M378gHdi2wX0/n1SW0ap5Z0+laB8hrXPXCgkITdOG1Rew==
X-Received: by 2002:a17:902:6908:: with SMTP id j8mr25294841plk.124.1593671672291;
        Wed, 01 Jul 2020 23:34:32 -0700 (PDT)
Received: from localhost ([2409:10:2e40:5100:6e29:95ff:fe2d:8f34])
        by smtp.gmail.com with ESMTPSA id w4sm7736926pfd.39.2020.07.01.23.34.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2020 23:34:31 -0700 (PDT)
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
X-Google-Original-From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Date:   Thu, 2 Jul 2020 15:34:29 +0900
To:     "S, Shirish" <Shirish.S@amd.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tony Lindgren <tony@atomide.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Petr Mladek <pmladek@suse.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Raul Rangel <rrangel@google.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "kurt@linutronix.de" <kurt@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        John Ogness <john.ogness@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: UART/TTY console deadlock
Message-ID: <20200702063429.GA1315@jagdpanzerIV.localdomain>
References: <20200630035816.GA21591@jagdpanzerIV.localdomain>
 <20200630102141.GA11587@alley>
 <20200630105512.GA530@jagdpanzerIV.localdomain>
 <20200630122239.GD6173@alley>
 <20200630130534.GB145027@jagdpanzerIV.localdomain>
 <20200630180255.GD37466@atomide.com>
 <3b665cbd-7afb-b72d-22c0-7dc1543ac42e@amd.com>
 <BY5PR12MB37780DF07B437B9FFD1BB344F26D0@BY5PR12MB3778.namprd12.prod.outlook.com>
 <20200702061136.GA679876@kroah.com>
 <BY5PR12MB37789152C6311FDE04759806F26D0@BY5PR12MB3778.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BY5PR12MB37789152C6311FDE04759806F26D0@BY5PR12MB3778.namprd12.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (20/07/02 06:14), S, Shirish wrote:
> This one:
> https://lkml.org/lkml/2020/6/30/394
> 
> I did reply to all, not sure what I am missing while replying.

It's not a formal patch yet. Give us some more time to figure out
how do we want to fix the problem at hand.

	-ss
