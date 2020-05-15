Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F540C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 18:36:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D0FB520756
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 18:36:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="PhNfluho"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726298AbgEOSg3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 14:36:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726236AbgEOSg2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 14:36:28 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20B52C061A0C
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 11:36:28 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id g185so3594558qke.7
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 11:36:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=3jEh/c8X5kAh+mw2s8BlpUXCIYSTIWmWDs3YUbpKhds=;
        b=PhNfluhoV7c1JGujBvuA9/GYqlD5DjmJIveS+0n2VX3jtO4FvwwtRfMyWghIeo7erW
         gMMFC8WYCc+v55d5zLp9VxQxVGdz1bMBfcoqLJS08TKH1eNbFPQy20ZBF0jF+mRN3tEf
         o29q71gxJCJuFN/ej9tEdbM7ZOd5FGdqIg8jESsOjSOoNFLUb8ytzquSOxE3E/fhLXla
         6CTcAud+uGtcpN+TQONR+B0fKvHarlzXdm8x0LIE/ZpxhUrcFZaYdqxkU/ECHjpN6bZJ
         e5PMDh9BThuBCEWNZCn0FLkP4l67yImZHXlZq0oEW8XwYe8gzFFJyhnG9Yz3Kc3Beoa4
         mQnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=3jEh/c8X5kAh+mw2s8BlpUXCIYSTIWmWDs3YUbpKhds=;
        b=jOtrOG2U4CAQSCSLmwNjHj1izWmvJuHGTzQ/YR2jYqRmNzkz9iphmw7bDwgjzfAPmu
         lUsCf0wfQZuLNmZ/f4Dph+ujCulJvSWjSQYKJxdY0mUxbqbqkkEMj7mTYOh+kCqdD7vH
         61nTuoL5gd3yLjC5tXV9nAjJPudmDIIbWvzS9iCRxpOlHlxgkmixmiEvkW+oWBs0By5E
         63Nsh0QBsts9hFoRSVl1+T4oIIYL2V/37fjojANAzS5M/YOr0nSktLlAnyZTsyJkcmGV
         sGDv2/j/pIRG/Py4z7T1PJrCwC2jgRBkdFGY3/o5eqfPeQUg30Gy66++X+Mver+gHea+
         k6Ew==
X-Gm-Message-State: AOAM53115Z9hOcpi/41B3T5hTumXoqbYbnfbln9RwaO57w4zJgs9QMxP
        tHG5GCtBLqLBv6RAoYwEdjFl9A==
X-Google-Smtp-Source: ABdhPJxzDm0p+lh/LmOvXYP48iojGEO/n1SJLLCSOXcwdvKDOtZ2hEon3oDubvx0zGhWM8OmH6bO0Q==
X-Received: by 2002:a37:5804:: with SMTP id m4mr4655956qkb.109.1589567787258;
        Fri, 15 May 2020 11:36:27 -0700 (PDT)
Received: from [192.168.1.183] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id n9sm2165469qkn.10.2020.05.15.11.36.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 May 2020 11:36:26 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
From:   Qian Cai <cai@lca.pw>
Mime-Version: 1.0 (1.0)
Subject: Re: Default enable RCU list lockdep debugging with PROVE_RCU
Date:   Fri, 15 May 2020 14:36:26 -0400
Message-Id: <CA610F47-290E-4826-B1D9-7CE09D7CEA6D@lca.pw>
References: <20200514181305.GT2869@paulmck-ThinkPad-P72>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>,
        Amol Grover <frextrite@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>
In-Reply-To: <20200514181305.GT2869@paulmck-ThinkPad-P72>
To:     paulmck@kernel.org
X-Mailer: iPhone Mail (17D50)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On May 14, 2020, at 2:13 PM, Paul E. McKenney <paulmck@kernel.org> wrote:
>=20
> Fair enough!  And yes, the Linux kernel is quite large, so I certainly am
> not asking you to test the whole thing yourself.

Ok, I saw 0day bot also started to report those which is good. For example,

lkml.org/lkml/2020/5/12/1358

which so far is nit blocking 0day on linux-next since it does not use panic_=
on_warn yet (while syzbot does).

Thus, I am more convinced that we should not revert the commit just for syzb=
ot until someone could also convince 0day to select RCU_EXPERT and then DEBU=
G_RCU_LIST?=
