Return-Path: <SRS0=fqu/=3Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 120B4C35247
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 00:41:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D24A2214AF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 00:41:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sIL7asl4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727762AbgBEAlt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Feb 2020 19:41:49 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:38966 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727494AbgBEAls (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 19:41:48 -0500
Received: by mail-oi1-f196.google.com with SMTP id z2so230259oih.6;
        Tue, 04 Feb 2020 16:41:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UkH7zbzWwgt3KeJcgew3A/K0SL1CvpLePI0yYn94J6g=;
        b=sIL7asl4JV/aeujSnhoo9ko0NGsytCLBeMGQC4SFikAsR7B9aYASMBtsfgRQtgkTYB
         Dmb9M0NbIknBAq2f5BMjSpM+QKoGmFOgYKPdo782y9x4bNB7TwNoK3Qi1kjs3Uv3JhF4
         IdO0eB1tJExfhQEQYI7XniFbVjYgShEOOcQwaC9cvrY24h0rEaK6d/WrzFOJaZjnxtSY
         Iiu+E7tRunShDCMBv/u16FMi+FfctlpuzNVkQ/xVzajow7S1zBuSZhpmPxJCDp3OCVAV
         2ReyaJ/fG6Wqk85wZc+LAWYcsF25fAsGo9GUC2dkcK/ZFJT42wE2X8JSg6McUANkUk5z
         qEjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UkH7zbzWwgt3KeJcgew3A/K0SL1CvpLePI0yYn94J6g=;
        b=tbhQvB+NN7uCAY8cOk3lWcsLDAYabnSYFjF4WZczLa+A4BcqW56qBSPWEjzeelJYJw
         TYyDLk3rBxs5GxE5XhdoBgvnixKR0zwGHmE4g8JUB2YjmA37wngRKZZyZPo2gDiwnE6c
         P+Wr2tRnE/+fbey6Fd5hqRxEJCGCsgmZBfXlcB1WrnjKIw+M9hyPjL+zRouWZy8vPUYl
         ZdFd7CCG7hNBIg/1HLkj2HzJmF4CEzTRjMhlpAGG8ttk4CHWN3pRiDfbl0QxR3O7jAE4
         6z+il6dLPpzCIEG+ms4s+EM0stQDFG1qlyDF4s/GTEdX+HiiYWrEzt9AmZuR6CCBG7R5
         iDRQ==
X-Gm-Message-State: APjAAAVwWq9WKj//XcyUFz2jAT00oiEsxpyDpsTWCmTsqX2NJ/9vLtV7
        RHuAC5EZYmD5siONT0KgzMO0NMLaPtETtwti5XNCBJj6
X-Google-Smtp-Source: APXvYqyFz525nHfcKUq3P7rIhqzT5qT6SVTceYfQt/OupvQZEYPyeRik9oA34bQZylq02f9SCd/6JHgrvmvA788P+eM=
X-Received: by 2002:aca:fc0c:: with SMTP id a12mr1153544oii.118.1580863307735;
 Tue, 04 Feb 2020 16:41:47 -0800 (PST)
MIME-Version: 1.0
References: <0000000000009a59d2059dc3c8e9@google.com> <a1673e4f-6382-d7df-6942-6e4ffd2b81ce@gmail.com>
 <20200204.222245.1920371518669295397.davem@davemloft.net> <CAM_iQpVE=B+LDpG=DpiHh_ydUxxhTj_ge-20zgdB4J1OqAfCtQ@mail.gmail.com>
 <787030ee-ff3e-8eae-3526-24aa8251bcc6@gmail.com>
In-Reply-To: <787030ee-ff3e-8eae-3526-24aa8251bcc6@gmail.com>
From:   Cong Wang <xiyou.wangcong@gmail.com>
Date:   Tue, 4 Feb 2020 16:41:36 -0800
Message-ID: <CAM_iQpWzhdfgHqLQPYwN8dyd37+SMXihM+bf1Cbw3iTV8VE8dw@mail.gmail.com>
Subject: Re: memory leak in tcindex_set_parms
To:     Eric Dumazet <eric.dumazet@gmail.com>
Cc:     David Miller <davem@davemloft.net>,
        syzbot+f0bbb2287b8993d4fa74@syzkaller.appspotmail.com,
        Jamal Hadi Salim <jhs@mojatatu.com>,
        Jiri Pirko <jiri@resnulli.us>,
        Jakub Kicinski <kuba@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Kernel Network Developers <netdev@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 4, 2020 at 3:40 PM Eric Dumazet <eric.dumazet@gmail.com> wrote:
>
> The only thing the repro fires for me on latest net tree is an UBSAN warning about a silly ->shift

Yeah, I thought HEAD commit 322bf2d3 already contains my fix,
I was wrong.


>
> I have not tried it on the old kernel.
>
> [  170.331009] UBSAN: Undefined behaviour in net/sched/cls_tcindex.c:239:29
> [  170.337729] shift exponent 19375 is too large for 32-bit type 'int'

Please send your patch formally, it looks reasonable to me.

Thanks.
