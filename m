Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89AD9C3F2D1
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 01:51:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 568AC20801
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 01:51:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583459473;
	bh=fBPZTNKVmE1hgU6NPzJDk+RxRcB7GHz4B/xu2UW858E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=ase4jgX4dlLH0kUkr266Jkdddf6BQI8+ZI9aBwj3T4aK/C/C3xNGQxGFXlXyZnFG/
	 LDbe4dBMiw2RgBg+DfeqAWBLYtHOXKsqdfU5KNOSquwaUxw1ecTKk3F+W2KuoGqd3D
	 GgJwstXc5p/RyM1xyVoBM+9IFVbamyMItxraun2Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726766AbgCFBvM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 20:51:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:41144 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726191AbgCFBvM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 20:51:12 -0500
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C94C12073D;
        Fri,  6 Mar 2020 01:51:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583459471;
        bh=fBPZTNKVmE1hgU6NPzJDk+RxRcB7GHz4B/xu2UW858E=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=wk5YwY25z9KMKu8CtJWyejdMTwhoxNIegrIzGZ78qjGOBWDY9XM8xTPFLOTPB3cEP
         dNrBGhnRDpnelVGEECd9kPFTmTWvtKm3nPWRISHJjxLmK4qCJe34xYGTn/v7XbFstf
         WzA0e7I0TNAgZNHt9MobVV8x1gltWUZGXEyRx1ls=
Date:   Fri, 6 Mar 2020 10:51:07 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     linux-doc@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH v5.1] Documentation: bootconfig: Update boot
 configuration documentation
Message-Id: <20200306105107.afba066a97db1eb12f290aff@kernel.org>
In-Reply-To: <f3c51b0a-2a55-6523-96e2-4f9ef0635d9f@web.de>
References: <ef820445-25c5-a312-57d4-25ff3b4d08cf@infradead.org>
        <158341540688.4236.11231142256496896074.stgit@devnote2>
        <f3c51b0a-2a55-6523-96e2-4f9ef0635d9f@web.de>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 5 Mar 2020 15:00:14 +0100
Markus Elfring <Markus.Elfring@web.de> wrote:

> > Changes in v5.1:
> >  - Fix some mistakes (Thanks Randy!)
> 
> Do you need any more reminders for remaining update candidates?

Hmm, no, I don't need it any more at this point. This is good enough.

If you think you have "any more" update candidates, feel free to make
an update "patch" and send to us. That will be the next step.

> …
> > +++ b/Documentation/admin-guide/bootconfig.rst
> …
> > +If you think that kernel/init options become too long to write in boot-loader
> > +configuration file or you want to comment on each option, the boot
> > +configuration may be suitable. …
> 
> Would you like to specify any settings in the boot configuration file
> because the provided storage capacity would be too limited by the kernel command line?

Yes.

Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
