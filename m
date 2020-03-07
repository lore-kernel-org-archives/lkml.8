Return-Path: <SRS0=IBMW=4Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E0F9C10F00
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Mar 2020 11:28:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CE58206D5
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Mar 2020 11:28:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gOGx1F3Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726266AbgCGL2n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Mar 2020 06:28:43 -0500
Received: from mail-pf1-f181.google.com ([209.85.210.181]:45936 "EHLO
        mail-pf1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726102AbgCGL2m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Mar 2020 06:28:42 -0500
Received: by mail-pf1-f181.google.com with SMTP id 2so2432315pfg.12
        for <linux-kernel@vger.kernel.org>; Sat, 07 Mar 2020 03:28:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Pt8QP3xxt7JkGiM0RpaHywq3DPvUhYSmR2kNTrIhsjU=;
        b=gOGx1F3YTVo7mv+JqdmDGV47G4Q/YeJKqbqYlXUFtYJGsyl6fI0EnCki9XLQdTpR1J
         j37xhEdekFUukXcGKSU/4on/QoQAKyFqrIzC0UrqwHueuFcOkV9I2kF2F3adlAr9+jtj
         WTkpEtsFP6K5eaZ1wNalkM3HXCAxUiDtzvZW8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Pt8QP3xxt7JkGiM0RpaHywq3DPvUhYSmR2kNTrIhsjU=;
        b=j7I0UzCorL5PnrTHejF6V6tL71sEdl828iVeq94Q+UMUWcblDGVZBl1QoFaWjcvcZG
         UAsRUG2PQ5qEUNxQmWj8CUnQVuJB0gg/0WTY4ryFebgBTwfnOAagah7PjNqY7G4rKKsa
         OPGLzw7F2Tha8XIHIJBawvU0HGfwGrXirGUs+J1e1c70t2Iq9socmdqTUGyIOxP7Hbbn
         /qG+DZDLrjlMZapY4ipwd6r+beR+dK5UGCNXLpLg8p5bI5vM4ny1zRrHxd87RI7Tap87
         zxEBG9YD3fhIqvrjgbeXuJ7kWsYGdKrtGAfZQFqZ6TyMWM3fig9DD9M6HnqE9rsWrmyw
         zJ+A==
X-Gm-Message-State: ANhLgQ2iLWnGjusv1HGO9mmcRbAAQhQa9NCCgKOVhx7sVE8jMYJBizfr
        JpMW/p60vH3+YWGpQqaoGgOrRA==
X-Google-Smtp-Source: ADFU+vs0W+uOmFlybn7WzYsJlIHhujsx0QfhuS80dowA1b8rYYjWZ/TnHCmiIe488bP7tS9mYZLxkQ==
X-Received: by 2002:a63:485f:: with SMTP id x31mr5627374pgk.347.1583580521718;
        Sat, 07 Mar 2020 03:28:41 -0800 (PST)
Received: from localhost ([2401:fa00:8f:203:5bbb:c872:f2b1:f53b])
        by smtp.gmail.com with ESMTPSA id k2sm20747450pfh.16.2020.03.07.03.28.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Mar 2020 03:28:40 -0800 (PST)
Date:   Sat, 7 Mar 2020 20:28:38 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Hans Verkuil <hverkuil@xs4all.nl>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Tomasz Figa <tfiga@chromium.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Sakari Ailus <sakari.ailus@iki.fi>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Pawel Osciak <posciak@chromium.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv4 01/11] videobuf2: add cache management members
Message-ID: <20200307112838.GA125961@google.com>
References: <20200302041213.27662-1-senozhatsky@chromium.org>
 <20200302041213.27662-2-senozhatsky@chromium.org>
 <17060663-9c30-de5e-da58-0c847b93e4d3@xs4all.nl>
 <20200307094634.GB29464@google.com>
 <6f5916dd-63f6-5d19-13f4-edd523205a1f@xs4all.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6f5916dd-63f6-5d19-13f4-edd523205a1f@xs4all.nl>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (20/03/07 11:10), Hans Verkuil wrote:
[..]
> >>> @@ -564,6 +573,7 @@ struct vb2_queue {
> >>>  	unsigned			requires_requests:1;
> >>>  	unsigned			uses_qbuf:1;
> >>>  	unsigned			uses_requests:1;
> >>> +	unsigned			allow_cache_hints:1;
> > 
> > Shall I use "unsigned int" here instead of "unsigned"?
> 
> The vb2_queue bitfields are the only places in that header were 'unsigned' is
> used. I think that that should be fixed in a separate patch. It's nice to have
> it consistent.
> 
> Put that patch in the beginning of the series, that way I can pick it up in the
> next pull request.

OK, done.

For the time being the series has moved to github public repo [0],
I'll try to run more 'twisty' cases and re-submit once it survives
beating.

[0] https://github.com/sergey-senozhatsky/v4l2-mmap-cache-flags

	-ss
