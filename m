Return-Path: <SRS0=7DLR=6Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1479C47254
	for <linux-kernel@archiver.kernel.org>; Sat,  2 May 2020 04:12:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CBB5920775
	for <linux-kernel@archiver.kernel.org>; Sat,  2 May 2020 04:12:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="kf2yU7Bs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727791AbgEBEM2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 May 2020 00:12:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726846AbgEBEM1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 May 2020 00:12:27 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED2B1C08E859
        for <linux-kernel@vger.kernel.org>; Fri,  1 May 2020 21:12:26 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id 71so9557599qtc.12
        for <linux-kernel@vger.kernel.org>; Fri, 01 May 2020 21:12:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=AzOwTGLCqsoxcos1rC36ROn5pWK/vWwfcPGTzajxF68=;
        b=kf2yU7BsKbHqzFcVVJurq2/7ijIg6XVB+iwt2JTUEy76OXGB4gpE+VVijMuiRfKM7c
         xw9fpS3AerfR9/Z1YpZHd1X3sAbEpO4DlPE2CMHC0ZrkXb/ExGyMcqxK+VC66cx8LFLW
         kRC23+eMoFlPS8/d0Np6dfiuYsQkWrsQfpb1LLVj1o+ZeOZwmryFS3HgAS23YPGv4xAZ
         XCkkGiiep+y/PkA7p2cCbfRfjyXdrXA91XOVDSxw+NOEf1FH9QJU8dTt3IuHcP002Vl6
         kqYxbsPinAZ//7Bd2Z43slseZJ24TpZAFdQQSfWfcuE1JCsBM4ei2I+V8c3/qdnbbYbz
         hhgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=AzOwTGLCqsoxcos1rC36ROn5pWK/vWwfcPGTzajxF68=;
        b=RIC2kDwF4x/raSO/mt+1JgYVR+RTxxd0yaQqh1MSl2uGnk2RmdvpIut7YSq2aX2edW
         IIDRkCiE+oMLqi3alaibGsPgTGyEWzzvHiECMpT+dnQ75xar+IcH1di76TfF+6fpnjMr
         g0nlk6YH1hWoVabXLbqcBt9JPMCeS0nYugTkwjAHysHFG4uFClEuM7oXYj/O9cT4RAAI
         f/gnYjXyXa85MahHZBLXX00YWWy++va39KMSGSOGbup6h+ZohaG2IP7owfvX8zF/oXaa
         oieNmGy+7AFFYKOPidsvS8//uhQCPmjCj5tjAgUc0QOAL57RzG4mlM2Uab9rf/qqEy7W
         kJQw==
X-Gm-Message-State: AGi0PuZXdLk/pATMrodHhrwxK1uSj944DS1sazNRxEQ6ya/hqahzAbE2
        wyVZR2S8V4R3+DOaXI+850JVIozTzT3KhA==
X-Google-Smtp-Source: APiQypLPkWWge7EXckbKA9YVakIfE03lfFAsJz99G06idEV0NvoYOvjA5KdUvBzLII+eZqBDJlak7Q==
X-Received: by 2002:aed:34c3:: with SMTP id x61mr6579161qtd.333.1588392746111;
        Fri, 01 May 2020 21:12:26 -0700 (PDT)
Received: from [192.168.1.183] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id y10sm4300219qki.63.2020.05.01.21.12.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 May 2020 21:12:25 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
From:   Qian Cai <cai@lca.pw>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] net: fix memory leaks in flush_backlog() with RPS
Date:   Sat, 2 May 2020 00:12:24 -0400
Message-Id: <C9E5387E-6241-4CB3-B3F2-9CA575920569@lca.pw>
References: <8a012879-825f-596d-9866-0dd3a095dfbb@gmail.com>
Cc:     davem@davemloft.net, kuba@kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <8a012879-825f-596d-9866-0dd3a095dfbb@gmail.com>
To:     Eric Dumazet <eric.dumazet@gmail.com>
X-Mailer: iPhone Mail (17D50)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On May 1, 2020, at 11:32 PM, Eric Dumazet <eric.dumazet@gmail.com> wrote:
>=20
> kfree_skb() is supposed to call skb_dst_drop() (look in skb_release_head_s=
tate())
>=20
> If you think about it, we would have hundreds of similar bugs if this was n=
ot the case.

Thanks for quick response. Funny thing is that once I applied this patch, th=
e leaks went away. It could be the fuzzers do not always reproduce the leaks=
 or it could be that call_rcu() in skb_dst_drop() takes a long time waiting f=
or grace periods which may confuse kmemleak because skb has already gone.=
