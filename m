Return-Path: <SRS0=VV4q=52=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75AFBC2BB1D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 02:28:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5412720B1F
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 02:28:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726726AbgDJC2q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 22:28:46 -0400
Received: from smtprelay0082.hostedemail.com ([216.40.44.82]:47184 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725987AbgDJC2q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 22:28:46 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id CA3A9182CCCD0;
        Fri, 10 Apr 2020 02:28:45 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: cart95_697e48a2c6740
X-Filterd-Recvd-Size: 1458
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf05.hostedemail.com (Postfix) with ESMTPA;
        Fri, 10 Apr 2020 02:28:44 +0000 (UTC)
Message-ID: <135aaf66d6e9bf38e1d64edbdca9929743c33e4b.camel@perches.com>
Subject: Re: [PATCH v2] staging: rtl8192u: Corrects 'Avoid CamelCase' for
 variables
From:   Joe Perches <joe@perches.com>
To:     Camylla Cantanheide <c.cantanheide@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        lkcamp@lists.libreplanetbr.org
Date:   Thu, 09 Apr 2020 19:26:43 -0700
In-Reply-To: <CAG3pErLnRA-02XfG1pbvv7F=gU06=yTMByuvpX0QjiZvDVqFxw@mail.gmail.com>
References: <20200318211205.188-1-c.cantanheide@gmail.com>
         <bb163d6b706a7b07e8b2e1c51b0da72a5923af97.camel@perches.com>
         <CAG3pErLnRA-02XfG1pbvv7F=gU06=yTMByuvpX0QjiZvDVqFxw@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2020-04-09 at 23:09 -0300, Camylla Cantanheide wrote:
> Hi Joe,
> 
> Thanks for your review, I'm new to this and I would like to learn.
> 
> I didn't undertand your coment, I was hoping if you could help me clarify a
> bit.

I sent you a suggested patch clarifying the code
rather than clarifying the naming just before this.

https://lore.kernel.org/lkml/a421ed974d7c675a7d41405d483c7645004d4125.camel@perches.com/



