Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 663B8C3F2D7
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 00:59:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35964214D8
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 00:59:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583369963;
	bh=AdbQ5f/7J8xRD1RJTNFcvHuv+j3LCyuretP+IHCgIuE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=o8g7poSyLXQictrRqGE4Ji+vNu3Y5akEt+NNnNSEkXrG8JfAuT0GnWbmoanU7eqLp
	 uFT7jPaTKVc1FcEzH2fz+uIRvZe63vqGjU2b22bfvNYm+Uslp2Q2+YpKFDrjlzk4xZ
	 fEQ8p3PDz1XcMO+PF7JE0Ac5O0P5nYQaUvdYhXC4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725977AbgCEA7W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 19:59:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:59264 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725308AbgCEA7W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 19:59:22 -0500
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C093120842;
        Thu,  5 Mar 2020 00:59:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583369961;
        bh=AdbQ5f/7J8xRD1RJTNFcvHuv+j3LCyuretP+IHCgIuE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=e3LAq9RuZ3ugCTvwSfKBJ+lklf3PpsADX17OJwBFnnNq7X+zl8cLkTCCs/V7ZYwza
         dSdQOwm7Rojom16NziEbZSHQBAfQvtGsdHrKaGb/vFbq5G2JTaA8LMsfnzgwcogua0
         B+wrW0UC+afDvTWfyLPiyri3/VaXzh6hmFr0V/tk=
Date:   Thu, 5 Mar 2020 09:59:17 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Markus Elfring <Markus.Elfring@web.de>,
        Randy Dunlap <rdunlap@infradead.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-doc@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [v4] Documentation: bootconfig: Update boot configuration
 documentation
Message-Id: <20200305095917.9cd7c2a7f5f6b492601e27bb@kernel.org>
In-Reply-To: <20200304142259.7eaa3633@lwn.net>
References: <158322634266.31847.8245359938993378502.stgit@devnote2>
        <158322635301.31847.15011454479023637649.stgit@devnote2>
        <ad1e9855-4c64-53bd-7da5-f7cdafe78571@infradead.org>
        <20200304203722.8e8699c2a3e0a979aae091b1@kernel.org>
        <3a3a5f1a-3654-d96d-3b4a-dd649a366c65@web.de>
        <531371ef-354a-b0fa-f69f-c8cf9ecc9919@infradead.org>
        <a9f8980e-4325-52c1-d217-d2fca1add37d@web.de>
        <3118d72b-a33c-e6d7-36a1-204d39d2bdbb@infradead.org>
        <a6680eb7-5a1d-ea58-0eec-14f2b5bcd99a@web.de>
        <20200304142259.7eaa3633@lwn.net>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 4 Mar 2020 14:22:59 -0700
Jonathan Corbet <corbet@lwn.net> wrote:

> On Wed, 4 Mar 2020 22:20:07 +0100
> Markus Elfring <Markus.Elfring@web.de> wrote:
> 
> > > I'm hoping to be done with the current changes. :)  
> > 
> > Will a term like “grouping of parent keys” need any additional explanation?
> 
> Honestly, Markus, I think that the patch is good enough for now; time to
> merge it and move on to something else.

Thanks Jon,

I'll send the final version soon.

-- 
Masami Hiramatsu <mhiramat@kernel.org>
