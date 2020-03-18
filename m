Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2C2EC10DCE
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 11:17:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B44362076C
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 11:17:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727758AbgCRLRn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 07:17:43 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:34619 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726550AbgCRLRn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 07:17:43 -0400
Received: from ip5f5bf7ec.dynamic.kabel-deutschland.de ([95.91.247.236] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1jEWhU-0004kJ-7S; Wed, 18 Mar 2020 11:17:28 +0000
Date:   Wed, 18 Mar 2020 12:17:26 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Cyrill Gorcunov <gorcunov@gmail.com>
Cc:     Adrian Reber <areber@redhat.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Pavel Emelyanov <ovzxemul@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Andrei Vagin <avagin@gmail.com>, linux-kernel@vger.kernel.org,
        Mike Rapoport <rppt@linux.ibm.com>,
        Radostin Stoyanov <rstoyanov1@gmail.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 1/4] ns: prepare time namespace for clone3()
Message-ID: <20200318111726.u2r3ghymexyng5nn@wittgenstein>
References: <20200317083043.226593-1-areber@redhat.com>
 <20200317083043.226593-2-areber@redhat.com>
 <20200318105747.GP27301@uranus>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200318105747.GP27301@uranus>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 18, 2020 at 01:57:47PM +0300, Cyrill Gorcunov wrote:
> On Tue, Mar 17, 2020 at 09:30:41AM +0100, Adrian Reber wrote:
> ...
> > +/*
> > + * This structure is used to set the time namespace offset
> > + * via /proc as well as via clone3().
> > + */
> > +struct set_timens_offset {
> > +	int			clockid;
> > +	struct timespec64	val;
> > +};
> > +
> 
> I'm sorry, I didn't follow this series much so can't comment right now.
> Still this structure made me a bit wonder -- the @val seems to be 8 byte
> aligned and I guess we have a useless pad between these members. If so
> can we swap them? Or it is already part of api?

It's not part of the api yet. We're still arguing about how and what we
want to pass down.
