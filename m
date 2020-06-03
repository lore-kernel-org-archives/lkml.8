Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C59FC433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 19:27:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 800112067B
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 19:27:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jUsMlR1R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726186AbgFCT1J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 15:27:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725821AbgFCT1I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 15:27:08 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3B5AC08C5C0
        for <linux-kernel@vger.kernel.org>; Wed,  3 Jun 2020 12:27:07 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id 5so31385pjd.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jun 2020 12:27:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=ZSMftb7icpvsyoSXS5PItKRkVfeyWpaHE5r3DB6Xjaw=;
        b=jUsMlR1RT79CKfLxfCazzC5c3SsnKZ63d+zPHXbyKcdCsWKSVfVL3O2CEW/TfCKNCi
         ZYqei+/mQT997W4IhEAfGWVljykJk3lwib2/cbVClPBTho9E/LlyXw9BsLXswPqsuiPm
         rOs5eiSxxU+ZwsSWVsAuCOLj9oF8KdkAL393IKwjel24G+wdWoHq2V/5pwtgktNjlXkN
         XKkDzKg3+nLQzKp7awmKSzvi2dO62h3bd5TaQYNX2Hkx8nWVylnbc/7Hypkf2IwMPfhD
         mRV+Y3P45x4pzNdcRTkkBBPK3d/Gz08qKPXEEoI1UiT5uYsExgjiQDNd46eqDZ3Tk2t2
         ohHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=ZSMftb7icpvsyoSXS5PItKRkVfeyWpaHE5r3DB6Xjaw=;
        b=cSj3HrzKF/ZhwABQ5ta2GzHgcLcamcayXp0GVbptqdfEgkjk/ZYqDoiMz50AKCCZ+0
         rs8UP9wsh3xCRCHDPLQ56Hcio8VPMmHrRlILKHPjrPao1viXq9zXlACNT7iVUTA0IglN
         sp52dIBjMZ29o/VowByCDB8F+9DsPLYgPQdKeNYvI2789JDS5x+EQU8or92uK1gOk1NB
         IAWpCOsShN38CboJZ2SpVgW1Ecl0yGR89zo6JKTUrVzEQgTJquIywXUeEE1KPJBuA3Cu
         w4vSCuQdS6NOn6udQtRoev5++Sei0fwNqnvfu8N5i9SGsmF6cVbXBYf2QZNdpcdCP3eN
         oBxA==
X-Gm-Message-State: AOAM532LOrxcMRZRSwjhS6laQO6ga5QAjEizOa7zfvrjKQZ/wpCnvjy9
        Ege037KIdQ/uB1EPxxXL0nlkqA==
X-Google-Smtp-Source: ABdhPJxRTnU49ECTZHBARL7gCHB5oOpAcTXW29vDl04+N4qcbHdJif1wNxlxo4PGXqJS2xuxVsBC1w==
X-Received: by 2002:a17:902:6b4b:: with SMTP id g11mr1320561plt.9.1591212426385;
        Wed, 03 Jun 2020 12:27:06 -0700 (PDT)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id nl5sm3538815pjb.36.2020.06.03.12.27.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2020 12:27:05 -0700 (PDT)
Date:   Wed, 3 Jun 2020 12:27:05 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Vlastimil Babka <vbabka@suse.cz>
cc:     Gavin Guo <gavin.guo@canonical.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, akpm@linux-foundation.org,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: Re: [PATCH] mm: thp: Add new kernel parameters
 transparent_hugepage_defrag/khugepaged_defrag
In-Reply-To: <14faa6c7-6701-7a8e-3e88-4febee20f56e@suse.cz>
Message-ID: <alpine.DEB.2.22.394.2006031225100.43135@chino.kir.corp.google.com>
References: <20200603065049.11598-1-gavin.guo@canonical.com> <14faa6c7-6701-7a8e-3e88-4febee20f56e@suse.cz>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 Jun 2020, Vlastimil Babka wrote:

> > There is no way to set up the defrag options in boot time. And it's
> > useful to set it up by default instead of making it work by a
> > systemd/upstart service or put the command to set up defrag inside
> > /etc/rc.local.
> > 
> > Signed-off-by: Gavin Guo <gavin.guo@canonical.com>
> 
> Well, maybe isntead of adding these handlers, we could extend the new boot
> parameter sysctl support (handling procfs /proc/sys/) to sysfs (/sys) as well,
> as Eric already suggested? [1]
> 
> [1] https://lore.kernel.org/linux-api/87bloj2skm.fsf@x220.int.ebiederm.org/
> 

Fully agreed, I think the solution needs to be more generic since thp 
defrag isn't special here.  With the generic support to tune sysctls and 
sysfs tunables from the command line it seems like this patch would be 
redundant.
