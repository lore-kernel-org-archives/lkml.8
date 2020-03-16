Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFFDDC18E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 08:54:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88E2A20663
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 08:54:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584348871;
	bh=v7hXJ4QtlAS1nCeXylZunfs+0bqr321iM4wgN/aGXTE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=AGz14lwAnGCWVMESDLMMmFwTohHPGyhGZeUQ6JsTZXwCddjr52ndGRc+OsIZe8uzg
	 ZwBzOvh8n2j04Rx96vnW6O+2luuP6sP08FwEd2DYQJwH5MWQMgkLUcIB+UJJANdzdT
	 evaU3x9b7TctNdMMxrq8YKJTLXpu/K1Tqh/LHwt4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730386AbgCPIya (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 04:54:30 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:54092 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730131AbgCPIya (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 04:54:30 -0400
Received: by mail-wm1-f66.google.com with SMTP id 25so16657445wmk.3
        for <linux-kernel@vger.kernel.org>; Mon, 16 Mar 2020 01:54:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=oYVrvr0SPfoysj/NNmvUSSHpDs57n+aIQag0hdxed9Q=;
        b=bDnW7ZtF7HesZgM+hfU10AFngBAyRtXXp+/zvT2q+SsyDj/nBJeo6YjHh6cXu87Rf4
         QTKYpyH61XPKRzyqR1uMfV9d+NchTZkhu2xYY++llavLTjnX0DABK6QqmwgygjL0BV/t
         S5S3ghlNY4RYC6Zj+ZuPdaJDMnSzDeWm5UdDZQWccfnmvXXi3ZsVYGYBHe/i6AXydlPI
         6E1iXLS1rCdbFgodm5cQfI8l3h2KIKZkB1evFo680wTgDo/xBxtFFUqP1TsjV5sImiz1
         Lxg1E87sgKFfHMmq+UBtgfX9yP9S88bGCgpnhdxGLVQeaLkroQqMePAQC2OS82ViOkfv
         X6rA==
X-Gm-Message-State: ANhLgQ2v7QFxgOzuzawpMdKpL6QvJJz6wVQrBA4kjE1cDSwRRyhD6x9z
        qworOkXSPGzH6xRvhZGpHQw=
X-Google-Smtp-Source: ADFU+vtmZUZuH5KSxW2MgIvH0EKbLpsX37ml/XOZS0AIAJE35PQu3muHqSe7FqIS923IhbPKrfZNlQ==
X-Received: by 2002:a7b:c92a:: with SMTP id h10mr26017913wml.26.1584348868140;
        Mon, 16 Mar 2020 01:54:28 -0700 (PDT)
Received: from localhost (ip-37-188-254-25.eurotel.cz. [37.188.254.25])
        by smtp.gmail.com with ESMTPSA id o3sm31430395wme.36.2020.03.16.01.54.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2020 01:54:27 -0700 (PDT)
Date:   Mon, 16 Mar 2020 09:54:25 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Christopher Lameter <cl@linux.com>
Cc:     Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Mel Gorman <mgorman@suse.de>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 3/3] mm/page_alloc: Keep memoryless cpuless node 0 offline
Message-ID: <20200316085425.GB11482@dhcp22.suse.cz>
References: <20200311110237.5731-1-srikar@linux.vnet.ibm.com>
 <20200311110237.5731-4-srikar@linux.vnet.ibm.com>
 <alpine.DEB.2.21.2003151416230.14449@www.lameter.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.2003151416230.14449@www.lameter.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun 15-03-20 14:20:05, Cristopher Lameter wrote:
> On Wed, 11 Mar 2020, Srikar Dronamraju wrote:
> 
> > Currently Linux kernel with CONFIG_NUMA on a system with multiple
> > possible nodes, marks node 0 as online at boot.  However in practice,
> > there are systems which have node 0 as memoryless and cpuless.
> 
> Would it not be better and simpler to require that node 0 always has
> memory (and processors)? A  mininum operational set?

I do not think you can simply ignore the reality. I cannot say that I am
a fan of memoryless/cpuless numa configurations but they are a sad
reality of different LPAR configurations. We have to deal with them.
Besides that I do not really see any strong technical arguments to lack
a support for those crippled configurations. We do have zonelists that
allow to do reasonable decisions on memoryless nodes. So no, I do not
think that this is a viable approach.

> We can dynamically number the nodes right? So just make sure that the
> firmware properly creates memory on node 0?

Are you suggesting that the OS would renumber NUMA nodes coming
from FW just to satisfy node 0 existence? If yes then I believe this is
really a bad idea because it would make HW/LPAR configuration matching
to the resulting memory layout really hard to follow.

-- 
Michal Hocko
SUSE Labs
