Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC8A3C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 07:42:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 938EA206CC
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 07:42:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585554172;
	bh=jrUwRKTYqT8oJok1FsnBLDh3Az8SwQ/UPd4d3cwORFo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=evbBbAZvrCOONO5p7VSPVvh+gmWWqMDqNg5GPr1mc6BD+MYn9tYLWV+zYX9Xc0K0O
	 3rWQaTwfdmit52KkppstXejQZbDlHqZylFEkXOGjZZRT7epvtp5HZPaFi4XcW7SLzu
	 /dqh7zycgpJEnY0VPTFoJjVprtCMz38y9CQqvvog=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729534AbgC3Hmv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 03:42:51 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:52347 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728766AbgC3Hmv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 03:42:51 -0400
Received: by mail-wm1-f68.google.com with SMTP id z18so18869777wmk.2;
        Mon, 30 Mar 2020 00:42:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=G2GbSd8nfrGqlF2CTXpVag+1XrsMr3qO8HlwnrY50kI=;
        b=DdQdvAXnD2BSZexg1ZRcxL87E/iMhdISSAyNTZomPN1CicE9V6a+IHTVz2LjnN5+4j
         36K/+hJAljsLhNw9jcHROHDApJ6Ov1uwFyklR1LvSsN6l+/60o/bReQxIzq+5xzaQ5xO
         MIQWw78915u0dJ12Gr3vb88SY3t/LPw3iZ+pgKM+Iy3nf9u3Zx3Z4kSxW0vGoTEqhnTS
         ioNljitGjcJ4zCMV2uqovz9WE135tC9sEjPYOdaK1A3JnZMRW+AQzT2k1g7m6XqOhWAy
         KY+k5Y85bHudQPyCbjPlv2pqKTsPV6Hd1/bws/jBKhO/XBNoZOjlmTAMz0rBozI0MFfA
         yOAQ==
X-Gm-Message-State: ANhLgQ2Ep8CFsI5trTetWmeB+TaPqv+L32uvBcjXu24vVQEmvf18khk/
        bud+2/FV4Fpi8hnZ0G4/u/0=
X-Google-Smtp-Source: ADFU+vtTO40ug73YLnNFJoExcCn1PsdhzxCpQLzjsmdgJmi+fsq6hPq9O7t9QjqmLmc+CwVgWIwn6A==
X-Received: by 2002:a05:600c:4145:: with SMTP id h5mr11604265wmm.3.1585554168707;
        Mon, 30 Mar 2020 00:42:48 -0700 (PDT)
Received: from localhost (ip-37-188-180-223.eurotel.cz. [37.188.180.223])
        by smtp.gmail.com with ESMTPSA id 98sm21456009wrk.52.2020.03.30.00.42.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2020 00:42:47 -0700 (PDT)
Date:   Mon, 30 Mar 2020 09:42:46 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Hoan Tran <Hoan@os.amperecomputing.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Oscar Salvador <osalvador@suse.de>,
        Pavel Tatashin <pavel.tatashin@microsoft.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "David S. Miller" <davem@davemloft.net>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
        linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org,
        sparclinux@vger.kernel.org, x86@kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        lho@amperecomputing.com, mmorana@amperecomputing.com
Subject: Re: [PATCH v3 0/5] mm: Enable CONFIG_NODES_SPAN_OTHER_NODES by
 default for NUMA
Message-ID: <20200330074246.GA14243@dhcp22.suse.cz>
References: <1585420282-25630-1-git-send-email-Hoan@os.amperecomputing.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1585420282-25630-1-git-send-email-Hoan@os.amperecomputing.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat 28-03-20 11:31:17, Hoan Tran wrote:
> In NUMA layout which nodes have memory ranges that span across other nodes,
> the mm driver can detect the memory node id incorrectly.
> 
> For example, with layout below
> Node 0 address: 0000 xxxx 0000 xxxx
> Node 1 address: xxxx 1111 xxxx 1111
> 
> Note:
>  - Memory from low to high
>  - 0/1: Node id
>  - x: Invalid memory of a node
> 
> When mm probes the memory map, without CONFIG_NODES_SPAN_OTHER_NODES
> config, mm only checks the memory validity but not the node id.
> Because of that, Node 1 also detects the memory from node 0 as below
> when it scans from the start address to the end address of node 1.
> 
> Node 0 address: 0000 xxxx xxxx xxxx
> Node 1 address: xxxx 1111 1111 1111
> 
> This layout could occur on any architecture. Most of them enables
> this config by default with CONFIG_NUMA. This patch, by default, enables
> CONFIG_NODES_SPAN_OTHER_NODES or uses early_pfn_in_nid() for NUMA.

I am not opposed to this at all. It reduces the config space and that is
a good thing on its own. The history has shown that meory layout might
be really wild wrt NUMA. The config is only used for early_pfn_in_nid
which is clearly an overkill.

Your description doesn't really explain why this is safe though. The
history of this config is somehow messy, though. Mike has tried
to remove it a94b3ab7eab4 ("[PATCH] mm: remove arch independent
NODES_SPAN_OTHER_NODES") just to be reintroduced by 7516795739bd
("[PATCH] Reintroduce NODES_SPAN_OTHER_NODES for powerpc") without any
reasoning what so ever. This doesn't make it really easy see whether
reasons for reintroduction are still there. Maybe there are some subtle
dependencies. I do not see any TBH but that might be burried deep in an
arch specific code.

> v3:
>  * Revise the patch description
> 
> V2:
>  * Revise the patch description
> 
> Hoan Tran (5):
>   mm: Enable CONFIG_NODES_SPAN_OTHER_NODES by default for NUMA
>   powerpc: Kconfig: Remove CONFIG_NODES_SPAN_OTHER_NODES
>   x86: Kconfig: Remove CONFIG_NODES_SPAN_OTHER_NODES
>   sparc: Kconfig: Remove CONFIG_NODES_SPAN_OTHER_NODES
>   s390: Kconfig: Remove CONFIG_NODES_SPAN_OTHER_NODES
> 
>  arch/powerpc/Kconfig | 9 ---------
>  arch/s390/Kconfig    | 8 --------
>  arch/sparc/Kconfig   | 9 ---------
>  arch/x86/Kconfig     | 9 ---------
>  mm/page_alloc.c      | 2 +-
>  5 files changed, 1 insertion(+), 36 deletions(-)
> 
> -- 
> 1.8.3.1
> 

-- 
Michal Hocko
SUSE Labs
