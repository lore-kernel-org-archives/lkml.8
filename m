Return-Path: <SRS0=2gEN=4S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81D97C3F2D1
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Mar 2020 16:20:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5650D2468A
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Mar 2020 16:20:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BmBgW1BX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727085AbgCAQUL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Mar 2020 11:20:11 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:44435 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726602AbgCAQUK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Mar 2020 11:20:10 -0500
Received: by mail-pf1-f196.google.com with SMTP id y5so4301370pfb.11
        for <linux-kernel@vger.kernel.org>; Sun, 01 Mar 2020 08:20:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ol996i7Ly7uLXMGPOcxJk9a2/P7UfTmFHb83woUuOo4=;
        b=BmBgW1BXpb61N9UVhWc3UCobtjZmRY8cfjAit8K3GJNut56umMykryyzI9AzxVCNPu
         zOEVDsY3sT4UDzTHMxTNl9cA7M9jDoCm9XTPeWxZcTzpfVvX/4GlQyjehDQw0YtTjoWL
         EB9DXjWAslee7XYEPpiMDSk/CpSA8B7PG1YgEGGc+U8RJWtG64RB7rrOGqzA7b4rQS5s
         omthZP5UEN5t/YqPCx4Z7BD6vT2yjRFsX2lYXKeIaPmSzb2BFnmgmLEeGuprZ4xHPtlk
         MsDaZbTpDj609q6Y8zXZ0uP9KGKGRdg1t2ky59PPhmZPGZJqesifD/zmyl5NnA3qyDyZ
         FcaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ol996i7Ly7uLXMGPOcxJk9a2/P7UfTmFHb83woUuOo4=;
        b=QSxHxDZeux4MtSayO12Zig3auybSb4KnxFolSODPxh4YVg7gCNbg4PKjU9qBQNj2rW
         plZWDUjNrdt5d7TQkYh1A3wBU0S/+DnLhm6+dbEqIQUIdSvmHZIaRxJ9gc3g0k2nucfH
         5dlp0VX+uyrl7A+qdMyPqWWY56bT1tzvbMTiN52/ruOg8jRZXF7mzlUiJYrzkqGMZAKV
         jfbRIoailFIIzMtT2ZEnqYCW76+gPFWI8/4H1nbciJRCg4PUtXNkemFSK37QA4I1752l
         dbU1KPiTp/bIll9Zi5PokZDhqNWi7r6UDIF7EllFTbbC7vuOX9mvbOYuj9UlSTbYD6D9
         KGcA==
X-Gm-Message-State: APjAAAXfowbdeAA5vRZwimArHyk7rdGg8XAFZdJ0QRkGG5nAVWubMgJ/
        KuC9uUm2w0jQpZ+sxOL3Jbt0Nw==
X-Google-Smtp-Source: APXvYqybwsty6KbQzUZw6ydXZynsFTmZ7U2b15x7Sf8aB1XCoBDm81Hv5r+UKknAcAJrYKKAt382gA==
X-Received: by 2002:a65:6147:: with SMTP id o7mr15882420pgv.442.1583079609158;
        Sun, 01 Mar 2020 08:20:09 -0800 (PST)
Received: from google.com ([2620:15c:211:202:ae26:61fb:e2f3:92e7])
        by smtp.gmail.com with ESMTPSA id e2sm9004532pjs.25.2020.03.01.08.20.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Mar 2020 08:20:08 -0800 (PST)
Date:   Sun, 1 Mar 2020 08:20:03 -0800
From:   Marco Ballesio <balejs@google.com>
To:     Roman Gushchin <guro@fb.com>
Cc:     tj@kernel.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, lizefan@huawei.com,
        hannes@cmpxchg.org, corbet@lwn.net, rjw@rjwysocki.net,
        pavel@ucw.cz, len.brown@intel.com, linux-doc@vger.kernel.org,
        linux-pm@vger.kernel.org, minchan@google.com, surenb@google.com,
        dancol@google.com
Subject: Re: [PATCH] cgroup-v1: freezer: optionally killable freezer
Message-ID: <20200301162003.GA186618@google.com>
References: <20200219183231.50985-1-balejs@google.com>
 <20200229005131.GB9813@google.com>
 <20200229184300.GA484762@carbon.DHCP.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200229184300.GA484762@carbon.DHCP.thefacebook.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 29, 2020 at 10:43:00AM -0800, Roman Gushchin wrote:
> On Fri, Feb 28, 2020 at 04:51:31PM -0800, Marco Ballesio wrote:
> > Hi all,
> > 
> > did anyone have time to look into my proposal and, in case, are there
> > any suggestions, ideas or comments about it?
> 
> Hello, Marco!
> 
> I'm sorry, somehow I missed the original letter.
> 
> In general the cgroup v1 interface is considered frozen. Are there any particular
> reasons why you want to extend the v1 freezer rather than use the v2 version of it?
> 
> You don't even need to fully convert to cgroup v2 in order to do it, some v1
> controllers can still be used.
> 
> Thanks!
> 
> Roman

Hi Roman,

When compared with backports of v2 features and their dependency chains, this
patch would be easier to carry in Android common. The potential is to have
killability for frozen processes on hw currently in use.

Marco
