Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BBA5C35247
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 22:34:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED72C20721
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 22:34:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="bFqSrV10"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727336AbgBCWej (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 17:34:39 -0500
Received: from mail-qv1-f65.google.com ([209.85.219.65]:42341 "EHLO
        mail-qv1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727176AbgBCWei (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 17:34:38 -0500
Received: by mail-qv1-f65.google.com with SMTP id dc14so7625373qvb.9
        for <linux-kernel@vger.kernel.org>; Mon, 03 Feb 2020 14:34:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=+fusxKQznfXe0AR6ZRaAM9DvgsEBwF2XHWrHEPkZkVI=;
        b=bFqSrV10iRvDAZ/8wZkiP5LNSgydjiVDGxkvlnZFoX/IbXO6VLESkTO02xIQm5xh7D
         nSmh3e4Z0JRFhX01lUM4VgAgpGan+2//aKG74o6//J5b9jZZ1Yuh0uPPU15XNVn3dP4H
         7vseIj8E/cSfHt8TD5BP4QGLJhgRt8fhW87I77Ea9dgYkjzJPA4/szNGMr52n5tRelDQ
         y0258cgv7p0vW8AaXnvfqC50e433ErrCVftsAvtuGeRNGCstDc+FC84hU0/vc4GFVy/n
         y6yGaaVT7B1mk3VYmRUDoNIpg604j9lJGEImbRrILVb12ngo2/wXWGwgrm0ftr4RDhMt
         1gRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=+fusxKQznfXe0AR6ZRaAM9DvgsEBwF2XHWrHEPkZkVI=;
        b=ZDI9oKcuUpfEaFlJky0bwr03uIodiLN3zOgSQikTxsoZHtpAz90sFEoRw5oVJIN7co
         ne+9MK8dVxcFTsNKeXzFSTao67sHyZ4zsxP9u6B5yB8zMmSPEfMHnzUPsElkBf292QdP
         riOC7tUGao+zDdGc8PSwBGTHyEjQnjhdW1ZM/qqkUJAiLK5Jqsxo8+aRrZUFUEO5aThn
         H4al0syHbZOYwLvakjjZp2wU5x6xzZGT5RZBkB0GEuGsVOynb5sgPHenqLGiKlKumJzj
         gHHSt+VOZKq8m5Ch8ZgRF4NS9/vYcRVQGeiTn7+NgDwaZz6X2v9A3VAhP/jv8p0P6wYU
         5d2g==
X-Gm-Message-State: APjAAAVyoTj2gD59MCw3RmCm+HRcdRtBiWRGkJwwyinWIfZUqWH1IDSf
        z7GogrhEIMppFTyrMQ4uKe07tA==
X-Google-Smtp-Source: APXvYqzOQ5czIomE+ue1IlX3E1IxdYf4I/ww5gdtcv2hvPP7Xx1OOVLQNOuBUibenHi7fR/ywY23Wg==
X-Received: by 2002:a0c:eacb:: with SMTP id y11mr25722163qvp.68.1580769276355;
        Mon, 03 Feb 2020 14:34:36 -0800 (PST)
Received: from ?IPv6:2600:1000:b048:97ac:a93a:b890:262:8b7b? ([2600:1000:b048:97ac:a93a:b890:262:8b7b])
        by smtp.gmail.com with ESMTPSA id e3sm10786731qtb.65.2020.02.03.14.34.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Feb 2020 14:34:35 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Qian Cai <cai@lca.pw>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] skbuff: fix a data race in skb_queue_len()
Date:   Mon, 3 Feb 2020 17:34:34 -0500
Message-Id: <A5748E52-90D8-4B5B-87BD-65F980D79A63@lca.pw>
References: <126aa227-2383-efdd-742c-6ccf85ae7ba4@gmail.com>
Cc:     davem@davemloft.net, kuba@kernel.org, elver@google.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <126aa227-2383-efdd-742c-6ccf85ae7ba4@gmail.com>
To:     Eric Dumazet <eric.dumazet@gmail.com>
X-Mailer: iPhone Mail (17C54)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Feb 3, 2020, at 3:28 PM, Eric Dumazet <eric.dumazet@gmail.com> wrote:
>=20
> We added recently skb_queue_empty_lockless() helper, to use in these conte=
xts.
>=20
> The fact that we use READ_ONCE() is more of an implementation detail I thi=
nk.
>=20

Make sense. I=E2=80=99ll use lockless in naming instead.

> Also, addressing load-stearing issues without making sure the write side
> is using WRITE_ONCE() might be not enough (even if KCSAN warnings disappea=
r)

I suppose that could be a case. I=E2=80=99ll have,

WRITE_ONCE(list->qlen, list->qlen - 1);

in __skb_unlink() where it had already had a few WRITE_ONCE() for other vari=
ables.=
