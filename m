Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29EC5C2D0F3
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 16:19:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0052A20787
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 16:19:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="N69s+eop"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389837AbgDBQT6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 12:19:58 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:35443 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389796AbgDBQT5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 12:19:57 -0400
Received: by mail-qk1-f194.google.com with SMTP id k13so4594634qki.2
        for <linux-kernel@vger.kernel.org>; Thu, 02 Apr 2020 09:19:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=hxf9moS4Fx5cYinkxtKnKXZUbKH1kCLQlOUICyLrcAQ=;
        b=N69s+eopVKPjt9Ak3LJWLduGUIkLlf6HHcv65RpJVSxl05EWhWEmdw9z4801LmN+u9
         k2MqUvT/h7DlzYLWWppX2sDw61SpC9vAV7Po+V6Xq+bFILdWRoCDsGAmL4n5WMJHDr1y
         rh6CCqO368IvkScTluhEX7tztJbuoQGCqzdUp5ObEHNV4pK2ENnkP+uNPbB4uuXmg1hA
         Ka1RYp9i1NfLgd5JgqI6T4ABs6AL0yNsEipKPdyOGtqlaS49U9nOoM5JFqumiTxEjs82
         QVGf+jmTvBrbwx7AT6eyfaqHE/40pUbVjxK6tvuqSkNV6lVNlFPOrFs9hg+9BMCCP7wh
         wZGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=hxf9moS4Fx5cYinkxtKnKXZUbKH1kCLQlOUICyLrcAQ=;
        b=j+r24DUCSFQoCnRGoJpbdW8cisCsewr9c66L37DP9WnCySG4cELDRGsnXT1tSVFLZb
         BFYi785a3yKRq89bjxn4FtL1YE2V4xma0sIobh/WHZf7/kAHFKuwSFNXjTIGcMw2du5S
         R0YxTmxfNN0xgWT7vuVpVgr4vVWsOQU5pkM+fNRjlC0q2sPfu/WSW8pUYpRBtAw9bHJn
         ssq6lG25+G1PGNWpLdmtrRo8VVr59u3p4ONEQR8aD/uWRk9B7TCn5pstdC8wltXuCTqL
         45rJoa9i57ZbvHoVRg2o/4VrH2/5T2k4lwrXQZfO/3+b9v7nIUKAWOpX2V5hff8Fd5mP
         Evbw==
X-Gm-Message-State: AGi0PuZk8ZZM59SAuQhuCmm0nNgqMPv1sRGyvQbSsP7QW9JBbT0W3e1e
        QWoMFkG8oFD5d2SRd36ljqRR1g==
X-Google-Smtp-Source: APiQypK7Tvv6yfkAlbuv3Zm98Fh5mhbo2QkHe/iKDQdeZp1Qh9wYR7AKizHCaNBlBQr8zGtGsc6oQQ==
X-Received: by 2002:a37:4648:: with SMTP id t69mr4077821qka.299.1585844396325;
        Thu, 02 Apr 2020 09:19:56 -0700 (PDT)
Received: from [192.168.1.183] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id o13sm4083358qtk.12.2020.04.02.09.19.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Apr 2020 09:19:55 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
From:   Qian Cai <cai@lca.pw>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v2] sched/core: fix illegal RCU from offline CPUs
Date:   Thu, 2 Apr 2020 12:19:54 -0400
Message-Id: <4134872A-3D1D-4860-9C1B-2FD9C00272BB@lca.pw>
References: <20200402155406.GP19865@paulmck-ThinkPad-P72>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, vincent.guittot@linaro.org,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        tglx@linutronix.de,
        "James.Bottomley@hansenpartnership.com" 
        <James.Bottomley@hansenpartnership.com>, deller@gmx.de,
        linuxppc-dev@lists.ozlabs.org, linux-parisc@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Nicholas Piggin <npiggin@gmail.com>
In-Reply-To: <20200402155406.GP19865@paulmck-ThinkPad-P72>
To:     paulmck@kernel.org
X-Mailer: iPhone Mail (17D50)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Apr 2, 2020, at 11:54 AM, Paul E. McKenney <paulmck@kernel.org> wrote:
>=20
> I do run this combination quite frequently, but only as part of
> rcutorture, which might not be a representative workload.  For one thing,
> it has a minimal userspace consisting only of a trivial init program.
> I don't recall having ever seen this.  (I have seen one recent complaint
> about an IPI being sent to an offline CPU, but I cannot prove that this
> was not due to RCU bugs that I was chasing at the time.)

Yes, a trivial init is tough while running systemd should be able to catch i=
t as it will use cgroup.=
