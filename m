Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56A43C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 10:02:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 36367206F7
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 10:02:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728060AbgFJKCL convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 06:02:11 -0400
Received: from smtp.asem.it ([151.1.184.197]:62608 "EHLO smtp.asem.it"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726134AbgFJKCK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 06:02:10 -0400
Received: from webmail.asem.it
        by asem.it (smtp.asem.it)
        (SecurityGateway 6.5.2)
        with ESMTP id SG000308629.MSG 
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 12:02:07 +0200S
Received: from ASAS044.asem.intra (172.16.16.44) by ASAS044.asem.intra
 (172.16.16.44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 10
 Jun 2020 12:02:06 +0200
Received: from ASAS044.asem.intra ([::1]) by ASAS044.asem.intra ([::1]) with
 mapi id 15.01.1979.003; Wed, 10 Jun 2020 12:02:06 +0200
From:   Flavio Suligoi <f.suligoi@asem.it>
To:     Jiri Slaby <jslaby@suse.cz>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Joe Perches <joe@perches.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: RE: [PATCH 1/1] tty: fix spelling mistake
Thread-Topic: [PATCH 1/1] tty: fix spelling mistake
Thread-Index: AQHWPndvNiJPjgjccE67O52pCshwZajQarSAgAAg/ICAARNuYA==
Date:   Wed, 10 Jun 2020 10:02:06 +0000
Message-ID: <28f2520a39e0427bb48301cd34dd48ac@asem.it>
References: <20200609160249.31329-1-f.suligoi@asem.it>
 <64758b6f2142a1b2a170de38b80f2dbe6c70ceb2.camel@perches.com>
 <54556b78-d58f-089c-ecd9-ee643e1f1451@suse.cz>
In-Reply-To: <54556b78-d58f-089c-ecd9-ee643e1f1451@suse.cz>
Accept-Language: it-IT, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.16.17.208]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-SGHeloLookup-Result: pass smtp.helo=webmail.asem.it (ip=172.16.16.44)
X-SGSPF-Result: none (smtp.asem.it)
X-SGOP-RefID: str=0001.0A782F17.5EE0AF25.008D,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0 (_st=1 _vt=0 _iwf=0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jiri,

> Subject: Re: [PATCH 1/1] tty: fix spelling mistake
> 
> On 09. 06. 20, 19:37, Joe Perches wrote:
> > On Tue, 2020-06-09 at 18:02 +0200, Flavio Suligoi wrote:
> >> Fix typo: "tigger" --> "trigger"
> >
> > Thanks.
> >
> > fyi:
> >
> > $ git grep -w -i tigger
> 
> FYI:
> git grep -wi triger
> ...
> worth fixing too :).

ok

> 
> --
> js
> suse labs

Regards,

Flavio
