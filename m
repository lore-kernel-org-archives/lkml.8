Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B12B4C433E2
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 12:17:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 877DC22CF6
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 12:17:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595333878;
	bh=Spt2Exb8HT7Dykg3qDYB/7gUc4yxbpePjA2NDk2Rt9A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=DzfMcR8KRGcJDTXzJzfXM8wOkCzx996IDgcN171nKk/4eWV4XiOLL4SWm9/1LcBgG
	 9SLDdly2WK3nwsDlyuDav4oAXwqqYdNoocZzCAgotYKzW09HEY2wm9kZm4alaC4VMX
	 +x9yqJGqZFGEPeEaDo9ALNayWLzEkExBTaRfJduc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729927AbgGUMR5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 08:17:57 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33587 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726715AbgGUMR4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 08:17:56 -0400
Received: by mail-wr1-f66.google.com with SMTP id f18so21033023wrs.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 05:17:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=dJvVQh1+L1IfifarBH4M4EwzY4CvwCn4HIgD+1uPERQ=;
        b=mgN7wA1dBxVrnfCi1HLaMnN+bZMq1MLSXA+lq0VBoctQpivPT7uhIuCByGUCuVsbsk
         ZuSTb2bU/ryVrNbtdLQAk0O+CFY5U4BzTWypx067Oup53MR3VuXwwYaUfwJ3udz3S7t2
         4i4rZg+Pk7DQ62UmPvRH1pQTUGtUbmuR8JXwhFfsBRhUWJ6LANtYYveDxA5JdRQKvTdL
         cU8NeO+GHWusQPqt/Bd+a7WfSh7meUenrqfQI3UiXuJERMhCYeACMrRpf11HeaiAf7Jj
         QjtMcpJLI6BYiGluxvZmCe1zjmA3WmddlwsEhUoGS0Rtfr6abpoz6kpdLNTmz4DrtvHK
         mftA==
X-Gm-Message-State: AOAM533n93ekl1qysNyRNIZGzQVc2N3FI+UF65CDUU/xWMrR+wGgEH40
        N7BaQjx2CC/FoRi0z3ZWj68=
X-Google-Smtp-Source: ABdhPJwDGRt8F636vOy7k2pds/V9jjrF0/7h59KQuRE0uck5kZSb5Vaw2he31fwyAFBLJb7El9Qg7A==
X-Received: by 2002:a5d:5651:: with SMTP id j17mr25144930wrw.145.1595333874568;
        Tue, 21 Jul 2020 05:17:54 -0700 (PDT)
Received: from localhost (ip-37-188-169-187.eurotel.cz. [37.188.169.187])
        by smtp.gmail.com with ESMTPSA id c17sm23700986wrc.42.2020.07.21.05.17.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2020 05:17:53 -0700 (PDT)
Date:   Tue, 21 Jul 2020 14:17:52 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Qian Cai <cai@lca.pw>
Cc:     linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tim Chen <tim.c.chen@linux.intel.com>
Subject: Re: [RFC PATCH] mm: silence soft lockups from unlock_page
Message-ID: <20200721121752.GK4061@dhcp22.suse.cz>
References: <20200721112529.GJ4061@dhcp22.suse.cz>
 <664A07B6-DBCD-4520-84F1-241A4E7A339F@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <664A07B6-DBCD-4520-84F1-241A4E7A339F@lca.pw>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 21-07-20 07:44:07, Qian Cai wrote:
> 
> 
> > On Jul 21, 2020, at 7:25 AM, Michal Hocko <mhocko@kernel.org> wrote:
> > 
> > Are these really important? I believe I can dig that out from the bug
> > report but I didn't really consider that important enough.
> 
> Please dig them out. We have also been running those things on
> “large” powerpc as well and never saw such soft-lockups. Those
> details may give us some clues about the actual problem.

I strongly suspect this is not really relevant but just FYI this is
16Node, 11.9TB with 1536CPUs system.

> Once we
> understand the problem better, we may judge if this “hack” is
> really worth it.

I do not have access to the machine so I can only judge from the boot
log I have in hands. And from that it is pretty clear that 
$ grep BUG tmp/attachment.txt | wc -l
896

$ grep BUG tmp/attachment.txt | grep "\[systemd" | wc -l
860

$ grep do_fault+0x448 tmp/attachment.txt | wc -l
860

that the boot struggles, lockups happen from udev workers and most of
them are stuck at the very same place which is unlock_page. The rest is
a part of the changelog.
-- 
Michal Hocko
SUSE Labs
