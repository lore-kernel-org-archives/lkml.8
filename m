Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AF7CC10F29
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 14:01:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 548A721D7E
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 14:01:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="AKz+U+gF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727061AbgCIOBy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 10:01:54 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:39306 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727005AbgCIOBx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 10:01:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Transfer-Encoding
        :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=DtQS5O0hQQwBgslAAVUsLKrdeW4x55wzUHWwe5NBXGg=; b=AKz+U+gFd1aSjmGlOvFl3PMm/b
        V7ONgOBVPBl+LL+p0e6IvqZ9/ozi330UJkt1sWFzRdl7nbvTTG6DJiDiwV7J8/+QZ0YDwaRciyNJo
        Rro7rJqhN5dRSGYtmiMoE4wSmS/BVzgrY43a87z+SVWEff4i5mPG2HqgB8PnP/9i1l++pV2zidf3p
        ZyamoK9q1HN0wGGfvcRcbj/QJbtznsHgtLTgMg6hPhw6m9icokvLvNsTfxZAPfeXFM1NS7GRMP74d
        4nx6vc9kYOYsJtD+Zww81MFJZSiNn1NZPXzZJR4s36B3StLeyITITlmZhNL9pAk5kT/kEgEv5NI9E
        G5Qme7rw==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jBIya-0002i3-QM; Mon, 09 Mar 2020 14:01:48 +0000
Date:   Mon, 9 Mar 2020 07:01:48 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Jaewon Kim <jaewon31.kim@samsung.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, walken@google.com,
        bp@suse.de, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        jaewon31.kim@gmail.com
Subject: Re: [PATCH] mm: mmap: show vm_unmapped_area error log
Message-ID: <20200309140148.GK31215@bombadil.infradead.org>
References: <CGME20200304030211epcas1p4da8cb569947aefb3aad1da039aaabce4@epcas1p4.samsung.com>
 <20200304030206.1706-1-jaewon31.kim@samsung.com>
 <5E605749.9050509@samsung.com>
 <20200305202443.8de3598558336b1d75afbba7@linux-foundation.org>
 <5E61EAB6.5080609@samsung.com>
 <20200307154744.acd523831b45efa8d0fc1dfa@linux-foundation.org>
 <20200308015802.GD31215@bombadil.infradead.org>
 <5E64C1D7.3000208@samsung.com>
 <20200308123616.GH31215@bombadil.infradead.org>
 <5E660863.2090104@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5E660863.2090104@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 09, 2020 at 06:12:03PM +0900, Jaewon Kim wrote:
> On 2020년 03월 08일 21:36, Matthew Wilcox wrote:
> > On Sun, Mar 08, 2020 at 06:58:47PM +0900, Jaewon Kim wrote:
> >> On 2020년 03월 08일 10:58, Matthew Wilcox wrote:
> >>> On Sat, Mar 07, 2020 at 03:47:44PM -0800, Andrew Morton wrote:
> >>>> On Fri, 6 Mar 2020 15:16:22 +0900 Jaewon Kim <jaewon31.kim@samsung.com> wrote:
> >>>>> Even on 64 bit kernel, the mmap failure can happen for a 32 bit task.
> >>>>> Virtual memory space shortage of a task on mmap is reported to userspace
> >>>>> as -ENOMEM. It can be confused as physical memory shortage of overall
> >>>>> system.
> >>> But userspace can trigger this printk.  We don't usually allow printks
> >>> under those circumstances, even ratelimited.
> >> Hello thank you your comment.
> >>
> >> Yes, userspace can trigger printk, but this was useful for to know why
> >> a userspace task was crashed. There seems to be still many userspace
> >> applications which did not check error of mmap and access invalid address.
> >>
> >> Additionally in my AARCH64 Android environment, display driver tries to
> >> get userspace address to map its display memory. The display driver
> >> report -ENOMEM from vm_unmapped_area and but also from GPU related
> >> address space.
> >>
> >> Please let me know your comment again if this debug is now allowed
> >> in that userspace triggered perspective.
> > The scenario that worries us is an attacker being able to fill the log
> > files and so also fill (eg) the /var partition.  Once it's full, future
> > kernel messages cannot be stored anywhere and so there will be no traces
> > of their privilege escalation.
> Although up to 10 times within 5 secs is not many, I think those log may remove
> other important log in log buffer if it is the system which produces very few log.
> In my Android phone device system, there seems to be much more kernel log though.

I've never seen the logs on my android phone.  All that a ratelimit is
going to do is make the attacker be more patient.

> > Maybe a tracepoint would be a better idea?  Usually they are disabled,
> > but they can be enabled by a sysadmin to gain insight into why an
> > application is crashing.
> In Android phone device system, we cannot get sysadmin permission if it is built
> for end user. And it is not easy to reproduce this symptom because it is an user's app.
> 
> Anyway let me try pr_devel_ratelimited which is disabled by default. I hope this is
> good enough. Additionally I moved the code from mm.h to mmap.c.

https://source.android.com/devices/tech/debug/ftrace
