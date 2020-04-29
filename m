Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FF95C83000
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 15:03:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2628F21973
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 15:03:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726883AbgD2PDb convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 11:03:31 -0400
Received: from lithops.sigma-star.at ([195.201.40.130]:45604 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726423AbgD2PDb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 11:03:31 -0400
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id F3AD2609D2FA;
        Wed, 29 Apr 2020 17:03:28 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id lX7sjEyPFomq; Wed, 29 Apr 2020 17:03:28 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 740FF6075EB6;
        Wed, 29 Apr 2020 17:03:28 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 8Uf7_MeP4EgF; Wed, 29 Apr 2020 17:03:28 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id 5288660632C0;
        Wed, 29 Apr 2020 17:03:28 +0200 (CEST)
Date:   Wed, 29 Apr 2020 17:03:28 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     linux-mtd <linux-mtd@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <191182038.171422.1588172608162.JavaMail.zimbra@nod.at>
In-Reply-To: <875zdibasg.fsf@vostro.fn.ogness.net>
References: <20200119215233.7292-1-richard@nod.at> <875zdibasg.fsf@vostro.fn.ogness.net>
Subject: Re: [PATCH] ubifs: Fix ubifs_tnc_lookup() usage in
 do_kill_orphans()
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF68 (Linux)/8.8.12_GA_3809)
Thread-Topic: ubifs: Fix ubifs_tnc_lookup() usage in do_kill_orphans()
Thread-Index: VZvOuEmGG52wsyHCwYg4ePnx4nCziw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello John,

----- Ursprüngliche Mail -----
> Von: "John Ogness" <john.ogness@linutronix.de>
> An: "richard" <richard@nod.at>
> CC: "linux-mtd" <linux-mtd@lists.infradead.org>, "linux-kernel" <linux-kernel@vger.kernel.org>
> Gesendet: Mittwoch, 29. April 2020 16:56:31
> Betreff: Re: [PATCH] ubifs: Fix ubifs_tnc_lookup() usage in do_kill_orphans()

> Hi Richard,
> 
> Could you CC this patch to stable? It fixes a serious problem that I am
> seeing on real devices (i.e. Linux not being able to mount its root
> filesystem after a power cut). Thanks.

It has a Fixes-Tag, so it should make it into stable.

Thanks,
//richard
