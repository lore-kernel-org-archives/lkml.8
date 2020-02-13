Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CC6CC352A3
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 21:44:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53CE8206B6
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 21:44:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="PIw7E5FK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728433AbgBMVop (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 16:44:45 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:38735 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728168AbgBMVoo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 16:44:44 -0500
Received: by mail-ed1-f67.google.com with SMTP id p23so8680780edr.5
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2020 13:44:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=d6iMkJnmuaDOT/nQ8QyRCzJW1DxHpPU5cNxqRI+5goo=;
        b=PIw7E5FK5uMGQSQO8wbpPUp6f5T9D17OUGexKYbXdtUQttg7lkFcb7ZrY7zxqkJuF7
         IUDTTxfFWuajXiDFDWQXvBELPs2+KOoqds7y/MldWSq0di1ROQs14wpIC16aAbnzux9Y
         qTBvzLrg6gTeYg5Wb+/fgQXuupbE2u9OV73zEr2tujxtHYiZ2igPBO+L0RiCnuBbY33H
         JTGxZFfAlWsYu5+0uaqBK6gTlPgjcJoCWGD1613byRZSuN+WJYaIWoSr865H09zNQXZ4
         iJ2yQcaJmzck0TPBQtlzrJJ61lJ/sdUV7Mkch0Em0zgoL4IjpU8MKonw+E3A6AI+Grt1
         Ly8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=d6iMkJnmuaDOT/nQ8QyRCzJW1DxHpPU5cNxqRI+5goo=;
        b=ncpSIit2583gO2tzX33JvMpia3tJj6pZJivyolrzvbvWg0no+cbLmLgf3AJ67+NhJm
         28dNQG7gbmTYhJ8u3CCCyxUO6Y3RX1NHIL8ukX9Mnv5xT5LECG3JWHRX7G2dCGJn354m
         wYeXOnGbTBFtnYrroL2SOUKX1cZ6z9oZTq4C+uvlF/bI1K0UeUcAj8Bdazaw8aRhCE8n
         uKJjBzl3PVyyn0Vcs2f/T69zCaK28lv5FGIdT2UuL+RWckuoaFD/0emZUY/1Uq/htZ0K
         EblV9Z1SjX2535wguiJw1vtLa5PeIwwRHJSABlHzU6XiZIJBMh3L5qewnJjI3ElNhuml
         QNrQ==
X-Gm-Message-State: APjAAAWAn4J08KMd+G0fE7s9kpUOWpDxzyi3AXkKH3k2r0s/a/QDSlVU
        mwePt1PsqPkf/20OqsEKGou3ZFOSMwQ8yGWdBqSM
X-Google-Smtp-Source: APXvYqzivqkXBB8NR1AVMPaykKlw/9vR8JhyBC59wFMjKjm5evBAVa6TlImCpH9hT3l8uI72hnHie5UbgBWCB+RdQRU=
X-Received: by 2002:aa7:db55:: with SMTP id n21mr16664962edt.31.1581630280853;
 Thu, 13 Feb 2020 13:44:40 -0800 (PST)
MIME-Version: 1.0
References: <cover.1577736799.git.rgb@redhat.com> <20200204231454.oxa7pyvuxbj466fj@madcap2.tricolour.ca>
 <CAHC9VhQquokw+7UOU=G0SsD35UdgmfysVKCGCE87JVaoTkbisg@mail.gmail.com>
 <3142237.YMNxv0uec1@x2> <CAHC9VhTiCHQbp2SwK0Xb1QgpUZxOQ26JKKPsVGT0ZvMqx28oPQ@mail.gmail.com>
In-Reply-To: <CAHC9VhTiCHQbp2SwK0Xb1QgpUZxOQ26JKKPsVGT0ZvMqx28oPQ@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 13 Feb 2020 16:44:29 -0500
Message-ID: <CAHC9VhS09b_fM19tn7pHZzxfyxcHnK+PJx80Z9Z1hn8-==4oLA@mail.gmail.com>
Subject: Re: [PATCH ghak90 V8 07/16] audit: add contid support for signalling
 the audit daemon
To:     Steve Grubb <sgrubb@redhat.com>
Cc:     linux-audit@redhat.com, Richard Guy Briggs <rgb@redhat.com>,
        nhorman@tuxdriver.com, linux-api@vger.kernel.org,
        containers@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>, dhowells@redhat.com,
        netfilter-devel@vger.kernel.org, ebiederm@xmission.com,
        simo@redhat.com, netdev@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Eric Paris <eparis@parisplace.org>,
        mpatel@redhat.com, Serge Hallyn <serge@hallyn.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a bit of a thread-hijack, and for that I apologize, but
another thought crossed my mind while thinking about this issue
further ... Once we support multiple auditd instances, including the
necessary record routing and duplication/multiple-sends (the host
always sees *everything*), we will likely need to find a way to "trim"
the audit container ID (ACID) lists we send in the records.  The
auditd instance running on the host/initns will always see everything,
so it will want the full container ACID list; however an auditd
instance running inside a container really should only see the ACIDs
of any child containers.

For example, imagine a system where the host has containers 1 and 2,
each running an auditd instance.  Inside container 1 there are
containers A and B.  Inside container 2 there are containers Y and Z.
If an audit event is generated in container Z, I would expect the
host's auditd to see a ACID list of "1,Z" but container 1's auditd
should only see an ACID list of "Z".  The auditd running in container
2 should not see the record at all (that will be relatively
straightforward).  Does that make sense?  Do we have the record
formats properly designed to handle this without too much problem (I'm
not entirely sure we do)?

-- 
paul moore
www.paul-moore.com
