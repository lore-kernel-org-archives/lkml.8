Return-Path: <SRS0=7RkH=3E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42FB0C32771
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 22:20:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EDB72465A
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 22:20:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579126840;
	bh=MecWhcCJAGPUJ4OXDGGrCD3wo4H4PxqxgKhgor6BbSI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=teHv7ER4kxOjSxC5z8GbNMTo0NIB2S/kmpOUf1fBFjQxesA6OieQjVOBSYPYSE1uh
	 LspRCMSV3YJ/faW7Ef/YDM/VTuPcRCnOc3jWX+mvR0CWtcVKikgUMJtPFV/35PNhLO
	 aTOVXxw5Yop4C3xr+jgCN5O69zEFMCw1WLLsiAcE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730645AbgAOWUj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jan 2020 17:20:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:38576 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728899AbgAOWUi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 17:20:38 -0500
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 417742187F;
        Wed, 15 Jan 2020 22:20:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579126838;
        bh=MecWhcCJAGPUJ4OXDGGrCD3wo4H4PxqxgKhgor6BbSI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Kbk0a/GXE86lIbzo/QxgQJJd57fWJrBt8kybb3SilQpU2LHP7WMunGcQDYj0Td7zV
         GIemnGEZzeSV0KuLG5Y8yStj56NJNmZknHopWreVDnI/pPRCsux8OM0z/7ijL7eJUg
         dn2zDdklBL/lf6lJNDjSf3x9jE319JVeRmYfxHb4=
Date:   Thu, 16 Jan 2020 07:20:34 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Mike Rapoport <rppt@linux.ibm.com>
Cc:     Chen Zhou <chenzhou10@huawei.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        akpm@linux-foundation.org, sfr@canb.auug.org.au,
        keescook@chromium.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH next] init/main.c: make some symbols static
Message-Id: <20200116072034.93933a2acc82627b86e091bf@kernel.org>
In-Reply-To: <20200115142057.GE19826@linux.ibm.com>
References: <20200115135458.71460-1-chenzhou10@huawei.com>
        <20200115142057.GE19826@linux.ibm.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chen Hulk and Mike,

Thanks for reporting.

This looks good to me.

Acked-by: Masami Hiramatsu <mhiramat@kernel.org>

Thank you!


On Wed, 15 Jan 2020 16:20:58 +0200
Mike Rapoport <rppt@linux.ibm.com> wrote:

> (added Steven and Masami)
> 
> On Wed, Jan 15, 2020 at 09:54:58PM +0800, Chen Zhou wrote:
> > Make variable xbc_namebuf and function boot_config_checksum static to
> > fix build warnings, warnings are as follows:
> > 
> > init/main.c:254:6:
> > 	warning: symbol 'xbc_namebuf' was not declared. Should it be static?
> > init/main.c:330:5:
> > 	warning: symbol 'boot_config_checksum' was not declared. Should it be static?
> > 
> > Reported-by: Hulk Robot <hulkci@huawei.com>
> > Signed-off-by: Chen Zhou <chenzhou10@huawei.com>
> > ---
> >  init/main.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/init/main.c b/init/main.c
> > index a77114f..3a95591 100644
> > --- a/init/main.c
> > +++ b/init/main.c
> > @@ -251,7 +251,7 @@ early_param("loglevel", loglevel);
> >  
> >  #ifdef CONFIG_BOOT_CONFIG
> >  
> > -char xbc_namebuf[XBC_KEYLEN_MAX] __initdata;
> > +static char xbc_namebuf[XBC_KEYLEN_MAX] __initdata;
> >  
> >  #define rest(dst, end) ((end) > (dst) ? (end) - (dst) : 0)
> >  
> > @@ -327,7 +327,7 @@ static char * __init xbc_make_cmdline(const char *key)
> >  	return new_cmdline;
> >  }
> >  
> > -u32 boot_config_checksum(unsigned char *p, u32 size)
> > +static u32 boot_config_checksum(unsigned char *p, u32 size)
> >  {
> >  	u32 ret = 0;
> >  
> > -- 
> > 2.7.4
> > 
> 
> -- 
> Sincerely yours,
> Mike.
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
