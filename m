Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8F57C2BA19
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 14:52:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9BA9B2078B
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 14:52:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C/H1Ld/U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S371063AbgDOOwj (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 10:52:39 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:22422 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S371008AbgDOOwb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 10:52:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586962349;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1kDbnhqGtMqjG8lQXCk80CQmsrtdvPEc5fw6ACqAyhw=;
        b=C/H1Ld/UpTcQIYs9FOkp4c61aFCqM+2TIofKygMKARV3ZkswPrwRH/jBHQuLarq7ws9JBA
        Zbr62q2asMH68WVXXNJs2ejBRWkM9BZlVnzL7FuMnhbRV05MHb2ETBdxo4jreuL7i4ATxb
        NtE5hjH0xLPOGhvPuFpGbu6lfghbfxI=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-399-vgPpevbXMUC7Y9TFMnlG3Q-1; Wed, 15 Apr 2020 10:52:28 -0400
X-MC-Unique: vgPpevbXMUC7Y9TFMnlG3Q-1
Received: by mail-oi1-f199.google.com with SMTP id y70so13153725oie.21
        for <linux-kernel@vger.kernel.org>; Wed, 15 Apr 2020 07:52:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1kDbnhqGtMqjG8lQXCk80CQmsrtdvPEc5fw6ACqAyhw=;
        b=c61xZJizK3q6qbOxGzYk7sNld0Kke3hWEUPNOhtrzzaQF1KoGfPZZffUGuzbv9hVxT
         ouSH8DBzq0qoH8Z8iUrkWQoqcOhiYhUjAtszUy3RFTLLXm7316r9RrvXJjyQ4cMhvzNc
         rHWW8XwIrP+0h3m0KgiwPuZx/hZV/k95w4I7WiwjISKvpQhTL+RbBEWzz5Lul8oxXiFG
         rRtEFDpc1yxnJBB5t0U9/raOE/GyygvJh/6WJIxt6LR01yl40GYbb+IAOHJfk1uCqq1g
         JqYk3w4U+7cOiLkNBzMZC4+f1qLeyN/zkU8BfcOfPxZF5IV4Slk17bfulOUHqrcRzwdO
         Okjg==
X-Gm-Message-State: AGi0PuZvsCWZCSqUJAinZWlSmG7bGdFBngNt0Yiy7glbPlJitO1khutK
        MqJnJaFkex1cddkwebuY4XjiHf/FvExWTtkSgcrjXd496u7vu9bycSfz00XeuZKvrn88/tzfq1W
        Z3lA+j/7JSfgGavx92g5GhMq5eSACI78DTaKo2ek4
X-Received: by 2002:a9d:de2:: with SMTP id 89mr2906548ots.95.1586962347576;
        Wed, 15 Apr 2020 07:52:27 -0700 (PDT)
X-Google-Smtp-Source: APiQypLmVmCktd00qieZfjc3BOKQ5/p1IiZjFTHz+lHTkbXBFkFLjMuioL0TxwltuaXwGoF4kLCbcx9/6KoorQ3tcig=
X-Received: by 2002:a9d:de2:: with SMTP id 89mr2906526ots.95.1586962347345;
 Wed, 15 Apr 2020 07:52:27 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1586960617.git.mchehab+huawei@kernel.org> <e146506222bf13e8ef7008ac8b4547172c2faad8.1586960617.git.mchehab+huawei@kernel.org>
In-Reply-To: <e146506222bf13e8ef7008ac8b4547172c2faad8.1586960617.git.mchehab+huawei@kernel.org>
From:   Andreas Gruenbacher <agruenba@redhat.com>
Date:   Wed, 15 Apr 2020 16:52:16 +0200
Message-ID: <CAHc6FU7AKuXMtyYduqd5POOmi6nOLbi6_usmS_Jk3eJ-bK568w@mail.gmail.com>
Subject: Re: [PATCH 18/34] docs: filesystems: convert gfs2-glocks.txt to ReST
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Bob Peterson <rpeterso@redhat.com>,
        cluster-devel <cluster-devel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mauro,

I've pushed this to for-next.

Thanks,
Andreas

