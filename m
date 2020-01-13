Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 034B5C33CB0
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 07:46:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB71320661
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 07:46:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578901597;
	bh=krPn9+Yz3BGizB05V7pAVesjTH5/X9HVzlmktZdWQd8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=hOxWcbOVDZPhELsmWgVlzLzw004R2WGI8huXTDZ1DvnhH/+jMgfbrhNebpMQuSWrf
	 q6kd+SW9SOy3rrAj7LI5q+5vCFTemdXdQTT2yM4Xraz1V8rnRvflum/YNODrJDPVFh
	 E7NKorlkzAQ5SmqXgCt8sO21em/xNF6nZQXm9KoE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728712AbgAMHqh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 02:46:37 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:33837 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727021AbgAMHqh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 02:46:37 -0500
Received: by mail-ed1-f68.google.com with SMTP id l8so7617811edw.1;
        Sun, 12 Jan 2020 23:46:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9+NYHUXqWb5LThglCHJH2RV2/Z3BgkHI4Ngou8ygTeM=;
        b=kOam0NbcyKwGIva9cZkCOy0xKIIhe7/hBsO9MzRHTtWbaJ8esZSxvMO5b/xtRZlXek
         Vx0K6EFCwFlaTUaE7ED1P46cIN28t9I8TBw13EAO7/ae8obq//hJfev6gvDmhU+cHlJW
         4nlJbfL0rez7cNBR1RXOdYPvN/NTqMuJrllIwfAgyFZsSmUQpvdn5zyRzosAlyxt9JI4
         /vp9V3sTspNv228344hgwaGgoSLV5uJ8idYQpkyxU9+g0H9MW2Zqn1NQa9kxOUcUkIih
         egPN4/Ue42B8QfOV48u7X486Gn08WRh2wNzO68hYxOAiWyc60/dtG/yfoWlGatSQ+Eoc
         4gOA==
X-Gm-Message-State: APjAAAVIsZf5lfezYcUT9D2wiq/Yg/ftaOSG7HGtaaSy9Kc9TMS4ZuOJ
        j2UgRzob9gwMZ57JR3sGhFo=
X-Google-Smtp-Source: APXvYqzi2butQD8WUbdthxqJ+MEw6KBLKjtLWPlvu/eksm5HSQg2bqJpNmL4e5nbvOjMdE7ge3nd1Q==
X-Received: by 2002:a17:906:948e:: with SMTP id t14mr15643734ejx.123.1578901595055;
        Sun, 12 Jan 2020 23:46:35 -0800 (PST)
Received: from pi3 ([194.230.155.229])
        by smtp.googlemail.com with ESMTPSA id n14sm400975ejs.40.2020.01.12.23.46.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jan 2020 23:46:34 -0800 (PST)
Date:   Mon, 13 Jan 2020 08:46:32 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     kbuild test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Subject: Re: [PATCH 3/3] mtd: onenand: Enable compile testing of OMAP and
 Samsung drivers
Message-ID: <20200113074632.GA1187@pi3>
References: <20191229183612.22133-3-krzk@kernel.org>
 <201912310904.9iM6MaFr%lkp@intel.com>
 <20191231073339.GA6747@pi3>
 <20200109161826.7fda02a4@xps13>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200109161826.7fda02a4@xps13>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 09, 2020 at 04:18:26PM +0100, Miquel Raynal wrote:
> Hi Krzysztof,
> 
> Krzysztof Kozlowski <krzk@kernel.org> wrote on Tue, 31 Dec 2019
> 08:33:39 +0100:
> 
> > On Tue, Dec 31, 2019 at 10:00:48AM +0800, kbuild test robot wrote:
> > > Hi Krzysztof,
> > > 
> > > I love your patch! Perhaps something to improve:
> > > 
> > > [auto build test WARNING on linus/master]
> > > [also build test WARNING on v5.5-rc4 next-20191220]
> > > [if your patch is applied to the wrong git tree, please drop us a note to help
> > > improve the system. BTW, we also suggest to use '--base' option to specify the
> > > base tree in git format-patch, please see https://stackoverflow.com/a/37406982]
> > > 
> > > url:    https://github.com/0day-ci/linux/commits/Krzysztof-Kozlowski/mtd-onenand-samsung-Fix-pointer-cast-Wpointer-to-int-cast-warnings-on-64-bit/20191230-030838
> > > base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git bf8d1cd4386535004c4afe7f03d37f9864c9940e
> > > reproduce:
> > >         # apt-get install sparse
> > >         # sparse version: v0.6.1-129-g341daf20-dirty
> > >         make ARCH=x86_64 allmodconfig
> > >         make C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__'
> > > 
> > > If you fix the issue, kindly add following tag
> > > Reported-by: kbuild test robot <lkp@intel.com>
> > >   
> > 
> > It is not related to my patch. I'll fix it up soon.
> 
> I would like this to be fixed before enabling compile testing, is your
> fix read?

Yes, you picked up the fix here:
https://lore.kernel.org/lkml/20200103164158.4265-1-krzk@kernel.org/

Best regards,
Krzysztof

