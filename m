Return-Path: <SRS0=I467=5O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29400C43331
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Mar 2020 21:54:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2AC320774
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Mar 2020 21:54:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729101AbgC2VyL convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Mar 2020 17:54:11 -0400
Received: from lithops.sigma-star.at ([195.201.40.130]:35326 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729040AbgC2VyL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Mar 2020 17:54:11 -0400
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id A76B160D0874;
        Sun, 29 Mar 2020 23:54:08 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id jNc3WgwF_MAg; Sun, 29 Mar 2020 23:54:07 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 64BC16091853;
        Sun, 29 Mar 2020 23:54:07 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id TqkE4nhMYMmY; Sun, 29 Mar 2020 23:54:07 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id 3533860D0872;
        Sun, 29 Mar 2020 23:54:07 +0200 (CEST)
Date:   Sun, 29 Mar 2020 23:54:07 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     anton ivanov <anton.ivanov@cambridgegreys.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Jeff Dike <jdike@addtoit.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        James McMechan <james_mcmechan@hotmail.com>,
        linux-um <linux-um@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        davidgow <davidgow@google.com>
Message-ID: <606921391.56755.1585518847045.JavaMail.zimbra@nod.at>
In-Reply-To: <7f8b86f1-3759-c9ff-6216-a7104edb8030@cambridgegreys.com>
References: <20200124221401.210449-1-brendanhiggins@google.com> <CAFd5g44eznV-9cPf4JVpsJo93+R8YCqUwBqRf+PbjaRMizy1aQ@mail.gmail.com> <7f8b86f1-3759-c9ff-6216-a7104edb8030@cambridgegreys.com>
Subject: Re: [PATCH v3] uml: make CONFIG_STATIC_LINK actually static
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF68 (Linux)/8.8.12_GA_3809)
Thread-Topic: make CONFIG_STATIC_LINK actually static
Thread-Index: TqGQUOqF7TCvWDerkItHXFGdXoxNQw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- Ursprüngliche Mail -----
> Von: "anton ivanov" <anton.ivanov@cambridgegreys.com>
> An: "Brendan Higgins" <brendanhiggins@google.com>, "Jeff Dike" <jdike@addtoit.com>, "richard" <richard@nod.at>, "Geert
> Uytterhoeven" <geert@linux-m68k.org>, "James McMechan" <james_mcmechan@hotmail.com>
> CC: "linux-um" <linux-um@lists.infradead.org>, "linux-kernel" <linux-kernel@vger.kernel.org>, "davidgow"
> <davidgow@google.com>
> Gesendet: Samstag, 8. Februar 2020 08:56:58
> Betreff: Re: [PATCH v3] uml: make CONFIG_STATIC_LINK actually static

> On 08/02/2020 01:07, Brendan Higgins wrote:
>> On Fri, Jan 24, 2020 at 2:14 PM Brendan Higgins
>> <brendanhiggins@google.com> wrote:
>>>
>>> Currently, CONFIG_STATIC_LINK can be enabled with options which cannot
>>> be statically linked, namely UML_NET_VECTOR, UML_NET_VDE, and
>>> UML_NET_PCAP; this is because glibc tries to load NSS which does not
>>> support being statically linked. So make CONFIG_STATIC_LINK depend on
>>> !UML_NET_VECTOR && !UML_NET_VDE && !UML_NET_PCAP.
>>>
>>> Link:
>>> https://lore.kernel.org/lkml/f658f317-be54-ed75-8296-c373c2dcc697@cambridgegreys.com/#t
>>> Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
>>> ---
>> 
>> Ping.
> 
> ICMP echo reply,
> 
> I thought I acked it :)
> 
> If not - apologies.

Applied, thanks!

Thanks,
//richard
