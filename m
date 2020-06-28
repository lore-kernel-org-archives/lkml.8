Return-Path: <SRS0=fM4p=AJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7F08C433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jun 2020 00:49:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A35B720C09
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jun 2020 00:49:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="TResSNgQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726704AbgF1Ate (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Jun 2020 20:49:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725940AbgF1Ate (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Jun 2020 20:49:34 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0911FC03E979
        for <linux-kernel@vger.kernel.org>; Sat, 27 Jun 2020 17:49:33 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id e11so12341521qkm.3
        for <linux-kernel@vger.kernel.org>; Sat, 27 Jun 2020 17:49:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=aIUCFtVbjmz2UWddn6XMMzJcn+xFSa+jncR/lAH4nxU=;
        b=TResSNgQGlitgQRbkTDrv9Ab6BRSFbwkNZDckP6UkDi9vvRf0fUUJS6B2GDrAteQRP
         Ur/0NUJXvRWb4fa8S1ErSBZv3sZCh0jN/Z46n28Y3W82xHaHGswxdCZrN1G/xO0HKlI8
         OujANN9R83aQ7JODaCEraWp6YVLHpQBjvb0jusEyqQlCyvktn3ZyYOA1/cmE5Qf6orbA
         Ipmbg2RGJBARNbM8j4kNV9V05vahyrw/u2uWEhgjdJNYFjMxRLlm8MYtUgV6L9pbrv6U
         a2aEDxYc43xc40mKRw1g/Uh7OU+Bi2mCCOGut6tWqU4KTuVBxXI43sRo7ZA8H8fjA1pm
         VP4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=aIUCFtVbjmz2UWddn6XMMzJcn+xFSa+jncR/lAH4nxU=;
        b=fV65ZwnHrNQU1CbVtTSBTzDw9M1f6g0Ut3MIYfOJC++ImpO9W5as/lpFC1l8nPzY+F
         J0LyRXAu7jHteENrZ0+gGs1Fx/Iw9UvjEvp6FR/zslnCGxnMeeoBUp7Yl9UXMlbH6PBi
         3Yd/FaWhhCe659fqMpafZFFIxxfX9uhADJ7jfJHm+p4HsIr6WSIh2FuY1Hcj9vzsi4ED
         Aj6/dMICYZ9iOLuxXvzXgUNCSQ5ppRfvlrH+hkCpMFAMrIQ+8H2RgIuPFVNtoPTkhPbt
         AxcVKQ3Yp/QMb+L3MSdOQWtJHm97lNvCDCMPaCQcRXHUMhnGQNteO1gBZ+ppXPu1UHzT
         aNAA==
X-Gm-Message-State: AOAM531nXZ9repuRNemRlBzig+x+odUqED0cN0sM0ttP+qmPRw/VxNtY
        073lqbqTmtbsUFMRImB6h1WFA0YbMUxciQ==
X-Google-Smtp-Source: ABdhPJwE6ef11vX0eS7F8SGmPGFDsOo+ruwTfPdFcFjy+UhMX5OBuU8fvN0wtss6T7AkymR/I1drUw==
X-Received: by 2002:a37:4acc:: with SMTP id x195mr9558401qka.454.1593305371968;
        Sat, 27 Jun 2020 17:49:31 -0700 (PDT)
Received: from [192.168.1.183] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id 72sm10855463qkh.136.2020.06.27.17.49.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 27 Jun 2020 17:49:31 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
From:   Qian Cai <cai@lca.pw>
Mime-Version: 1.0 (1.0)
Subject: Re: linux-next boot error: WARNING in kmem_cache_free
Date:   Sat, 27 Jun 2020 20:49:30 -0400
Message-Id: <CE087189-8054-4D2F-AAB1-2D75CF1BFC15@lca.pw>
References: <20200627231013.GM7065@sol.localdomain>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        syzbot <syzbot+95bccd805a4aa06a4b0d@syzkaller.appspotmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        linux-mm@kvack.org
In-Reply-To: <20200627231013.GM7065@sol.localdomain>
To:     Eric Biggers <ebiggers@kernel.org>
X-Mailer: iPhone Mail (17F80)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jun 27, 2020, at 7:10 PM, Eric Biggers <ebiggers@kernel.org> wrote:
>=20
> This bug also got reported 2 days later by the kernel test robot
> (lore.kernel.org/lkml/20200623090213.GW5535@shao2-debian/).
> Then it was fixed by commit 437edcaafbe3, so telling syzbot:
>=20
> #syz fix: mm, slab/slub: improve error reporting and overhead of cache_fro=
m_obj()-fix
>=20
> If CONFIG_SLAB is no longer useful and supported then it needs to be remov=
ed
> from the kernel.  Otherwise, it needs to be tested just like all other opt=
ions.

It is awesome that kernel test robot was able to bisect it which is especial=
ly useful for testing legacy options like SLAB.=
