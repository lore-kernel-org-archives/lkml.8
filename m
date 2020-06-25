Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BEBBC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 09:25:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 466822063A
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 09:25:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OoGnm8rU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390873AbgFYJZR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 05:25:17 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:59863 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2390071AbgFYJZQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 05:25:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593077115;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=dVA4/ziNOuhP2UV2s7csHYRpFcncYdcHmNZ/+uSHbaQ=;
        b=OoGnm8rUeJWvCbnCYOApbO2ZULNVWvP/mV4OwHJ0nmtQbVh1GAgi60NCFsZy1gtYsomFwy
        elrzdDm295WoAKe/ZiCIrPM2rs6Ca5xrxj1BPPUgGTsmeC+MeYitg2sHEDY8mCOGieX29l
        gd3qKyWnaHlvPiBo6QH0mCZ7E/XIpLA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-456-vklKhMziMEmviBvmhP0vdQ-1; Thu, 25 Jun 2020 05:25:13 -0400
X-MC-Unique: vklKhMziMEmviBvmhP0vdQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 51599464;
        Thu, 25 Jun 2020 09:25:12 +0000 (UTC)
Received: from starship (unknown [10.35.206.197])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7C973612A5;
        Thu, 25 Jun 2020 09:25:11 +0000 (UTC)
Message-ID: <a98b0f0ebe0c23615a76f1d23f25fd0c84835e6b.camel@redhat.com>
Subject: Search function in xconfig is partially broken after recent changes
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Date:   Thu, 25 Jun 2020 12:25:10 +0300
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I noticed that on recent kernels the search function in xconfig is partially broken.
This means that when you select a found entry, it is not selected in the main window,
something that I often do to find some entry near the area I would like to modify,
and then use main window to navigate/explore that area.

Reverting these commits helps restore the original behavier:

b311142fcfd37b58dfec72e040ed04949eb1ac86 - kconfig: qconf: fix support for the split view mode
cce1faba82645fee899ccef5b7d3050fed3a3d10 - kconfig: qconf: fix the content of the main widget

I have Qt5 5.13.2 from fedora 31 (5.13.2-1.fc31)

Could you explain what these commits are supposed to fix?
I mostly use the split view mode too and it does appear to work for me with these commits reverted as well.

Another question is do you know how to run the qconf standalone? It appears to crash when I attempt to do so,
althought I checked that I pass correct command line to it, and use the same current directory.
I guess PATH or something is set by the makefile, but I was unable yet to find out what exactly breaks it.

This is what I see:

[mlevitsk@starship ~/UPSTREAM/linux-kernel/src]$./scripts/kconfig/qconf Kconfig
sh: /scripts/gcc-version.sh: No such file or directory
init/Kconfig:34: syntax error
init/Kconfig:33: invalid statement
init/Kconfig:34: invalid statement
sh: /scripts/ld-version.sh: No such file or directory
sh: --version: command not found
init/Kconfig:39: syntax error
init/Kconfig:38: invalid statement
sh: /scripts/clang-version.sh: No such file or directory
init/Kconfig:49: syntax error
init/Kconfig:48: invalid statement
Recursive inclusion detected.
Inclusion path:

I ended up hacking the Makefile to run gdb on xconfig and I also hacked it to add -g2 to gcc,
as it looks like CFLAGS and CXXFLAGS don't affect build of xconfig.

I tried to debug this is a bit with mixed success but still I don't see the smoking gun.

Best regards,
	Maxim Levitsky

