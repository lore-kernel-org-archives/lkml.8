Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60AE8C33CB3
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 15:54:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 386422075B
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 15:54:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579190079;
	bh=zdYQ+BhwWGpdUEVVoM1h5ruir82zwLZhHHvUKjQ8iDU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=lfy9/CuD4lLDjngdZflHFO9gChj+DjT+GvxnyKB5vkI03YfxDY2OPlwAPAK5reWpV
	 APi5xu0iTWb0vFbEUE3DHY5nQNLDz+bnlOi5/PKXMEs+lU23He40CjLpZYX6zvW2OH
	 5hNlTNAmkJj5+/MLTrdtHN9OZ28Uny2TT5j6aYUQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726827AbgAPPyi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 10:54:38 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:39987 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726151AbgAPPyi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 10:54:38 -0500
Received: by mail-wm1-f68.google.com with SMTP id t14so4324392wmi.5
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jan 2020 07:54:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=h2hhG4jWcxA95LxI7Qpc36hdp7bTXlmQIH0NAyxSMOM=;
        b=cFsCMlGbV9CxVegvID0DQ8M0tAVb+4jvB0218oBKkVmZLv0N93+qhep8tNf53Svagl
         frVOCmGFI82r/3LF5g4VPf6rZq6CyFoNCmgkgHTqaHY010LSKN+oKMwo7/yIBfwt2Lxe
         Wy5SzM4f8u6aqZOVbr5nDejKZHW9l4mEDUJPXx0xA2GVIwOt68kQuiJvoMQRv4LPuHeo
         Ab8JDbKVpOKnZkXPEK8LVKfcogQvfKN1nrm8sE15U52EHKZCXNHpyCe6QwJh5QKv1/DY
         fvnRn03d3I0tEyNoDwflevHzBjZX+7jHJajPfRjc5bwpc6T2KXC9EkXxeynVVyq84D/X
         U2Xg==
X-Gm-Message-State: APjAAAUqmY8TmkPGdxTK/rhBHalrANvmRKYh/MYVpy3dK22T0AoewoiS
        ibnN1JK4Q00JCx1ZCrOSolw=
X-Google-Smtp-Source: APXvYqwasirTn2mRHt5icpct1OzxtW+H1/bjOZhi54tv2uRe3d85H230iWIMdGxgg57kTjY/fesRKQ==
X-Received: by 2002:a1c:44d:: with SMTP id 74mr19355wme.53.1579190075850;
        Thu, 16 Jan 2020 07:54:35 -0800 (PST)
Received: from localhost (prg-ext-pat.suse.com. [213.151.95.130])
        by smtp.gmail.com with ESMTPSA id r5sm29390925wrt.43.2020.01.16.07.54.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2020 07:54:35 -0800 (PST)
Date:   Thu, 16 Jan 2020 16:54:34 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Qian Cai <cai@lca.pw>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        pmladek@suse.com, rostedt@goodmis.org, peterz@infradead.org,
        david@redhat.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next v3] mm/hotplug: silence a lockdep splat with
 printk()
Message-ID: <20200116155434.GB19428@dhcp22.suse.cz>
References: <20200115172916.16277-1-cai@lca.pw>
 <20200116142827.GU19428@dhcp22.suse.cz>
 <162DFB9F-247F-4DCA-9B69-535B9D714FBB@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <162DFB9F-247F-4DCA-9B69-535B9D714FBB@lca.pw>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 16-01-20 09:53:13, Qian Cai wrote:
> 
> 
> > On Jan 16, 2020, at 9:28 AM, Michal Hocko <mhocko@kernel.org> wrote:
> > 
> > On Wed 15-01-20 12:29:16, Qian Cai wrote:
> >> It is guaranteed to trigger a lockdep splat if calling printk() with
> >> zone->lock held because there are many places (tty, console drivers,
> >> debugobjects etc) would allocate some memory with another lock
> >> held which is proved to be difficult to fix them all.
> > 
> > I am still not happy with the above much. What would say about something
> > like below instead?
> > "
> > It is not that hard to trigger lockdep splats by calling printk from
> > under zone->lock. Most of them are false positives caused by lock chains
> > introduced early in the boot process and they do not cause any real
> > problems. There are some console drivers which do allocate from the
> > printk context as well and those should be fixed. In any case false
> > positives are not that trivial to workaround and it is far from optimal
> > to lose lockdep functionality for something that is a non-issue.
> > <An example of such a false positive goes here>
> > "
> 
> I feel like I repeated myself too many times. A call trace for one lock dependency
> is sometimes from early boot process because lockdep will save the first one it
> encountered, but it does not mean the lock dependency will only not happen in
> early boot. I spent some time to study those early boot call traces in the given
> lockdep splats, and it looks to me the lock dependency is also possible after
> the boot.

Then state it explicitly with an example of the trace and explanation
that the deadlock is real. If the deadlock is real then it shouldn't be
really terribly hard to notice even without lockdep splats which get
disabled after the first false positive, right?

-- 
Michal Hocko
SUSE Labs
