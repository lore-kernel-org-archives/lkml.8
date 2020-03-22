Return-Path: <SRS0=o5Nk=5H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 205C9C43332
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Mar 2020 06:41:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D521920753
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Mar 2020 06:41:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ncUZJloh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726583AbgCVGlR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Mar 2020 02:41:17 -0400
Received: from mail-vs1-f51.google.com ([209.85.217.51]:46001 "EHLO
        mail-vs1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725881AbgCVGlR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Mar 2020 02:41:17 -0400
Received: by mail-vs1-f51.google.com with SMTP id x82so6635702vsc.12;
        Sat, 21 Mar 2020 23:41:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0FVH9lZ/HXMu1482Vsk3kACq86y1ubOdqxK/BhWz3os=;
        b=ncUZJlohxmtm6zQakobDf7amad4ORwcCRzNTPaYRhQ6WjCgtnq1PtvAWtjiCtm2wXt
         KN/Kca1xWWeNth9eUiBKLi9OmmVRxJE0tYzno0ghDM1C7cUOrutNkWWuvD6GEd7meg9C
         tVFtGnOCOLH6WTSvIWRqo/I7kvp5TrcyspRhB3ni3JVO3fDdYHkfjkQU48VezZgsEDmQ
         6ksH6yqw2IDFGgVl0c4duEsWxKW2NLZHGqvrzek3S1fWpQ6orrAQER5kqIjClcWeRWap
         EOHo+MWvp+BoRnBbImwYqfe+r+RoBWc0asb0pwhMVWCEZjfqMHt4UsAWqKe915CStmq5
         tAUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0FVH9lZ/HXMu1482Vsk3kACq86y1ubOdqxK/BhWz3os=;
        b=b/y1ALyVX1pLuVl7D/fTqDY3CTb6xDCvWX7kUyp+K2qY5XpSqoR7xcQ0no70IQwUEA
         E2jnfHUclCMRzFH/LPbG3RbGEPPiLzOojqqD89pRdX5nBemQz4intPv0xdKfUB6ecjiK
         U1bZrQjObIbAQYav5kvv9oT6mzb5FNQ71nXajxg99NAE/v6yA4YAoa6ibJ19kIMhwyBS
         Pl8YKbxSN80VxW0LjkDI2ccSIFWPFm684/qymUfY94NkfVOWCWV+vt6KWo3QzBNRAJ6k
         GFRKJQ495sy+DHE3DuNvVPL62+Ir6y4RJI7HSQR3ojx7u3Ez8O1GVM3qUm/acTdOvl1j
         vo8w==
X-Gm-Message-State: ANhLgQ10mOp5rq6zfnE8luKGEhfYT5PclRT6KvMpeIr6b9DJe2HdvpqI
        zDtxHdD1Ta5Kc00vd5nqmCKjgGPFfiDD1fhcCaQ=
X-Google-Smtp-Source: ADFU+vub3xhS7J7IYzeJuE5ApI2j8bGNmi5QG2kYvTUeHq+fkXkK2y6oZK64R3kO31TZ3alMVbiVLd4p76MpZya7R9E=
X-Received: by 2002:a67:c189:: with SMTP id h9mr1142966vsj.91.1584859276174;
 Sat, 21 Mar 2020 23:41:16 -0700 (PDT)
MIME-Version: 1.0
References: <CADG63jB59ZXWSUFKieXKGGEbPT9=z5OPARBjGqMgfh+K-k4-yQ@mail.gmail.com>
 <0000000000000f2eea05a16a1979@google.com>
In-Reply-To: <0000000000000f2eea05a16a1979@google.com>
From:   Qiujun Huang <anenbupt@gmail.com>
Date:   Sun, 22 Mar 2020 14:41:02 +0800
Message-ID: <CADG63jCpZWBjtJH_rjzBjTyTfYV0z9SHf1CzT9ic0-VY5C4AiQ@mail.gmail.com>
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

#syz test: https://github.com/hqj/hqjagain_test.git datamsg_list
