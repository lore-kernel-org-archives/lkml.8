Return-Path: <SRS0=dmjt=BL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C72D0C433E1
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Aug 2020 02:17:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A856A2083B
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Aug 2020 02:17:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kOp5n2iZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728247AbgHACRW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 22:17:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727047AbgHACRV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 22:17:21 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8CE8C06174A
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jul 2020 19:17:21 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id s23so24482536qtq.12
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jul 2020 19:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=551gxb/V4cTHIiiIvEHAlAkEOZo6GSnjWtQQen+5b6w=;
        b=kOp5n2iZXKZcz2c1X475lqnIm8vIuCa31L9u9JzJGWOkwWQbIQLlZ+H1amAAkf7QHz
         XgJ44qXJ+jM3HedbEquCiofO6qhNMjEnMpuqlRXhrGPiz62cxjy+LBGVuJGGZiD5cI79
         sNV/5JsZtDcTbbGvs8Xx/qDgH4VKyZTgGqM1tXIbCvO+fKPIWWCy55t6XmV+OJ/7WbID
         ab4tZEkFPTd1ROZ/MT0fTdfVNwA2ucD+CJ0qbNV/nyTcMshplVmt9Ic2H/yoffvBXkjT
         /09Eg4qld3E0biyLZHdIXHcXQOvs+NPZwv0mWR23SQWtkTsnYJIsP0PUYtD5hSB3n496
         8ndQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=551gxb/V4cTHIiiIvEHAlAkEOZo6GSnjWtQQen+5b6w=;
        b=rUDzHUE+ZEKWC7WRyuMXLPQLArWVmzqIQrTrXpTe3Ho+47Xm61NIF9bkHRD9CEUpkt
         OVyh5ACrbwWweq72Y3mLgvWClAHG5VxKhrcKx0pVH0KndYypkYMxxf4E0pYrRJpBLCws
         6KedVEO37pOCETGdsTkYShBW7CyGyEDA/AplqRHaCWn4eEIJhnKmNPjc2i8kFmYDnZfn
         h1J5+3h2EbQodI+PgWEiZgIO04cQjd1YgzciPc+ACowbRo/59QKg822U7GQW9mn3sZr3
         Ua3yOAwx8EkOe3tNT1tKt0iTMl5EO+kqeXA+2WnfFjwfjefYM/t7dJkQK0Y7xcFDkD19
         74AA==
X-Gm-Message-State: AOAM532hXkk15B1MvNKbC421hThaOCx8VFNDUz43cPnNjnh8VeJ9T9Ie
        bJOLwuDaNoWm2XoU9AoW6hEo+g==
X-Google-Smtp-Source: ABdhPJz3gH++78Vvmmq9ZZ1hzxWOKmU7mlavMunGl3Se40mVR64wiolL/i1HG7NMo1VevX15NFmYRQ==
X-Received: by 2002:ac8:7402:: with SMTP id p2mr6521959qtq.19.1596248240453;
        Fri, 31 Jul 2020 19:17:20 -0700 (PDT)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 78sm11130904qke.81.2020.07.31.19.17.18
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Fri, 31 Jul 2020 19:17:19 -0700 (PDT)
Date:   Fri, 31 Jul 2020 19:17:05 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Roman Gushchin <guro@fb.com>
cc:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
        kernel-team@fb.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm: vmstat: fix /proc/sys/vm/stat_refresh generating
 false warnings
In-Reply-To: <20200801011821.GA859734@carbon.dhcp.thefacebook.com>
Message-ID: <alpine.LSU.2.11.2007311915130.9716@eggly.anvils>
References: <20200714173920.3319063-1-guro@fb.com> <alpine.LSU.2.11.2007291902340.6363@eggly.anvils> <20200730162348.GA679955@carbon.dhcp.thefacebook.com> <alpine.LSU.2.11.2007302018350.2410@eggly.anvils>
 <20200801011821.GA859734@carbon.dhcp.thefacebook.com>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 31 Jul 2020, Roman Gushchin wrote:
> On Thu, Jul 30, 2020 at 09:06:55PM -0700, Hugh Dickins wrote:
> > 
> > Though another alternative did occur to me overnight: we could
> > scrap the logged warning, and show "nr_whatever -53" as output
> > from /proc/sys/vm/stat_refresh: that too would be acceptable
> > to me, and you redirect to /dev/null.
> 
> It sounds like a good idea to me. Do you want me to prepare a patch?

Yes, if you like that one best, please do prepare a patch - thanks!

Hugh
