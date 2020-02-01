Return-Path: <SRS0=DSTS=3V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23F24C33C9E
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Feb 2020 08:07:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E851C20679
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Feb 2020 08:07:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hRi0IFDa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726387AbgBAIHn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Feb 2020 03:07:43 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:40224 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725992AbgBAIHm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Feb 2020 03:07:42 -0500
Received: by mail-pl1-f193.google.com with SMTP id y1so3739903plp.7
        for <linux-kernel@vger.kernel.org>; Sat, 01 Feb 2020 00:07:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=5nTO1YAVmPYSrJV28ycJBVRQxudQyA//ln8alpueGps=;
        b=hRi0IFDaZn1lUYPec0qzmBKxfP6Dp5z1ASVzko/oGim4N6t0iTqI+Rq5GJ79UGsZk4
         jIRbBfvCFm83PIOe/5646uAh8jt4ocQYU7CEHv9EaZyOIkDfQJ9B0eKkb/7GfYVLo1ZC
         oT3GwN2WPDGuMq08oWbz6KJEkiqFMhXvoyPFKdSfX4BqTu3KPBWk8GM7IravPiATD710
         u1Ky4J0jaFm2nfXfZQ7BdWnQ99puOsxnndHxi1tGJGEDuIzRsHT9SvDlkLH8dC8h4P04
         jCjbN95qHqHt8huMtBcMIA+bc+hjyvdgw8SpcIWGUvLa8yXcIadvVzgWnZPdbi6GUbDb
         ItuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=5nTO1YAVmPYSrJV28ycJBVRQxudQyA//ln8alpueGps=;
        b=EgXds3/Dkam39SOXmB/u5ozH8/ZxzTlbd3JumwAyt8RUUU3FxndJrhW4b3XgMtZgXQ
         FcNWYy27l3DYTb2rG1xSAYy4UdwfIaDnI6GGLhYEyBQ3BXwztUX2+qGPS4SxzKQ+B62E
         3Dx0mRIAHQNBoKLagMEe/GCJKyuveg9KREOzodQ+FfKZ5MegP1L/GmjaSFJZFfespukF
         NjQwOdXSb0mfPVknGZnwQzXvmu9YOpCm9+BnC3YDfABSQx1zU/zuJNQ+F2h2UuT4iesI
         ymm2Q1/pOhxKSrHuB8E92yxF5POnhew+DBl4hL7Eg6pnQgecvnHxG9upEqZj5XuLDvj/
         3V+Q==
X-Gm-Message-State: APjAAAVmzko+YC5uO2eJmLCJdJqGM8cLLPCo9LilJ/9Vog4Z3qgJdq7B
        jNwHucm7i6m4U1vKR+WwRBk=
X-Google-Smtp-Source: APXvYqwaEPljKf+Uny3oyoHTmu8YcqVO19suYZDZeuOPA9IUPKs3vW0aZ/6hfDDv6IKxZBH9yVyBcg==
X-Received: by 2002:a17:902:a514:: with SMTP id s20mr13995193plq.300.1580544460768;
        Sat, 01 Feb 2020 00:07:40 -0800 (PST)
Received: from [192.168.1.101] (122-58-182-19-adsl.sparkbb.co.nz. [122.58.182.19])
        by smtp.gmail.com with ESMTPSA id x132sm12731750pfc.148.2020.02.01.00.07.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 01 Feb 2020 00:07:40 -0800 (PST)
Subject: Re: [PATCH -v2 00/10] Rewrite Motorola MMU page-table layout
To:     Peter Zijlstra <peterz@infradead.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>
References: <20200131124531.623136425@infradead.org>
Cc:     linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
        Will Deacon <will@kernel.org>,
        Greg Ungerer <gerg@linux-m68k.org>
From:   Michael Schmitz <schmitzmic@gmail.com>
Message-ID: <415a1105-f971-5513-bd41-fbd2ec4e1cd7@gmail.com>
Date:   Sat, 1 Feb 2020 21:07:34 +1300
User-Agent: Mozilla/5.0 (X11; Linux ppc; rv:45.0) Gecko/20100101
 Icedove/45.4.0
MIME-Version: 1.0
In-Reply-To: <20200131124531.623136425@infradead.org>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Peter,

this version tested OK on 030, so

Tested-by; Michael Schmitz <schmitzmic@gmail.com>

Am 01.02.2020 um 01:45 schrieb Peter Zijlstra:
> Hi!
>
> In order to faciliate Will's READ_ONCE() patches:
>
>   https://lkml.kernel.org/r/20200123153341.19947-1-will@kernel.org
>
> we need to fix m68k/motorola to not have a giant pmd_t. These patches do so and
> are tested using ARAnyM/68040.
>
> Michael tested the previous version on his Atari Falcon/68030.
>
> Build tested for sun3/coldfire.
>
> Please consider!
>
> Changes since -v1:
>  - fixed sun3/coldfire build issues
>  - unified motorola mmu page setup
>  - added enum to table allocator
>  - moved pointer table allocator to motorola.c
>  - converted coldfire pgtable_t
>  - fixed coldfire pgd_alloc
>  - fixed coldfire nocache
>
> ---
>  arch/m68k/include/asm/mcf_pgalloc.h      |  31 ++---
>  arch/m68k/include/asm/motorola_pgalloc.h |  74 ++++------
>  arch/m68k/include/asm/motorola_pgtable.h |  36 +++--
>  arch/m68k/include/asm/page.h             |  16 ++-
>  arch/m68k/include/asm/pgtable_mm.h       |  10 +-
>  arch/m68k/mm/init.c                      |  34 +++--
>  arch/m68k/mm/kmap.c                      |  36 +++--
>  arch/m68k/mm/memory.c                    | 103 --------------
>  arch/m68k/mm/motorola.c                  | 228 +++++++++++++++++++++++++------
>  9 files changed, 302 insertions(+), 266 deletions(-)
>
>
