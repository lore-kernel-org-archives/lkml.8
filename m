Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF7C3C3F2D7
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 23:23:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DBA02173E
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 23:23:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726890AbgCBXXt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 18:23:49 -0500
Received: from ms.lwn.net ([45.79.88.28]:59976 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726728AbgCBXXs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 18:23:48 -0500
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 4FEB0823;
        Mon,  2 Mar 2020 23:23:48 +0000 (UTC)
Date:   Mon, 2 Mar 2020 16:23:47 -0700
From:   Jonathan Corbet <corbet@lwn.net>
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH 0/3] Better organize the core-api manual
Message-ID: <20200302162347.65dc3709@lwn.net>
In-Reply-To: <202003021456.F173F9DFC7@keescook>
References: <20200302223957.905473-1-corbet@lwn.net>
        <202003021456.F173F9DFC7@keescook>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2 Mar 2020 14:59:43 -0800
Kees Cook <keescook@chromium.org> wrote:

> Random thought while looking through it: there's
> stuff in the driver-api that seems like maybe it should move into the
> core (e.g. Documentation/driver-api/basics.rst) but I'm not sure what
> the line between "core" and "driver" is. I would think the "driver API"
> docs should be driver-specific, in which case much of basics.rst should
> be moved into "core".

Sigh...driver-api is, of course, an even bigger mess than core-api.  I
mean to delve into it and create some order there as well, when I get a
chance.

The original idea was that driver-api would contain stuff you need to know
if you're writing drivers but can ignore otherwise.  We can always rethink
that, of course.

Thanks,

jon
