Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CD9FC4BA09
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 01:48:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FC522082F
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 01:48:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="IOjaXzZe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729702AbgBZBsU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 20:48:20 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:38052 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729403AbgBZBsT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 20:48:19 -0500
Received: by mail-qk1-f193.google.com with SMTP id z19so1186359qkj.5
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2020 17:48:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=i+uuXL4ROSQrRMXJx8YzNpaMLWaT0zkBrSK5utVMd+4=;
        b=IOjaXzZe1BC2Kf4gSBwQNKcZFSNsnH3EsyM+t3Nhcp3RvkIjMByJLbob6MO0u0OJyp
         F0cNre9pQTozbRAjk+FU6TR7MQ0fvlr31Gl4ITEnzYchcxSgHKZ8acop3YebW97Z1ACP
         dqFvtrGYi6yD60HVlt0bsSA+Ji/moA0Zyp+sI9ZHieZi/lOrRRwRZx2rO+T/PkZj1R4k
         6FPRBa1DdSYiUvZl3Pf0PvL/vAIya/1wy5gUUtGwOAYFQ04l2Ok4joyG62vk9UWBQoLw
         vSY9yZevZ9szs+od3YMepRRF9IiprTWYLffUgmR6+fA/w2KIa65H39+9ECrGS3OUsoQI
         1EXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=i+uuXL4ROSQrRMXJx8YzNpaMLWaT0zkBrSK5utVMd+4=;
        b=cwOyb7HaFNJ0mJpH5Q1qJLxlS+bQUJ+IVmYeX0TKCQ0aPPidahFyjTJF6Q4B3CmrMm
         dSwDx4HeAYQW7fLbV+pBwIFQY+rO00pmK/RwikzrTqhkCfS+Sl5hF0oMnmgHZ8q15suo
         /HVaTSBKgY2NFOa3Fb+B605sp6ZToPKaRyh1zl8ntZz4M8bE0VfeANvBv0Z9mHVxJJRx
         MFwHJFu4P4jpc6V444oENWS8oAgErZM4b7tF+stm+lU7oayijxYPu017/CTTCaMb2Z2M
         EdxwE6noVgFPwIJk+nQ1KlLHk6WNmjhidD01DRIEgcf99u98yh1VliWoqn/WXrjpRlm4
         7arQ==
X-Gm-Message-State: APjAAAUF+yZCT64jN99pDgJsgbx/5noOE2PPU+e+E9mdXNakR+ZrUVk6
        ED7U8AEyI7Rpf9T+QsksC6pwFgNA/3WIZQ==
X-Google-Smtp-Source: APXvYqxKRO9wzG3Q2qn/iSlNi92tbElxa8RdUi0qeQPKLsUNPOI+jzNCP9uUj4zuiyjS3Zt/3eW/ng==
X-Received: by 2002:a37:a982:: with SMTP id s124mr2359705qke.496.1582681696856;
        Tue, 25 Feb 2020 17:48:16 -0800 (PST)
Received: from [192.168.1.153] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id o17sm245069qtj.80.2020.02.25.17.48.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Feb 2020 17:48:16 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.60.0.2.5\))
Subject: Re: [PATCH] mm/vmscan: fix data races at kswapd_classzone_idx
From:   Qian Cai <cai@lca.pw>
In-Reply-To: <20200226012952.GV24185@bombadil.infradead.org>
Date:   Tue, 25 Feb 2020 20:48:14 -0500
Cc:     Andrew Morton <akpm@linux-foundation.org>, elver@google.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <984ADA76-837B-4B07-88C5-0D82FE8FA9A5@lca.pw>
References: <1582649726-15474-1-git-send-email-cai@lca.pw>
 <20200226012952.GV24185@bombadil.infradead.org>
To:     Matthew Wilcox <willy@infradead.org>
X-Mailer: Apple Mail (2.3608.60.0.2.5)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Feb 25, 2020, at 8:29 PM, Matthew Wilcox <willy@infradead.org> =
wrote:
>=20
> On Tue, Feb 25, 2020 at 11:55:26AM -0500, Qian Cai wrote:
>> -	if (pgdat->kswapd_classzone_idx =3D=3D MAX_NR_ZONES)
>> -		pgdat->kswapd_classzone_idx =3D classzone_idx;
>> -	else
>> -		pgdat->kswapd_classzone_idx =3D =
max(pgdat->kswapd_classzone_idx,
>> -						  classzone_idx);
>> +	if (READ_ONCE(pgdat->kswapd_classzone_idx) =3D=3D MAX_NR_ZONES =
||
>> +	    READ_ONCE(pgdat->kswapd_classzone_idx) < classzone_idx)
>> +		WRITE_ONCE(pgdat->kswapd_classzone_idx, classzone_idx);
>> +
>> 	pgdat->kswapd_order =3D max(pgdat->kswapd_order, order);
>=20
> Doesn't this line have the exact same problem you're "solving" above?

Good catch. I missed that.

>=20
> Also, why would you do this crazy "f(READ_ONCE(x)) || g(READ_ONCE(x))?
> Surely you should be stashing READ_ONCE(x) into a local variable?

Not a bad idea.

>=20
> And there are a _lot_ of places which access kswapd_classzone_idx
> without a lock.  Are you sure this patch is sufficient?

I am not sure, but KCSAN did not complain about other places after =
running extended
period of testing, so I will look into once other places show up later.

