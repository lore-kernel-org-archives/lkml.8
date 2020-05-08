Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9444AC38A2A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 08:25:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 65279208DB
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 08:25:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588926313;
	bh=nXOlXreEj4ITmMhrknV0ABFkeWV53vYLs9Lxe0vrS9c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=yOVh2f43t6EDwNn75EcSh+xgGiA6/LLdlbhF+Q7thgCirAKFtC0+ygvuR56z/Q5Z4
	 NukJq0VZGDo3dqPnY3hEdWw1vWHF2N/Z4xt7aZ05sjcKUmAhVs/8hl0BQqH6lc1FU4
	 97erYbZKVh+1gyugpeOhPJAyM/9T+I7oQh8tb8/g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727084AbgEHIZM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 04:25:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:49242 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726598AbgEHIZM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 04:25:12 -0400
Received: from linux-8ccs.fritz.box (p57A239F2.dip0.t-ipconnect.de [87.162.57.242])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4AAAE208CA;
        Fri,  8 May 2020 08:25:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588926311;
        bh=nXOlXreEj4ITmMhrknV0ABFkeWV53vYLs9Lxe0vrS9c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Fgqadvh0KYrgQ+vVt7gNXOSWy+5bu8SWM9NpQUF3xDcwcDDKiRS6/BXu91SeQwo++
         AhR9oqCCV7WjvhdGVo7TTrdj5sCxdS+sTJWlXkGTYtI1yGWrJswnZ+ioYIZPOX+A9E
         ftmv7/n/dkq5KNcqkCNzg1YJOkatQjPbSjVxxxuU=
Date:   Fri, 8 May 2020 10:25:07 +0200
From:   Jessica Yu <jeyu@kernel.org>
To:     Vincent Whitchurch <vincent.whitchurch@axis.com>
Cc:     linux@armlinux.org.uk, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel@axis.com
Subject: Re: [PATCH 1/2] module: allow arch overrides for .init section names
Message-ID: <20200508082504.GA15302@linux-8ccs.fritz.box>
References: <20200506152533.31286-1-vincent.whitchurch@axis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20200506152533.31286-1-vincent.whitchurch@axis.com>
X-OS:   Linux linux-8ccs 4.12.14-lp150.12.61-default x86_64
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+++ Vincent Whitchurch [06/05/20 17:25 +0200]:
>ARM stores unwind information for .init.text in sections named
>.ARM.extab.init.text and .ARM.exidx.init.text.  Since those aren't
>currently recognized as init sections, they're allocated along with the
>core section, and relocation fails if the core and the init section are
>allocated from different regions and can't reach other.
>
>  final section addresses:
>        ...
>        0x7f800000 .init.text
>        ..
>        0xcbb54078 .ARM.exidx.init.text
>        ..
>
> section 16 reloc 0 sym '': relocation 42 out of range (0xcbb54078 ->
> 0x7f800000)
>
>Allow architectures to override the section name so that ARM can fix
>this.
>
>Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
>---
> include/linux/moduleloader.h | 2 ++
> kernel/module.c              | 9 +++++++--
> 2 files changed, 9 insertions(+), 2 deletions(-)
>
>diff --git a/include/linux/moduleloader.h b/include/linux/moduleloader.h
>index ca92aea8a6bd..07d079085f11 100644
>--- a/include/linux/moduleloader.h
>+++ b/include/linux/moduleloader.h
>@@ -29,6 +29,8 @@ void *module_alloc(unsigned long size);
> /* Free memory returned from module_alloc. */
> void module_memfree(void *module_region);
>
>+bool module_init_section(const char *name);
>+

Hi, I just have two small nits. Could you please add a comment on top of
module_init_section to document it? (similar to module_exit_section())

> /* Determines if the section name is an exit section (that is only used during
>  * module unloading)
>  */
>diff --git a/kernel/module.c b/kernel/module.c
>index 33569a01d6e1..a5f2b4e1ef53 100644
>--- a/kernel/module.c
>+++ b/kernel/module.c
>@@ -2370,6 +2370,11 @@ static long get_offset(struct module *mod, unsigned int *size,
> 	return ret;
> }
>
>+bool __weak module_init_section(const char *name)
>+{
>+	return strstarts(name, ".init");
>+}
>+

Could you move this next to module_exit_section()? Just trying to keep
similar functions together. Otherwise, the patch looks fine to me.

Thanks!

Jessica

