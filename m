Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52D13C33CAC
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 18:04:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3029721741
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 18:04:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NeWLe5kp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727842AbgBFSER (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 13:04:17 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:28948 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727662AbgBFSEQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 13:04:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581012256;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Y/oUdILRq0LVH4thGA+cmxynW/DGFzJVkoOfhzWfStg=;
        b=NeWLe5kp4M3T6RxlTA/4g/8MD21OIkMlesBRA1ZHRYOFJ5eDcOwmYlip2FlYyJCcmPKTN0
        wrO9akdXHywatlgjCx+OHi9aYB1rzc0kWhGRjf3XFL0Avp91di8gcfTBCGUYXDXpxuSBOs
        Lf6rFLUlJ4tGCJciw+hLJmYND8KIT08=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-272-iZJLLlR7N7SfU8lSIS-k8g-1; Thu, 06 Feb 2020 13:04:11 -0500
X-MC-Unique: iZJLLlR7N7SfU8lSIS-k8g-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AD7021800D42;
        Thu,  6 Feb 2020 18:04:10 +0000 (UTC)
Received: from treble (ovpn-120-83.rdu2.redhat.com [10.10.120.83])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D1F851001B05;
        Thu,  6 Feb 2020 18:04:09 +0000 (UTC)
Date:   Thu, 6 Feb 2020 12:04:07 -0600
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: linux-next: Tree for Feb 6 (objtool warning)
Message-ID: <20200206180407.vr5dyg2h73hmceh3@treble>
References: <20200206150901.6f9f792e@canb.auug.org.au>
 <8a8a76cd-81d6-ffeb-08d8-e8de427caa45@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8a8a76cd-81d6-ffeb-08d8-e8de427caa45@infradead.org>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 06, 2020 at 08:10:20AM -0800, Randy Dunlap wrote:
> On 2/5/20 8:09 PM, Stephen Rothwell wrote:
> > Hi all,
> > 
> > Please do not add any v5.7 material to your linux-next included
> > branches until after v5.6-rc1 has been released.
> > 
> > Changes since 20200205:
> > 
> 
> drivers/pinctrl/pinctrl-ingenic.o: warning: objtool: ingenic_pinconf_set() falls through to next function ingenic_pinconf_group_set()

Thanks Randy.  I'm able to recreate with the config.  Objtool is
confused by the unreachable() statement in ingenic_pinconf_set().

I think a BUG() would be more appropriate anyway.  Will post a proper
patch.

diff --git a/drivers/pinctrl/pinctrl-ingenic.c b/drivers/pinctrl/pinctrl-ingenic.c
index 96f04d121ebd..6b61ac6cd4d2 100644
--- a/drivers/pinctrl/pinctrl-ingenic.c
+++ b/drivers/pinctrl/pinctrl-ingenic.c
@@ -2158,7 +2158,7 @@ static int ingenic_pinconf_set(struct pinctrl_dev *pctldev, unsigned int pin,
 			break;
 
 		default:
-			unreachable();
+			BUG();
 		}
 	}
 

