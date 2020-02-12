Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4722C352A4
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 19:56:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72B05206B6
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 19:56:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wCji2WQ1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728984AbgBLT4e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 14:56:34 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:52436 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727439AbgBLT4e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 14:56:34 -0500
Received: by mail-wm1-f66.google.com with SMTP id p9so3713921wmc.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2020 11:56:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=qQ41iYMZO33MrUoyEW3Beg7Vzzsi5jGTe9Ra4Gt4eOs=;
        b=wCji2WQ1ILTnUjjzJRUz4oCz7XrV3NIrWY98W9S4feK3Hf3Gb7UzVvUMTQLGLQarhA
         Z71iDX5l+F6H0VteLOBcg5HtBY9V8U3aGfl0HftoKglz8RVxJIJ/v9h+AYYBS+cwtiGU
         ATv5gQtBTkukhhWvrOkoT+n4RX43Hvj/QBrCrzD9+fI3wGKBNDll1Ay90I52QtGEp5oa
         +2M1H6Jcq2pjVceTCsPUe8Oz3d+csREdnXV5Qm5S1GznGt8kP8T+vq1TFC8CmtZvAXx+
         +856xkwVgJqdGI9ZTnqPIr0t8ewOsNdmdXuzBa011faQw3rJ4E9D/kj5S/prQGPUrMA1
         28/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qQ41iYMZO33MrUoyEW3Beg7Vzzsi5jGTe9Ra4Gt4eOs=;
        b=id/kCwN5ytcyiC0LJmZTIgt+70hZcC0Tyv44wf5/bmmDZoE/cYqmVtZTrjy2xTrpGp
         vn7KEwR2R45dXcCt66a0Kol575nY9ONU5+EVdRLmrfoGpdpGc6P40D8+xKoRB2ZhW837
         FCRSgKr2lrimtxrRiqvVh8iy5ZBRN+GrHBZFRnPs3RYO7BeiT8aBorO9cBQC3lpm6T34
         XgdAfLNPsRu7OW5nk2rAj51yF+DvhuCh1QXwKWSZRUU1y1mU1M8Iqy9Et3HTCuKGUy3R
         kq1/vTCiiexmQVBltmoQnuKSXPsFIksJg8TjeGG83NFS8Befzmu0wdfCYgm/3rzDcCFD
         wSjg==
X-Gm-Message-State: APjAAAWU832nxEXM3rhuaCpLyCZ5LT0Fa5+S01tEwZkcWARd6WXFZcxw
        mlqylOMo9nCyDRiGVaGxUaBWrQ==
X-Google-Smtp-Source: APXvYqwEl9cQngn/7oDlMn7bWea1TxMCkOAElS0ziVIFCzxa+Eol6iOxsuuvkqztF8uDox/Brt/9lQ==
X-Received: by 2002:a7b:cbc9:: with SMTP id n9mr720068wmi.89.1581537392650;
        Wed, 12 Feb 2020 11:56:32 -0800 (PST)
Received: from google.com ([2a00:79e0:d:110:d6cc:2030:37c1:9964])
        by smtp.gmail.com with ESMTPSA id o4sm1846268wrx.25.2020.02.12.11.56.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2020 11:56:32 -0800 (PST)
Date:   Wed, 12 Feb 2020 19:56:28 +0000
From:   Quentin Perret <qperret@google.com>
To:     kbuild test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, masahiroy@kernel.org, nico@fluxnic.net,
        linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        maennich@google.com, kernel-team@android.com, jeyu@kernel.org,
        hch@infradead.org
Subject: Re: [PATCH v3 3/3] kbuild: generate autoksyms.h early
Message-ID: <20200212195628.GA120870@google.com>
References: <20200207180755.100561-4-qperret@google.com>
 <202002111002.wXBhAK5H%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202002111002.wXBhAK5H%lkp@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 11 Feb 2020 at 10:14:14 (+0800), kbuild test robot wrote:
> Hi Quentin,
> 
> Thank you for the patch! Yet something to improve:
> 
> [auto build test ERROR on kbuild/for-next]
> [also build test ERROR on linux/master linus/master v5.6-rc1 next-20200210]
> [if your patch is applied to the wrong git tree, please drop us a note to help
> improve the system. BTW, we also suggest to use '--base' option to specify the
> base tree in git format-patch, please see https://stackoverflow.com/a/37406982]
> 
> url:    https://github.com/0day-ci/linux/commits/Quentin-Perret/kbuild-allow-symbol-whitelisting-with-TRIM_UNUSED_KSYM/20200211-020659
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git for-next
> config: i386-randconfig-c002-20200211 (attached as .config)
> compiler: gcc-7 (Debian 7.5.0-4) 7.5.0
> reproduce:
>         # save the attached .config to linux build tree
>         make ARCH=i386 
> 
> If you fix the issue, kindly add following tag
> Reported-by: kbuild test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
> >> ERROR: "trace_event_raw_init" [lib/objagg.ko] undefined!
> >> ERROR: "trace_event_reg" [lib/objagg.ko] undefined!
> >> ERROR: "ida_destroy" [lib/objagg.ko] undefined!
> >> ERROR: "rhashtable_destroy" [lib/objagg.ko] undefined!
> >> ERROR: "kmalloc_order_trace" [lib/objagg.ko] undefined!
> >> ERROR: "sort" [lib/objagg.ko] undefined!
> >> ERROR: "__raw_spin_lock_init" [lib/objagg.ko] undefined!
> >> ERROR: "rhashtable_init" [lib/objagg.ko] undefined!
> >> ERROR: "rht_bucket_nested" [lib/objagg.ko] undefined!
> >> ERROR: "__list_del_entry_valid" [lib/objagg.ko] undefined!
> >> ERROR: "__rht_bucket_nested" [lib/objagg.ko] undefined!
> >> ERROR: "kmem_cache_alloc_trace" [lib/objagg.ko] undefined!
> >> ERROR: "kmalloc_caches" [lib/objagg.ko] undefined!
> >> ERROR: "queue_work_on" [lib/objagg.ko] undefined!
> >> ERROR: "system_wq" [lib/objagg.ko] undefined!
> >> ERROR: "kfree" [lib/objagg.ko] undefined!
> >> ERROR: "__list_add_valid" [lib/objagg.ko] undefined!
> >> ERROR: "lockdep_rht_bucket_is_held" [lib/objagg.ko] undefined!
> >> ERROR: "rhashtable_insert_slow" [lib/objagg.ko] undefined!
> >> ERROR: "__local_bh_enable_ip" [lib/objagg.ko] undefined!

I find myself unable to reproduce this error on my box. Could you please
provide the full build log ?

In the meantime I'll proceed to send a v4.

Thanks,
Quentin
