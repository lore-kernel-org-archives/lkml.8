Return-Path: <SRS0=/Won=67=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13432C433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 17 May 2020 11:12:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DBC8A206F4
	for <linux-kernel@archiver.kernel.org>; Sun, 17 May 2020 11:12:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="gVfUAYDo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727907AbgEQLMh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 May 2020 07:12:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727832AbgEQLMg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 May 2020 07:12:36 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F2A7C061A0C
        for <linux-kernel@vger.kernel.org>; Sun, 17 May 2020 04:12:36 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id c24so5811367qtw.7
        for <linux-kernel@vger.kernel.org>; Sun, 17 May 2020 04:12:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=Zyl3SarFIasLxbZ+RIzpA3l1T3ELrj/FBTllereD9vE=;
        b=gVfUAYDorbrrcavuF+7jzMivSWiuHH+HWijoJzN3x7+36DiWCaaXZeshs+HeYjbaVn
         sGCIdzXE40/UKgJpzhp6xtYBzBttOR1dp0VfiBDyCwjXB0YfyAe6xiHM89fH0ZP3ahLL
         UhcWS/esXKCSeQcqrLW+7fpfza1HvO8lSghtmjsxG8/YGZCa3aOtGDgCrymKSfNZOQBf
         nA7McKvnwl3+7T8j+oBVAMFpmLWFAUusLSQ1cNwHflYRsvbUIfre1u0PiJc1Olkvk+NY
         wxqDt8f4P1AJMRy/r8DBlmxXn+MNt/9s24JKgmQAGONF0XNS4AUhbTlErFPS7ie6dOyR
         zkkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=Zyl3SarFIasLxbZ+RIzpA3l1T3ELrj/FBTllereD9vE=;
        b=PuWjLAlCxhEaLP+Db+dANv6h2+EV1Sq+yfCpTNBkRPyVC3ITeX2BVqeekaabTbD15G
         ELQQGRkgyHQup3Ar+fZtWbUIMlGSJmEgI0iK8d2Tmpj7+/v8YtIred6Bcl3gGcR3xYT+
         foIS9xUAMH51o2rrsjTlJFvTZiQZXbLuGZIrxFDF6kRkKIGxgZl+xMyYUG0gnPfQeSTR
         ogWsBXnrl29e+vhi5ci8w0U68OGzGl+GbKdirSY31H8o910H7lY5theJ3Sive6u3Jz7x
         c0N0+u6+CzmgLRp6MhbjZr+UsY/meod1aeVFqBkKzBjdUETy99hgZ56MgQZsBTjmaq94
         hkjg==
X-Gm-Message-State: AOAM5323eRx+JDUiAveOW5Hkyfrmy5sGp5ah0R4dERU2JMHdZihVffxS
        1DGooWMXo663vmpdkl+hhiuCew==
X-Google-Smtp-Source: ABdhPJxm+Z6psJVh1daO567GdnW4roVUxYUbV5oTdCairc5qpsrr0Ja8dmh8CYKiFCVFihyKb1Eg+w==
X-Received: by 2002:ac8:4650:: with SMTP id f16mr11496052qto.168.1589713954634;
        Sun, 17 May 2020 04:12:34 -0700 (PDT)
Received: from [192.168.1.183] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id h22sm6512975qtn.23.2020.05.17.04.12.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 17 May 2020 04:12:33 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Qian Cai <cai@lca.pw>
Mime-Version: 1.0 (1.0)
Subject: Re: "BUG: MAX_LOCKDEP_ENTRIES too low" with 6979 "&type->s_umount_key"
Date:   Sun, 17 May 2020 07:12:33 -0400
Message-Id: <06E43DA0-9976-4D44-AC72-5ED8A7022FA3@lca.pw>
References: <e8c6d3af-3045-0a37-5e9e-bfd60c09f97d@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        David Howells <dhowells@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <e8c6d3af-3045-0a37-5e9e-bfd60c09f97d@redhat.com>
To:     Waiman Long <longman@redhat.com>
X-Mailer: iPhone Mail (17E262)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On May 16, 2020, at 9:16 PM, Waiman Long <longman@redhat.com> wrote:
>=20
> The lock_list table entries are for tracking a lock's forward and backward=
 dependencies. The lockdep_chains isn't the right lockdep file to look at. I=
nstead, check the lockdep files for entries with the maximum BD (backward de=
pendency) + FD (forward dependency). That will give you a better view of whi=
ch locks are consuming most of the lock_list entries. Also take a look at lo=
ckdep_stats for an overall view of how much various table entries are being c=
onsumed.

Thanks for the hint. It seems something in vfs is the culprit because every s=
ingle one of those triggering from path_openat() (vfs_open()) or vfs_get_tre=
e()

When the system after boot, lock_list entries is around 10000. After running=
 LTP syscalls and mm tests, the number is around 20000. Then, it will go all=
 the way over the max (32700) while running LTP fs tests. Most of the time f=
rom a test that would read every single file in sysfs.

I=E2=80=99ll decode the lockdep file to see if there is any more clues.=
