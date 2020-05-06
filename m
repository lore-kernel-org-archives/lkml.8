Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12E4EC28CBC
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 16:22:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E5613208DB
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 16:22:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="blArYA9V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730125AbgEFQWn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 12:22:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729602AbgEFQWl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 12:22:41 -0400
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5F98C061A0F
        for <linux-kernel@vger.kernel.org>; Wed,  6 May 2020 09:22:40 -0700 (PDT)
Received: by mail-qv1-xf36.google.com with SMTP id v10so1030222qvr.2
        for <linux-kernel@vger.kernel.org>; Wed, 06 May 2020 09:22:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:content-transfer-encoding:mime-version:subject:message-id:date
         :cc:to;
        bh=phACmFjtsUr519GbyVMqeDIygQPJGWBVYvjGrWTBdhE=;
        b=blArYA9VIT1l590CBcRy4de/5VR4Zz8ladRcp5qB3XrsCeS8dPce/7akzh7znMzZd2
         QJwhrtAG/gh1Lz2wE12y6ajf6ZUFm2jzzfET5PL52gO5usJDMbN1yCeMQPZGnI2AgCXo
         wJD+/u5gxKVj4r7rMNNen+nNKr/h/NsRYY3Vw0GyvqI+dCMJpCZW4x37yKNmntn07Tt/
         VdP7m+LSNsJfP/pqSA0Yq5X5DSYMWZ0nl7s1hGUhkOmn3+iY9qYzmAtpvG+GIK7sETr/
         KUhMVGJJfIjjWHVGf8eYN/maUwpUODKcPwPTZg0zbZMVgzWDNIvSUngz5qiIArjQms/i
         bc4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:content-transfer-encoding:mime-version
         :subject:message-id:date:cc:to;
        bh=phACmFjtsUr519GbyVMqeDIygQPJGWBVYvjGrWTBdhE=;
        b=Ce40z6VtCwAg13QyEZ8FfoCKM203a1Xyht3G5+DaJNDauzMDM6JyXphE4Gs3YChTTM
         O7RXE0SlkOa6lsnnfgIzx6YdCkBGhP2DwSFXQnse0yGmRBoxiqmBXNSlphYho+x3UGe4
         w6urFQGnIsg8aUS+4elKHXoCjQcrvKp23VpajbGGNbYR5DLtG2defBdgAZCwbWIXxvGI
         MbXGDL1YKU0s+QDmIZ3/h+rtswfTk1tNuOdbThV9EPIVn9I6+l0Oa0fdOip7ZKn0O/Gv
         bkGB2cheHpvZHpd0Whz6kaPfd3S0XlQK4p3unqA7i5wYJwuw9Px60Uj4QjpF+5mttY9d
         7pvA==
X-Gm-Message-State: AGi0PuY7YgiixQHhkbZ09R0BKJjvc+g+rhszt0QvvuxaQts5/wtSk+KO
        vYSWbkiq22UqVFJ1oWZeYmi9ZCiNh8itdw==
X-Google-Smtp-Source: APiQypJx//I3wpa4sAYFG0etQeNjQjU3zYkRQnI7Ifia9Us5vO9GTnNQ2HPLH3gBgcIzdwZJAOyosw==
X-Received: by 2002:ad4:4864:: with SMTP id u4mr8268319qvy.117.1588782160029;
        Wed, 06 May 2020 09:22:40 -0700 (PDT)
Received: from [192.168.1.153] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id x5sm1864421qtm.81.2020.05.06.09.22.37
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 May 2020 09:22:38 -0700 (PDT)
From:   Qian Cai <cai@lca.pw>
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Kmemleak infrastructure improvement for task_struct leaks and
 call_rcu() 
Message-Id: <45D2D811-C3B0-442B-9744-415B4AC5CCDB@lca.pw>
Date:   Wed, 6 May 2020 12:22:37 -0400
Cc:     Linux-MM <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=3D=3D task struck leaks =3D=3D
There are leaks from task struct from time to time where someone forgot =
to call put_task_struct() somewhere leading to leaks. For example,

=
https://lore.kernel.org/lkml/C1CCBDAC-A453-4FF2-908F-0B6E356223D1@lca.pw/

It was such a pain to debug this kind of leaks at the moment, as all we =
could do was to audit the code by checking all new put_task_struct()  =
and get_task_struct() call sites which is error-prone because there =
could be other new call sites like get_pid_task() which would also need =
to be balanced with put_task_struct() as well.

What do you think about adding some aux call traces for kmemleak in =
general? For example, if the tracking object is a task struct, it would =
save call traces for the first and last call of both get_task_struct() =
and put_task_struct(). Then, it could be expanded to track other =
refcount-based leaks in the future.

=3D=3D call_rcu() leaks =3D=3D
Another issue that might be relevant is that it seems sometimes, =
kmemleak will give a lot of false positives (hundreds) because the =
memory was supposed to be freed by call_rcu()  (for example, in =
dst_release()) but for some reasons, it takes a long time probably =
waiting for grace periods or some kind of RCU self-stall, but the memory =
had already became an orphan. I am not sure how we are going to resolve =
this properly until we have to figure out why call_rcu() is taking so =
long to finish?

Another solution is to add aux call traces for both skb_dst_drop() and =
skb_dst_set() for this case, but that there are many places to free =
memory via call_rcu() like inode free etc.=
