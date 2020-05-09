Return-Path: <SRS0=dqcu=6X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47489C28CBC
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 16:53:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 13CF9214D8
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 16:53:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="qFs16vID"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728365AbgEIQxl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 May 2020 12:53:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726214AbgEIQxk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 May 2020 12:53:40 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80340C061A0C
        for <linux-kernel@vger.kernel.org>; Sat,  9 May 2020 09:53:40 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id w18so2479213qvs.3
        for <linux-kernel@vger.kernel.org>; Sat, 09 May 2020 09:53:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=v9n7nUQ6BLocSh8QyJi1U2YpynP7/+J+TFH6Gxsb30Y=;
        b=qFs16vID/5+OQQ9e/MZmB45bW49we+0yycpTS9fxgcC2Xn4c4+qElKzH23Ut6mnxFD
         dITX/LrIy8hCMLZCcSVjnfd59cG8qd3zpfgU4L/YypF613l6Yio+PcvOcZ5m2u9gaC8s
         2b4E2CQ2o3Qm6BHkRqiT0H8ZsX6azu2lqIcNhqD6skcXAWLy9Ex5xfYlWtNJpJnFcc+3
         17hpkUjvNeGMIQmRqaIE/72Hq36NCg0HczS+7A+go5LsSg8pTQtyB9qctfz2KjimuvoL
         XZHHCnBh8PQ/CIfw5PNMPFnGVlp/3AGKBN4SejYh+uB7fQI6CKjCCp/RTfG/fB6pyQE4
         uHSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=v9n7nUQ6BLocSh8QyJi1U2YpynP7/+J+TFH6Gxsb30Y=;
        b=dk7jmUgT4ZFi/emE+mOLOLvl01krpZBlxV/RZesytqgefPCpHDpeIcVAlOr1hW5ANm
         GLbkGEV75XetvrWOentZBXyDrGmzrR7WS8unBh7v+EL0xGJCMUaLPbHIIbXI+3Fl+mZh
         uCtpqHW1gkMOc5vjl1cp9pxxudnwjzGLwtoNtfFlpTvmeZnIpiXzrYeDPIgBNnX3msHP
         xVGCqA/9S8m8CaBkMpfoLLmW8u+Ivp+v7xatgn84oxStxCtZa92AGdOC7EJIIpU1Lozb
         U1usBvwGltdMSsw1RvjMNxwWQccIeyrfP9/z05JQsx3UENknSnF3D0EmMFVbSwycIq+X
         rNNA==
X-Gm-Message-State: AGi0PuYN3MiEwrSelFRgA/BjhD4vU+3ik+qlTIaVvh6jocEqomXIP/m1
        S9uSBv6/8BqSYgoDn3zWY/dHuOqJjLKFew==
X-Google-Smtp-Source: APiQypJ3CD/mAwPWe5YW/aYfZV0QikFvLBDdCE7V8q0rKGpDvtLAoTFxKtxOsgpnJGdz7BKOoKhWmg==
X-Received: by 2002:a0c:ac41:: with SMTP id m1mr8162790qvb.71.1589043219371;
        Sat, 09 May 2020 09:53:39 -0700 (PDT)
Received: from [192.168.1.183] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id 202sm3919656qko.135.2020.05.09.09.53.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 09 May 2020 09:53:38 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
From:   Qian Cai <cai@lca.pw>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH -next v2] locking/osq_lock: annotate a data race in osq_lock
Date:   Sat, 9 May 2020 12:53:38 -0400
Message-Id: <45D9EEEB-D887-485D-9045-417A7F2C6A1A@lca.pw>
References: <20200509161217.GN2869@paulmck-ThinkPad-P72>
Cc:     Will Deacon <will@kernel.org>, Elver Marco <elver@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
In-Reply-To: <20200509161217.GN2869@paulmck-ThinkPad-P72>
To:     paulmck@kernel.org
X-Mailer: iPhone Mail (17D50)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On May 9, 2020, at 12:12 PM, Paul E. McKenney <paulmck@kernel.org> wrote:
>=20
> Ah, and I forgot to ask.  Why "if (data_race(prev->next =3D=3D node)" inst=
ead
> of "if (data_race(prev->next) =3D=3D node"?

I think the one you suggested is slightly better to point out the exact race=
. Do you want me to resend or you could squash it instead?=
