Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69595C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 15:44:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 426662073B
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 15:44:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FMtr+unp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404532AbgE1Po1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 11:44:27 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:52344 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2404518AbgE1PoZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 11:44:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590680664;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=w7CshrItXz8vvevX1N6Q7Vo4dM7itnMloFYSakyyKRo=;
        b=FMtr+unpTfoMljhggRxHLn7aDoCqZ0AdhyMIo8ArnKqCZRPlHpviXnQq/Q7jFRiXefK38P
        y7zu/+NFQyRB0DmBoJwmWGqCb43oynxJbaTFZisQ7KxyxEz3jvclC8XNkX7ZRHxbkZf5pX
        kanI+6DTKBhSVUpOG2vufE1cs2mfOyc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-133-r6aIwrs2O8OkeoNKBHkEfg-1; Thu, 28 May 2020 11:44:20 -0400
X-MC-Unique: r6aIwrs2O8OkeoNKBHkEfg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3E13F1855A26;
        Thu, 28 May 2020 15:44:07 +0000 (UTC)
Received: from treble (ovpn-117-65.rdu2.redhat.com [10.10.117.65])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id F0BFA5C1B0;
        Thu, 28 May 2020 15:44:05 +0000 (UTC)
Date:   Thu, 28 May 2020 10:44:04 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Kees Cook <keescook@chromium.org>
Subject: Re: linux-next: Tree for May 14 (objtool 2/2)
Message-ID: <20200528154404.74sjv4bdj3myacn6@treble>
References: <20200514210716.30b416ee@canb.auug.org.au>
 <742521db-1e8c-0d7a-1ed4-a908894fb497@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <742521db-1e8c-0d7a-1ed4-a908894fb497@infradead.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 14, 2020 at 09:04:36AM -0700, Randy Dunlap wrote:
> On 5/14/20 4:07 AM, Stephen Rothwell wrote:
> > Hi all,
> > 
> > Changes since 20200512:
> > 
> 
> on x86_64:
> 
> drivers/ide/ide-tape.o: warning: objtool: ide_tape_discard_merge_buffer.constprop.7()+0x4e: unreachable instruction
> drivers/scsi/sd.o: warning: objtool: sd_pr_clear()+0x1e: unreachable instruction
> drivers/scsi/sd_zbc.o: warning: objtool: sd_zbc_update_wp_offset_workfn()+0xec: unreachable instruction
> drivers/target/target_core_xcopy.o: warning: objtool: target_xcopy_do_work()+0xdd6: unreachable instruction
> 
> 
> randconfig file is attached.

Kees,

More UBSAN_TRAP fun.  This randconfig has:

CONFIG_UBSAN_TRAP=y
CONFIG_UBSAN_ALIGNMENT=y
# CONFIG_COMPILE_TEST is not set

-- 
Josh

