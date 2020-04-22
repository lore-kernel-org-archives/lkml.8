Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC35BC54FCB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 14:22:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C01432082E
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 14:22:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587565360;
	bh=zsWFLb3FLz87JE8F76HKVj3cOIPNQbXRJM/pwJXKcL8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=JX1pXg2k6WLFdWIACpWaWwD+hEcR3O8n7ABWPmzfPUhNrvvfMkRlE9VSAmVnwFrHY
	 zJ4FwLNUiQOUnLaRiQtaNKzald3E9/t7kl/hd8wh02V3FOKAJNuvZV+m31NtJcECR/
	 8/buvlV8vHHiyM/oQlPbop74SZnEhRst4IHrhofU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727818AbgDVOWk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 10:22:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726720AbgDVOWj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 10:22:39 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0473AC03C1A9
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 07:22:39 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id g13so2607696wrb.8
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 07:22:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ufnee/q97CC1CGBkoV1pipCbIwuaBK73Df12DK7GmQM=;
        b=G/q6n0qYA2Zalko2hOs1fOAoBG23c4arPJ4/nR/mgJ9jIpO6v9X61ryrLtTzpQQA6M
         +lH71mW+Kg7emKULTYSSiElVHDq9SnlUfgpRkmingJxKtgeO9jkIDkvnfe8Vo15Z9F/W
         JB/Y0biRf6LaEP6sU/CRAHP8FZmgXkAkMaoSebj0zqEhSuXchgKhNm1WvWmIWKmMf67E
         DAUUSYEZNHkM4tfVpWxMjEUJV6jV4TLlme9exaNphU7HZfM792GczQTrvn/0h6J5mU7H
         O8a4LiUqKwHRhbkk4sA/VQxLm4FyFtPzBdoGrdDYCp1ZYqX79Bhhw/F4dAHIRN1hLfUT
         KMwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=ufnee/q97CC1CGBkoV1pipCbIwuaBK73Df12DK7GmQM=;
        b=Mvho7DNamEuIup3+zdYJAUu+DPBz/wNXtjoCQIZxYQcuSX91VzDlSXqB38E/DR246W
         l6vf8CDAaz5q7H8JPtOcVOjRORwJ6lowW0DXcyoNzoIwcnjsyRpb03AlA4il2ux73e/X
         hKXXTiygGIWJdkxMkbkqV4aKxlUT/p3YlBlBzdP955hHAQUK2ILEnGOdfLmyZDAlfHAr
         GBK/1Y0pQAocfXZrhS5DRfNvpAOaaCyEEaxW8fZh6ZZjudQEnUtDKF5NFmEe1/Ihkx05
         WsIPawTkHalo/wvsGaBvn2x1XnrMmWBhJvntP305X6U5OY/7mdFpGsEIFQKehYEygkp0
         aVUw==
X-Gm-Message-State: AGi0Puaaaz0naoIte+uPg2dY8n+tvAWggmFmeCJKRx1uZ4ucyVQEX3AU
        NDQYi8pn5jU3flp0mTFKizE=
X-Google-Smtp-Source: APiQypI7Ji2w+STU5RCXfOUCRhnwJ6IvSkfob35nBNPOrSZw/R9iM2Tj6zxzC0UkKIP1XK5+l7n9lQ==
X-Received: by 2002:a5d:4b04:: with SMTP id v4mr31729231wrq.358.1587565357795;
        Wed, 22 Apr 2020 07:22:37 -0700 (PDT)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id b12sm9092431wro.18.2020.04.22.07.22.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2020 07:22:37 -0700 (PDT)
Date:   Wed, 22 Apr 2020 16:22:35 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Josh Poimboeuf <jpoimboe@redhat.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Borislav Petkov <bp@alien8.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 2/3] objtool: Rename elf_read() to elf_open_read()
Message-ID: <20200422142235.GA2840@gmail.com>
References: <20200422103205.61900-1-mingo@kernel.org>
 <20200422103205.61900-3-mingo@kernel.org>
 <20200422114342.GD20730@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200422114342.GD20730@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Peter Zijlstra <peterz@infradead.org> wrote:

> On Wed, Apr 22, 2020 at 12:32:04PM +0200, Ingo Molnar wrote:
> > 'struct elf *' handling is an open/close paradigm, make sure the naming
> > matches that:
> > 
> >    elf_open_read()
> >    elf_write()
> >    elf_close()
> 
> 
> > diff --git a/tools/objtool/check.c b/tools/objtool/check.c
> > index f2a84271e807..12e2aea42bb2 100644
> > --- a/tools/objtool/check.c
> > +++ b/tools/objtool/check.c
> > @@ -2614,7 +2614,7 @@ int check(const char *_objname, bool orc)
> >  
> >  	objname = _objname;
> >  
> > -	file.elf = elf_read(objname, orc ? O_RDWR : O_RDONLY);
> > +	file.elf = elf_open_read(objname, orc ? O_RDWR : O_RDONLY);
> 
> Note that I have a patch pending that makes that unconditionally O_RDWR,
> which sort of seems to suggest elf_open() might be the better name.

Ok, done!

Thanks,

	Ingo
