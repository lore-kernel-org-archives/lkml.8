Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2473C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 02:28:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 70BBF2075F
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 02:28:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="cQpNRMs3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728537AbgETC2o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 22:28:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726178AbgETC2o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 22:28:44 -0400
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13739C061A0E
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 19:28:44 -0700 (PDT)
Received: by mail-qv1-xf41.google.com with SMTP id f89so672060qva.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 19:28:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=6Y7HJEX97OtUoScp+6aHU6PvBtaRCji4KFMDWzl/1dU=;
        b=cQpNRMs3iNodzFhYuYipwiBMcUEGOJ3xUdc3cfUveLOQY59Je2GsuNTi2qpKEMxCpQ
         3bqSWrAGjqBoAKndJjjTJrgrLfwV0bEtLHNG8higFC140vI+VtauJs/m9kOAIHQ6bdEw
         QRu0U4nvggp52A00zOVb/a/qFsqC/GopXdX8Jhr4Op5hTwamyOUlKSvJCKIRDiAIwkTo
         XfRXahdTu0FwM1JDD2xDu73FAuvNFDfQjV+Q3E36HgXNh7DUvzGr+s3+FZYeI/Wx2n+Q
         +d1/j8ipY6CjVaaY4nrlOIakqFbwnltU0/SBa5QN+3728tuYh4pF+2SKKjug3/I9bVaB
         +tpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=6Y7HJEX97OtUoScp+6aHU6PvBtaRCji4KFMDWzl/1dU=;
        b=gLM/tbKiKzVlim1/fokAOHKuHEjZt3/GHLjxrdT+1PtfUxc6oQUHtFWdxIfbnC8aJv
         wGsMTLhcmOzBGl03yDgEWuaei/dpx1bh/BvgmNWfq5eY1u2oUepNqT+jMBYZS0ROKG3c
         OxNEcd2XM4fdxvvYFE5kzcA9rJ5WOBh8hDmhSmDr9JgLkfLrz7W2r2AhIe9yl2FwtPMf
         waEhig0zjTFZzbgDU5Y242dROae4Ny1JiMK0qG0G/h/a5L5r9DWQuuQk1cODS2qYWdQQ
         X5LfRGPVXvkxzUQCOeUCuiN12EPu0+O7ZXcIl9PIFczIHrIXChzfw0W9h3QVWbci2HAO
         P3xA==
X-Gm-Message-State: AOAM533s+Eu5oqll3Yg1kppv23HxLioAAUtcibI0WvsHMYi/3/2CuUye
        GbFL9yC72sZF8428MaY9VIOLI8VhTAqDdQ==
X-Google-Smtp-Source: ABdhPJxjYdKtmPOvMy1Q+JLwtSfq4dDdlPjcDcKr8rNqyafvMGhhzymtntu2oBRo1PCaBOT5oqbIQg==
X-Received: by 2002:a05:6214:1c2:: with SMTP id c2mr2800690qvt.185.1589941723237;
        Tue, 19 May 2020 19:28:43 -0700 (PDT)
Received: from [192.168.1.183] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id y66sm988332qka.24.2020.05.19.19.28.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 May 2020 19:28:42 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Qian Cai <cai@lca.pw>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] READ_ONCE, WRITE_ONCE, kcsan: Perform checks in __*_ONCE variants
Date:   Tue, 19 May 2020 22:28:41 -0400
Message-Id: <360AFD09-27EC-4133-A5E3-149B8C0C4232@lca.pw>
References: <87y2pn60ob.fsf@nanos.tec.linutronix.de>
Cc:     Marco Elver <elver@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Will Deacon <will@kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Ingo Molnar <mingo@kernel.org>
In-Reply-To: <87y2pn60ob.fsf@nanos.tec.linutronix.de>
To:     Thomas Gleixner <tglx@linutronix.de>
X-Mailer: iPhone Mail (17E262)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On May 19, 2020, at 6:05 PM, Thomas Gleixner <tglx@linutronix.de> wrote:
>=20
> Yes, it's unfortunate, but we have to stop making major concessions just
> because tools are not up to the task.
>=20
> We've done that way too much in the past and this particular problem
> clearly demonstrates that there are limits.
>=20
> Making brand new technology depend on sane tools is not asked too
> much. And yes, it's inconvenient, but all of us have to build tools
> every now and then to get our job done. It's not the end of the world.
>=20
> Building clang is trivial enough and pointing the make to the right
> compiler is not rocket science either.

Yes, it all make sense from that angle. On the other hand, I want to be focu=
s on kernel rather than compilers by using a stable and rocket-solid version=
. Not mentioned the time lost by compiling and properly manage my own toolch=
ain in an automated environment, using such new version of compilers means t=
hat I have to inevitably deal with compiler bugs occasionally. Anyway, it is=
 just some other more bugs I have to deal with, and I don=E2=80=99t have a b=
etter solution to offer right now.=
