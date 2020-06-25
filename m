Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80D57C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 10:59:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4913120781
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 10:59:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593082761;
	bh=jTUxaG3li/C2pcyxCp36pc2lexRwidiVX4MLGwZleGs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=RJm9p3Pw9bQsIRGorIjlkEeRWlzU1IEqR2uONPAOJWUXIc4kFAPJ6DA7j5IVMOhNJ
	 WOOXnxN1qgBolEe2U6LbSgJj5E/gUiM82+0iV95lQsHBNOz9gizNE1HsiEIEO1ahwj
	 fvXKG2kwQrLPNQjS7nCVxJranNDhlPOKfHM2Dtsg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404082AbgFYK7T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 06:59:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:54400 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404042AbgFYK7S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 06:59:18 -0400
Received: from coco.lan (unknown [95.90.213.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 955072076E;
        Thu, 25 Jun 2020 10:59:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593082758;
        bh=jTUxaG3li/C2pcyxCp36pc2lexRwidiVX4MLGwZleGs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=hXLL+xu4L9uKpxJd27SdkdCMY3e0fIn9dMaNOrHRCYfZR7gwC0PENVTCKsRCTVmJw
         w815s7TxfSqv4htzXJ1O8JA3KecxXIo1xYyEQhcUliaD6gd9WrLCC/WaNaT9BLxjY1
         P8V8BOhzjNKXnfSmQgGnAY8GDIAIqjRiYjymIWso=
Date:   Thu, 25 Jun 2020 12:59:15 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Maxim Levitsky <mlevitsk@redhat.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: Search function in xconfig is partially broken after recent
 changes
Message-ID: <20200625125906.6b7688eb@coco.lan>
In-Reply-To: <a98b0f0ebe0c23615a76f1d23f25fd0c84835e6b.camel@redhat.com>
References: <a98b0f0ebe0c23615a76f1d23f25fd0c84835e6b.camel@redhat.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Maxim,

Em Thu, 25 Jun 2020 12:25:10 +0300
Maxim Levitsky <mlevitsk@redhat.com> escreveu:

> Hi!
> 
> I noticed that on recent kernels the search function in xconfig is partially broken.
> This means that when you select a found entry, it is not selected in the main window,
> something that I often do to find some entry near the area I would like to modify,
> and then use main window to navigate/explore that area.
> 
> Reverting these commits helps restore the original behavier:
> 
> b311142fcfd37b58dfec72e040ed04949eb1ac86 - kconfig: qconf: fix support for the split view mode
> cce1faba82645fee899ccef5b7d3050fed3a3d10 - kconfig: qconf: fix the content of the main widget
> 
> I have Qt5 5.13.2 from fedora 31 (5.13.2-1.fc31)
> 
> Could you explain what these commits are supposed to fix?
> I mostly use the split view mode too and it does appear to work for me with these commits reverted as well.
> 

There are three view modes for qconf:

	- Single
	- Split
	- Full

those got broken when gconf was converted to use Qt5, back on Kernel 3.14.
Those patches restore the original behavior.

> Another question is do you know how to run the qconf standalone? It appears to crash when I attempt to do so,
> althought I checked that I pass correct command line to it, and use the same current directory.
> I guess PATH or something is set by the makefile, but I was unable yet to find out what exactly breaks it.
> 
> This is what I see:
> 
> [mlevitsk@starship ~/UPSTREAM/linux-kernel/src]$./scripts/kconfig/qconf Kconfig
> sh: /scripts/gcc-version.sh: No such file or directory
> init/Kconfig:34: syntax error
> init/Kconfig:33: invalid statement
> init/Kconfig:34: invalid statement
> sh: /scripts/ld-version.sh: No such file or directory
> sh: --version: command not found
> init/Kconfig:39: syntax error
> init/Kconfig:38: invalid statement
> sh: /scripts/clang-version.sh: No such file or directory
> init/Kconfig:49: syntax error
> init/Kconfig:48: invalid statement
> Recursive inclusion detected.
> Inclusion path:

It requires some environment vars. This would make it a little better:


	export LD=$(which ldd); export CC=$(which gcc); export srctree=$(pwd); scripts/kconfig/gconf Kconfig
	Recursive inclusion detected.
	Inclusion path:
	  current file : arch//Kconfig
	  included from: arch//Kconfig:10

but it seems that something else is also needed.

Thanks,
Mauro
