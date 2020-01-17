Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43893C33CAF
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 02:50:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11C5820730
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 02:50:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A9dALr6S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388697AbgAQCuB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 21:50:01 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:36949 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388384AbgAQCuA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 21:50:00 -0500
Received: by mail-pf1-f196.google.com with SMTP id p14so11224156pfn.4
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jan 2020 18:50:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Ocx1bcHvca+8n2uDvEKp0ll9Xosk7Vm9gTmI5pqwqMY=;
        b=A9dALr6S1daNEyD2gQ3R+ElBRW1LXgSwVHb0wqfhCi/w46iAnWFXeEHJ7eMeVbjcYO
         A2H2cVbJy7G3KqIZLilJfguEYu+t0b0/mO5IJ/UPkqDaxviENqYUpEtNkB7q+cBNbmjt
         nE22pYPhcGeS9bk/MGtaYs1u7bYZKRQtn0m2ytM+iB+TvLv0zFgR+6YErcCdSKCqTimN
         /6KzW61HT8H1XAnCmH9Ag+mlgFx9MNcewP2G6XHZ79RIS67EXjLCxl38+7qJdDoMaZfd
         n8XR2zaFnsVkpy0s/EgfO0pX4i4J20BZXKHNMNjWDXDKGte19fUjz09amzmo1OGh18e6
         HX5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Ocx1bcHvca+8n2uDvEKp0ll9Xosk7Vm9gTmI5pqwqMY=;
        b=YDoXs+RvT8B6hx0yRhL29FTiDj7Oqv6mnzSAMQ20vAsjE3j0sLXpeqW0Oed+ouGBa0
         ijj3P6xyovH6usFZl1K8ltLsS7FzPlnUdl9FS/VXV4Po3YPBEN137g9tkfEFdXMvL07T
         tRG8mDEWSJmpkvpyT/Hf39JriBPJ2JVjWBKvetNR0ItIMIMp6xipcY8bWu9ehf9EknRg
         NGU9EwuvNOpCgvD0VfjHEKoFjQNl9M25F7mFZqHxe6UAuEydyS4K0iHeWLGP+Dp2/Rof
         HuCQfVu0+L4KW8hG71oM+eQbY6gWnq5ocolDdcaBT4pFwPS1fFDwXMhHI0KtG5yOnZIi
         XzKA==
X-Gm-Message-State: APjAAAWjzPiQCAxeJesZshec0luM8vDSSQXx6jnN0OT3J2/2MuXgUExI
        1jt89nmAIjuFUxJlNp+JkvU=
X-Google-Smtp-Source: APXvYqwQvFDnTATlFyF5/qlEI9Pl40x+gtbXGOWUGS+tSdK/gYhZSnx3HZR48Rfp24YtPLhJNEBoFA==
X-Received: by 2002:a62:e30d:: with SMTP id g13mr761645pfh.92.1579229400236;
        Thu, 16 Jan 2020 18:50:00 -0800 (PST)
Received: from localhost ([2401:fa00:8f:203:5bbb:c872:f2b1:f53b])
        by smtp.gmail.com with ESMTPSA id s131sm29571468pfs.135.2020.01.16.18.49.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2020 18:49:59 -0800 (PST)
Date:   Fri, 17 Jan 2020 11:49:57 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Qian Cai <cai@lca.pw>
Cc:     akpm@linux-foundation.org, mhocko@kernel.org,
        sergey.senozhatsky.work@gmail.com, pmladek@suse.com,
        rostedt@goodmis.org, peterz@infradead.org, david@redhat.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Michal Hocko <mhocko@suse.com>
Subject: Re: [PATCH -next v4] mm/hotplug: silence a lockdep splat with
 printk()
Message-ID: <20200117024957.GA7372@google.com>
References: <20200117022111.18807-1-cai@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200117022111.18807-1-cai@lca.pw>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (20/01/16 21:21), Qian Cai wrote:
> It is not that hard to trigger lockdep splats by calling printk from
> under zone->lock. Most of them are false positives caused by lock chains
> introduced early in the boot process and they do not cause any real
> problems (although some of the early boot lock dependencies could
> happenn after boot as well). There are some console drivers which do
> allocate from the printk context as well and those should be fixed. In
> any case false positives are not that trivial to workaround and it is
> far from optimal to lose lockdep functionality for something that is a
> non-issue.
[..]
>
> Acked-by: Michal Hocko <mhocko@suse.com>
> Signed-off-by: Qian Cai <cai@lca.pw>

FWIW,
Reviewed-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>

	-ss
