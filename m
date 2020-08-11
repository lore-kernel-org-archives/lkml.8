Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BFBDC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 19:32:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DEDC7206B2
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 19:32:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zup5i22j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726587AbgHKTcJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 15:32:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726528AbgHKTcI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 15:32:08 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E5B0C06174A
        for <linux-kernel@vger.kernel.org>; Tue, 11 Aug 2020 12:32:08 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id d188so8175929pfd.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Aug 2020 12:32:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=L1QCDqC1jeWEZjJgqKuh/PvlUoKdtPIRoCRlMgnSgkk=;
        b=Zup5i22jfTfst2Dd9AzeWzIIw+U7EsZCFQh3l8LsO9CjkJjfS3FJn20mcGyoGWKCbm
         VeUqLCo8GyxQ7xY9GfK9FlzIiVo6GY4rbzNgAo8c4F5/dx5BPM1UKzgHq97/RjraWvmc
         hjDQUGAeqD5EU9sCtHQY3+TjMETJtA5naF4CGkAk6uDWqtBucnajeCiASzxw2WHMF1Ov
         EVq4+EDngGWQZQ4Oq7Efz6tATDHiGyHPCPBQ7cqbIA3wdlcLH7+caOJTWIRX8RE+FIDr
         vg/JVUd+qXJv78k4MUs4IemYQpP/qqwK7sVKV8wqNWf2oSUsvMu65CuMgvNh0ou8Q0BB
         xCsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=L1QCDqC1jeWEZjJgqKuh/PvlUoKdtPIRoCRlMgnSgkk=;
        b=RTe9Ec3Iqmg06lPg18WfH8aMVxRSE6upoDolXqwCGlaEAfY7V8nUawuoMhrGIeBkvI
         ijcu1SL1oembRaa54apPgRN3JGY+3jyYtW3uM2gqLnsQkuP3KTYAmgkMMubkVwM0mxqA
         SVGWmqjSHV/DxbzcSsNHiA+Try/uhtUetovB+zv6UXgy6GobKT0DV1+lBB4wEtFpchzP
         cQjrfboihGBjptDpjGkPbXT0PIcH4q81TPDGR3VDv7UJsBbIqAgREbwE8AYNVoQDGSOD
         qPp04T+BfG5WgiNhXakFkkO5BDELofNVyInDxFjvZ6csLqocwFSKWKA5lk96iasLkK1s
         p/Ew==
X-Gm-Message-State: AOAM532kk1644KiMv8YIMCI9VmdxOuFFRRPmZxYxt+XxGKMlsI8qfo6r
        bpOWm4VRzmgLUZpLzOqDNg==
X-Google-Smtp-Source: ABdhPJyaa+AyUu5yMrX2PZZf5f/8RCTfXLIoKqj+U5eWAsuHEVf1Sm0q44cbwOoWVGmUMdkdq6HnTg==
X-Received: by 2002:aa7:8608:: with SMTP id p8mr7464007pfn.62.1597174327916;
        Tue, 11 Aug 2020 12:32:07 -0700 (PDT)
Received: from u2004 (h175-177-040-128.catv02.itscom.jp. [175.177.40.128])
        by smtp.gmail.com with ESMTPSA id d80sm27121218pfd.22.2020.08.11.12.32.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2020 12:32:07 -0700 (PDT)
Date:   Wed, 12 Aug 2020 04:32:01 +0900
From:   Naoya Horiguchi <nao.horiguchi@gmail.com>
To:     Qian Cai <cai@lca.pw>
Cc:     HORIGUCHI =?iso-2022-jp?B?TkFPWUEoGyRCS1k4fSEhRD5MaRsoQik=?= 
        <naoya.horiguchi@nec.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "mhocko@kernel.org" <mhocko@kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "osalvador@suse.de" <osalvador@suse.de>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "david@redhat.com" <david@redhat.com>,
        "aneesh.kumar@linux.vnet.ibm.com" <aneesh.kumar@linux.vnet.ibm.com>,
        "zeil@yandex-team.ru" <zeil@yandex-team.ru>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will@kernel.org" <will@kernel.org>
Subject: Re: [PATCH v6 00/12] HWPOISON: soft offline rework
Message-ID: <20200811193201.GA1410457@u2004>
References: <20200806184923.7007-1-nao.horiguchi@gmail.com>
 <20200810152254.GC5307@lca.pw>
 <20200811031139.GA7145@hori.linux.bs1.fc.nec.co.jp>
 <20200811173923.GA39857@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-2022-jp
Content-Disposition: inline
In-Reply-To: <20200811173923.GA39857@lca.pw>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 11, 2020 at 01:39:24PM -0400, Qian Cai wrote:
> On Tue, Aug 11, 2020 at 03:11:40AM +0000, HORIGUCHI NAOYA(堀口 直也) wrote:
> > I'm still not sure why the test succeeded by reverting these because
> > current mainline kernel provides similar mechanism to prevent reuse of
> > soft offlined page. So this success seems to me something suspicious.
> > 
> > To investigate more, I want to have additional info about the page states
> > of the relevant pages after soft offlining.  Could you collect it by the
> > following steps?
> > 
> >   - modify random.c not to run hotplug_memory() in migrate_huge_hotplug_memory(),
> >   - compile it and run "./random 1" once,
> >   - to collect page state with hwpoisoned pages, run "./page-types -Nlr -b hwpoison",
> >     where page-types is available under tools/vm in kernel source tree.
> >   - choose a few pfns of soft offlined pages from kernel message
> >     "Soft offlining pfn ...", and run "./page-types -Nlr -a <pfn>".
> 
> # ./page-types -Nlr -b hwpoison
> offset	len	flags
> 99a000	1	__________B________X_______________________
> 99c000	1	__________B________X_______________________
> 99e000	1	__________B________X_______________________
> 9a0000	1	__________B________X_______________________
> ba6000	1	__________B________X_______________________
> baa000	1	__________B________X_______________________

Thank you.  It only shows 6 lines of records, which is unexpected to me
because random.c iterates soft offline 2 hugepages with madvise() 1000 times.
Somehow (maybe in arch specific way?) other hwpoisoned pages might be cleared?
If they really are, the success of this test is a fake, and this patchset
can be considered as a fix.

> 
> Every single one of pfns was like this,
> 
> # ./page-types -Nlr -a 0x99a000
> offset	len	flags
> 99a000	1	__________B________X_______________________
> 
> # ./page-types -Nlr -a 0x99e000
> offset	len	flags
> 99e000	1	__________B________X_______________________
> 
> # ./page-types -Nlr -a 0x99c000
> offset	len	flags
> 99c000	1	__________B________X_______________________
