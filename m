Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45C14C4332B
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 11:11:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15AF720732
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 11:11:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RG4d5K1o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727070AbgCTLLN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 07:11:13 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:33875 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726726AbgCTLLN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 07:11:13 -0400
Received: by mail-vs1-f65.google.com with SMTP id t10so3726277vsp.1;
        Fri, 20 Mar 2020 04:11:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oN4/KUQ8b4ahyaIikru+djpxL5XQQFIKZYbjC0vKpsU=;
        b=RG4d5K1oz2ont5jUJjkmBXY8+/64X5o3IKIS4LOSaudxUVUe8DU1ydUBqbiQboKELu
         1ShHuDcThMIFNOAeKf9tDwjqw0JD2VD1JpQID7+cH7o6+JfICVKvz4V984jiknR/mmw8
         DzXs1jdJJTlxXsvtCLrKUH2u3HagA7ZvDhtaP2ox+KWSqtIM1C271gNXEtCd2P3dytUn
         O6nm8l1TYAlQbcFMaJdY2GR7PMy/utD82oPmrj9xG2NfYizrVrVaMn5tRiLHtcL3ZkNv
         ghk2Px//JSIsj1S93uV8jR/iFOdRWNaPme7LthP+qDx+QkfrE65yHJJ82m04tVoXmP86
         Bisw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oN4/KUQ8b4ahyaIikru+djpxL5XQQFIKZYbjC0vKpsU=;
        b=eAQ1GBq+dPcXJrEutbZxXCgPnwmw6O84rAJUCTyB1iJ0NY6kifb4kbsyHNyK5wK6S7
         1fNfkh3lRxrmq5V8RYXjZLROLuoUO6oTZeaf6xvB+SJfGhfFx6LnhztJhjam6gxvUCC2
         QVMMkmir/CTtcjPwrPHXgcN2TwgLFx2UE+SSnhlk/jXbgpjayf/nO0dpqwfAXsWbxKhq
         ikLa6lNIGoyvASufSbU1Nq+0ZHYDtgWPhaxAllkYhyEdDrpfo9tMyGnyPdqO9Dl+7pnS
         RN4td6oTPiom6N6z64Zci0eM3uvlnu1gz0QuXA6CXoEH35uI3fW+mkrBltTNh1P7RTgn
         /NNQ==
X-Gm-Message-State: ANhLgQ2KAHY+HPF/cUlR4gKhYoOUeCh2EFu67630hXJm2yQAEMfECuId
        dhEfEKkXi8puZcl7eMGIPGlNWo56YGhIT7N00zE=
X-Google-Smtp-Source: ADFU+vsejFVbOnAEdlAKw8nIgzTdGgU0d2mSV9i20J6AFqSFFPnk0AB6zKSwUyzGRMagEavDO/mDBNZWfo1spYVz3hc=
X-Received: by 2002:a05:6102:303c:: with SMTP id v28mr5230330vsa.91.1584702672495;
 Fri, 20 Mar 2020 04:11:12 -0700 (PDT)
MIME-Version: 1.0
References: <00000000000088452f05a07621d2@google.com>
In-Reply-To: <00000000000088452f05a07621d2@google.com>
From:   Qiujun Huang <anenbupt@gmail.com>
Date:   Fri, 20 Mar 2020 19:11:00 +0800
Message-ID: <CADG63jAwaYMP+Q3WNqpOnf39_XZ3z5ZZu-ST-f5q2XM+kHgcgg@mail.gmail.com>
Subject: Re: WARNING: refcount bug in sctp_wfree
To:     syzbot <syzbot+cea71eec5d6de256d54d@syzkaller.appspotmail.com>
Cc:     davem@davemloft.net, kuba@kernel.org, linux-kernel@vger.kernel.org,
        linux-sctp@vger.kernel.org, marcelo.leitner@gmail.com,
        netdev@vger.kernel.org, nhorman@tuxdriver.com,
        syzkaller-bugs@googlegroups.com, vyasevich@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

#syz test: https://github.com/hqj/hqjagain_test.git sctp_wfree_refcount_bug
