Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BE90C35679
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 06:31:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D39E520661
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 06:31:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TPmHKW48"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727463AbgBXGb0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 01:31:26 -0500
Received: from mail-lj1-f170.google.com ([209.85.208.170]:39128 "EHLO
        mail-lj1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727197AbgBXGbZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 01:31:25 -0500
Received: by mail-lj1-f170.google.com with SMTP id o15so8741810ljg.6
        for <linux-kernel@vger.kernel.org>; Sun, 23 Feb 2020 22:31:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=B6/VXN/riP71mCT7qHtBjSkrNxoJZJJB4MT4JYPDpck=;
        b=TPmHKW48Ysrhnhx/b/lWggw4rt/v1MsWdRNZRG8bcfy/Pr2UGJLyi/vtc7nI83lzAV
         bIWIrbUL2CXLaFF0UJQL+xjNrUWHw4mJBDEHFv8LzsTMjAf2uKoI66eNzORxXhmA1tct
         hM3oncsWX16jmzZwbY8Tq9XeWyyto52TmfI6JUWK0N90Gwq+RE9ijVtQQvD9Cs1iJEQq
         OBlLk/2Qg56aoWd2oTTnbzElIVZBpSUeoHmLWLxpWHZi7ajB6AOy8IQ/LfFCUYbACpgn
         22f2wrUq0hZIYg4Yvt4x3CEqnLbbZy9zHBF8/JajcoafcJZCJeIuw44dauywNwwCejUn
         2bQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=B6/VXN/riP71mCT7qHtBjSkrNxoJZJJB4MT4JYPDpck=;
        b=VGw8JBXHp790fD5fCt6QgSR1ZndDpwr8tkGqMr/97pM9K+gDjL7V0jbH6U22KTG6et
         PHhvwlVJq1fLrekLk3eGhToozc5RIX+8jIalE/g/68+W2X5IffWv4Sa/ZSTYQ1IlwHh5
         s0EqAeSwdXK2vNNaNjAqnrT0km/t2nnyEzreiezZXdxpckVxYHX4fJ8dH2hBHgxqvvAn
         NJh85nm7lRU/U2t+HhrMmLRlxn5i3OubYaWTJDSeCLtmDuFGevOEgomcwjOVoLXxY5/p
         q4d72IyzEF4PLtyRef9z0w1jis+sk+s25Qpv1c/O/8IznoTxlJTpxrwd9zz4qIXUmfRd
         8RPg==
X-Gm-Message-State: APjAAAUyHGahrWDtC7pV4bcElTp6abZf9RJvQYc+GjRRHTUabv6X4/Jl
        zK848kM+17lFRQU1JTEYFpBtOhJ/7sD1O5kAmngF
X-Google-Smtp-Source: APXvYqzCets3klF2yiOvrJ3xHkpvKVhM7CGgTckA9GbP9Oj3WrNPed5eiyuTwfO716e2IHFKnOUh8ey48pupRf75vo8=
X-Received: by 2002:a2e:7812:: with SMTP id t18mr31072503ljc.289.1582525882593;
 Sun, 23 Feb 2020 22:31:22 -0800 (PST)
MIME-Version: 1.0
References: <20200212222922.5dfa9f36@oasis.local.home> <20200213042331.157606-1-zzyiwei@google.com>
 <20200213090308.223f3f20@gandalf.local.home> <CAKT=dDmB=TX++VeL=-NihDv5L4iBn_48=i7Lsnrkd+4e13QQsQ@mail.gmail.com>
In-Reply-To: <CAKT=dDmB=TX++VeL=-NihDv5L4iBn_48=i7Lsnrkd+4e13QQsQ@mail.gmail.com>
From:   Yiwei Zhang <zzyiwei@google.com>
Date:   Sun, 23 Feb 2020 22:31:11 -0800
Message-ID: <CAKT=dDnt174adfWzSiNfheA5EVL32AG_2RQa0861V2Mjh-f51w@mail.gmail.com>
Subject: Re: [PATCH v3] gpu/trace: add gpu memory tracepoints
To:     Steven Rostedt <rostedt@goodmis.org>, mingo@redhat.com,
        Greg KH <gregkh@linuxfoundation.org>, elder@kernel.org,
        federico.vaga@cern.ch, tony.luck@intel.com, vilhelm.gray@gmail.com,
        Linus Walleij <linus.walleij@linaro.org>, tglx@linutronix.de,
        yamada.masahiro@socionext.com, paul.walmsley@sifive.com
Cc:     linux-kernel@vger.kernel.org,
        Prahlad Kilambi <prahladk@google.com>,
        Joel Fernandes <joelaf@google.com>,
        android-kernel <android-kernel@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear gpu and tracing owners,

It's been a while and this is just a gentle and friendly re-ping for
review of this small patch.

Many many thanks!
Yiwei
