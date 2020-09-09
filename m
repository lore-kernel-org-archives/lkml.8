Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FREEMAIL_REPLYTO_END_DIGIT,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78806C43461
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 04:52:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B13221D43
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 04:52:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="RJjpCFBl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727005AbgIIEwx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 00:52:53 -0400
Received: from mail-40130.protonmail.ch ([185.70.40.130]:38044 "EHLO
        mail-40130.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725767AbgIIEwx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 00:52:53 -0400
Date:   Wed, 09 Sep 2020 04:52:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1599627171;
        bh=tNg5tAtet1Dlg5OTVR2V6g98ZiGX3ACoiac7ICl2DmM=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=RJjpCFBlvf4fdppzE0wIZMdw7YRwkSpBxEBlQNj5ME/vGCIWrGlpYpRnJCiP/PGiU
         +udrl/F8dvHP3cUkPeWpT3Lr8gQI7A5WCK+dQMcFMsd2FEBwthAIi1DBRzxqdvn/6H
         YXrWzzaEZpKZSowKgunyCfo4+AZqRpXOPQWAIpqE=
To:     syzbot <syzbot+b8639c8dcb5ec4483d4f@syzkaller.appspotmail.com>
From:   Harley <hl1998@protonmail.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Reply-To: Harley <hl1998@protonmail.com>
Subject: Re: KASAN: use-after-free Read in delete_partition
Message-ID: <XjoJ_0FjJeoD1mcx0kiX8d7mdvChRUfhcnMXFMbWHmo9OQQiNaaIOn3puoADsae1WvNuBnoLgGrpczV8lDoCW7tqtIjJBqMHECHkDPX5n2w=@protonmail.com>
In-Reply-To: <0000000000009323e705ae870d48@google.com>
References: <0000000000009323e705ae870d48@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I am having difficulty actually reproducing the bug from the supplied C rep=
ro and .config. Perhaps it is some sort of race condition?
