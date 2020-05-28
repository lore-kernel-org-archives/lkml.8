Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A9F3C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 07:44:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E40D42145D
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 07:44:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590651889;
	bh=JQovPRzRildkfK94RqErFvrfrdiBQzI+HhRl0V5TBkU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=H6Dneav0fYUhte4I0Wzjl5IEWnrE4DLWM+sClJ8r6ftFMsb7FYS+CoMEso+8SNP0i
	 2BVK7UsoWaoRUfeq7cfp1KY3XFdxas3XaUEAVEbNPhsrpvwZnn4yIal9ZVUNzJ11X4
	 Oo/zUjHB8IOZJEGy5BOmqhu51qJwoGVQCY4E6XHY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726734AbgE1Hos (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 03:44:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725747AbgE1Hor (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 03:44:47 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50473C05BD1E
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 00:44:46 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id g9so22376698edw.10
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 00:44:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=MxtFmPxsx2QLpxqRiRjosE9zDHzIOqgaK1Ln9E8J5Wk=;
        b=MDZ0Hyla0vij8gZtFndPn/KfM/hS0wvjYUGWft1tfhbG0pU6ZGt7atfIXQ5b7b7z/T
         3LyJ6Eee6zMOPIvML5uvgrpCou7YURDnmhhkJU8VgAV0SyZjh2YvWhmgalnsoThWuk4a
         8NaLsKDDHpnLPjySR/rVJsr+hByzyZDhzNFlXdc9Dx16ZTmSj8xYD4fi0NAqlrw56bzF
         qiVDs1PfMMLBK/RIsndTpg3j71xn+LfGr28zv5+I/VOZCkIC0dyMuhuOjUmr2yLoR81p
         ZxuQ0UL7gi3vkE3NV8h+Kt565HWKjVarPkxF1dfOtNH4fQcSj0bQCHpqQCnyK8aQ7t2E
         3MYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=MxtFmPxsx2QLpxqRiRjosE9zDHzIOqgaK1Ln9E8J5Wk=;
        b=Mmfg02MFrLn6QPcrGXO3VccdbbGFGWTaiiUVDfAhYEDijbRThTBSUa0/nCFA7utVyO
         ck9ewHraCoKBwcUlMgqE88pE+n8zcxLM7aKJzY913OsC61MgJNJgSAQj/qbN1CEOodWB
         a7adBi7E29nBVQdo3GoM4IlZ+aFeYt/Zuma1mUIIDHldy4OrYO4IqndE0Jhi+1zH/TZi
         F9qs+Be4dLlwnmoAhrcjumNnBH94nuiXljdh+K5fRaC1DK+LQExs679Ov6vT86blKxUd
         JZ8Ncm+L/oQ7ee4wAe2e0GOO9ZjxsI9qA+QUHxgbHNszU4Al6eS5/0RowmQZi8FlcBcw
         sFeA==
X-Gm-Message-State: AOAM530SENogZSRhqMBPgrpM0Tcv4AtAByfLjb4NXU+ZiohTaftXPIaw
        cdTlR3ztEYLR0hjy0KbDQ9s=
X-Google-Smtp-Source: ABdhPJzrOP9f0vBgk3VCRYh6KvIrcCjAt5BDMpQk8bcsNZIYcbVEjhcirApDUmmi6x3XRvzeU+GjZA==
X-Received: by 2002:a50:8d42:: with SMTP id t2mr1705746edt.170.1590651885152;
        Thu, 28 May 2020 00:44:45 -0700 (PDT)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id q22sm4420821edg.97.2020.05.28.00.44.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2020 00:44:44 -0700 (PDT)
Date:   Thu, 28 May 2020 09:44:42 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Subject: Re: [git pull] coredump infoleak fix
Message-ID: <20200528074442.GB790247@gmail.com>
References: <20200527213447.GH23230@ZenIV.linux.org.uk>
 <20200528070255.GA790247@gmail.com>
 <20200528070552.GJ23230@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200528070552.GJ23230@ZenIV.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Al Viro <viro@zeniv.linux.org.uk> wrote:

> On Thu, May 28, 2020 at 09:02:55AM +0200, Ingo Molnar wrote:
> 
> > Looks good to me.
> > 
> > I'm wondering, shouldn't we also zero-initialize the dump data to 
> > begin with? See the patch below (untested).
> 
> Note that this hides the bug from KASAN, though ;-)  And the bug
> is not just infoleak - not all components are "all zeroes" in the
> init state.

Yeah, but is zero-init really a problem though? Wouldn't it be 
'better' to have all zeroes if the dump doesn't fit? But I might be 
missing something ...

Thanks,

	Ingo
