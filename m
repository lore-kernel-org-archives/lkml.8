Return-Path: <SRS0=6raZ=AQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B8FAC433E0
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jul 2020 12:15:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 29FCC20724
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jul 2020 12:15:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="jmu3wSIH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726906AbgGEMPH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Jul 2020 08:15:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726692AbgGEMPH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jul 2020 08:15:07 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC8ACC061794
        for <linux-kernel@vger.kernel.org>; Sun,  5 Jul 2020 05:15:06 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id j80so32516849qke.0
        for <linux-kernel@vger.kernel.org>; Sun, 05 Jul 2020 05:15:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=NeeC3BoKw9HtpTq+ErElyvyWue7It9U6wNs4zBp3mYg=;
        b=jmu3wSIHJp3Wh+uXtKDaQe03zcCuhSCj9u2xsXl+awOyc4qL7l27wQFCJDjBG0ud2M
         z7/wYmik9tYcpR0FQ8vD+SQWCecLj3Ygz0jImAV/LqWJCab/Dan+3/70WEsourVpRnOF
         G+RO13T2q4yxdETNMJtYbWUNrnMTFGWIL9KfjtHxI1aYkKoohjDcyu2KJpdOOzRM2ZBP
         /i0A2hu84HhT9jtU+/ipOLxj6r/siHjCbJAIOzoPSriuq0oviw9NHz+X3zBTydCPwxCp
         L+kUlZSkfU71NEidNsA2+I+mzH5Jc5bt8Hu9LZiasauqzoWg8pBcm7uGWdVi+ahI1/1p
         QJnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=NeeC3BoKw9HtpTq+ErElyvyWue7It9U6wNs4zBp3mYg=;
        b=E7pGj2Gnrx2oV4Dnu6kHtk45ctic6ZH53Ym7s80oqA3EhTPEhgKW6t8o4pH3C8fmyS
         ovdIPQiWJ4KhVw8WqK+LjAK+DFNAhs8YUGlPT1ZvKpdQ4RhKeAtzuH+utktlWTgleO/r
         G0H+GqFrU04hkrF9Dz/ylNNSlSmc2bmjbqibEG5hBz10zFntX93nVkMDlEJEvpAvid4O
         WSrfw89yuMmfZCQHmDZ/qBG2JilkBSr5K0h3IzP82ijtNtRW/HYL15w71Fccs6uq6gN2
         KV/C3qoEjomj/LHWX6Znal0xnvpvmPK13h5qKmfV8HkyQ2Y8xbc7jMC9mBE8fXMTsX/E
         jung==
X-Gm-Message-State: AOAM531Maaat+Vz5+N5Jc8xmVcY4ieMOwsao5jUF0lvXdWgy8RJ1UsT1
        wdQo9FGVduGkuHsAYk8Pjp2PUb2HeQuWag==
X-Google-Smtp-Source: ABdhPJwnCItzWm07jx6a0u/P4LRFpyoPar9X+my51ckRR3JgOZCzNSkpYlL6jdAiJdAtVb4NH3p5/A==
X-Received: by 2002:a37:b041:: with SMTP id z62mr26042069qke.448.1593951305098;
        Sun, 05 Jul 2020 05:15:05 -0700 (PDT)
Received: from [192.168.1.183] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id y67sm12708546qka.101.2020.07.05.05.15.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 Jul 2020 05:15:04 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
From:   Qian Cai <cai@lca.pw>
Mime-Version: 1.0 (1.0)
Subject: Re: [mm] 4e2c82a409: ltp.overcommit_memory01.fail
Date:   Sun, 5 Jul 2020 08:15:03 -0400
Message-Id: <FAAE2B23-2565-4F36-B278-018A5AD219EE@lca.pw>
References: <20200705044454.GA90533@shbuild999.sh.intel.com>
Cc:     kernel test robot <rong.a.chen@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Kees Cook <keescook@chromium.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Iurii Zaikin <yzaikin@google.com>, andi.kleen@intel.com,
        tim.c.chen@intel.com, dave.hansen@intel.com, ying.huang@intel.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org, lkp@lists.01.org
In-Reply-To: <20200705044454.GA90533@shbuild999.sh.intel.com>
To:     Feng Tang <feng.tang@intel.com>
X-Mailer: iPhone Mail (17F80)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jul 5, 2020, at 12:45 AM, Feng Tang <feng.tang@intel.com> wrote:
>=20
> I did reproduce the problem, and from the debugging, this should
> be the same root cause as lore.kernel.org/lkml/20200526181459.GD991@lca.pw=
/
> that loosing the batch cause some accuracy problem, and the solution of
> adding some sync is still needed, which is dicussed in

Well, before taking any of those patches now to fix the regression, we will n=
eed some performance data first. If it turned out the original performance g=
ain is no longer relevant anymore due to this regression fix on top, it is b=
est to drop this patchset and restore that VM_WARN_ONCE, so you can retry la=
ter once you found a better way to optimize.=
