Return-Path: <SRS0=flzY=3U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3086C2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 14:56:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 897AE20707
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 14:56:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="P54WA2PG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729159AbgAaO40 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jan 2020 09:56:26 -0500
Received: from mail-yw1-f65.google.com ([209.85.161.65]:33526 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729008AbgAaO40 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jan 2020 09:56:26 -0500
Received: by mail-yw1-f65.google.com with SMTP id 192so4954402ywy.0
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jan 2020 06:56:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=f3RC/SQifpuY8VOrKnWaTREoPKqzmE43+PbrL0jAXis=;
        b=P54WA2PGuxfHKuFWwjrCbu/PdvMVuTnU6Dy7LvFOdRSFKsLV2oQuVF4ER8MQlrTzXG
         BXeSJzDcUOkjj1ktcmYJEd+ANaql3n7CK1hTX1lLL/noTkNXvixZOjO1xhQKB4i7oNX/
         Jz0RTVlQUZ6txzCjiRFNpCIY+moznMKuzZ/jwGn076BYfEQ457YobGxXeax8y9d7Sfk/
         B2HZTKv6CE2qMyFykdxTS3+qtSqlOe24FS78clS9dvGX9mg0/TAofXrBoUqJpS+fjcQf
         znE14zc4DrIFSnqC41wvvUaa13UJl7g0WxziSCWoLP/A7YDivoTpGwdYYNcAJzpmmvMb
         Ollg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=f3RC/SQifpuY8VOrKnWaTREoPKqzmE43+PbrL0jAXis=;
        b=f9jg/XfYnDgb1iAbZx183uNuxmftiUhu3vA/3bmjosPdk+PsV+8/7XitsqsL0fkNp9
         XMB/b9DZRuQk+d4Ec/sTGdZe0bIDwyg/c1Zi/K6cydn2b6jxr9J5q3VInCUjxHKZZUj7
         H3/qSX5AsLnrJ0yYkRMtGgtkyyobvCplcB9aRnCojzSYHUp/abpVhBot4u+OdAwjj7lw
         z0D8b9JG78QcstBMGH54gKXt0Ny2IFq1BcRVNzGmzLUr02dlAPQl5NKNiGbHmJILoDXv
         DLwQsEOHrLz4IuOJty6NTYvZXcYpFiZQK7UamoI8DO/qFwpZ2RccsVzM+/nQRXkWe/sb
         hY1w==
X-Gm-Message-State: APjAAAVKMi7u3QjE+ivuFHtBX+rOhRZJy0IG+QtJlqAWxEUstN9kWtBM
        aUHRhvp+sI1OOhOiTMRDNiJBnuudxtI+OYUdDuWlPw==
X-Google-Smtp-Source: APXvYqxA/y+W7hbdbObbPKgxxIFfPSwtpl3SGq3C/Avbu4JwPSIPL0Zm0sJFTvez7VjM7JtzbYh23B12TQvZ1QBQ0ck=
X-Received: by 2002:a0d:c701:: with SMTP id j1mr1163590ywd.52.1580482585227;
 Fri, 31 Jan 2020 06:56:25 -0800 (PST)
MIME-Version: 1.0
References: <20200131122421.23286-1-sjpark@amazon.com> <20200131122421.23286-4-sjpark@amazon.com>
In-Reply-To: <20200131122421.23286-4-sjpark@amazon.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Fri, 31 Jan 2020 06:56:13 -0800
Message-ID: <CANn89iJrwVuEUHFqH1iCJd3nwTWAuXCdEJozwz6gzDV5Snm3Ug@mail.gmail.com>
Subject: Re: [PATCH 3/3] selftests: net: Add FIN_ACK processing order related
 latency spike test
To:     sjpark@amazon.com
Cc:     David Miller <davem@davemloft.net>, Shuah Khan <shuah@kernel.org>,
        netdev <netdev@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, sj38.park@gmail.com,
        aams@amazon.com, SeongJae Park <sjpark@amazon.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 31, 2020 at 4:25 AM <sjpark@amazon.com> wrote:
>
> From: SeongJae Park <sjpark@amazon.de>
>
> This commit adds a test for FIN_ACK process races related reconnection
> latency spike issues.  The issue has described and solved by the
> previous commit ("tcp: Reduce SYN resend delay if a suspicous ACK is
> received").
>

I do not know for other tests, but using a hard coded port (4242) is
going to be flakky, since the port might be already used.

Please make sure to run tests on a separate namespace.
