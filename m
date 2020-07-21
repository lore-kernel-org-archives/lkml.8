Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A1A9C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 13:23:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 757BE21702
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 13:23:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="K3+TBw5i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726617AbgGUNX4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 09:23:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726192AbgGUNXz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 09:23:55 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DB45C061794
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 06:23:55 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id u64so5954129qka.12
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 06:23:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=Vl6nY10QRE8L9pFubciH3YlE4tKocCVwUrJH3mwnBNc=;
        b=K3+TBw5iH3oRutMINHodqnnpw+ILqFjg71lC1X6m2kb6Md5rz6bvLqUnKDsBG79NFA
         bD9XgacSi+rNHjzxTKWyhnKE0EwnRmMA0uqL/Gw28wU/WeC/IDenPPdM3k735pwZwOIK
         zEOGEKF1kGb+e2BHjiP29JtPH14KxtHu0sXS1Og2BxaOFOwU7Y6OySeHBTTgbBXydcai
         QC/y9HFU3zXTKyAhVHT1FE8b1Ou8A66+ObgK/9fvElBuVI+NYG4hcAQ5/ZgSlWJa0hwe
         rG9dJpVxutJwZiocT75qbFHgj+QR9L45EGHmHgB1hUQ7BemEam6RjuGqsoFsFHjrw/2l
         dNJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=Vl6nY10QRE8L9pFubciH3YlE4tKocCVwUrJH3mwnBNc=;
        b=JgG2LD8Htb+9ZwcM5RcX/foJQ106br7r6v6c1WfLHvnp/Up5LI1G4jT7+YvutJvUcp
         ZMvK5AD4I9QWFkf4PbpJ9y+zvpK8aWjwIfqtbcpX7Kh1Dzj/3jPmj0XuM1SKfQKTd2GQ
         tA14q06VSSGF55KylzMSAuQpK0wTVG2P6yh8R71R8Ozep63wVrjadVc3WzfqOD1pna+v
         tL6a8F5MPllGxipYVY/gRPxb1IkNJ6flengf1MDK6ZSSWS6IOFLcgp5pPZto3Ewe+cvK
         7cMh2uARlc8TcD+mglxeiKpHXJweeJiZ109cqJo/cjnZ/QBsdoOWnLyfTrj2Gzp3jy9m
         cSJA==
X-Gm-Message-State: AOAM532aZ93WPnQKJyn+spPEGu4fJaGUCkeWgF71YnrokXx65sCT3Bj6
        RVzTSvXmydcGpEZpcvfe/BA2TQ==
X-Google-Smtp-Source: ABdhPJzl8onqElLOVMngr7Mjj6E5F8oxQRuWOzRxb7/vM5+xWcBHat5t/y9eyqyKmBhLBTIcGC1SOQ==
X-Received: by 2002:ae9:dfc2:: with SMTP id t185mr8700616qkf.49.1595337834564;
        Tue, 21 Jul 2020 06:23:54 -0700 (PDT)
Received: from lca.pw (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id a5sm22832242qtd.84.2020.07.21.06.23.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2020 06:23:54 -0700 (PDT)
Date:   Tue, 21 Jul 2020 09:23:44 -0400
From:   Qian Cai <cai@lca.pw>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tim Chen <tim.c.chen@linux.intel.com>
Subject: Re: [RFC PATCH] mm: silence soft lockups from unlock_page
Message-ID: <20200721132343.GA4261@lca.pw>
References: <20200721112529.GJ4061@dhcp22.suse.cz>
 <664A07B6-DBCD-4520-84F1-241A4E7A339F@lca.pw>
 <20200721121752.GK4061@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200721121752.GK4061@dhcp22.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 21, 2020 at 02:17:52PM +0200, Michal Hocko wrote:
> On Tue 21-07-20 07:44:07, Qian Cai wrote:
> > 
> > 
> > > On Jul 21, 2020, at 7:25 AM, Michal Hocko <mhocko@kernel.org> wrote:
> > > 
> > > Are these really important? I believe I can dig that out from the bug
> > > report but I didn't really consider that important enough.
> > 
> > Please dig them out. We have also been running those things on
> > “large” powerpc as well and never saw such soft-lockups. Those
> > details may give us some clues about the actual problem.
> 
> I strongly suspect this is not really relevant but just FYI this is
> 16Node, 11.9TB with 1536CPUs system.

Okay, we are now talking about the HPC special case. Just brain-storming some
ideas here.


1) What about increase the soft-lockup threshold early at boot and restore
afterwards? As far as I can tell, those soft-lockups are just a few bursts of
things and then cure itself after the booting.

2) Reading through the comments above page_waitqueue(), it said rare hash
collisions could happen, so sounds like in this HPC case, it is rather easy to
hit those hash collisons. Thus, need to deal with that instead?

3) The commit 62906027091f ("mm: add PageWaiters indicating tasks are waiting
for a page bit") mentioned that,

"Putting two bits in the same word opens the opportunity to remove the memory
barrier between clearing the lock bit and testing the waiters bit, after some
work on the arch primitives (e.g., ensuring memory operand widths match and
cover both bits)."

Do you happen to know if this only happen on powerpc? Also, probably need to
dig out if those memory barrier is still there that could be removed to speed
up things.

> 
> > Once we
> > understand the problem better, we may judge if this “hack” is
> > really worth it.
> 
> I do not have access to the machine so I can only judge from the boot
> log I have in hands. And from that it is pretty clear that 
> $ grep BUG tmp/attachment.txt | wc -l
> 896
> 
> $ grep BUG tmp/attachment.txt | grep "\[systemd" | wc -l
> 860
> 
> $ grep do_fault+0x448 tmp/attachment.txt | wc -l
> 860
> 
> that the boot struggles, lockups happen from udev workers and most of
> them are stuck at the very same place which is unlock_page. The rest is
> a part of the changelog.
> -- 
> Michal Hocko
> SUSE Labs
