Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 139ECC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 13:52:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E9B7920835
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 13:52:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727053AbgFKNwM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 09:52:12 -0400
Received: from ms.lwn.net ([45.79.88.28]:38582 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726109AbgFKNwL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 09:52:11 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 7819C6D6;
        Thu, 11 Jun 2020 13:52:10 +0000 (UTC)
Date:   Thu, 11 Jun 2020 07:52:09 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     "Alexander A. Klimov" <grandmaster@al2klimov.de>
Cc:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Federico Vaga <federico.vaga@vaga.pv.it>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        David Sterba <dsterba@suse.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Theodore Ts'o <tytso@mit.edu>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Pankaj Bharadiya <pankaj.laxminarayan.bharadiya@intel.com>,
        Jacob Huisman <jacobhuisman@kernelthusiast.com>,
        Jonathan =?UTF-8?B?TmV1c2Now6RmZXI=?= <j.neuschaefer@gmx.net>,
        Rob Herring <robh@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] Replace HTTP links with HTTPS ones:
 Documentation/translations/it_IT
Message-ID: <20200611075209.1ec03712@lwn.net>
In-Reply-To: <3a6354fd-90ec-914f-b5df-0c4c219bd26e@al2klimov.de>
References: <20200609201241.81518-1-grandmaster@al2klimov.de>
        <4235548.LvFx2qVVIh@harkonnen>
        <cd260d03-27a4-7794-f58f-21e8e0be9755@al2klimov.de>
        <202006102009.CB14D7F@keescook>
        <8ee16c38-e28b-b4e6-ed30-55a59e216b49@al2klimov.de>
        <CANiq72n50OVRtFAQkAmqjaj=dJTP9VqYYHN7++8O_t4cbfaJgw@mail.gmail.com>
        <3a6354fd-90ec-914f-b5df-0c4c219bd26e@al2klimov.de>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 Jun 2020 13:02:08 +0200
"Alexander A. Klimov" <grandmaster@al2klimov.de> wrote:

> Who if not Linus shall review one huge patch spreading across lots of 
> subsystems?

In practice almost nobody, which is why I've said several times that you
shouldn't do that.  There is no flag-day situation forcing this work to be
done in a single big patch.

jon
