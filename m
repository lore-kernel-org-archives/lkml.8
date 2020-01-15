Return-Path: <SRS0=7RkH=3E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3178CC33CB2
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 12:35:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F282724679
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 12:35:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="bB1RWKWZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726559AbgAOMft (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jan 2020 07:35:49 -0500
Received: from mail-qk1-f180.google.com ([209.85.222.180]:38441 "EHLO
        mail-qk1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726071AbgAOMfs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 07:35:48 -0500
Received: by mail-qk1-f180.google.com with SMTP id k6so15433016qki.5
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jan 2020 04:35:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=iqApvHFhN/2y0vIYJ3VQfDet+rTcg9cDecADYiR5JVU=;
        b=bB1RWKWZMEneVE4Y5JXxfIQj3cSUOnG4agG6xpED5c78v4My2ZxnFoZ+WMxAPgslhd
         JVkMISZNbybG0bX8TNxmJnMSvWApNKd2Id/EBLco2/Ii+GOIdOpZhVzYtKmFc93NfJD1
         2f5AmgsPm3oaoWeBThw5rqLj/u/Fu6zwfnozi7Z+jKjrEYPwL791CQwdvJVmXjPTTU3I
         tSiklFVWzEngTJBXW+8U6MajiNRAmD9xBRvAVLxMV8/WAImaXih3uvL5Ax19Gtps0v71
         lHk3NKCQrtaZ8HNOV4ZuobUrtMG07l4Tggue9V0/M2GMeQNl38KLUjipG38Hu11bSQ1r
         2eDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=iqApvHFhN/2y0vIYJ3VQfDet+rTcg9cDecADYiR5JVU=;
        b=qJfflfXkmBnoE2osgMIX2r1A6vN4R0dlr8vEoE3LCZBNpxCOzQDaZyhjfY9n82dVLq
         Ww9HXGzLS3TR7WNtmzosgtrLMIE90FCmjLUdZAjMDw5V1vK07x6OpBJz2YvDiw3nfGq5
         qvQi3TrAtMGe+XgOeZhJqgGpv9dbEsWTkhp378xnFuK444tDDGCNKenezq5G3cMDbAgZ
         u2mboNITRSC0omgN822bSJsHnvL0ze5hnARLYg46DFsy6z61+ZiVC6kANu/kStoMkVuS
         4KA8ap51snJRHAbrAkCKKHKJyk8i0a52TcXYVsUAENMpbbZbtCocP5dYG/9S3SEPJ+N7
         E+8w==
X-Gm-Message-State: APjAAAUWMnH5saHqmZOBaf1reCTIjugcyK58ETPg/nQyZLOdmwKJTO7R
        Gm38go9LfKxcnb9LKzkFTcGgkdOeJWU8/A==
X-Google-Smtp-Source: APXvYqwAXI2OjM9Fg8agJQyfEn0+0DpAuXhCeo2L0sBGBb7M/5mZE/BcGtIoBElTJBWIyL7ZPBan3w==
X-Received: by 2002:a05:620a:3cf:: with SMTP id r15mr27565236qkm.12.1579091747280;
        Wed, 15 Jan 2020 04:35:47 -0800 (PST)
Received: from [192.168.1.183] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id q131sm8414276qke.1.2020.01.15.04.35.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jan 2020 04:35:46 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Qian Cai <cai@lca.pw>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH -next v2] mm/hotplug: silence a lockdep splat with printk()
Date:   Wed, 15 Jan 2020 07:35:45 -0500
Message-Id: <39D75B58-A5CE-4837-BCD3-8026E2C88861@lca.pw>
References: <20200115092221.GX19428@dhcp22.suse.cz>
Cc:     akpm@linux-foundation.org, sergey.senozhatsky.work@gmail.com,
        pmladek@suse.com, rostedt@goodmis.org, peterz@infradead.org,
        david@redhat.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Mike Kravetz <mike.kravetz@oracle.com>
In-Reply-To: <20200115092221.GX19428@dhcp22.suse.cz>
To:     Michal Hocko <mhocko@kernel.org>
X-Mailer: iPhone Mail (17C54)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jan 15, 2020, at 4:22 AM, Michal Hocko <mhocko@kernel.org> wrote:
>=20
> Is this correct? CMA pages cannot be comound?

I never saw a CMA page also a compound page. Also, in alloc_contig_range(), i=
t calls migrate_pages()=E2=80=94> unmap_and_move_huge_page() which will free=
 the old huge page, so I think that will clear pageCompound.

Cc Mike in case I miss anything.=
