Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36365C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 11:43:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C1E3206DF
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 11:43:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="ZEZ70nFN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728303AbgGGLnw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 07:43:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726839AbgGGLnv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 07:43:51 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F071C061755
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jul 2020 04:43:51 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id x62so31423718qtd.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jul 2020 04:43:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=content-transfer-encoding:from:mime-version:date:subject:message-id
         :cc:to;
        bh=A9gSnrCtL/bGUuz2j7Why4pIYAniE74nj8UvcX8ftPM=;
        b=ZEZ70nFNW/jZxMK5raOTl3pxvgkG/iMPz4vUgnidv00V58Qaxy6OwyY3Q6yTwJ8gOM
         6NU1zdNMzKIWRhvsi5fFnghjIHuQG77mc51sJvWWsvZvXHQ6yFirO74ExRtYfzUzfzkD
         tokxahefG/bmJ2rahgruC1fs1u6mlq4K3cL7J7UaGaEqUIBBWRzAgwFk3caoMpAOYHqG
         DDMMQzS3PHYEykF2KBIBgJwqr20x55GVqzgW5+pckvo3w28fWPRaN8R2DVgukn0P5fhl
         j9VZIchx5z6fsMqqQl9yoCMve747j74yHnVurk7N+FnvCz/SuZgaV3AvSnWe8RKdwy7v
         eLCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version:date
         :subject:message-id:cc:to;
        bh=A9gSnrCtL/bGUuz2j7Why4pIYAniE74nj8UvcX8ftPM=;
        b=GUqf2dXfaLfJK+Q19g2/X0Xrv+zk+j++O3tAP+i20sbyUxAglf4rA9vt3Xlr81YZ3h
         HJzusF+2mDD4HFc8QY72E4S4NYjIkIs+alvPT5U15QWY0Ei9c95JYXpNQ++ITBZzQDiz
         6aKgAwpxsiyd9tMngeezF7N4o6sWMqSBlN/p0ygb8G90JAA066CEk6atDVfAKWVVouBR
         zpuvvzXEJnzc/DaIBVc5fzp0ClYMqC3JlEZkXBnmXgBQY4J3Oi6PXbraBwRorT/Brs7S
         DWEsSMC2dQL6OqZZ+pppH7bazSZ+gCXf2+9ru2AG/8Y/er6oaUCLw98Ty/fTI5Ey+8EW
         7Etg==
X-Gm-Message-State: AOAM533NMEujIfB2vEL4Liw3MmQqNc2bB/BxXSnWMsKaW9F/+NJIQ9OW
        sgu/sKz2DMyQYYqTL4JC1eTQ4w==
X-Google-Smtp-Source: ABdhPJzkM+z+xPyymM4mUAX6gtuBqKzbmeFgH9PL/GqTsEQOO8JI6Uua4TRrViXApcBKl3cavLghcQ==
X-Received: by 2002:ac8:47d0:: with SMTP id d16mr54502664qtr.349.1594122230304;
        Tue, 07 Jul 2020 04:43:50 -0700 (PDT)
Received: from [192.168.1.183] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id 16sm23948626qkv.48.2020.07.07.04.43.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jul 2020 04:43:49 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Qian Cai <cai@lca.pw>
Mime-Version: 1.0 (1.0)
Date:   Tue, 7 Jul 2020 07:43:48 -0400
Subject: Re: [mm] 4e2c82a409: ltp.overcommit_memory01.fail
Message-Id: <AF8CFC10-7655-4664-974D-3632793B0710@lca.pw>
Cc:     Feng Tang <feng.tang@intel.com>,
        kernel test robot <rong.a.chen@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Kees Cook <keescook@chromium.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Iurii Zaikin <yzaikin@google.com>, andi.kleen@intel.com,
        tim.c.chen@intel.com, dave.hansen@intel.com, ying.huang@intel.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org, lkp@lists.01.org
To:     Michal Hocko <mhocko@kernel.org>
X-Mailer: iPhone Mail (17F80)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jul 7, 2020, at 6:28 AM, Michal Hocko <mhocko@kernel.org> wrote:
>=20
> Would you have any examples? Because I find this highly unlikely.
> OVERCOMMIT_NEVER only works when virtual memory is not largerly
> overcommited wrt to real memory demand. And that tends to be more of
> an exception rather than a rule. "Modern" userspace (whatever that
> means) tends to be really hungry with virtual memory which is only used
> very sparsely.
>=20
> I would argue that either somebody is running an "OVERCOMMIT_NEVER"
> friendly SW and this is a permanent setting or this is not used at all.
> At least this is my experience.
>=20
> So I strongly suspect that LTP test failure is not something we should
> really lose sleep over. It would be nice to find a way to flush existing
> batches but I would rather see a real workload that would suffer from
> this imprecision.

I hear you many times that you really don=E2=80=99t care about those use cas=
es unless you hear exactly people are using in your world.

For example, when you said LTP oom tests are totally artificial last time an=
d how less you care about if they are failing, and I could only enjoy their e=
fficiencies to find many issues like race conditions and bad error accumulat=
ion handling etc that your =E2=80=9Creal world use cases=E2=80=9D are going t=
o take ages or no way to flag them.

There are just too many valid use cases in this wild world. The difference i=
s that I admit that I don=E2=80=99t know or even aware all the use cases, an=
d I don=E2=80=99t believe you do as well.

If a patchset broke the existing behaviors that written exactly in the spec,=
 it is then someone has to prove its innocent. For example, if nobody is goi=
ng to rely on something like this now and future, and then fix the spec and e=
xplain exactly nobody should be rely upon.=
