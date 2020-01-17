Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ADD5C33CB1
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 09:40:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E585420730
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 09:40:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579254015;
	bh=XFQahqhZbnxUQ9+f3HGQQLmmRQrjqVD8CUi5mpTGDmA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Q4Ob+08qwXbEwyFcAAAjJo5pFXUHQOUfuTNrmyHnNpwg2PFET/BqhZXp0wuO3B+1c
	 UK5xE7lMvnZ3Cq/vr1mHDooEVtWjfn6DJfJ1UV/yib53cjMBGBksjb0sjmIcQ8RTw3
	 RTCvR6XBCghafT908N2ZC6FKWL0AxmwoJ/j6LUXE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727018AbgAQJkN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jan 2020 04:40:13 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:43112 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726371AbgAQJkN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 04:40:13 -0500
Received: by mail-wr1-f66.google.com with SMTP id d16so21996307wre.10
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jan 2020 01:40:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tvr1JplSwE1Nh+0Rfwn/I+92DolIasGyNqPK2F8NHJM=;
        b=rQHp521l7UxhpsI/SF45+Qmrje2p7XRC528FI9Ch9Ox/2cIwE/ES7oWngtgFJyGruT
         xbQWdKlOFuS1BY2p5x1oN96xIGgSS0HrKeiuZ+fu1TvWHEJUy/j1cgc5kzwRhujmIcO/
         Hj8RCziuftKfqHKiNwZIsu2UljQz9phiSqeTWN4jlLgWydqACjeZgmXUjxU+Ic4ZtwWu
         HhOcVfYAq52vRdY6l44INveuvx7oKU79gs2RzQvHPLG66ijiBx/+9p/MVpz7z72rpsbp
         eec7TbFjnaygnbNzwz0NfEbLtQL8rUhc71n7/blj0SGMG6gBYjrVF4EdnenY9go9hZmy
         aDAQ==
X-Gm-Message-State: APjAAAWydu6aZqTKz7njphTjIOoIG7nEK7i4TVD83xFG89ozJLmXn/ei
        MfWaSQEFt984Kc3dGnTniqs=
X-Google-Smtp-Source: APXvYqzkrIXzunc/uYXDhzL8/S19ckAbHFJkQVLLeYE2bCafJrJH6Liu3rFvQpCzPaVVKwxD7KM6Hg==
X-Received: by 2002:a5d:540f:: with SMTP id g15mr2026501wrv.86.1579254011010;
        Fri, 17 Jan 2020 01:40:11 -0800 (PST)
Received: from localhost (prg-ext-pat.suse.com. [213.151.95.130])
        by smtp.gmail.com with ESMTPSA id x16sm2876904wmk.35.2020.01.17.01.40.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2020 01:40:10 -0800 (PST)
Date:   Fri, 17 Jan 2020 10:40:09 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     Qian Cai <cai@lca.pw>, akpm@linux-foundation.org,
        sergey.senozhatsky.work@gmail.com, pmladek@suse.com,
        rostedt@goodmis.org, peterz@infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next v4] mm/hotplug: silence a lockdep splat with
 printk()
Message-ID: <20200117094009.GP19428@dhcp22.suse.cz>
References: <20200117022111.18807-1-cai@lca.pw>
 <d7068679-e28a-98a9-f5b8-49ea47f7c092@redhat.com>
 <20200117085932.GK19428@dhcp22.suse.cz>
 <b8aba013-16a8-8407-9330-8884d17b9594@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b8aba013-16a8-8407-9330-8884d17b9594@redhat.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 17-01-20 10:25:06, David Hildenbrand wrote:
> On 17.01.20 09:59, Michal Hocko wrote:
> > On Fri 17-01-20 09:51:05, David Hildenbrand wrote:
> >> On 17.01.20 03:21, Qian Cai wrote:
> > [...]
> >>> Even though has_unmovable_pages doesn't hold any reference to the
> >>> returned page this should be reasonably safe for the purpose of
> >>> reporting the page (dump_page) because it cannot be hotremoved. The
> >>
> >> This is only true in the context of memory unplug, but not in the
> >> context of is_mem_section_removable()-> is_pageblock_removable_nolock().
> > 
> > Well, the above should hold for that path as well AFAICS. If the page is
> > unmovable then a racing hotplug cannot remove it, right? Or do you
> > consider a temporary unmovability to be a problem?
> 
> Somebody could test /sys/devices/system/memory/memoryX/removable. While
> returning the unmovable page, it could become movable and
> offlining+removing could succeed.

Doesn't this path use device lock or something? If not than the new code
is not more racy then the existing one. Just look at
is_pageblock_removable_nolock and how it dereferences struct page
(page_zonenum in  page_zone.)
-- 
Michal Hocko
SUSE Labs
