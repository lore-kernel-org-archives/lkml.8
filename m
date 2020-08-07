Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA7FEC433E1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 07:42:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A2FB206B5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 07:42:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OV76/l2Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726648AbgHGHm5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 03:42:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725805AbgHGHm5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 03:42:57 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D43B6C061574;
        Fri,  7 Aug 2020 00:42:56 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id h21so641324qtp.11;
        Fri, 07 Aug 2020 00:42:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=j1PHKfmXiylGJIkjZYDzTA3mKv1+F3AU7u80Di/VqIw=;
        b=OV76/l2QfZcw48Z9C91+mcRH/DaCJN333f8HhOAQGBdJOj9bE6LuEtnN2AR/5q96EU
         B4BdRp4UCJ51CmHUmHkWaeO2ZuxXB6MZHkWNzo56R353S37ldNz39A5XxfQE5FkyTkxK
         NN0c1bcsWXvI5BLk7eqMZ9Gj0byAoZU0UHGSkO3mKHowJ99hpdW/xHxVsg12DTnMT7Av
         Jvw9Yk0M69WSp3BBDRX72iCHxtSlJQ8S4VmZ2z4561Swgs43qfOthmONYpQA3jADZruO
         1pKdQTXHnLwRQB+H3XjLQxONP87PEAKVgc6R4jpvUZmpvyZ6dwPUoMcUXMew8t1dXLMU
         geYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=j1PHKfmXiylGJIkjZYDzTA3mKv1+F3AU7u80Di/VqIw=;
        b=DHxOMaqYKjxhzEXVpCRCooSMELSV143E/DQzVYrBYB39oG+siG8sop7TSsGcEED9Wk
         fH71U1PrXhzsV205Dg7z73AuU2vqgzzSKokITiQ1iUmre1q6vjAwRLRwpNLgSiNCIvgz
         C2eNZJ7NrMGF2g+XNSmY0OPwJmnFmKrXnWRZmpBf/Z88DfZ3cp3KBtiu9sjQVNGeUJgd
         xVu95Ywp4dR5nt+SLubT1UUmRrnETlYmvLaP2jk8Al4ETNHJkbOpEY8IW9LnbzazJ0qt
         XYeRZaBz0UMBXZL0pOkQUp8xBR24Ox3H8LeSmVjCMfXZOZPVRdKWc+wzONKRx0VPSUG0
         O6dQ==
X-Gm-Message-State: AOAM530vsQZ+6TSlMolMnq4Qy27pP2uvvZ82/1BwxJExTC7JpTQjpeSO
        uz/QRvdm1fwwI2jpZSt9Pzc=
X-Google-Smtp-Source: ABdhPJwCuUcPbN6uRftDOG+l2D+A2n1wiHCcAC3Px4U+eLuc5gGrn8kXA1u+UKCb5TXk5oiVQZytmg==
X-Received: by 2002:aed:36c8:: with SMTP id f66mr12829418qtb.6.1596786174614;
        Fri, 07 Aug 2020 00:42:54 -0700 (PDT)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id w58sm7303650qth.95.2020.08.07.00.42.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Aug 2020 00:42:53 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailauth.nyi.internal (Postfix) with ESMTP id A66F627C0054;
        Fri,  7 Aug 2020 03:42:52 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Fri, 07 Aug 2020 03:42:52 -0400
X-ME-Sender: <xms:_AUtX--55OZMgH4oQPWqMEmHe8LCR3mT2l-e4Sb910JvcC4ztCWfnA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrkedugdduvdehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffoggfgsedtkeertdertddtnecuhfhrohhmpeeuohhquhhnucfh
    vghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrthhtvg
    hrnhephfegleelfffhgeejleffffeliefgtdejtdeffeefffegffelteehhffhgfeiveeg
    necuffhomhgrihhnpehmrghrtgdrihhnfhhopdhkvghrnhgvlhdrohhrghdplhifnhdrnh
    gvthenucfkphepuddugedrkeehrddukedtrddvudehnecuvehluhhsthgvrhfuihiivgep
    tdenucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhhph
    gvrhhsohhnrghlihhthidqieelvdeghedtieegqddujeejkeehheehvddqsghoqhhunhep
    pehfihigmhgvrdhnrghmvgesfhhigihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:_AUtX-sAusCZPdc1VdpDSCOM2j94cCVyNaEMI_XdGFLPDmAXuN1bOw>
    <xmx:_AUtX0DeCcZvhKpNQYhLJr85oUa2mKlehaXS8tCxUXT_lq8Db4tI6g>
    <xmx:_AUtX2eNxNdsd4yNtliC7Ozrou_keOuUNPjwbKp3sKYk2G-j12TDUQ>
    <xmx:_AUtX4r5eWITIG5Aq2fq4Caccjvscih0kL46_bV70qrCFFc9L3I4Tw>
