Return-Path: <SRS0=PEot=6K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8715AC55186
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Apr 2020 02:55:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5BBEB2071E
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Apr 2020 02:55:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m/42paNY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726156AbgDZCzl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Apr 2020 22:55:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725952AbgDZCzl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Apr 2020 22:55:41 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4CA7C061A0C;
        Sat, 25 Apr 2020 19:55:39 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id t16so5472903plo.7;
        Sat, 25 Apr 2020 19:55:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=asnsPXdyirP9oS05sJeDQpJdG3Yhu+JHcjQarVbK0gk=;
        b=m/42paNYk4bTJSAgkYwKRquaje4aOyqgds2AflCUcNPSom+nmtRb/rohJdbkyrAZ4j
         a/l5Y+caMeCjIuX8q3HTHuO9b3BvriFmpwynhXu3NQF9jj0We7IQyTxjFay4RnVe7V7N
         i+YDgva5XOg2biHHGXlRV4FhkmvzojIDkj4DPNKiji/EIIMl8aw7Tq9PWMW621z/RLsS
         5pMr9tQOILDYQYcetoAwwQtza6Dyjr6geiaoh4grKc1QmGUWa0P3QZhQfWa7k3txGhZR
         5xSMr7ts/QnFBm8Q9QNmM5L6GSWn+GzJurQPoSJCRna2qxlW5aSzFIYKR9BcS6xODzGH
         TzxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=asnsPXdyirP9oS05sJeDQpJdG3Yhu+JHcjQarVbK0gk=;
        b=oqwwYl4eEWx4QfoeuY8/H+cw4aFbuH+/TQ2yN6/BlF/yLloxx6AhW5PYXgG+2eNDVp
         S13OliFzKgeOzc8HqJGJk9o5Qjr7PwesOglzaZ7NQIFLSYudcoEz44YHP0jLip2qInHM
         Ay22S3cb3bPdTcqTqO2Hs+DhaSFw3OhKBeOTa+C/psqigw7ZoRhOlg5yIllI7K4inUL9
         ppMrDInTnNX2KX9aNYbPIIBziHqxSJs64Plmx8SteN4czJjL/RKhBIPS+mTjGwA8AMCi
         L05OjvZLO9CYlDb7ZfdyC+65GdiKDTaImqvdwT4hdcw22200jz5G4ssC4H2UF+i36J8h
         0sKg==
X-Gm-Message-State: AGi0PuZ5vgFqxw/Zn+IUvemuk15otvg//+rLtaaykuJYx9hT7Y/pS3lF
        pQAToH5glJYqs2gv3vof19E=
X-Google-Smtp-Source: APiQypK1GdDBLwOHRoHmSNhagXQufrO/V6jYWukUGGNElpFTa7XzOuwPiJ8w5GPxjpgKb04FkBxlKg==
X-Received: by 2002:a17:90a:a40e:: with SMTP id y14mr16047402pjp.101.1587869739112;
        Sat, 25 Apr 2020 19:55:39 -0700 (PDT)
Received: from localhost ([176.122.158.64])
        by smtp.gmail.com with ESMTPSA id 79sm8037252pgd.62.2020.04.25.19.55.38
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 25 Apr 2020 19:55:38 -0700 (PDT)
Date:   Sun, 26 Apr 2020 10:55:34 +0800
From:   Dejin Zheng <zhengdejin5@gmail.com>
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v3] console: newport_con: fix an issue about leak related
 system resources
Message-ID: <20200426025534.GA19252@nuc8i5>
References: <20f37865-5af3-5fb9-8b8f-91f9464e4af3@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20f37865-5af3-5fb9-8b8f-91f9464e4af3@web.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 24, 2020 at 06:54:41PM +0200, Markus Elfring wrote:
> > The corresponding system resources were not released then.
> 
> How do you think about a wording variant like the following?
>
Markus, I think my commit comments is a sufficiently clear description
for this patch. Someone has told me not to send commit comments again
and again when it is enough clear. Because it only wastes the precious
time of the maintainer and very very little help for patch improvement.

BTW, In the past week, you asked me to change the commit comments in my
6 patches like this one. Let me return to the essence of patch, point
out the code problems and better solutions will be more popular.

>    Subject:
>    [PATCH v4] console: newport_con: Fix incomplete releasing of system resources
> 
>    Change description:
>    * A call of the function do_take_over_console() can fail here.
>      The corresponding system resources were not released then.
>      Thus add a call of iounmap() and release_mem_region()
>      together with the check of a failure predicate.
> 
>    * Add also a call of release_mem_region() for the completion
>      of resource clean-up on device removal.
> 
> 
> It can be nicer if all patch reviewers (including me) will be explicitly specified
> as recipients for such messages, can't it?
> 
> Regards,
> Markus
