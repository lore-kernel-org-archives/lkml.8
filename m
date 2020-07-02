Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C57AC433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 12:36:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 009EA20885
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 12:36:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="itMn6AcG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729026AbgGBMgM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 08:36:12 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:59181 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729013AbgGBMgJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 08:36:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593693368;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zoS32aEetNA7WukhLGFWUUUslXaekp29CK8PuqfIdFc=;
        b=itMn6AcGNEDJXvtRpDlvqJqE4Y6P1FmKfV8NsVi8D+Xw0BW22VXH8QYOlOhT00UCf+pHif
        cP4q2qmTTjCn5MgBK9GAjnTQAZUxQox3cbc0J6gGO2xfznqHEC5apqC2Ti0MK2UIUcrMDX
        bH+MI+kzLWVhbz8PZe3EH8dlaNoHMvk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-257-LX71wF1AMamum0V7EvPErQ-1; Thu, 02 Jul 2020 08:36:04 -0400
X-MC-Unique: LX71wF1AMamum0V7EvPErQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E6A47106B243;
        Thu,  2 Jul 2020 12:35:57 +0000 (UTC)
Received: from treble (ovpn-117-134.rdu2.redhat.com [10.10.117.134])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 44A4378800;
        Thu,  2 Jul 2020 12:35:57 +0000 (UTC)
Date:   Thu, 2 Jul 2020 07:35:55 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Miroslav Benes <mbenes@suse.cz>
Subject: Re: linux-next: Tree for Jun 23 (objtool (2))
Message-ID: <20200702123555.bjioosahrs5vjovu@treble>
References: <20200623162820.3f45feae@canb.auug.org.au>
 <61df2e8f-75e8-d233-9c3c-5b4fa2b7fbdc@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <61df2e8f-75e8-d233-9c3c-5b4fa2b7fbdc@infradead.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 23, 2020 at 08:06:07AM -0700, Randy Dunlap wrote:
> On 6/22/20 11:28 PM, Stephen Rothwell wrote:
> > Hi all,
> > 
> > Changes since 20200622:
> > 
> 
> on x86_64:
> 
> arch/x86/kernel/cpu/mce/core.o: warning: objtool: mce_timed_out()+0x24: unreachable instruction
> kernel/exit.o: warning: objtool: __x64_sys_exit_group()+0x14: unreachable instruction
> 
> Full randconfig file is attached.

More livepatch...

-- 
Josh

