Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57386C433E6
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 11:25:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 30F422064C
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 11:25:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595330735;
	bh=7A5kQtDDM/GtMDMbKqd8YEx9XpKSoyPCfQAMnX1dy4U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=IMGbaoizbxNJ0pblUy+fT41UmaxRFcyJ/0sG+Wo8POz83Qzmxu/gbjV2TF4SllN8G
	 l4+uGwxMKeRLRFe6wXMTxxsd75ddAV7uBB7RbRebxPyb1Zd39fBAvk5d5nN7rmLH5O
	 ombzIuJIi/R0hscguxuJSQArgWBc2UKBKi0Xgm4w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729695AbgGULZd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 07:25:33 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:46008 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728108AbgGULZd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 07:25:33 -0400
Received: by mail-wr1-f66.google.com with SMTP id s10so20773972wrw.12
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 04:25:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=eDTdOZ1dDPKD1UqSkexaZR5dMf1fmObppvOA9WWtcgo=;
        b=oyiOxy2/AXmOtGdpulNKvZqs63SrUho3mMqn10p/Rg8TxTq2vsHPwHjOaVGGgzboxq
         ccmU6ET2WiVAmiD8N+fMdgmtLg21QxmtN0bCE83cSATqOVo6KhcSU4X835UBVdT4GaSe
         xooh8ZRzKG1CqxJx519zEU+BPg1/R3UDEqiK5Fc+G1NKz0OUzytwM/QmxhibrM38s9PF
         5KexqlnBLiNCI3G8xWaGZM3XKPEK6J9GmMwnkKY+zluvmmNfBl6oz7+xTysz/T7u/s06
         kfykmNcuyQJVkf5eyvoZNft86cS7LjTrEfE7BUTw0t5YYwIekZDhtlPpoGmvHWO9Tlhk
         dVBA==
X-Gm-Message-State: AOAM5338e80JIIqfMWMtgQ/YdxqA2ik7i4X2XPoXolX2OzpOlgUGPoLe
        Cl3xhKquGpCmkccy24Vk3WQ=
X-Google-Smtp-Source: ABdhPJzZKaTi9QRRHmX+Uo51vDunXQdue9WmRqUSRKPrkIu061TGYiIPW/mozoV1jdvTv2eoWOEt+Q==
X-Received: by 2002:a5d:4b0c:: with SMTP id v12mr17163309wrq.199.1595330731618;
        Tue, 21 Jul 2020 04:25:31 -0700 (PDT)
Received: from localhost (ip-37-188-169-187.eurotel.cz. [37.188.169.187])
        by smtp.gmail.com with ESMTPSA id o21sm3068116wmh.18.2020.07.21.04.25.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2020 04:25:30 -0700 (PDT)
Date:   Tue, 21 Jul 2020 13:25:29 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Qian Cai <cai@lca.pw>
Cc:     linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tim Chen <tim.c.chen@linux.intel.com>
Subject: Re: [RFC PATCH] mm: silence soft lockups from unlock_page
Message-ID: <20200721112529.GJ4061@dhcp22.suse.cz>
References: <20200721063258.17140-1-mhocko@kernel.org>
 <FCC3EB2D-9F11-4E9E-88F4-40B2926B35CC@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <FCC3EB2D-9F11-4E9E-88F4-40B2926B35CC@lca.pw>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 21-07-20 07:10:14, Qian Cai wrote:
> 
> 
> > On Jul 21, 2020, at 2:33 AM, Michal Hocko <mhocko@kernel.org> wrote:
> > 
> > on a large ppc machine. The very likely cause is a suboptimal
> > configuration when systed-udev spawns way too many workders to bring the
> > system up.
> 
> This is strange. The problem description is missing quite a few
> important details. For example, what systems exactly are those? How
> many CPUs, memory and NUMA nodes were you talking about?

Are these really important? I believe I can dig that out from the bug
report but I didn't really consider that important enough.

> Which kernel version was it reported?

It is a SLES 4.12 based kernel with the said commit backported. The page
lock internals are thus in line with the upstream kernel.

> How many workers from systemd-udev was “misconfigured”?

I do not know that information. I believe that it used whatever systemd
comes with as a default. And that can be a lot.

Do you have any actual feedback to the patch?

-- 
Michal Hocko
SUSE Labs
