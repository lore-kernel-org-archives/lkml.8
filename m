Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2F8CC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 04:40:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B83CA207F9
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 04:40:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590036009;
	bh=2w9DxCHe0scNGtAZ7nw2RWCMBOMr7GLohZ7W2FFj9Gk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=Afakmm4khzMfBkaQ50XOh0GZnkiJYF5Rv7Os1PD5Xd55rOqeOdYcVyozhVEoaE69I
	 D5HI6rcSLTltJ+yyc0twX8NwvBL0vDC1G0U/Q+NK3LzkIOsBpw6L5hLZU39k+urEgE
	 pjgrIDxvdMVlKsA439k1vqfvVmzgBYBK1c4FbRkU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728115AbgEUEkI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 00:40:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:47240 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726887AbgEUEkI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 00:40:08 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 085EB20738;
        Thu, 21 May 2020 04:40:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590036008;
        bh=2w9DxCHe0scNGtAZ7nw2RWCMBOMr7GLohZ7W2FFj9Gk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ptCl1re6iGPmvbMoa+Kxvl3v2vb6IA2r1DBlonJlocQDk4spMLVOJLVDdsdYVZhmY
         POucurkfgP9X/qiQ+Vgv66cmmG7AmJgVoYXR1jW4GbvEeZOCrnXG88c3KOOZxJs+pK
         Do3SM2jUr/HJsokTJPMTG/91o3Zxobpe5tnjIZI4=
Date:   Wed, 20 May 2020 21:40:07 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc:     Joe Perches <joe@perches.com>,
        Chenggang Wang <wangchenggang@vivo.com>,
        linux-kernel@vger.kernel.org, Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [RFC PATCH 2/2] init: Allow multi-line output of kernel command
 line
Message-Id: <20200520214007.86f36f61e1fc0329b66758ed@linux-foundation.org>
In-Reply-To: <20200521043628.GB755@jagdpanzerIV.localdomain>
References: <cover.1589916689.git.joe@perches.com>
        <2b3832fed9370f0f8dfd1ea33dddb1d05a36e265.1589916689.git.joe@perches.com>
        <20200520044127.GB938@jagdpanzerIV.localdomain>
        <ae3aff79301c130aa15b3fe0ff801804bb019384.camel@perches.com>
        <20200520121000.GF520@jagdpanzerIV.localdomain>
        <19a8c717f8d9dc76f2b09e6dd19f3fbb71bf29c5.camel@perches.com>
        <20200520180028.8fc1b7890774c6f92a6c2623@linux-foundation.org>
        <20200521043628.GB755@jagdpanzerIV.localdomain>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 May 2020 13:36:28 +0900 Sergey Senozhatsky <sergey.senozhatsky@gmail.com> wrote:

> On (20/05/20 18:00), Andrew Morton wrote:
> [..]
> > I'm wondering if we shold add a kernel puts() (putsk()?  yuk) which can
> > puts() a string of any length.
> > 
> > I'm counting around 150 instances of printk("%s", ...) and pr_foo("%s",
> > ...) which could perhaps be converted, thus saving an argument.
> 
> Can you point me at some examples?
> 

./arch/powerpc/kernel/udbg.c:           printk("%s", s);
./arch/powerpc/xmon/nonstdio.c:         printk("%s", xmon_outbuf);
./arch/um/os-Linux/drivers/ethertap_user.c:             printk("%s", output);
./arch/um/os-Linux/drivers/ethertap_user.c:             printk("%s", output);
./arch/um/os-Linux/drivers/tuntap_user.c:                       printk("%s", out

etc.

My point is, if we created a length-unlimited puts() function for printing the
kernel command line, it could be reused in such places, resulting in a
smaller kernel.


