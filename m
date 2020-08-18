Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03901C433E3
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 05:17:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D240B2075E
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 05:17:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597727846;
	bh=uO12krvzTYQRlC82JhrP4ddHuWmV0fYlnXYrn7qE6I4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=CjD8Uov2hwxpftyRmSWefUA6lImbH94pT+gmjvYatqRgNx6A3YrHusE36PhQ5BKnF
	 /3fFdflgesMyAz2Gi9iCyyYZmNyHHjUcVfhRnIvi09HWApYo81xcd2K3U548e/wIcZ
	 KkWZ9GcKgMhAvQa3lYQg834GSWfi2ZdEGuj2nQdg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726535AbgHRFRZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 01:17:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726370AbgHRFRY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 01:17:24 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 083CCC061389;
        Mon, 17 Aug 2020 22:17:24 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id c16so20508856ejx.12;
        Mon, 17 Aug 2020 22:17:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=705PFNm/gGw5cISxo/mBa28/BdVOfVrbtfnHTQdTKxk=;
        b=pt2+jYZzkGH2X6wSwEhWXPkM3WcCgKkoeP5Sn+GIUYQycqvMQNOnI1pWGAD4o0HAGY
         J1mmsE5pHBKl8WMIEhOw0bugsjifGHvx2s1aInX2Mqlfm9iAQulB8akAX9dxw0AHuPze
         wHvMN/BFKELTb5WgJSAznIDwGFbbXXAJdZC2SsWDf9nSNQIPv3W9iKlAMxKM5AUCMK4P
         2sWfo4/9bScb8NwLzLEK3XuiJe7aWpCfrXaT6YQmvRWJlLxX1xvK8s6886TZPwTTBkJu
         Vesw+iDU45G7Xg2/vFA8PIpFPtT+MTrnnfwkO2OoTEPx2pVgRSvgHaIddfPnfKFRaj4X
         hy/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=705PFNm/gGw5cISxo/mBa28/BdVOfVrbtfnHTQdTKxk=;
        b=lrvJ/pBDH0Qm/1vOt+mmQrHdUl/nuayyn9A/tWRDQC0KLSFuj6o0Gwj3q06+hc567m
         b5YvrXDrS/QIROkjlkVmpIuEptqdrR+qA48helaJBrkZTIiKcLQ4n7kOuSo2CwCAExx8
         ikUtBn4S4Is/MTKOiZ55o8QTkLGO9urZZ6CPOtsN/AFsHxPyaVHBTH9FgiNTZGS9eJYh
         sLdOjZc7EP2/Eva2/zBtE/ZBSBm6BsY1yC+lRUuo/cd84AFQnsTd9OlIfI2YGUuGjICL
         ehM2PYVo4DpljkpY9K1B6R9DfnCqgPZTj2Zi6c7TvwYHZUdiRVNgaIY0l6ldprst9gzW
         Y8QQ==
X-Gm-Message-State: AOAM53166C1ePriqREslPTqg0ZUp3HP0xGRFeCjI4AtcswUxtJxC2T3/
        I0EbwFh1FgrlRu4wy1znuJo=
X-Google-Smtp-Source: ABdhPJwKXufJTsBmCAWfcBLDfIQjZyXLv0fFUUBLnkVmChTwR/mnaZPhEDPNZEZhaAkrvTpkqYkBJw==
X-Received: by 2002:a17:906:9392:: with SMTP id l18mr18130560ejx.357.1597727842650;
        Mon, 17 Aug 2020 22:17:22 -0700 (PDT)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id d16sm15635292ejb.8.2020.08.17.22.17.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2020 22:17:20 -0700 (PDT)
Date:   Tue, 18 Aug 2020 07:17:17 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Pavel Machek <pavel@ucw.cz>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Michael Witten <mfwitten@gmail.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        John Levon <john.levon@joyent.com>,
        John Levon <levon@movementarian.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] Makefile: Yes. Finally remove
 '-Wdeclaration-after-statement'
Message-ID: <20200818051717.GA3134537@gmail.com>
References: <c6fda26e8d134264b04fadc3386d6c32@gmail.com>
 <20200816175303.GB1236603@ZenIV.linux.org.uk>
 <20200817204223.GB12414@amd>
 <87lfid6kpi.fsf@x220.int.ebiederm.org>
 <CAHk-=wj04wKCjHz6b6d7N58xoS4AftnwTUBaXsEekQ5RhfWVnw@mail.gmail.com>
 <20200817220908.GA3701@amd>
 <CAHk-=wh7Rn=8mVi_KWV71ZaQ2HrCz240DbjEJMDdARTwB3CYvA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wh7Rn=8mVi_KWV71ZaQ2HrCz240DbjEJMDdARTwB3CYvA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Mon, Aug 17, 2020 at 3:09 PM Pavel Machek <pavel@ucw.cz> wrote:
> >
> > Submitter believes "wild variable placement" can help with
> > #ifdefs.. and that may be actually good tradeoff.
> 
> I agree that it can help in some cases.
> 
> But it can also make it really hard to find the variable declarations
> in other cases. I've seen a lot of code that ends up actively
> declaring the variable close to where it's used (because people find
> that to be locally more legible) and then it just means that people
> who arent' familiar with the code have a much harder time finding it.
> 
> I'd instead try to discourage people from using #ifdef's inside code.

I'm a big fan of -Wdeclaration-after-statement and I think C++ style 
mixed variables/statements code has several disadvantages:

- One advantage of -Wdeclaration-after-statement is that it can detect 
  mismerges that can happen with the 'patch' tool when it applies a 
  patch with fuzz.

- Also, enforcing -Wdeclaration-after-statement means we have the nice 
  symmetry that local variable declarations are always at the 
  beginning of curly brace blocks, which includes function 
  definitions. This IMO is a very helpful visual clue that allows the 
  quick reading of kernel code.

- A third advantage is that the grouping of local variables at the 
  beginning of curly brace blocks encourages smaller, better 
  structured functions: a large function would look automatically ugly 
  due to the many local variables crammed at the beginning of it.

So the gentle code structure message is: you can declare new local 
variables in a loop construct or branch, at the cost of losing one 
level of indentation. If it gets too deep, you are encouraged to split 
your logic up better with helper functions. The kind of run-on 
mega-functions that C++ style mixed variables often allow looks 
*automatically* uglier under -Wdeclaration-after-statement and quickly 
breaks simple kernel style rules such as col80 or indentation level 
depth or the too high visual complexity of variable definition lines.

Basically the removal of -Wdeclaration-after-statement removes a 
helpful symmetry & allows the addition of random noise to our code 
base, with very little benefits offered. I'd be sad to see it go.

Thanks,

	Ingo
