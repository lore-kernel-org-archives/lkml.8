Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F141C10DCE
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 13:03:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4573A2084E
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 13:03:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HGbxSKDO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727000AbgCFNDJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 08:03:09 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:35306 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726704AbgCFNDJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 08:03:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583499788;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AeNZCzKp4mmhDEQbTbjcCIj/A6BgEDT9MrAVKVagARs=;
        b=HGbxSKDOJsKgfkbZV2frfF4pRwQuVPUu6c7t+cPgmTb4ozTpwyTTi3EHjeAqLbCCqaCADu
        fvsekQ5n8rOMFVBGO8aIPNF87E0YtLxxXxJ9vlmlX0937vEMf8jWy+w+oRYtdVCvnz09QB
        tSP0wYNfFbhhNI7H3NAc1jtsdJpfra8=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-229-m3LY9_CRMfe2DM-pJmiFBA-1; Fri, 06 Mar 2020 08:03:06 -0500
X-MC-Unique: m3LY9_CRMfe2DM-pJmiFBA-1
Received: by mail-wr1-f70.google.com with SMTP id b12so975167wro.4
        for <linux-kernel@vger.kernel.org>; Fri, 06 Mar 2020 05:03:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=AeNZCzKp4mmhDEQbTbjcCIj/A6BgEDT9MrAVKVagARs=;
        b=FqVWWTGRXap5y0HXaNSfblIBCl/9RlCfD1L1OO7VKSeddtZCYyezztTgltQUPlvx5j
         xoExr0Kgy1ohMl5kWZ2UTdL0zHaxyIDcRFW5cQM5lVlkNAz5R3vf2Z+P4D/A2ppEJpSo
         WLgnugAPVwDut7USQmqqefHh9zjFYTdUcucjTWlJsGZae1bwJBnS2Z4Jr6XQnpI10vZC
         XmWJ5nkbHXt0y/uD4q/mTrOslcG9O6d7EzsyvAye2Bo2gFNiGzLsD1zEPTPMsnz5gaU4
         BnTc4YM74h9M6CvYTSxBjdPW2u3n6he0BaPISiU0ks8nrajG04U8jEjEOBl620lvazPO
         kerg==
X-Gm-Message-State: ANhLgQ0XsqHMVDqoVkiXqSu9at6Kw3O4BOBhuX2FNzyu2YDmld+MbuJh
        E9jJDuPTy4a8lOCAIQ3bsDYgztoyCvISCz7453R+q+o8TMWAbtSd11mDdtoGJXnBmV88S4qXqo+
        Ka/8JW+gAxE8KNueuDAR+atqF
X-Received: by 2002:a7b:ce16:: with SMTP id m22mr3898430wmc.139.1583499785757;
        Fri, 06 Mar 2020 05:03:05 -0800 (PST)
X-Google-Smtp-Source: ADFU+vvEnwGXyafS3KsWnNfbGv3ywCKKxQujnkoCIP1TlH3Tk+PhNccmC+8J7KvT/3Xm1mYySmUIUA==
X-Received: by 2002:a7b:ce16:: with SMTP id m22mr3898394wmc.139.1583499785507;
        Fri, 06 Mar 2020 05:03:05 -0800 (PST)
Received: from localhost ([2001:470:5b39:28:1273:be38:bc73:5c36])
        by smtp.gmail.com with ESMTPSA id u8sm4029986wrn.69.2020.03.06.05.03.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2020 05:03:03 -0800 (PST)
Date:   Fri, 6 Mar 2020 14:03:03 +0100
From:   Oleksandr Natalenko <oleksandr@redhat.com>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>, linux-api@vger.kernel.org,
        Suren Baghdasaryan <surenb@google.com>,
        Tim Murray <timmurray@google.com>,
        Daniel Colascione <dancol@google.com>,
        Sandeep Patil <sspatil@google.com>,
        Sonny Rao <sonnyrao@google.com>,
        Brian Geffon <bgeffon@google.com>,
        Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shakeel Butt <shakeelb@google.com>,
        John Dias <joaodias@google.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Jann Horn <jannh@google.com>,
        alexander.h.duyck@linux.intel.com, sj38.park@gmail.com
Subject: Re: [PATCH v7 6/7] mm/madvise: employ mmget_still_valid for write
 lock
Message-ID: <20200306130303.kztv64f52qknxb6k@butterfly.localdomain>
References: <20200302193630.68771-1-minchan@kernel.org>
 <20200302193630.68771-7-minchan@kernel.org>
 <d21c85b2-2493-e538-5419-79cf049a469e@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d21c85b2-2493-e538-5419-79cf049a469e@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

On Fri, Mar 06, 2020 at 01:52:07PM +0100, Vlastimil Babka wrote:
> > diff --git a/mm/madvise.c b/mm/madvise.c
> > index e794367f681e..e77c6c1fad34 100644
> > --- a/mm/madvise.c
> > +++ b/mm/madvise.c
> > @@ -1118,6 +1118,8 @@ int do_madvise(struct task_struct *target_task, struct mm_struct *mm,
> >  	if (write) {
> >  		if (down_write_killable(&mm->mmap_sem))
> >  			return -EINTR;
> > +		if (current->mm != mm && !mmget_still_valid(mm))
> > +			goto skip_mm;
> 
> This will return 0, is that correct? Shoudln't there be a similar error e.g. as
> when finding the task by pid fails (-ESRCH ?), because IIUC the task here is
> going away and dumping the core?

Yeah.

Something like this then:

===
diff --git a/mm/madvise.c b/mm/madvise.c
index 48d1da08c160..7ed2f4d13924 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -1122,6 +1122,10 @@ int do_madvise(struct task_struct *target_task, struct mm_struct *mm,
 	if (write) {
 		if (down_write_killable(&mm->mmap_sem))
 			return -EINTR;
+		if (current->mm != mm && !mmget_still_valid(mm)) {
+			error = -ESRCH;
+			goto skip_mm;
+		}
 	} else {
 		down_read(&mm->mmap_sem);
 	}
@@ -1173,6 +1177,7 @@ int do_madvise(struct task_struct *target_task, struct mm_struct *mm,
 	}
 out:
 	blk_finish_plug(&plug);
+skip_mm:
 	if (write)
 		up_write(&mm->mmap_sem);
 	else

===

?

> 
> >  	} else {
> >  		down_read(&mm->mmap_sem);
> >  	}
> > @@ -1169,6 +1171,7 @@ int do_madvise(struct task_struct *target_task, struct mm_struct *mm,
> >  	}
> >  out:
> >  	blk_finish_plug(&plug);
> > +skip_mm:
> >  	if (write)
> >  		up_write(&mm->mmap_sem);
> >  	else
> > 
> 

-- 
  Best regards,
    Oleksandr Natalenko (post-factum)
    Principal Software Maintenance Engineer

