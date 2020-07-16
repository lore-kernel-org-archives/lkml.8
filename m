Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EB29C433EA
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 13:54:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C08220825
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 13:54:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594907692;
	bh=am0ZDnPlbNUcD8HJg1pW/jR09QsXY16ykxnng6kMcoE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=v3wmBNynlMWjnQmZ0NOBoMF1atP0U9cp7a9CXhKWjyZUhcSC+F0GZi5MhJr70GlXU
	 iA0vePeKpqmNOVEmNMU9lxq0k03HPnZY3ctcQr6X3qpSzdByqk75Ye2SfCUgoLZ2O7
	 YmJKiSBnaiNWgp7cOqWfyG6CzwdsvRBarVadfhsY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728958AbgGPNyu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 09:54:50 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:40536 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726986AbgGPNyt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 09:54:49 -0400
Received: by mail-wm1-f65.google.com with SMTP id f139so11698214wmf.5
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 06:54:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=65QcCnpAmDce81oUaFA3QmWLjs//tlPa4Tv3XmT8+FQ=;
        b=UTYNXgoD/PQPT8VgeMDlmKpwkhZyazb7d5OL9+XHUK4vcd1gyJ6rHmiaI5vRSin5Et
         Rj5cInFIrKwMYOXLAaoNpgFTA4rahrA8/LUdp22kiUAXYIqeIHMbp4ssbeFsXxOkRWqa
         WQTQo9/5M5v58eAznIWjlkRttxiJf1TszFbNAkpGznl23BqXnkfGaK0qlEsLoujPO/8l
         xApcJXuTtEwOLQbWLUjYOkj9P9pzUl9JchsAw5R3CuqL90b4yLDyJ412yfaJ0jcZtqaa
         7uaR0UO4Z87nG3GvNbSkDY6xeP4QyLzE5YKM1XeQQV8jLWVevm307kk2UvRQ9QGlLD9J
         ikFQ==
X-Gm-Message-State: AOAM533tM5ZEInt8AE/AzEBURS9j54E6cFqdeTNAdHwqoGtv6+3UCoVU
        D0eiMBMAJfq4wyIu8S76KNo=
X-Google-Smtp-Source: ABdhPJyj2yoIu1OI5sYIfY/IP84jBUda+jO/u4IzsW4mJwUw1NjKcW5ImRsOWLC2FicYTufKJVMauQ==
X-Received: by 2002:a05:600c:218f:: with SMTP id e15mr4169276wme.63.1594907687641;
        Thu, 16 Jul 2020 06:54:47 -0700 (PDT)
Received: from localhost (ip-37-188-169-187.eurotel.cz. [37.188.169.187])
        by smtp.gmail.com with ESMTPSA id k20sm8457168wmi.27.2020.07.16.06.54.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2020 06:54:46 -0700 (PDT)
Date:   Thu, 16 Jul 2020 15:54:45 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arve Hjonnevag <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <christian@brauner.io>,
        syzbot <syzbot+e5344baa319c9a96edec@syzkaller.appspotmail.com>,
        acme@kernel.org, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, linux-kernel@vger.kernel.org,
        mark.rutland@arm.com, mingo@redhat.com, namhyung@kernel.org,
        peterz@infradead.org, syzkaller-bugs@googlegroups.com,
        "open list:ANDROID DRIVERS" <devel@driverdev.osuosl.org>,
        linux-mm <linux-mm@kvack.org>
Subject: Re: [PATCH] binder: Don't use mmput() from shrinker function.
Message-ID: <20200716135445.GN31089@dhcp22.suse.cz>
References: <0000000000001fbbb605aa805c9b@google.com>
 <5ce3ee90-333e-638d-ac8c-cd6d7ab7aa3b@I-love.SAKURA.ne.jp>
 <20200716083506.GA20915@dhcp22.suse.cz>
 <36db7016-98d6-2c6b-110b-b2481fd480ac@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <36db7016-98d6-2c6b-110b-b2481fd480ac@i-love.sakura.ne.jp>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 16-07-20 22:41:14, Tetsuo Handa wrote:
> On 2020/07/16 17:35, Michal Hocko wrote:
[...]
> > But in order for this to happen the shrinker would have to do the last
> > put on the mm. But mm cannot go away from under uprobe_mmap so those two
> > paths cannot race with each other.
> 
> and mm1 != mm2 is possible, isn't it?

OK, I have missed that information. You are right. Can you make this
into the changelog please?
-- 
Michal Hocko
SUSE Labs