Received: from localhost (unknown [114.85.180.215])
        by mail.messagingengine.com (Postfix) with ESMTPA id 435523060067;
        Fri,  7 Aug 2020 03:42:50 -0400 (EDT)
From:   Boqun Feng <boqun.feng@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>
Subject: [RFC v7 00/19] lockdep: Support deadlock detection for recursive read locks
Date:   Fri,  7 Aug 2020 15:42:19 +0800
Message-Id: <20200807074238.1632519-1-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter and Waiman,

As promised, this is the updated version of my previous lockdep patchset
for recursive read lock support. It's based on v5.8. Previous versions
can be found at:

V1: https://marc.info/?l=linux-kernel&m=150393341825453
V2: https://marc.info/?l=linux-kernel&m=150468649417950
V3: https://marc.info/?l=linux-kernel&m=150637795424969
V4: https://marc.info/?l=linux-kernel&m=151550860121565
V5: https://marc.info/?l=linux-kernel&m=151928315529363
V6: https://lore.kernel.org/lkml/20180411135110.9217-1-boqun.feng@gmail.com/

Changes since last version:

*	I change the detection algorithm which I present in 2018
	plumbers [1], you can find the explanation of the detection
	method in patch #2.

*	Adjust the irq safe->unsafe changes from Frederic Weisbecker

*	Add more tests.


As Peter pointed out:

	https://marc.info/?l=linux-kernel&m=150349072023540

The lockdep current has a limit support for recursive read locks, the
deadlock case as follow could not be detected:

	read_lock(A);
				lock(B);
	lock(B);
				write_lock(A);

I got some inspiration from Gautham R Shenoy:

	https://lwn.net/Articles/332801/

, and came up with this series.

The basic idea is:

*	Add recursive read locks into the graph

*	Classify dependencies into -(SR)->, -(ER)->, -(SN)->,
	-(EN)->, where R stands for recursive read lock, N stands for
	other locks(i.e. non-recursive read locks and write locks), S
	stands for shared locks (read locks, no matter recursive or
	not), and E stands for exclusive locks (i.e. write locks)

*	Define strong dependency paths as the paths of dependencies
	don't have two adjacent dependencies as -(*R)-> and -(S*)->.

*	Extend __bfs() to only traverse on strong dependency paths.

*	If __bfs() finds a strong dependency circle, then a deadlock is
	reported.

The whole series consists of 19 patches:

1.	Add documentation for recursive read lock deadlock detection
	reasoning

2.	Annotate read_lock() correctly (with queued_read_lock()
	semantics into consideration)

3.	Do a clean up on the return value of __bfs() and its friends.

4.	Make __bfs() able to visit every dependency until a match is
	found. The old version of __bfs() could only visit each lock
	class once, and this is insufficient if we are going to add
	recursive read locks into the dependency graph.

5.	Reduce the size of lock_list::distance.

6-7	Extend __bfs() to be able to traverse the stong dependency
	patchs after recursive read locks added into the graph.

8.	Make __bfs(.math) return bool.

9-11	Adjust check_redundant(), check_noncircular() and
	check_irq_usage() with recursive read locks into consideration.

12.	Finally add recursive read locks into the dependency graph.

13-14	Adjust lock cache chain key generation with recursive read locks
	into consideration, and provide a test case.

15-16	Add more test cases.

17.	Revert commit d82fed752942 ("locking/lockdep/selftests: Fix
	mixed read-write ABBA tests"),

18-19	Add more test cases (including tests that are specific for
	queued_read_lock())

This series passed all the lockdep selftest cases (including those I
introduce).

Test and comments are welcome!

Regards,
Boqun
