Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF2B9C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 03:51:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B1EC9206B6
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 03:51:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GRPh52lQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729319AbgF3DvS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 23:51:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726686AbgF3DvQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 23:51:16 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E6DFC061755;
        Mon, 29 Jun 2020 20:51:16 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id f23so19537969iof.6;
        Mon, 29 Jun 2020 20:51:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yAZduYcEKm4wiOoLB6wnk1hlMRtoPsLgtKlyIvlMUUk=;
        b=GRPh52lQSWCzW35W1QnyaXOUmA34A/4AKUJjxPBB0VlNIVGeMOVGpYwzpA+yAP6u5J
         Q/9T5zn8OMWx8UqWS1/SU2N7Fa7rlMr4g+yxOfWeCLZOdHgItmQuwWt1HaSQVyDrBXPc
         a1AK+WsOXG+pgOsnP3x6sjLTHVz3Fo9neUwd7PbK6WAwQjRGfc2FhCrMdgJXECoCtfSF
         TxR9vEv4TM+Yq7FpuSrPu+z6w9pOaBMAQ1Sw+3h4CJIKBSb3oQM1s8R7fka14V0lbrhq
         vRzW4dTi4NG5laeU7B2h0KqzTxamOycL4XWGGp62R5RXGMS+uKyQyU6nKTpMmZOAja89
         nGnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yAZduYcEKm4wiOoLB6wnk1hlMRtoPsLgtKlyIvlMUUk=;
        b=hPPZ0PoE+PlVVAmdhSKSdn6T31+qmVD+4Dum8LRsFmniP3P6ydrS9yTQvoI12TJM0t
         i/S+J+2tIPCVwwfa0Wms2DvQYKbWTuH3k9PWGUb5gcmVomyvbBBsS6M8/EY3T2V3ghna
         3nsFpFnFkCkBWb85EutmYVgHNRkkIf8/322VaelAmT5puoofcZJi93SRwKIiE5jPWeTR
         gpIqL/d2f7/Z9bAwtNBlFoBpDVRbHbgVf1UpSmpBFPUvaBLEvzqx6YqcuE/Q3xnWCxbi
         QbW3EHvKAvdhZDmVjv/YlmUP0txzmViqxXkbTRMuCH0Wp9dmUfdtfcHfr8OZVQQ45QqZ
         TWIA==
X-Gm-Message-State: AOAM53031Q9m9S5j8mhBCkyTC5j3wbMNPw9ZsXseUNM29glgidedVp8L
        /hfdFAl6Jmm4hHVsxTVOb8BEXsVpc0bducq5bOU=
X-Google-Smtp-Source: ABdhPJzZuNXww1kpEzblOjBpzpBSukrXvLvu4Pg0QYX2Fd6c599me8PtcJRbpr2i2G2X4Cfyo6dOfit79hB2g9nQUgU=
X-Received: by 2002:a05:6602:1225:: with SMTP id z5mr20025766iot.64.1593489075913;
 Mon, 29 Jun 2020 20:51:15 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000dfdbe905a90ba06d@google.com>
In-Reply-To: <000000000000dfdbe905a90ba06d@google.com>
From:   Cong Wang <xiyou.wangcong@gmail.com>
Date:   Mon, 29 Jun 2020 20:51:04 -0700
Message-ID: <CAM_iQpU82OmoYhgHv7rywL65a61uG2KAK82ANnnDy+7_7cdLoA@mail.gmail.com>
Subject: Re: KASAN: vmalloc-out-of-bounds Read in __nla_validate_parse
To:     syzbot <syzbot+314cd606fbedf9d5d0b2@syzkaller.appspotmail.com>
Cc:     David Miller <davem@davemloft.net>, jmaloy@redhat.com,
        Jakub Kicinski <kuba@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Kernel Network Developers <netdev@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        tipc-discussion@lists.sourceforge.net,
        Ying Xue <ying.xue@windriver.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

#syz fix: genetlink: get rid of family->attrbuf
