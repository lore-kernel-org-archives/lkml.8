Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FB65C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 22:06:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 744E8206C3
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 22:06:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="J3AC+Xnp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726368AbgHKWGt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 18:06:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726023AbgHKWGt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 18:06:49 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFA62C06174A
        for <linux-kernel@vger.kernel.org>; Tue, 11 Aug 2020 15:06:48 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id j187so324323qke.11
        for <linux-kernel@vger.kernel.org>; Tue, 11 Aug 2020 15:06:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=IYtqmhJpymCz6j289iI5TeJwIC6OPAmI1DkbGnwCpRU=;
        b=J3AC+XnpS+owb7bsJYRZ9ilnHowutIRLLZQ64zerloJwnU40cIWxmRQ71vL51CMHgU
         GD+qcnVRYBpNL3kzm/cyx77Ep7oh3IsdPrT3uNnlAKjcsmJak3O8aPQ9Kx+p0O2KaJZh
         j5t6kRoSk1rKilptFy75fFW2SvUybc0fnRNMlw9XL4YbmFB1Ml49zuHTnKWMlUt8XEhw
         U7d+7O8s4fvZXScYiWQEMkqKP6TjRJ9MpQIiqSZM5AazE0jZ3cInujXul6Y+BAitFviw
         jQz6x83vlSwqVB5GGuSxVZJnskm+/5+Y8ECW63o0X/7YdfM7bdt2Gn16Y/z5KsoV0gJX
         5fqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=IYtqmhJpymCz6j289iI5TeJwIC6OPAmI1DkbGnwCpRU=;
        b=effEMBjBp0/zc69iW/yoJ9uQOzvvyAsg1UmB7QDi1MFbzKz8xShFVReAHYEQWByKHf
         rEBJc+qAxHgyNB1kgOtB9T69e8PCHZXqOV8ptr7tQKs154GGmx8ugh32mgobFI9LaqjO
         4MDJX/tg5tRtVu00PivfUz7TnqzrlXT4I4ccRSsBja8/ZIZ12qzMoK78wF72HNjhZmWW
         4AJRCvTZKWnqSRjbUv4AoV3PzEG9JyNt33t4Rjm7pI+G4fBmdmbRFMVtYg7k7iz8Qbo3
         V4HQaSe0bOmAp7u4PQmRlR5OsZu7epLjPVqwyjV7+GncyM2Ue6N/vXfbZyQngnYisy6r
         uiwA==
X-Gm-Message-State: AOAM530x1Xe3O+hpgzJsPo6Lc8uCD4RfFJ/PHqxy3WyqWQOtcd6tEEch
        61OTXRdTidYuMbG/BYgLkrFANQ==
X-Google-Smtp-Source: ABdhPJzlQX2iQgZ+zmEjLq2klBTu0I+UrXgd/y4ywaEaAkTgEZVMISbhT+fJawCotQsHT2fFBf4jsg==
X-Received: by 2002:a05:620a:1a:: with SMTP id j26mr3329668qki.183.1597183607773;
        Tue, 11 Aug 2020 15:06:47 -0700 (PDT)
Received: from lca.pw (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id h55sm173972qte.16.2020.08.11.15.06.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2020 15:06:47 -0700 (PDT)
Date:   Tue, 11 Aug 2020 18:06:44 -0400
From:   Qian Cai <cai@lca.pw>
To:     Naoya Horiguchi <nao.horiguchi@gmail.com>
Cc:     HORIGUCHI =?utf-8?B?TkFPWUEo5aCA5Y+j44CA55u05LmfKQ==?= 
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
Message-ID: <20200811220643.GB39857@lca.pw>
References: <20200806184923.7007-1-nao.horiguchi@gmail.com>
 <20200810152254.GC5307@lca.pw>
 <20200811031139.GA7145@hori.linux.bs1.fc.nec.co.jp>
 <20200811173923.GA39857@lca.pw>
 <20200811193201.GA1410457@u2004>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200811193201.GA1410457@u2004>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 12, 2020 at 04:32:01AM +0900, Naoya Horiguchi wrote:
> On Tue, Aug 11, 2020 at 01:39:24PM -0400, Qian Cai wrote:
> > On Tue, Aug 11, 2020 at 03:11:40AM +0000, HORIGUCHI NAOYA(堀口 直也) wrote:
> > > I'm still not sure why the test succeeded by reverting these because
> > > current mainline kernel provides similar mechanism to prevent reuse of
> > > soft offlined page. So this success seems to me something suspicious.
> > > 
> > > To investigate more, I want to have additional info about the page states
> > > of the relevant pages after soft offlining.  Could you collect it by the
> > > following steps?
> > > 
> > >   - modify random.c not to run hotplug_memory() in migrate_huge_hotplug_memory(),
> > >   - compile it and run "./random 1" once,
> > >   - to collect page state with hwpoisoned pages, run "./page-types -Nlr -b hwpoison",
> > >     where page-types is available under tools/vm in kernel source tree.
> > >   - choose a few pfns of soft offlined pages from kernel message
> > >     "Soft offlining pfn ...", and run "./page-types -Nlr -a <pfn>".
> > 
> > # ./page-types -Nlr -b hwpoison
> > offset	len	flags
> > 99a000	1	__________B________X_______________________
> > 99c000	1	__________B________X_______________________
> > 99e000	1	__________B________X_______________________
> > 9a0000	1	__________B________X_______________________
> > ba6000	1	__________B________X_______________________
> > baa000	1	__________B________X_______________________
> 
> Thank you.  It only shows 6 lines of records, which is unexpected to me
> because random.c iterates soft offline 2 hugepages with madvise() 1000 times.
> Somehow (maybe in arch specific way?) other hwpoisoned pages might be cleared?
> If they really are, the success of this test is a fake, and this patchset
> can be considered as a fix.

The test was designed to catch a previous bug (the latest patchset fixed that)
where kernel will be enterting into an endless loop.

https://lore.kernel.org/lkml/1570829564.5937.36.camel@lca.pw/

However, I don't understand why mmap() does not return ENOMEM in the first
place where overcommit_memory == 0 instead of munmap() or/and madvise()
returning ENOMEM. I suppose that is the price to pay with heuristic, and I
can't easily confirm if it is related to this patchset or not.

		addr = mmap(NULL, length, PROT_READ | PROT_WRITE,
			   MAP_PRIVATE | MAP_ANONYMOUS | MAP_HUGETLB, -1, 0);
		if (addr == MAP_FAILED) {
			if (i == 0 || errno != ENOMEM) {
				perror("mmap");
				return 1;
			}
			usleep(1000);
			continue;
		}
		memset(addr, 0, length);

		code = madvise(addr, length, MADV_SOFT_OFFLINE);
		if(safe_munmap(addr, length))
			return 1;

		/* madvise() could return >= 0 on success. */
		if (code < 0 && errno != EBUSY) {
			perror("madvise");
			return 1;
		}

Otherwise, our test will keep running and ignore ENOMEM correctly. I did also
confirm that this patchset has a higher success rate of soft-offlining
("page-types" shows 400+ lines) which changes the existing assumption (looks
like in a good way in this case).
